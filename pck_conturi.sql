CREATE OR REPLACE PACKAGE pck_conturi AS
	 function utilizator_valid( p_utilizator varchar2, p_parola varchar2 )RETURN number ;
   function inserare_utilizator( p_utilizator varchar2, p_parola varchar2, p_is_admin number ) return number ;
   --function sterge_utilizator(p_utilizator varchar2) return number ;
   --function modifica_utilizator(p_utilizator varchar2, p_parola_noua varchar2, p_is_admin number) return number ;
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

   
END pck_conturi;


/  
set serveroutput on;
declare 
   l_result NUMBER;
begin   
    l_result := pck_conturi.utilizator_valid('karateshine40' ,'acneequinox' );
    DBMS_OUTPUT.PUT_LINE(l_result);
end;