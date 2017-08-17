SET statement_timeout = 0;
SET lock_timeout = 0;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    name character varying,
    start_balance numeric DEFAULT 0.0,
    balance numeric DEFAULT 0.0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT true,
    currency character varying,
    "precision" integer DEFAULT 2
);


--
-- Name: account_balances; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW account_balances AS
 SELECT accounts.currency,
    sum(accounts.balance) AS value,
    avg(accounts."precision") AS avg
   FROM accounts
  GROUP BY accounts.currency;


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin_users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cards (
    id integer NOT NULL,
    name character varying,
    "limit" numeric DEFAULT 0.0,
    payment_day integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean DEFAULT true,
    "precision" integer DEFAULT 2
);


--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cards_id_seq OWNED BY cards.id;


--
-- Name: movements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE movements (
    id integer NOT NULL,
    description character varying,
    value numeric,
    paid boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    kind character varying,
    paid_at date,
    category character varying,
    chargeable_id integer,
    chargeable_type character varying,
    parent_id integer,
    card_id integer,
    fee numeric(15,10) DEFAULT 0.0,
    fee_kind character varying,
    transaction_hash character varying
);


--
-- Name: movements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE movements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: movements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE movements_id_seq OWNED BY movements.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: trades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trades (
    id integer NOT NULL,
    source_id integer,
    destination_id integer,
    value_in numeric DEFAULT 0.0,
    value_out numeric DEFAULT 0.0,
    fee numeric DEFAULT 0.0,
    trade_at date,
    transaction_hash character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    confirmed boolean DEFAULT false,
    kind character varying
);


--
-- Name: trades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE trades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE trades_id_seq OWNED BY trades.id;


--
-- Name: transfers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE transfers (
    id integer NOT NULL,
    source_id integer,
    destination_id integer,
    value numeric,
    confirmed boolean DEFAULT false,
    transfered_at date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    transaction_hash character varying,
    fee numeric DEFAULT 0.0
);


--
-- Name: transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transfers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transfers_id_seq OWNED BY transfers.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cards ALTER COLUMN id SET DEFAULT nextval('cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY movements ALTER COLUMN id SET DEFAULT nextval('movements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY trades ALTER COLUMN id SET DEFAULT nextval('trades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transfers ALTER COLUMN id SET DEFAULT nextval('transfers_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: movements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY movements
    ADD CONSTRAINT movements_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: trades_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trades
    ADD CONSTRAINT trades_pkey PRIMARY KEY (id);


--
-- Name: transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_currency; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_accounts_on_currency ON accounts USING btree (currency);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_movements_on_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_movements_on_card_id ON movements USING btree (card_id);


--
-- Name: index_movements_on_chargeable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_movements_on_chargeable_id ON movements USING btree (chargeable_id);


--
-- Name: index_movements_on_description; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_movements_on_description ON movements USING btree (description);


--
-- Name: index_movements_on_paid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_movements_on_paid ON movements USING btree (paid);


--
-- Name: index_movements_on_paid_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_movements_on_paid_at ON movements USING btree (paid_at);


--
-- Name: index_movements_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_movements_on_parent_id ON movements USING btree (parent_id);


--
-- Name: index_movements_on_transaction_hash; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_movements_on_transaction_hash ON movements USING btree (transaction_hash, chargeable_type, chargeable_id);


--
-- Name: index_trades_on_destination_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trades_on_destination_id ON trades USING btree (destination_id);


--
-- Name: index_trades_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trades_on_source_id ON trades USING btree (source_id);


--
-- Name: index_trades_on_transaction_hash; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_trades_on_transaction_hash ON trades USING btree (transaction_hash);


--
-- Name: index_transfers_on_transaction_hash; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_transfers_on_transaction_hash ON transfers USING btree (transaction_hash);


--
-- Name: fk_rails_4ab97a6e99; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trades
    ADD CONSTRAINT fk_rails_4ab97a6e99 FOREIGN KEY (destination_id) REFERENCES accounts(id);


--
-- Name: fk_rails_839a2eadf4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY movements
    ADD CONSTRAINT fk_rails_839a2eadf4 FOREIGN KEY (card_id) REFERENCES cards(id);


--
-- Name: fk_rails_a0ee042f6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trades
    ADD CONSTRAINT fk_rails_a0ee042f6a FOREIGN KEY (source_id) REFERENCES accounts(id);


--
-- Name: fk_rails_c061f1e057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY movements
    ADD CONSTRAINT fk_rails_c061f1e057 FOREIGN KEY (parent_id) REFERENCES movements(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO "schema_migrations" (version) VALUES
('20150706112711'),
('20150707013744'),
('20150707013858'),
('20150707143115'),
('20150707145249'),
('20150719230828'),
('20150719231813'),
('20150719233259'),
('20150719233942'),
('20150720000353'),
('20150731230358'),
('20150731235328'),
('20150902231255'),
('20150902233852'),
('20150903044104'),
('20151229120411'),
('20151229121634'),
('20151230154042'),
('20160109093632'),
('20160109162839'),
('20160110111801'),
('20161008143524'),
('20161008163139'),
('20161008174056'),
('20161009004744'),
('20161009125332'),
('20161009132132'),
('20161009172403'),
('20161012162746'),
('20170107233635'),
('20170115115708'),
('20170204161532'),
('20170815225825'),
('20170815225827'),
('20170817224352');


