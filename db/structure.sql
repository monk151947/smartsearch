--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assets (
    id integer NOT NULL,
    asset_file_name character varying(255),
    asset_content_type character varying(255),
    asset_file_size integer,
    asset_updated_at timestamp without time zone,
    searchapp_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    content text
);


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assets_id_seq OWNED BY assets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: searchapps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE searchapps (
    id integer NOT NULL,
    file_name character varying(255),
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: searchapps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE searchapps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: searchapps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE searchapps_id_seq OWNED BY searchapps.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assets ALTER COLUMN id SET DEFAULT nextval('assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY searchapps ALTER COLUMN id SET DEFAULT nextval('searchapps_id_seq'::regclass);


--
-- Name: assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: searchapps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY searchapps
    ADD CONSTRAINT searchapps_pkey PRIMARY KEY (id);


--
-- Name: assets_content; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX assets_content ON searchapps USING gin (to_tsvector('english'::regconfig, content));


--
-- Name: searchapps_content; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX searchapps_content ON searchapps USING gin (to_tsvector('english'::regconfig, content));


--
-- Name: searchapps_file_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX searchapps_file_name ON searchapps USING gin (to_tsvector('english'::regconfig, (file_name)::text));


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120716183342');

INSERT INTO schema_migrations (version) VALUES ('20120716193338');

INSERT INTO schema_migrations (version) VALUES ('20120728001306');

INSERT INTO schema_migrations (version) VALUES ('20120915134608');

INSERT INTO schema_migrations (version) VALUES ('20120915144845');

INSERT INTO schema_migrations (version) VALUES ('20120915152521');