/************************************************************************
 * Проверка создания задания Oracle через PL/Job и чтение его атрибутов *
 *                                                                      *
 * @file    test2.sql                                                   *
 * @author  Evgeny Sergeev                                              *
 * @version 1.0.0                                                       *
 * @history                                                             *
 * Evgeny Sergeev 24.04.2017 - created                                  *
 ************************************************************************
 * Copyright (c) 2017 Evgeny Sergeev                                    *
 * email: Bazinko@yandex.ru                                             *
 ***********************************************************************/

set serveroutput on

declare
  v_cJobName constant varchar2(32) := 'pljob_test_job2';
  v_xJob     TOracleJob;
  v_xJobNew  TOracleJob;

  function checkJobExists return boolean is
    v_xCount number(3);
  begin
    select 
      count(*)
    into
      v_xCount
    from   
      user_scheduler_jobs uj
    where
      uj.job_name = upper(v_cJobName);

    return (v_xCount > 0);
  end;

begin
  if checkJobExists then
    println('ERROR: job "' || v_cJobName || '" already exists');
  end if;

  v_xJob := new TOracleJob(v_pName      => v_cJobName,                                      
                           v_pType      => 'plsql_block',                                   
                           v_pAction    => 'begin dbms_output.put_line(''Test2''); end;',     
                           v_pStartDate => sysdate+1/24,                                    
                           v_pEnabled   => true,                                           
                           v_pComments  => 'Test2 for pl/job -  create job and read attribute');

  v_xJob.save();

  v_xJobNew := new TOracleJob(v_pName => v_cJobName);
  v_xJobNew.disable;

  if v_xJobNew.FEnabled = 'FALSE' then
    println('Test2: OK');
  end if;
  
  v_xJobNew.remove;

exception
  when others then
    println('ERROR: ' || sqlerrm(sqlcode));
    rollback;
end;
/

