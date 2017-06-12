/************************************************************************
 * Скрипт установки системы PL/Job в СУБД Oracle Database               *
 *                                                                      *
 * @file    object.sql                                                  *
 * @author  Evgeny Sergeev                                              *
 * @version 1.0.0                                                       *
 * @history                                                             *
 * Evgeny Sergeev 24.05.2017 - created                                  *
 ************************************************************************
 * Copyright (c) 2017 Evgeny Sergeev                                    *
 * email: Bazinko@yandex.ru                                             *
 ***********************************************************************/

spool install.log

@@object.sql
@@object.osp
@@object.obd

@@persistent.osp
@@persistent.obd

@@program.osp
@@program.obd

@@credential.osp
@@credential.obd

@@job.osp
@@job.obd

@@shell.osp
@@shell.obd

spool off
