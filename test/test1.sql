/************************************************************************
 * Проверка создания задания Oracle через PL/Job (в отключенном режиме) *
 *                                                                      *
 * @file    test1.sql                                                   *
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
  v_cJobName constant varchar2(32) := 'pljob_test_job1';
  v_xJob     TOracleJob;

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

  v_xJob := new TOracleJob(v_pName           => v_cJobName,                                      
                           v_pType           => 'plsql_block',                                   
                           v_pAction         => 'begin dbms_output.put_line(''Test1''); end;',     
                           v_pStartDate      => sysdate+1/24,                                    
                           v_pEnabled        => false,                                           
                           v_pComments       => 'Test1 for pl/job -  create job in disable state');

  v_xJob.save();

  if not checkJobExists then
    println('ERROR: job "' || v_cJobName || '" NOT created');
  end if;

  v_xJob.remove();

  if checkJobExists then
    println('ERROR: job "' || v_cJobName || '" NOT deleted');
  end if;

  println('Test1: OK');
  
exception
  when others then
    println('ERROR: ' || sqlerrm(sqlcode));
    rollback;
end;
/

