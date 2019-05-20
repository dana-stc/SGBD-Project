DROP SEQUENCE comenzi_id_seq ;
/
CREATE SEQUENCE comenzi_id_seq 
  start with 100 
  increment by 1;
/
CREATE or replace TRIGGER trigger_insert_new_id_comenzi
  BEFORE INSERT ON comenzi
  FOR EACH ROW
BEGIN
  SELECT comenzi_id_seq.NEXTVAL
  INTO   :new.id_comanda
  FROM   dual;
END;
/


CREATE OR REPLACE PACKAGE pck_comenzi AS
  FUNCTION adauga_comanda ( p_id_produs number, p_numar_masa number, p_cantitate number, p_pret float, p_data_comanda timestamp ) return number ;
  FUNCTION sterge_comanda ( p_id_comanda number ) return number ;
END pck_comenzi;


CREATE OR REPLACE PACKAGE BODY pck_comenzi AS
  
  FUNCTION adauga_comanda ( p_id_produs number, p_numar_masa number, p_cantitate number, p_pret float, p_data_comanda timestamp ) return number IS
    BEGIN
    INSERT INTO COMENZI (numar_masa, id_produs, cantitate, pret, data_comanda)
    VALUES (p_numar_masa, p_id_produs, p_cantitate, p_pret, p_data_comanda);
    COMMIT; 
    return 1;   
    exception
    when OTHERS then
    return 0;
  END adauga_comanda;
  
  
   FUNCTION sterge_comanda ( p_id_comanda number ) return number IS
   BEGIN
      DELETE FROM comenzi WHERE id_comanda = p_id_comanda;
      COMMIT; 
      return 1;   
      exception
      when OTHERS then
      return 0;
   END sterge_comanda;



END pck_comenzi;
/


set serveroutput on;
declare 
   v_id_produs number;
   v_numar_masa number;
   v_cantitate number;
   v_pret float;
   v_data_comanda timestamp;
   l_result NUMBER;
begin   
     v_id_produs := 300013;
     v_numar_masa := 48;
     v_cantitate := 2;
     v_pret := 26;
     v_data_comanda := sysdate;
     l_result := pck_comenzi.adauga_comanda(v_id_produs , v_numar_masa, v_cantitate,v_pret,v_data_comanda  );
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   v_id_comanda number;
   l_result NUMBER;
begin   
     v_id_comanda := 100;
     l_result := pck_comenzi.sterge_comanda(v_id_comanda);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/

