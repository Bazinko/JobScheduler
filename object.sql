/************************************************************************
 * Вспомогательные функции и процедуры для PL/Job                       *
 *                                                                      *
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

create or replace procedure println(v_pMsg in varchar2 := '') is
begin
  dbms_output.put_line(v_pMsg);
end;
/
show errors;


create or replace function StrToBoolean(v_pValue in varchar2) return boolean is
  v_xValue varchar2(32) := upper(v_pValue);
begin
  if (v_xValue = 'TRUE') then
    return true;
  end if;

  if (v_xValue = 'FALSE') then
    return true;
  end if;

  return false;
end;
/
show errors;


create or replace function BooleanToStr(v_pValue in boolean) return varchar2 is
begin
  if v_pValue then
    return 'TRUE';
  end if;

  return 'FALSE';
end;
/
show errors;


create or replace function iif_varchar(v_pCondition in boolean,
                                       v_pValue1    in varchar2,
                                       v_pValue2    in varchar2) return varchar2 is
begin
  if v_pCondition then
    return v_pValue1;
  end if;

  return v_pValue2;
end;
/
show errors;


create or replace function iif_number(v_pCondition in boolean,
                                      v_pValue1    in number,
                                      v_pValue2    in number) return number is
begin
  if v_pCondition then
    return v_pValue1;
  end if;

  return v_pValue2;
end;
/
show errors;


create or replace function inc(v_pValue in out nocopy pls_integer,
                               v_pDelta in pls_integer := 1) return pls_integer is
begin
  v_pValue := v_pValue + v_pDelta;

  return v_pValue;
end;
/
show errors;
 

create or replace function let(v_pTargetValue in out nocopy varchar2,
                               v_pValue       in varchar2) return varchar2 is
begin
  v_pTargetValue := v_pValue;

  return v_pTargetValue;
end;
/
show errors;


create or replace function let(v_pTargetValue in out nocopy pls_integer,
                               v_pValue       in pls_integer) return pls_integer is
begin
  v_pTargetValue := v_pValue;

  return v_pTargetValue;
end;
/
show errors;


create or replace function let(v_pNumTargetValue in out nocopy number,
                               v_pNumValue       in            number) return number is
begin
  v_pNumTargetValue := v_pNumValue;

  return v_pNumTargetValue;
end;
/
show errors;


create or replace function is_number(v_pNumStr in varchar2) return boolean is
  v_xNum number;

  v_xConvError exception;
  pragma exception_init(v_xConvError, -6502);
begin
  v_xNum := to_number(v_pNumStr);

  return true;

exception
  when invalid_number then
    return false;

  when v_xConvError then
    return false;
end;
/
show errors;


