CREATE OR REPLACE PACKAGE pck_mese AS
  TYPE linie_mese IS TABLE OF mese%ROWTYPE;
  function set_masa_disponibila(p_numar_masa number) return number;
  function set_masa_rezervata(p_numar_masa number) return number;
  function set_masa_ocupata(p_numar_masa number) return number;
  function adaugaRezervare(p_numar_masa number, p_data_rezervare timestamp, p_mentiune varchar2) return number;
  function preia_tabel_mese return linie_mese ;
END pck_mese;


CREATE OR REPLACE PACKAGE BODY pck_mese AS

 function set_masa_disponibila(p_numar_masa number) RETURN number IS 
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'disponibila'
        WHERE NUMAR = p_numar_masa;
        COMMIT; 
        return 1;   
      	exception
      	when OTHERS then
      	return 0;
   END set_masa_disponibila;
   
   
   
 function set_masa_rezervata(p_numar_masa number) RETURN number IS  
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'rezervata'
        WHERE NUMAR = p_numar_masa;
        COMMIT; 
      	return 1;   
      	exception
      	when OTHERS then
      	return 0;
   END set_masa_rezervata;
    
    
 function set_masa_ocupata(p_numar_masa number) RETURN number IS 
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'ocupata'
        WHERE NUMAR = p_numar_masa;
        COMMIT; 
      	return 1;   
      	exception
      	when OTHERS then
      	return 0;
   END set_masa_ocupata;
    
    
  function adaugaRezervare(p_numar_masa number, p_data_rezervare timestamp, p_mentiune varchar2) return number IS
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'rezervata',
        DATA_REZERVARE = p_data_rezervare,
        MENTIUNE = p_mentiune
        WHERE NUMAR = p_numar_masa;
        COMMIT; 
        return 1;   
      	exception
      	when OTHERS then
      	return 0;
   END adaugaRezervare;
   
   
   function preia_tabel_mese return linie_mese IS
   lista_mese linie_mese;
      BEGIN
      SELECT * BULK COLLECT INTO lista_mese FROM MESE;
      return lista_mese;  
   end preia_tabel_mese;
   
   
END pck_mese;



/  
set serveroutput on;
declare 
   l_result NUMBER;
   v_numar_masa number;
begin   
    v_numar_masa := 20;
    l_result := pck_mese.set_masa_disponibila(v_numar_masa);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/  
set serveroutput on;
declare 
   l_result NUMBER;
   v_numar_masa number;
begin   
    v_numar_masa := 21;
    l_result := pck_mese.set_masa_rezervata(v_numar_masa);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/  
set serveroutput on;
declare 
   l_result NUMBER;
   v_numar_masa number;
begin   
    v_numar_masa := 10;
    l_result := pck_mese.set_masa_ocupata(v_numar_masa);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/  
set serveroutput on;
declare 
   l_result NUMBER;
   v_numar_masa number;
   v_data_rezervare timestamp;
   v_mentiune varchar2(100);
begin   
    v_numar_masa := 21;
    v_data_rezervare := systimestamp;
    v_mentiune := 'for Dany';
    l_result := pck_mese.adaugaRezervare(v_numar_masa,v_data_rezervare,v_mentiune);
    DBMS_OUTPUT.PUT_LINE(l_result);
end;
/
set serveroutput on;
declare 
   l_result pck_mese.linie_mese;
begin   
   l_result := pck_mese.preia_tabel_mese();
     for i in l_result.first..l_result.last loop
        if l_result.exists(i) then 
           DBMS_OUTPUT.PUT_LINE( l_result(i).id_MASA||' - '||l_result(i).NUMAR || ' - '||l_result(i).STATUS || ' - '||l_result(i).DATA_REZERVARE || ' - '||l_result(i).MENTIUNE);  
        end if;
    end loop;   
end;
