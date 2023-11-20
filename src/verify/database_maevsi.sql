-- Verify maevsi:database_maevsi on pg

BEGIN;

DO $$
BEGIN
  ASSERT (SELECT 1 FROM pg_database WHERE datname='maevsi') = 1;
END $$;

ROLLBACK;
