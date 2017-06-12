set doc off
/************************************************************************
 * ������ �������� �������� ������� (����� ������� ��) � ������� �����- *
 * �������� ����������� API - ������� ������ DBMS_SCHEDULE              *
 * ������� ������� PL/Job                                               *
 *                                                                      *                             
 * @file    example1.sql                                                *
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
spool example1.log

begin
--������� �������� ������� ������ ��, ��� ������� ����� ����������� shell-������
  dbms_scheduler.create_credential(credential_name => 'RMAN_DB_BACKUP', 
                                   username        => 'oracle', 
                                   password        => 'oracle');

--������� �������
  dbms_scheduler.create_job(job_name            => 'RMAN_DAILY_FULL_BACKUP',
                            job_type            => 'EXECUTABLE',
                            job_action          => '/bin/bash',
                            number_of_arguments => 1,
                            start_date          => sysdate + (1/24/60)*2,  --trunc(sysdate+1)+7/24,
                            repeat_interval     => 'freq=daily;byhour=7',
                            credential_name     => 'RMAN_DB_BACKUP',
                            auto_drop           => false);

--������������� ������ ��� shell-�������, ������� ����� ���������� � �������
  dbms_scheduler.set_job_argument_value(job_name            => 'RMAN_DAILY_FULL_BACKUP',
                                        argument_position   =>  1,
                                        argument_value      => '/home/oracle/scripts/daily_backup.sh');

--���� ����� ����������� ������ ���� �� �������� �������� (Primary-DB)
  dbms_scheduler.set_attribute(name      => 'RMAN_DAILY_FULL_BACKUP',
                               attribute => 'database_role',
                               value     => 'PRIMARY');

  commit;
end;
/

spool off
