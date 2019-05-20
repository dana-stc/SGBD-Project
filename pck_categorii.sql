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
    -- FUNCTION inlocuire_categorie( p_id_vechi number, p_id_nou number) return number ;
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
  BEGIN
      SELECT COUNT(*) into v_number FROM LEG_CAT_PROD WHERE ID_CATEGORIE = p_id_categorie;
      IF v_number = 0  THEN
      DELETE FROM CATEGORII WHERE ID_CATEGORIE = p_id_categorie;
      COMMIT; 
      return 1;
      END IF;
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
    v_id_categorie := 16;  
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
select count(*) from categorii;
/
select count(*) from leg_cat_prod;


