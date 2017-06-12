set doc off
/************************************************************************
 * Пример создания внешнего задания (вызов скрипта ОС) с помощью        *
 * объектно-ориентированного API - с использованием объектных           *
 * типов PL/Job                                                         *
 *                                                                      *                             
 * @file    example2.sql                                                *
 * @author  Evgeni Sergeev                                              *
 * @version 1.0.0                                                       *
 * @history                                                             *
 *  Evgeni Sergeev 07.06.2017 - created                                 *
 ************************************************************************
 * Copyright (c) 2017 Evgeni Sergeev                                    *
 * email: zik-zenya@mail.ru                                             *
 ***********************************************************************/  
set doc on
set serveroutput on
spool example2.log


declare
  v_xCredential TOracleJobCredential;
  v_xJob        TOracleJobShellScript;
begin             
--Создаем объект: описание учетной записи ОС, под которой будет выполняться shell-скрипт
  v_xCredential := new TOracleJobCredential(v_pName     => 'RMAN_DB_BACKUP',    
                                            v_pUserName => 'oracle',    
                                            v_pPassword => 'oracle');    

--Cоздаем задание, которое будет выполнять shell-скрипт ОС
  v_xJob := new TOracleJobShellScript(v_pName           => 'RMAN_DAILY_FULL_BACKUP',
                                      v_pStartDate      => sysdate + (1/24/60)*2,  --trunc(sysdate+1)+7/24,
                                      v_pRepeatInterval => 'freq=daily;byhour=7',
                                      v_pCredential     => v_xCredential,
                                      v_pShellScript    => '/home/oracle/scripts/daily_backup.sh');
  v_xJob.save();
  v_xJob.setPrimaryRole();
  commit;
end;
/

spool off

