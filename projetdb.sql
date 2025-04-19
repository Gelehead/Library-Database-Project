--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-18 15:51:47

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
-- TOC entry 218 (class 1259 OID 16550)
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
-- TOC entry 217 (class 1259 OID 16549)
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
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 217
-- Name: adherent_id_adh_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adherent_id_adh_seq OWNED BY public.adherent.id_adh;


--
-- TOC entry 220 (class 1259 OID 16559)
-- Name: auteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auteur (
    id_auteur integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL
);


ALTER TABLE public.auteur OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16558)
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
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 219
-- Name: auteur_id_auteur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auteur_id_auteur_seq OWNED BY public.auteur.id_auteur;


--
-- TOC entry 228 (class 1259 OID 16611)
-- Name: commande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commande (
    id_commande integer NOT NULL,
    isbn character varying(13) NOT NULL,
    id_adh integer NOT NULL,
    date_commande date NOT NULL,
    statut character varying(20) NOT NULL,
    CONSTRAINT commande_statut_check CHECK (((statut)::text = ANY ((ARRAY['en attente'::character varying, 'honorée'::character varying, 'annulée'::character varying])::text[])))
);


ALTER TABLE public.commande OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16610)
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
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 227
-- Name: commande_id_commande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_id_commande_seq OWNED BY public.commande.id_commande;


--
-- TOC entry 226 (class 1259 OID 16592)
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
-- TOC entry 225 (class 1259 OID 16591)
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
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 225
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emprunt_id_emprunt_seq OWNED BY public.emprunt.id_emprunt;


--
-- TOC entry 224 (class 1259 OID 16580)
-- Name: exemplaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exemplaire (
    id_livre integer NOT NULL,
    isbn character varying(13) NOT NULL
);


ALTER TABLE public.exemplaire OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16579)
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
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 223
-- Name: exemplaire_id_livre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exemplaire_id_livre_seq OWNED BY public.exemplaire.id_livre;


--
-- TOC entry 222 (class 1259 OID 16566)
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
-- TOC entry 221 (class 1259 OID 16565)
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
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 221
-- Name: livre_id_livre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livre_id_livre_seq OWNED BY public.livre.id_livre;


