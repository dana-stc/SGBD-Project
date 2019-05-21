DROP SEQUENCE categorii_id_seq ;
/
CREATE SEQUENCE categorii_id_seq 
  start with 16
  increment by 1;
/
CREATE or replace TRIGGER tr_insert_new_id_categorii
  BEFORE INSERT ON categorii
  FOR EACH ROW
BEGIN
  SELECT categorii_id_seq.NEXTVAL
  INTO   :new.id_categorie
  FROM   dual;
END;
/


CREATE OR REPLACE PACKAGE pck_categorii AS
    TYPE linie_categorie IS TABLE OF categorii%ROWTYPE;
    FUNCTION editeaza_nume_categorie ( p_id_categorie number, p_nume_nou varchar2) return number ;
    FUNCTION adauga_categorie (p_nume_categorie varchar2) return number ;
    FUNCTION sterge_categorie ( p_id_categorie number) return number ;
    FUNCTION preia_tabel_categorii return linie_categorie ;
    FUNCTION inlocuire_categorie( p_id_vechi number, p_id_nou number) return number ;
END pck_categorii;

/
CREATE OR REPLACE PACKAGE BODY pck_categorii AS

   FUNCTION editeaza_nume_categorie ( p_id_categorie number, p_nume_nou varchar2) return number AS
   BEGIN
        UPDATE CATEGORII
        SET  
        NUME = p_nume_nou
        WHERE ID_CATEGORIE = p_id_categorie;
        COMMIT;
        return 1;
        exception
        when OTHERS then
        return 0;
   END editeaza_nume_categorie;

  FUNCTION adauga_categorie (p_nume_categorie varchar2) return number IS
      v_id_categorie CATEGORII.ID_CATEGORIE%type;
      BEGIN
      INSERT INTO CATEGORII (nume)
      VALUES (p_nume_categorie);
      COMMIT;  
      return 1;   
      exception
      when OTHERS then
      return 0;
  END adauga_categorie;

  FUNCTION sterge_categorie ( p_id_categorie number) return number IS
  v_number number;
  CURSOR lista_produse IS select id_produs from LEG_CAT_PROD where LEG_CAT_PROD.id_categorie = p_id_categorie;
  v_produs produse.id_produs%type;
  BEGIN
      OPEN lista_produse;
      LOOP
      FETCH lista_produse into v_produs;
      EXIT WHEN lista_produse%NOTFOUND;
      DELETE FROM COMENZI WHERE COMENZI.id_produs = v_produs;
      delete from leg_stoc where leg_stoc.id_produs = v_produs;
      DELETE FROM LEG_CAT_PROD WHERE ID_CATEGORIE = p_id_categorie and id_produs = v_produs;
      DELETE FROM PRODUSE where PRODUSE.id_produs = v_produs;
      END LOOP;     
      DELETE FROM CATEGORII WHERE ID_CATEGORIE = p_id_categorie;     
      COMMIT; 
      return 1;
      exception
      when OTHERS then
      return 0;
  END sterge_categorie;
  
  FUNCTION preia_tabel_categorii return linie_categorie IS
      lista_categorii linie_categorie;
      BEGIN
      SELECT * BULK COLLECT INTO lista_categorii FROM CATEGORII;
      return lista_categorii;  
      exception
      when OTHERS then
      return null;
  end preia_tabel_categorii;

  FUNCTION inlocuire_categorie( p_id_vechi number, p_id_nou number) return number IS
  BEGIN
        UPDATE leg_cat_prod
        SET  
        ID_CATEGORIE = p_id_nou
        WHERE ID_CATEGORIE = p_id_vechi;
        COMMIT; 
        return 1;   
      	exception
      	when OTHERS then
      	return 0;
  END inlocuire_categorie;
  
  
END pck_categorii;
/



set serveroutput on;
declare 
   v_id_categorie number;
   v_nume_nou varchar2(30);
   l_result NUMBER;
begin  
    v_id_categorie := 1;
    v_nume_nou := 'bauturi carbogazoase';
    l_result := pck_categorii.editeaza_nume_categorie(v_id_categorie, v_nume_nou);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   v_nume_categorie varchar2(30);
   l_result NUMBER;
begin  
    v_nume_categorie := 'noua categorie 2';
    l_result := pck_categorii.adauga_categorie(v_nume_categorie);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   v_id_categorie number;
   l_result NUMBER;
begin  
    v_id_categorie := 6;  
    l_result := pck_categorii.sterge_categorie(v_id_categorie);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   l_result pck_categorii.linie_categorie;
begin   
   l_result := pck_categorii.preia_tabel_categorii();
    for i in l_result.first..l_result.last loop
    if l_result.exists(i) then 
    DBMS_OUTPUT.PUT_LINE( l_result(i).ID_CATEGORIE||' - '||l_result(i).NUME);  
    end if;
    end loop;   
end;
/
set serveroutput on;
declare 
   l_result NUMBER;
begin  
    l_result := pck_categorii.inlocuire_categorie(3,4);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;

/
select count(*) from produse;
/
select count(*) from leg_cat_prod;

/

522131





