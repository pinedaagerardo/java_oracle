--table log
create table log_testtable (
  change_date  date,
  id     integer,
  old_value     varchar2(100),
  new_value     varchar2(100)
);

--trigger
create or replace trigger log_ch_testtable
after update on testtable
for each row 
begin 
  insert into log_testtable(change_date, id, old_value, new_value)
  values (SYSDATE, :old.id, :old.name, :new.name);
end;

--sequence
CREATE SEQUENCE testtable_seq
  MINVALUE 1
  START WITH 9
  INCREMENT BY 1
  NOCACHE;

--package
CREATE OR REPLACE PACKAGE test_pkg
IS
    TYPE refcursortype IS REF CURSOR;
    FUNCTION get_all RETURN refcursortype;
    PROCEDURE insert_testtable(name_in IN testtable.name%type);
    PROCEDURE delete_testtable(id_in IN testtable.id%type);
    PROCEDURE update_testtable(id_in IN testtable.id%type, name_in IN testtable.name%type);
END;

/

CREATE OR REPLACE PACKAGE BODY test_pkg
IS
    FUNCTION get_all RETURN refcursortype
    IS result refcursortype;
    BEGIN
        OPEN result FOR
            SELECT *
            FROM   testtable;

        RETURN result;
    END;

    PROCEDURE insert_testtable(
        name_in IN testtable.name%type
    )
    IS

    BEGIN

        INSERT INTO testtable
        VALUES ( 
            testtable_seq.NEXTVAL
            ,name_in ||' '||testtable_seq.CURRVAL
        );

        COMMIT;

    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    END;

    PROCEDURE delete_testtable(
        id_in IN testtable.id%type
    )
    IS

    BEGIN

        DELETE FROM testtable
        WHERE id = id_in;

    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    END;

    PROCEDURE update_testtable(
        id_in IN testtable.id%type
        , name_in IN testtable.name%type
    )
    IS

    BEGIN

        UPDATE testtable
        SET name = name_in
        WHERE id = id_in;

    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    END;
END;​