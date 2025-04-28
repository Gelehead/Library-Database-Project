--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-27 21:31:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 24578)
-- Name: adherent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adherent (
    id_adh integer NOT NULL,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    adresse text NOT NULL
);


ALTER TABLE public.adherent OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24577)
-- Name: adherent_id_adh_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adherent_id_adh_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.adherent_id_adh_seq OWNER TO postgres;

--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 217
-- Name: adherent_id_adh_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adherent_id_adh_seq OWNED BY public.adherent.id_adh;


--
-- TOC entry 220 (class 1259 OID 24587)
-- Name: auteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auteur (
    id_auteur integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL
);


ALTER TABLE public.auteur OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24586)
-- Name: auteur_id_auteur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auteur_id_auteur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auteur_id_auteur_seq OWNER TO postgres;

--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 219
-- Name: auteur_id_auteur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auteur_id_auteur_seq OWNED BY public.auteur.id_auteur;


--
-- TOC entry 228 (class 1259 OID 24658)
-- Name: commande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commande (
    id_commande integer NOT NULL,
    id_livre integer NOT NULL,
    id_adh integer NOT NULL,
    date_commande date NOT NULL,
    statut character varying(20) NOT NULL,
    CONSTRAINT commande_statut_check CHECK (((statut)::text = ANY ((ARRAY['en attente'::character varying, 'honor‚e'::character varying, 'annul‚e'::character varying])::text[])))
);


ALTER TABLE public.commande OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24657)
-- Name: commande_id_commande_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commande_id_commande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commande_id_commande_seq OWNER TO postgres;

--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 227
-- Name: commande_id_commande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_id_commande_seq OWNED BY public.commande.id_commande;


--
-- TOC entry 226 (class 1259 OID 24631)
-- Name: emprunt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emprunt (
    id_emprunt integer NOT NULL,
    id_livre integer NOT NULL,
    id_adh integer NOT NULL,
    date_emprunt date NOT NULL,
    date_retour date NOT NULL,
    CONSTRAINT emprunt_check CHECK ((date_retour > date_emprunt)),
    CONSTRAINT emprunt_check1 CHECK ((date_retour <= (date_emprunt + '14 days'::interval)))
);


ALTER TABLE public.emprunt OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24630)
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emprunt_id_emprunt_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emprunt_id_emprunt_seq OWNER TO postgres;

--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 225
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emprunt_id_emprunt_seq OWNED BY public.emprunt.id_emprunt;


--
-- TOC entry 224 (class 1259 OID 24613)
-- Name: exemplaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exemplaire (
    id_livre integer NOT NULL,
    isbn character varying(13) NOT NULL
);


ALTER TABLE public.exemplaire OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24612)
-- Name: exemplaire_id_livre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exemplaire_id_livre_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exemplaire_id_livre_seq OWNER TO postgres;

--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 223
-- Name: exemplaire_id_livre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exemplaire_id_livre_seq OWNED BY public.exemplaire.id_livre;


--
-- TOC entry 222 (class 1259 OID 24594)
-- Name: livre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livre (
    id_livre integer NOT NULL,
    isbn character varying(13),
    titre character varying(255) NOT NULL,
    genre character varying(50) NOT NULL,
    id_auteur integer NOT NULL
);


ALTER TABLE public.livre OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24593)
-- Name: livre_id_livre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livre_id_livre_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livre_id_livre_seq OWNER TO postgres;

--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 221
-- Name: livre_id_livre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livre_id_livre_seq OWNED BY public.livre.id_livre;


--
-- TOC entry 4772 (class 2604 OID 24581)
-- Name: adherent id_adh; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adherent ALTER COLUMN id_adh SET DEFAULT nextval('public.adherent_id_adh_seq'::regclass);


--
-- TOC entry 4773 (class 2604 OID 24590)
-- Name: auteur id_auteur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auteur ALTER COLUMN id_auteur SET DEFAULT nextval('public.auteur_id_auteur_seq'::regclass);


--
-- TOC entry 4777 (class 2604 OID 24661)
-- Name: commande id_commande; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande ALTER COLUMN id_commande SET DEFAULT nextval('public.commande_id_commande_seq'::regclass);


--
-- TOC entry 4776 (class 2604 OID 24634)
-- Name: emprunt id_emprunt; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt ALTER COLUMN id_emprunt SET DEFAULT nextval('public.emprunt_id_emprunt_seq'::regclass);


