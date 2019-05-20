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
   TYPE linie_cont IS TABLE OF conturi%ROWTYPE;
   function utilizator_valid( p_utilizator varchar2, p_parola varchar2 )RETURN number ;
   function inserare_utilizator( p_utilizator varchar2, p_parola varchar2, p_is_admin number ) return number ;
   function sterge_utilizator(p_utilizator varchar2) return number ;
   function modifica_utilizator(p_utilizator varchar2, p_parola_noua varchar2, p_is_admin number) return number ;
   function preia_tabel_utilizatori return linie_cont ;
   function is_admin (p_utilizator varchar2) return number ;
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
        IF trim(v_user) = trim(p_utilizator) and trim(v_password) = trim(p_parola) THEN  
        return 1;
        ELSIF  v_user = p_utilizator and v_password != p_parola THEN 
        return 0;    
        END IF;
        END LOOP;
        return -1;
        CLOSE lista_useri_parole;  
   END utilizator_valid;


   function inserare_utilizator( p_utilizator varchar2, p_parola varchar2, p_is_admin number ) return number IS
      BEGIN
      INSERT INTO CONTURI (UTILIZATOR, PAROLA, ISADMIN)
      VALUES (p_utilizator, p_parola, p_is_admin);
      COMMIT; 
      return 1;   
      exception
      when OTHERS then
      return 0;
   END inserare_utilizator;


    function sterge_utilizator(p_utilizator varchar2) return number IS
      BEGIN
      DELETE FROM ISTORIC WHERE UTILIZATOR = p_utilizator;
      DELETE FROM CONTURI WHERE UTILIZATOR = p_utilizator;
      COMMIT; 
      return 1;   
      exception
      when OTHERS then
      return 0;
    END sterge_utilizator;

    
    function modifica_utilizator(p_utilizator varchar2, p_parola_noua varchar2, p_is_admin number) return number IS 
        BEGIN
        UPDATE CONTURI
        SET  
        PAROLA = p_parola_noua,
        ISADMIN = p_is_admin
        WHERE UTILIZATOR = p_utilizator;
        COMMIT; 
        return 1;   
      	exception
      	when OTHERS then
      	return 0;
   END modifica_utilizator;


   function preia_tabel_utilizatori return linie_cont IS
      lista_conturi linie_cont;
      BEGIN
      SELECT * BULK COLLECT INTO lista_conturi FROM conturi;
      return lista_conturi;  
      exception
      when OTHERS then
      return null;
   end preia_tabel_utilizatori;
  
   
    function is_admin (p_utilizator varchar2) return number IS
      v_is_admin number;
      BEGIN
      SELECT isadmin into v_is_admin from conturi where utilizator = p_utilizator;
      return v_is_admin;  
      EXCEPTION
      WHEN no_data_found THEN
      return -1;
    end is_admin;
    
    
END pck_conturi;
/



set serveroutput on;
declare 
   v_utilizator varchar2(30);
   l_result NUMBER;
begin   
    v_utilizator := 'imprintdisobey81f';
    l_result := pck_conturi.is_admin(v_utilizator );
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/  
set serveroutput on;
declare 
   l_result NUMBER;
begin   
    l_result := pck_conturi.utilizator_valid('drowsilyrefresh20' ,'flossededmun,d' );
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
/
set serveroutput on;
declare 
   l_result pck_conturi.linie_cont;
begin   
   l_result := pck_conturi.preia_tabel_utilizatori();
    for i in l_result.first..l_result.last loop
    if l_result.exists(i) then 
    DBMS_OUTPUT.PUT_LINE( l_result(i).id_cont||' - '||l_result(i).utilizator || ' - '||l_result(i).parola || ' - '||l_result(i).isadmin);  
    end if;
    end loop;   
end;
