CREATE OR REPLACE FUNCTION "{schema}".drop_pepsicocas()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    row     record;
BEGIN
    FOR row IN
        select pg_class.relname from pg_class, pg_roles, pg_namespace where pg_roles.oid = pg_class.relowner and pg_roles.rolname = current_user and pg_namespace.oid = pg_class.relnamespace and pg_class.relkind = 'r' and pg_class.relname like 'pepsicoca%' and pg_class.relname not like 'pepsicoca\_1%'
    LOOP
        EXECUTE 'DROP TABLE ' || quote_ident(row.relname) || ' CASCADE';
        RAISE INFO 'Dropped table: %', quote_ident(row.relname);
    END LOOP;
END;
$function$
