DROP SEQUENCE conturi_id_seq ;
/
CREATE SEQUENCE conturi_id_seq 
  start with 23 
  increment by 1;
/
CREATE or replace TRIGGER trigger_insert_new_id_conturi
  BEFORE INSERT ON conturi
  FOR EACH ROW
BEGIN
  SELECT conturi_id_seq.NEXTVAL
  INTO   :new.id_cont
  FROM   dual;
END;

/
CREATE OR REPLACE PACKAGE pck_conturi AS
	 function utilizator_valid( p_utilizator varchar2, p_parola varchar2 )RETURN number ;
   function inserare_utilizator( p_utilizator varchar2, p_parola varchar2, p_is_admin number ) return number ;
   function sterge_utilizator(p_utilizator varchar2) return number ;
   function modifica_utilizator(p_utilizator varchar2, p_parola_noua varchar2, p_is_admin number) return number ;
   --function preia_tabel_utilizatori() return table ;
END pck_conturi;

CREATE OR REPLACE PACKAGE BODY pck_conturi AS

    function utilizator_valid( p_utilizator varchar2, p_parola varchar2 ) RETURN number IS 
    CURSOR lista_useri_parole  IS select utilizator, parola  from CONTURI;
    v_user CONTURI.UTILIZATOR%type;
    v_password CONTURI.PAROLA%type;
    BEGIN
    OPEN lista_useri_parole;
    LOOP
        FETCH lista_useri_parole INTO v_user, v_password;
        EXIT WHEN lista_useri_parole%NOTFOUND;   
    IF v_user = p_utilizator and v_password = p_parola THEN  
        return 1;
        ELSIF  v_user = p_utilizator and v_password != p_parola THEN 
        return 0;
        ELSE
        return -1;
     END IF;
    END LOOP;
   CLOSE lista_useri_parole;  
   END utilizator_valid;


   function inserare_utilizator( p_utilizator varchar2, p_parola varchar2, p_is_admin number ) return number IS
   i NUMBER; 
   BEGIN
    INSERT INTO CONTURI (UTILIZATOR, PAROLA, ISADMIN)
    VALUES (p_utilizator, p_parola, p_is_admin);
    i := SQL%rowcount; 
    COMMIT; 
    IF i > 0 THEN
    RETURN 1;
    END IF;
    RETURN 0;
   END inserare_utilizator;


    function sterge_utilizator(p_utilizator varchar2) return number IS
    i NUMBER; 
    BEGIN
      DELETE FROM ISTORIC WHERE UTILIZATOR = p_utilizator;
      DELETE FROM CONTURI WHERE UTILIZATOR = p_utilizator;
      i := SQL%rowcount; 
      COMMIT; 
      IF i > 0 THEN
      RETURN 1;
      END IF;
     RETURN 0;
    END sterge_utilizator;

    
    function modifica_utilizator(p_utilizator varchar2, p_parola_noua varchar2, p_is_admin number) return number IS 
    i NUMBER; 
    BEGIN
        UPDATE CONTURI
        SET  
        PAROLA = p_parola_noua,
        ISADMIN = p_is_admin
        WHERE UTILIZATOR = p_utilizator;
        i := SQL%rowcount; 
        COMMIT; 
        IF i > 0 THEN
        RETURN 1;
        END IF;
     RETURN 0;
   END modifica_utilizator;

   
END pck_conturi;


/  
set serveroutput on;
declare 
   l_result NUMBER;
begin   
    l_result := pck_conturi.utilizator_valid('karateshine40' ,'acneequinox' );
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/  

set serveroutput on;
declare 
   v_utilizator varchar2(30);
   v_parola varchar2(30);
   p_is_admin number;
   l_result NUMBER;
begin   
     v_utilizator := 'ioanad79';
     v_parola := 'myPas';
     p_is_admin := 1;
     l_result := pck_conturi.inserare_utilizator(v_utilizator , v_parola, p_is_admin );
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
 
 set serveroutput on;
declare 
   v_utilizator varchar2(30);
   l_result NUMBER;
begin   
     v_utilizator := 'ioanad79';
     l_result := pck_conturi.sterge_utilizator(v_utilizator);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
 
set serveroutput on;
declare 
   v_utilizator varchar2(30);
   v_parola_noua varchar2(30);
   v_is_admin varchar2(30);
   l_result NUMBER;
begin   
     v_utilizator := 'ioanad79';
     v_parola_noua := 'myPAS77';
     v_is_admin := 0;
     l_result := pck_conturi.modifica_utilizator(v_utilizator, v_parola_noua, v_is_admin);
   DBMS_OUTPUT.PUT_LINE(l_result);
end;