--
-- TOC entry 4766 (class 2604 OID 16553)
-- Name: adherent id_adh; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adherent ALTER COLUMN id_adh SET DEFAULT nextval('public.adherent_id_adh_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 16562)
-- Name: auteur id_auteur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auteur ALTER COLUMN id_auteur SET DEFAULT nextval('public.auteur_id_auteur_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 16614)
-- Name: commande id_commande; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande ALTER COLUMN id_commande SET DEFAULT nextval('public.commande_id_commande_seq'::regclass);


--
-- TOC entry 4770 (class 2604 OID 16595)
-- Name: emprunt id_emprunt; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt ALTER COLUMN id_emprunt SET DEFAULT nextval('public.emprunt_id_emprunt_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 16583)
-- Name: exemplaire id_livre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplaire ALTER COLUMN id_livre SET DEFAULT nextval('public.exemplaire_id_livre_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 16569)
-- Name: livre id_livre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre ALTER COLUMN id_livre SET DEFAULT nextval('public.livre_id_livre_seq'::regclass);


--
-- TOC entry 4941 (class 0 OID 16550)
-- Dependencies: 218
-- Data for Name: adherent; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (1, 'Leclerc', 'Anne', '123 Rue Principale, Montréal');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (2, 'Gagnon', 'Marc', '456 Av. des Pins, Montréal');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (3, 'Thibault', 'Julie', '789 Boul. St‑Laure, Laval');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (4, 'Roche', 'Claire', '321 Rue St‑Joseph, Québec');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (5, 'Beaulieu', 'Nicolas', '654 Av. Duplessis, Longueuil');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (6, 'Tremblay', 'Lucie', '987 Rue St‑Paul, Gatineau');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (7, 'Lapointe', 'Simon', '147 Rue Lajoie, Sherbrooke');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (8, 'Caron', 'Sandrine', '258 Chemin du Lac, Trois‑Rivières');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (9, 'Fortin', 'Olivier', '369 Rue Dorchester, Gatineau');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (10, 'Cloutier', 'Élise', '741 Av. de l’Université, Montréal');
INSERT INTO public.adherent (id_adh, nom, prenom, adresse) VALUES (11, 'Simard', 'Kévin', '852 Rue Wellington, Montréal');


--
-- TOC entry 4943 (class 0 OID 16559)
-- Dependencies: 220
-- Data for Name: auteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (1, 'Dupont', 'Jean');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (2, 'Martin', 'Marie');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (3, 'Durand', 'Pierre');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (4, 'Leroy', 'Sophie');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (5, 'Moreau', 'Luc');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (6, 'Fournier', 'Emma');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (7, 'Girard', 'Louis');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (8, 'Petit', 'Chloé');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (9, 'Rousseau', 'Paul');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (10, 'David', 'Emma');
INSERT INTO public.auteur (id_auteur, nom, prenom) VALUES (11, 'Bernard', 'Alice');


--
-- TOC entry 4951 (class 0 OID 16611)
-- Dependencies: 228
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (1, '9781234567897', 1, '2025-04-01', 'en attente');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (2, '9782345678901', 2, '2025-04-02', 'honorée');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (3, '9783456789012', 3, '2025-04-03', 'en attente');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (4, '9784567890123', 4, '2025-04-04', 'annulée');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (5, '9785678901234', 5, '2025-04-05', 'honorée');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (6, '9786789012345', 6, '2025-04-06', 'en attente');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (7, '9787890123456', 7, '2025-04-07', 'honorée');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (8, '9788901234567', 8, '2025-04-08', 'en attente');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (9, '9789012345678', 9, '2025-04-09', 'honorée');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (10, '9780123456789', 10, '2025-04-10', 'honorée');
INSERT INTO public.commande (id_commande, isbn, id_adh, date_commande, statut) VALUES (11, '9781122334455', 11, '2025-04-11', 'en attente');


--
-- TOC entry 4949 (class 0 OID 16592)
-- Dependencies: 226
-- Data for Name: emprunt; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (1, 1, 1, '2025-03-15', '2025-03-25');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (2, 2, 2, '2025-03-16', '2025-03-26');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (3, 3, 3, '2025-03-17', '2025-03-27');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (4, 4, 4, '2025-03-18', '2025-03-28');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (5, 5, 5, '2025-03-19', '2025-03-29');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (6, 6, 6, '2025-03-20', '2025-03-30');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (7, 7, 7, '2025-03-21', '2025-03-31');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (8, 8, 8, '2025-03-22', '2025-04-01');
INSERT INTO public.emprunt (id_emprunt, id_livre, id_adh, date_emprunt, date_retour) VALUES (9, 9, 9, '2025-03-23', '2025-04-02');


--
-- TOC entry 4947 (class 0 OID 16580)
-- Dependencies: 224
-- Data for Name: exemplaire; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.exemplaire (id_livre, isbn) VALUES (1, '9781234567897');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (2, '9781234567897');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (3, '9782345678901');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (4, '9782345678901');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (5, '9783456789012');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (6, '9783456789012');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (7, '9784567890123');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (8, '9785678901234');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (9, '9786789012345');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (10, '9786789012345');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (11, '9787890123456');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (12, '9788901234567');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (13, '9789012345678');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (14, '9780123456789');
INSERT INTO public.exemplaire (id_livre, isbn) VALUES (15, '9781122334455');


--
-- TOC entry 4945 (class 0 OID 16566)
-- Dependencies: 222
-- Data for Name: livre; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (1, '9781234567897', 'Le Petit Prince', 'Conte', 1);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (2, '9782345678901', 'Les Misérables', 'Roman', 2);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (3, '9783456789012', '1984', 'Dystopie', 3);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (4, '9784567890123', 'La Peste', 'Roman', 4);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (5, '9785678901234', 'Le Rouge et le Noir', 'Roman', 5);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (6, '9786789012345', 'Harry Potter à l’école des sorciers', 'Fantasy', 6);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (7, '9787890123456', 'Le Seigneur des Anneaux', 'Fantasy', 7);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (8, '9788901234567', 'Le Comte de Monte‑Cristo', 'Aventure', 8);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (9, '9789012345678', 'Le Journal d’Anne Frank', 'Biographie', 9);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (10, '9780123456789', 'Cien años de soledad', 'Roman', 10);
INSERT INTO public.livre (id_livre, isbn, titre, genre, id_auteur) VALUES (11, '9781122334455', 'Alice au pays des merveilles', 'Conte', 11);


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 217
-- Name: adherent_id_adh_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adherent_id_adh_seq', 11, true);


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 219
-- Name: auteur_id_auteur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auteur_id_auteur_seq', 11, true);


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 227
-- Name: commande_id_commande_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_id_commande_seq', 11, true);


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 225
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emprunt_id_emprunt_seq', 9, true);


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 223
-- Name: exemplaire_id_livre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exemplaire_id_livre_seq', 15, true);


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 221
-- Name: livre_id_livre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livre_id_livre_seq', 11, true);


--
-- TOC entry 4776 (class 2606 OID 16557)
-- Name: adherent adherent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adherent
    ADD CONSTRAINT adherent_pkey PRIMARY KEY (id_adh);


--
-- TOC entry 4778 (class 2606 OID 16564)
-- Name: auteur auteur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT auteur_pkey PRIMARY KEY (id_auteur);


--
-- TOC entry 4788 (class 2606 OID 16617)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id_commande);


--
-- TOC entry 4786 (class 2606 OID 16599)
-- Name: emprunt emprunt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_pkey PRIMARY KEY (id_emprunt);


--
-- TOC entry 4784 (class 2606 OID 16585)
-- Name: exemplaire exemplaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT exemplaire_pkey PRIMARY KEY (id_livre);


--
-- TOC entry 4780 (class 2606 OID 16573)
-- Name: livre livre_isbn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_isbn_key UNIQUE (isbn);


--
-- TOC entry 4782 (class 2606 OID 16571)
-- Name: livre livre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_pkey PRIMARY KEY (id_livre);


--
-- TOC entry 4793 (class 2606 OID 16623)
-- Name: commande commande_id_adh_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_adh_fkey FOREIGN KEY (id_adh) REFERENCES public.adherent(id_adh);


--
-- TOC entry 4794 (class 2606 OID 16618)
-- Name: commande commande_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.livre(isbn);


--
-- TOC entry 4791 (class 2606 OID 16605)
-- Name: emprunt emprunt_id_adh_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_id_adh_fkey FOREIGN KEY (id_adh) REFERENCES public.adherent(id_adh);


--
-- TOC entry 4792 (class 2606 OID 16600)
-- Name: emprunt emprunt_id_livre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_id_livre_fkey FOREIGN KEY (id_livre) REFERENCES public.exemplaire(id_livre);


--
-- TOC entry 4790 (class 2606 OID 16586)
-- Name: exemplaire exemplaire_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT exemplaire_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.livre(isbn);


--
-- TOC entry 4789 (class 2606 OID 16574)
-- Name: livre livre_id_auteur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_id_auteur_fkey FOREIGN KEY (id_auteur) REFERENCES public.auteur(id_auteur);


-- Completed on 2025-04-18 15:51:47

--
-- PostgreSQL database dump complete
--

