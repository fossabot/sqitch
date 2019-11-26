-- Deploy maevsi:table_event_group to pg
-- requires: schema_public
-- requires: role_account
-- requires: role_anonymous
-- requires: table_account

BEGIN;

CREATE TABLE maevsi.event_group (
    "id"            SERIAL PRIMARY KEY,
    "name"          TEXT NOT NULL CHECK (char_length("name") < 100),
    "slug"          TEXT NOT NULL CHECK (char_length("name") < 100 AND "slug" ~* '^[-A-Za-z0-9_]+$'),
    "organizer_id"  INTEGER REFERENCES maevsi_private.account("contact_id") NOT NULL,
    "archived"      BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE ("organizer_id", "slug")
);

COMMENT ON TABLE maevsi.event_group IS 'A group of events.';
COMMENT ON COLUMN maevsi.event_group.id IS 'The record''s id.';
COMMENT ON COLUMN maevsi.event_group.name IS 'The event group''s name.';
COMMENT ON COLUMN maevsi.event_group.slug IS 'The event group''s name, slugified.';
COMMENT ON COLUMN maevsi.event_group.organizer_id IS 'The id of the event group''s organizer.';
COMMENT ON COLUMN maevsi.event_group.archived IS 'Indicates whether the event group is archived.';

GRANT SELECT ON TABLE maevsi.event_group TO maevsi_account, maevsi_anonymous;
GRANT INSERT, UPDATE, DELETE ON TABLE maevsi.event_group TO maevsi_account;

GRANT USAGE ON SEQUENCE maevsi.event_group_id_seq TO maevsi_account;

ALTER TABLE maevsi.event_group ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY event_group_select ON maevsi.event_group FOR SELECT USING (
--     id IN (
--         SELECT event_group_id FROM maevsi.event_grouping
--     )
-- );

COMMIT;
