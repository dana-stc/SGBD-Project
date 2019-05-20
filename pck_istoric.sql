DROP SEQUENCE istoric_id_seq ;
/
CREATE SEQUENCE istoric_id_seq 
  start with 1000001
  increment by 1;
/
CREATE or replace TRIGGER trigger_insert_new_id_istoric
  BEFORE INSERT ON istoric
  FOR EACH ROW
BEGIN
  SELECT istoric_id_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/


CREATE OR REPLACE PACKAGE pck_istoric AS
  function adauga_log ( p_utilizator varchar2, p_comanda varchar2, p_numar_masa number, p_pret_comanda float, p_data_log timestamp ) return number ;
END pck_istoric;
/

CREATE OR REPLACE PACKAGE BODY pck_istoric AS
  function adauga_log ( p_utilizator varchar2, p_comanda varchar2, p_numar_masa number, p_pret_comanda float, p_data_log timestamp ) return number IS
      BEGIN
      INSERT INTO ISTORIC (UTILIZATOR, COMANDA, NUMAR_MASA, PRET_COMANDA, DATA)
      VALUES (p_utilizator, p_comanda, p_numar_masa,p_pret_comanda, p_data_log );
      COMMIT; 
      return 1;   
      exception
      when OTHERS then
      return 0;
   END adauga_log;
END pck_istoric;
/

set serveroutput on;
declare 
   l_result NUMBER;
begin   
   l_result := pck_istoric.adauga_log('ioanad79','pizza Tonno', 17,8, SYSDATE );
   DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
