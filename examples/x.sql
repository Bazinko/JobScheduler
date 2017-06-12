exec dbms_scheduler.drop_job('RMAN_DAILY_FULL_BACKUP');
exec dbms_scheduler.drop_credential('RMAN_DB_BACKUP');



exec dbms_scheduler.run_job('RMAN_DAILY_FULL_BACKUP', use_current_session=> TRUE);





