DROP SEQUENCE incasari_id_seq ;
/
CREATE SEQUENCE incasari_id_seq 
  start with 1000001 
  increment by 1;
/
CREATE or replace TRIGGER trigg_insert_new_id_incasari
  BEFORE INSERT ON incasari
  FOR EACH ROW
BEGIN
  SELECT conturi_id_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

CREATE OR REPLACE PACKAGE pck_incasari AS
   FUNCTION bani_incasati_luna ( p_data number ) return double precision ;
   FUNCTION bani_incasati_interval ( p_data1 TIMESTAMP,  p_data2 TIMESTAMP ) return double precision;
   FUNCTION bani_incasati_astazi return double precision;
   FUNCTION cel_mai_vandut_produs_al_lunii (p_luna number) return VARCHAR2;
   FUNCTION adauga_incasare( p_nume_produs varchar2, p_cantitate number, p_pret float, p_datancasare timestamp ) return number ;
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
     
    FUNCTION cel_mai_vandut_produs_al_lunii (p_luna number) return VARCHAR2 IS
      v_produs varchar2(30);
    BEGIN
      select nume_produs into v_produs  from (
      select nume_produs,count(nume_produs)  from incasari
      where extract(month from data_incasare) = p_luna
      group by nume_produs
      order by count(nume_produs) desc )
      where rownum <2;    
      return v_produs;
      exception
      when OTHERS then
      return null;
    END cel_mai_vandut_produs_al_lunii;  
    
   FUNCTION adauga_incasare( p_nume_produs varchar2, p_cantitate number, p_pret float, p_datancasare timestamp ) return number IS
      BEGIN
      INSERT INTO CONTURI (NUME_PRODUS, CANTITATE, PRET, DATA_INCASARE)
      VALUES ( p_nume_produs, p_cantitate, p_pret, p_datancasare);
      COMMIT; 
      return 1;   
      exception
      when OTHERS then
      return 0;
  END adauga_incasare;
  
    
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
set serveroutput on;
declare 
   l_result varchar2(30) ;
begin   
    l_result := pck_incasari.cel_mai_vandut_produs_al_lunii(11);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/    


 INSERT INTO CONTURI (NUME_PRODUS, CANTITATE, PRET, DATA_INCASARE)
    VALUES ( 'Zimmerman', 7, 10, systimestamp );



select * from (
select nume_produs,count(nume_produs)  from incasari
group by nume_produs
order by count(nume_produs) desc )
where rownum <2;