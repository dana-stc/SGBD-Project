CREATE OR REPLACE PACKAGE pck_incasari AS
   FUNCTION bani_incasati_luna ( p_data number ) return double precision ;
   FUNCTION bani_incasati_interval ( p_data1 TIMESTAMP,  p_data2 TIMESTAMP ) return double precision;
   FUNCTION bani_incasati_astazi return double precision;
   --FUNCTION cel_mai_vandut_produs_al_lunii  return VARCHAR2;
END pck_incasari;
/
CREATE OR REPLACE PACKAGE BODY pck_incasari AS
    
    FUNCTION bani_incasati_luna ( p_data number ) return double precision IS
      v_suma double precision;
      BEGIN
      select sum(pret) into v_suma from incasari where extract(month from data_incasare) = p_data;
      return v_suma;
    END bani_incasati_luna;


    FUNCTION bani_incasati_interval ( p_data1 TIMESTAMP,  p_data2 TIMESTAMP ) return double precision IS
     v_suma double precision;
    BEGIN
      select sum(pret) into v_suma from incasari where data_incasare between p_data1 and p_data2 ;
      return v_suma;
    END bani_incasati_interval;
    
    
    FUNCTION bani_incasati_astazi return double precision IS
      v_suma double precision;
    BEGIN
      select sum(pret) into v_suma from incasari where extract(day from data_incasare) = extract(day from sysdate);
      return v_suma;
    END bani_incasati_astazi;
    
    
END pck_incasari;
/


set serveroutput on;
declare 
   l_result double precision;
   v_luna number;
begin   
    v_luna := 6;
    l_result := pck_incasari.bani_incasati_luna(v_luna);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   l_result double precision;
begin   
    l_result := pck_incasari.bani_incasati_astazi();
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/

