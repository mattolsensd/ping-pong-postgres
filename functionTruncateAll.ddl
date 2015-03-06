-- Used to clear ping_pong tables before running unit tests
CREATE OR REPLACE FUNCTION truncate_ping_pong_tables() RETURNS void AS $$
DECLARE
    statements CURSOR FOR
        SELECT tablename FROM pg_tables
        WHERE tableowner = 'ping_pong' AND schemaname = 'ping_pong';
BEGIN
    FOR stmt IN statements LOOP
        --RAISE NOTICE 'TRUNCATE TABLE ping_pong.%', quote_ident(stmt.tablename);
        EXECUTE 'TRUNCATE TABLE ping_pong.' || quote_ident(stmt.tablename) || ' CASCADE;';
    END LOOP;
END;
$$ LANGUAGE plpgsql;
