/************************************************************************
 * ќпределение пользовател€ - владельца объектов PL/Job                 *
 *                                                                      *
 * явл€етс€ предком дл€ всех классов PL/Job                             *
 *                                                                      *
 * @file    user.sql                                                    *
 * @author  Evgeny Sergeev                                              *
 * @version 1.0.0                                                       *
 * @history                                                             *
 * Evgeny Sergeev 24.04.2017 - created                                  *
 ************************************************************************
 * Copyright (c) 2017 Evgeny Sergeev                                    *
 * email: Bazinko@yandex.ru                                             *
 ***********************************************************************/

create user pl_job
 identified by pl_job
 default    tablespace users
 temporary  tablespace temp;
 

grant connect,resource             to pl_job;
grant create view                  to pl_job;
grant create library               to pl_job;
grant create public synonym        to pl_job;
grant create any synonym           to pl_job;
grant execute on dbms_pipe         to pl_job;
grant execute on dbms_alert        to pl_job;
grant execute on dbms_aqadm        to pl_job;
grant execute on dbms_result_cache to pl_job;
grant create type                  to pl_job;
grant create database link         to pl_job;
grant execute on dbms_scheduler    to pl_job;
grant create job                   to pl_job;
grant create external job          to pl_job;