--
-- TOC entry 4775 (class 2604 OID 24616)
-- Name: exemplaire id_livre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplaire ALTER COLUMN id_livre SET DEFAULT nextval('public.exemplaire_id_livre_seq'::regclass);


--
-- TOC entry 4774 (class 2604 OID 24597)
-- Name: livre id_livre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre ALTER COLUMN id_livre SET DEFAULT nextval('public.livre_id_livre_seq'::regclass);


--
-- TOC entry 4945 (class 0 OID 24578)
-- Dependencies: 218
-- Data for Name: adherent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adherent (id_adh, nom, prenom, adresse) FROM stdin;
\.


--
-- TOC entry 4947 (class 0 OID 24587)
-- Dependencies: 220
-- Data for Name: auteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auteur (id_auteur, nom, prenom) FROM stdin;
\.


--
-- TOC entry 4955 (class 0 OID 24658)
-- Dependencies: 228
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commande (id_commande, id_livre, id_adh, date_commande, statut) FROM stdin;
\.


--
-- TOC entry 4953 (class 0 OID 24631)
-- Dependencies: 226
-- Data for Name: emprunt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) FROM stdin;
\.


--
-- TOC entry 4951 (class 0 OID 24613)
-- Dependencies: 224
-- Data for Name: exemplaire; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exemplaire (id_livre, isbn) FROM stdin;
\.


--
-- TOC entry 4949 (class 0 OID 24594)
-- Dependencies: 222
-- Data for Name: livre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livre (id_livre, isbn, titre, genre, id_auteur) FROM stdin;
\.


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 217
-- Name: adherent_id_adh_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adherent_id_adh_seq', 1, false);


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 219
-- Name: auteur_id_auteur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auteur_id_auteur_seq', 1, false);


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 227
-- Name: commande_id_commande_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_id_commande_seq', 1, false);


--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 225
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emprunt_id_emprunt_seq', 1, false);


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 223
-- Name: exemplaire_id_livre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exemplaire_id_livre_seq', 1, false);


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 221
-- Name: livre_id_livre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livre_id_livre_seq', 1, false);


--
-- TOC entry 4782 (class 2606 OID 24585)
-- Name: adherent adherent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adherent
    ADD CONSTRAINT adherent_pkey PRIMARY KEY (id_adh);


--
-- TOC entry 4784 (class 2606 OID 24592)
-- Name: auteur auteur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT auteur_pkey PRIMARY KEY (id_auteur);


--
-- TOC entry 4792 (class 2606 OID 24664)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id_commande);


--
-- TOC entry 4790 (class 2606 OID 24638)
-- Name: emprunt emprunt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_pkey PRIMARY KEY (id_emprunt);


--
-- TOC entry 4788 (class 2606 OID 24618)
-- Name: exemplaire exemplaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT exemplaire_pkey PRIMARY KEY (id_livre);


--
-- TOC entry 4786 (class 2606 OID 24599)
-- Name: livre livre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_pkey PRIMARY KEY (id_livre);


--
-- TOC entry 4797 (class 2606 OID 24670)
-- Name: commande commande_id_adh_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_adh_fkey FOREIGN KEY (id_adh) REFERENCES public.adherent(id_adh);


--
-- TOC entry 4798 (class 2606 OID 24665)
-- Name: commande commande_id_livre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_livre_fkey FOREIGN KEY (id_livre) REFERENCES public.exemplaire(id_livre);


--
-- TOC entry 4795 (class 2606 OID 24644)
-- Name: emprunt emprunt_id_adh_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_id_adh_fkey FOREIGN KEY (id_adh) REFERENCES public.adherent(id_adh);


--
-- TOC entry 4796 (class 2606 OID 24639)
-- Name: emprunt emprunt_id_livre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_id_livre_fkey FOREIGN KEY (id_livre) REFERENCES public.exemplaire(id_livre);


--
-- TOC entry 4794 (class 2606 OID 24619)
-- Name: exemplaire exemplaire_id_livre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT exemplaire_id_livre_fkey FOREIGN KEY (id_livre) REFERENCES public.livre(id_livre);


--
-- TOC entry 4793 (class 2606 OID 24600)
-- Name: livre livre_id_auteur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_id_auteur_fkey FOREIGN KEY (id_auteur) REFERENCES public.auteur(id_auteur);


-- Completed on 2025-04-27 21:31:04

--
-- PostgreSQL database dump complete
--

