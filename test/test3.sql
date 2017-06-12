/************************************************************************
 * Проверка создания программы через PL/Job и чтение его атрибутов      *
 *                                                                      *
 * @file    test3.sql                                                   *
 * @author  Evgeny Sergeev                                              *
 * @version 1.0.0                                                       *
 * @history                                                             *
 * Evgeny Sergeev 08.05.2017 - created                                  *
 ************************************************************************
 * Copyright (c) 2017 Evgeny Sergeev                                    *
 * email: Bazinko@yandex.ru                                             *
 ***********************************************************************/

set serveroutput on

declare
  v_cJobName constant varchar2(32) := 'pljob_test_job3';
  v_xProgram       TOracleJobProgram;
  v_xJobProgramNew TOracleJobProgram;

  function checkJobProgramExists return boolean is
    v_xCount number(3);
  begin
    select 
      count(*)
    into
      v_xCount
    from   
      user_scheduler_programs uj
    where
      uj.program_name = upper(v_cJobName);

    return (v_xCount > 0);
  end;

begin
  if checkJobProgramExists then
    println('ERROR: job "' || v_cJobName || '" already exists');
  end if;

  v_xProgram := new TOracleJobProgram(v_pName      => v_cJobName,                                      
       	                      	      v_pType      => 'plsql_block',                                   
                                      v_pAction    => 'begin dbms_output.put_line(''Test3''); end;',     
                                      v_pNumberOfArguments => 0,                                    
                                      v_pEnabled   => true,                                           
                                      v_pComments  => 'Test3 for pl/job -  create job program and read attributes');

  v_xProgram.save();

  v_xJobProgramNew := new TOracleJobProgram(v_pName => v_cJobName);

  if v_xJobProgramNew.FEnabled = 'TRUE' then
    if not checkJobProgramExists then
      println('ERROR: job program "' || v_cJobName || '" not created ');
      return; 
    end if;

    println('Test3: OK');
  end if;
  
  v_xJobProgramNew.remove;

exception
  when others then
    println('ERROR: ' || sqlerrm(sqlcode));
    rollback;
end;
/

