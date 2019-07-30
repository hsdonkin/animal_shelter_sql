--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: animal_types; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.animal_types (
    id integer NOT NULL,
    type character varying
);


ALTER TABLE public.animal_types OWNER TO "Guest";

--
-- Name: animal_types_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.animal_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animal_types_id_seq OWNER TO "Guest";

--
-- Name: animal_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.animal_types_id_seq OWNED BY public.animal_types.id;


--
-- Name: animals; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.animals (
    id integer NOT NULL,
    name character varying,
    gender character varying,
    date date,
    type integer,
    breed character varying
);


ALTER TABLE public.animals OWNER TO "Guest";

--
-- Name: animals_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.animals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animals_id_seq OWNER TO "Guest";

--
-- Name: animals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.animals_id_seq OWNED BY public.animals.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name character varying,
    phone character varying,
    animal_pref integer,
    breed_pref character varying
);


ALTER TABLE public.customers OWNER TO "Guest";

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO "Guest";

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: animal_types id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.animal_types ALTER COLUMN id SET DEFAULT nextval('public.animal_types_id_seq'::regclass);


--
-- Name: animals id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.animals ALTER COLUMN id SET DEFAULT nextval('public.animals_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Data for Name: animal_types; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.animal_types (id, type) FROM stdin;
1	cat
2	dog
\.


--
-- Data for Name: animals; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.animals (id, name, gender, date, type, breed) FROM stdin;
1	Hobbes	Male	2019-07-30	1	Tiger
2	Ellie	female	2019-07-30	1	american shorthair
3	Freddy	Male	2019-07-30	2	Golden Retriever
4	Beasley	male	2019-07-30	2	Mutt
5	Juneau	Female	2019-07-30	2	Pit / Lab Mix
6	Missy	Female	2019-07-30	1	American Longhair
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.customers (id, name, phone, animal_pref, breed_pref) FROM stdin;
1	Garland	415-123-4567	2	pug
2	hugh	7737472347304	1	looongcat
\.


--
-- Name: animal_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.animal_types_id_seq', 2, true);


--
-- Name: animals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.animals_id_seq', 6, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.customers_id_seq', 2, true);


--
-- Name: animal_types animal_types_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.animal_types
    ADD CONSTRAINT animal_types_pkey PRIMARY KEY (id);


--
-- Name: animals animals_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

