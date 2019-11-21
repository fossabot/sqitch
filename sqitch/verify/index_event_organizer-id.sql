-- Verify maevsi:index_event_organizer-id on pg

BEGIN;

SELECT 1/COUNT(*)
FROM   pg_class c
JOIN   pg_namespace n ON n.oid = c.relnamespace
WHERE  c.relname = 'idx_event_organizer-id'
AND    n.nspname = 'maevsi';

ROLLBACK;
