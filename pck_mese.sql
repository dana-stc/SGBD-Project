CREATE OR REPLACE PACKAGE pck_mese AS
  function set_masa_disponibila(p_numar_masa number) return number;
  function set_masa_rezervata(p_numar_masa number) return number;
  function set_masa_ocupata(p_numar_masa number) return number;
  function adaugaRezervare(numarMasa number, timestamp dataRezervare, mentiune varchar2) return number;

END pck_mese;

CREATE OR REPLACE PACKAGE BODY pck_mese AS

 function set_masa_disponibila(p_numar_masa number) RETURN number IS 
 i NUMBER; 
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'disponibila'
        WHERE NUMAR = p_numar_masa;
        i := SQL%rowcount; 
        COMMIT; 
        IF i > 0 THEN
        RETURN 1;
        END IF;
     RETURN 0;
   END set_masa_disponibila;
   
   
   
 function set_masa_rezervata(p_numar_masa number) RETURN number IS 
 i NUMBER; 
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'rezervata'
        WHERE NUMAR = p_numar_masa;
        i := SQL%rowcount; 
        COMMIT; 
        IF i > 0 THEN
        RETURN 1;
        END IF;
     RETURN 0;
   END set_masa_rezervata;
    
    
 function set_masa_ocupata(p_numar_masa number) RETURN number IS 
 i NUMBER; 
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'ocupata'
        WHERE NUMAR = p_numar_masa;
        i := SQL%rowcount; 
        COMMIT; 
        IF i > 0 THEN
        RETURN 1;
        END IF;
     RETURN 0;
   END set_masa_ocupata;
    
    
  function adaugaRezervare(p_numar_masa number, p_data_rezervare timestamp, p_mentiune varchar2) return number IS
  i NUMBER; 
 BEGIN
        UPDATE MESE
        SET  
        STATUS = 'rezervata'
        WHERE NUMAR = p_numar_masa;
        i := SQL%rowcount; 
        COMMIT; 
        IF i > 0 THEN
        RETURN 1;
        END IF;
     RETURN 0;
   END adaugaRezervare;
   
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