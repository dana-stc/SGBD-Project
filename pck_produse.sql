DROP SEQUENCE produse_id_seq ;
/
CREATE SEQUENCE produse_id_seq 
  start with 1000001 
  increment by 1;
/
CREATE or replace TRIGGER trigger_insert_new_id_produse
  BEFORE INSERT ON produse
  FOR EACH ROW
BEGIN
  SELECT produse_id_seq.NEXTVAL
  INTO   :new.id_produs
  FROM   dual;
END;
/


CREATE OR REPLACE PACKAGE pck_produse AS
  TYPE LINIE_PRODUS IS TABLE OF PRODUSE%ROWTYPE;
  FUNCTION adauga_produs (p_nume_produs varchar2, p_pret number, p_descriere varchar2, p_id_categorie number, p_stoc number ) return number;
  FUNCTION editeaza_produs ( p_id_produs number, p_pret_nou number, p_descriere_noua varchar2, p_id_categorie_noua number ) return number ;
  FUNCTION sterge_produs ( p_id_produs number ) return number;
  FUNCTION editeaza_stoc ( p_id_produs number, p_stoc_nou number ) return number ;
  FUNCTION preia_tabel_produse return LINIE_PRODUS ;
END pck_produse;


CREATE OR REPLACE PACKAGE BODY pck_produse AS
  
    PROCEDURE adauga_produs_folosind_id (p_nume_produs varchar2, p_pret number, p_descriere varchar2, v_id_produs out produse.id_produs%type ) as
      BEGIN
      INSERT INTO PRODUSE (nume_produs, pret, descriere)
      VALUES (p_nume_produs, p_pret, p_descriere)
      returning id_produs into v_id_produs;
    end adauga_produs_folosind_id;

    FUNCTION adauga_produs (p_nume_produs varchar2, p_pret number, p_descriere varchar2, p_id_categorie number, p_stoc number ) return number IS
      v_id_produs PRODUSE.id_produs%type;
      BEGIN 
      adauga_produs_folosind_id(p_nume_produs, p_pret, p_descriere, v_id_produs);
      INSERT INTO LEG_CAT_PROD (id_produs, id_categorie)
      VALUES (v_id_produs, p_id_categorie);   
      INSERT INTO LEG_STOC (ID_PRODUs, stoc)
      VALUES (v_id_produs, p_stoc);
      COMMIT;  
      return 1;   
      exception
      when OTHERS then
      return 0;
    END adauga_produs;
  
  
    FUNCTION editeaza_produs ( p_id_produs number, p_pret_nou number, p_descriere_noua varchar2, p_id_categorie_noua number ) return number AS
    BEGIN
        UPDATE PRODUSE
        SET  
        pret = p_pret_nou,
        descriere = p_descriere_noua
        WHERE id_produs = p_id_produs;
        UPDATE LEG_CAT_PROD
        SET  
        id_categorie = p_id_categorie_noua
        WHERE id_produs = p_id_produs;
        COMMIT; 
        return 1;
        exception
        when OTHERS then
        return 0;
    END editeaza_produs;
  
  
    FUNCTION sterge_produs ( p_id_produs number ) return number AS
    BEGIN
      DELETE FROM LEG_CAT_PROD WHERE ID_PRODUS = p_id_produs;
      DELETE FROM LEG_STOC WHERE ID_PRODUS = p_id_produs;
      DELETE FROM PRODUSE WHERE ID_PRODUS = p_id_produs;
      COMMIT; 
      return 1;   
      exception
      when OTHERS then
      return 0;
    END sterge_produs;
    
    
    FUNCTION editeaza_stoc ( p_id_produs number, p_stoc_nou number ) return number AS
    BEGIN
        UPDATE LEG_STOC
        SET  
        stoc = p_stoc_nou
        WHERE id_produs = p_id_produs;
        COMMIT; 
        return 1;
        exception
        when OTHERS then
        return 0;
    END editeaza_stoc;
    
    
    FUNCTION preia_tabel_produse return LINIE_PRODUS AS
      lista_produse LINIE_PRODUS;
      BEGIN
      SELECT * BULK COLLECT INTO lista_produse FROM produse;
      return lista_produse;  
   end preia_tabel_produse;


END pck_produse;


/
set serveroutput on;
declare 
   v_nume_produs varchar2(30);
   v_pret number;
   v_descriere varchar2(30);
   v_id_categorie number;
   v_stoc number;
   l_result NUMBER;
begin   
    v_nume_produs := 'Pepsi 0 zahar';
    v_pret := 6;
    v_descriere := 'bautura carbogazoasa';
    v_id_categorie := 1;
    v_stoc := 70;
     l_result := pck_produse.adauga_produs(v_nume_produs, v_pret, v_descriere, v_id_categorie, v_stoc);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   v_id produse.id_produs%type;
   v_pret number;
   v_descriere varchar2(30);
   v_id_categorie number;
   l_result NUMBER;
begin  
    v_id := 20;
    v_pret := 7;
    v_descriere := 'bautura carbogazoasa...';
    v_id_categorie := 1;
    l_result := pck_produse.editeaza_produs(v_id, v_pret, v_descriere, v_id_categorie);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   v_id produse.id_produs%type;
   l_result NUMBER;
begin  
    v_id := 1000007;
    l_result := pck_produse.sterge_produs(v_id);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   v_id produse.id_produs%type;
   v_stoc_nou number;
   l_result NUMBER;
begin  
    v_id := 1000006;
    v_stoc_nou := 43;
    l_result := pck_produse.editeaza_stoc(v_id,v_stoc_nou);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   l_result pck_produse.LINIE_PRODUS;
begin   
   l_result := pck_produse.preia_tabel_produse();
     for i in l_result.first..l_result.last loop
        if l_result.exists(i) then 
           DBMS_OUTPUT.PUT_LINE( l_result(i).id_produs||' - '||l_result(i).nume_produs || ' - '||l_result(i).pret || ' - '||l_result(i).descriere);  
        end if;
    end loop;   
end;


/
select count(*) from produse;
/
select count(*) from leg_cat_prod;
/
select count(*) from leg_stoc;
