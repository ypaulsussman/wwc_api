--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO ypaulsussman;

--
-- Name: findings; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.findings (
    id bigint NOT NULL,
    intervention_id bigint NOT NULL,
    outcome_measure_id bigint NOT NULL,
    comparison text,
    outcome_domain text,
    period text,
    sample_description text,
    is_subgroup boolean,
    outcome_sample_size integer,
    outcome_measure_intervention_sample_size double precision,
    outcome_measure_comparison_sample_size double precision,
    intervention_clusters_sample_size integer,
    comparison_clusters_sample_size integer,
    intervention_mean double precision,
    comparison_mean double precision,
    intervention_standard_deviation integer,
    comparison_standard_deviation integer,
    effect_size_study double precision,
    effect_size_wwc double precision,
    improvement_index double precision,
    p_value_study double precision,
    p_value_wwc double precision,
    icc double precision,
    clusters_total double precision,
    is_statistically_significant boolean,
    finding_rating text,
    essa_rating text,
    l1_unit_of_analysis text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    review_id bigint NOT NULL
);


ALTER TABLE public.findings OWNER TO ypaulsussman;

--
-- Name: findings_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.findings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.findings_id_seq OWNER TO ypaulsussman;

--
-- Name: findings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.findings_id_seq OWNED BY public.findings.id;


--
-- Name: intervention_reports; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.intervention_reports (
    id bigint NOT NULL,
    intervention_id integer,
    protocol_id integer,
    numstudiesmeetingstandards integer,
    numstudieseligible integer,
    sample_size_intervention integer,
    effectiveness_rating text,
    outcome_domain text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.intervention_reports OWNER TO ypaulsussman;

--
-- Name: intervention_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.intervention_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intervention_reports_id_seq OWNER TO ypaulsussman;

--
-- Name: intervention_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.intervention_reports_id_seq OWNED BY public.intervention_reports.id;


--
-- Name: interventions; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.interventions (
    id bigint NOT NULL,
    name text,
    wwcid integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    wwc_url text
);


ALTER TABLE public.interventions OWNER TO ypaulsussman;

--
-- Name: interventions_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.interventions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interventions_id_seq OWNER TO ypaulsussman;

--
-- Name: interventions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.interventions_id_seq OWNED BY public.interventions.id;


--
-- Name: outcome_measures; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.outcome_measures (
    id bigint NOT NULL,
    name text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.outcome_measures OWNER TO ypaulsussman;

--
-- Name: outcome_measures_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.outcome_measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.outcome_measures_id_seq OWNER TO ypaulsussman;

--
-- Name: outcome_measures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.outcome_measures_id_seq OWNED BY public.outcome_measures.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name text,
    wwcid integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.products OWNER TO ypaulsussman;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO ypaulsussman;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: protocols; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.protocols (
    id bigint NOT NULL,
    name text,
    version double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.protocols OWNER TO ypaulsussman;

--
-- Name: protocols_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.protocols_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.protocols_id_seq OWNER TO ypaulsussman;

--
-- Name: protocols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.protocols_id_seq OWNED BY public.protocols.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    intervention_id integer,
    product_id integer,
    protocol_id integer,
    study_id integer,
    standards_version text,
    purpose_of_review text,
    posting_date date,
    study_rating text,
    rating_reason text,
    ineligibility_reason text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO ypaulsussman;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO ypaulsussman;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO ypaulsussman;

--
-- Name: studies; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.studies (
    id bigint NOT NULL,
    citation text,
    publication text,
    publication_date text,
    study_page_url text,
    study_design text,
    ericid text,
    multisite boolean,
    demographics_of_study_sample_international boolean,
    demographics_of_study_sample_english_language_learners double precision,
    demographics_of_study_sample_free_or_reduced_price_lunch double precision,
    ethnicity_hispanic double precision,
    ethnicity_not_hispanic double precision,
    race_asian double precision,
    race_black double precision,
    race_native_american double precision,
    race_other double precision,
    race_pacific_islander double precision,
    race_white double precision,
    gender_female double precision,
    gender_male double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.studies OWNER TO ypaulsussman;

--
-- Name: studies_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.studies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.studies_id_seq OWNER TO ypaulsussman;

--
-- Name: studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.studies_id_seq OWNED BY public.studies.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    password_digest character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO ypaulsussman;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO ypaulsussman;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: findings id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings ALTER COLUMN id SET DEFAULT nextval('public.findings_id_seq'::regclass);


--
-- Name: intervention_reports id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.intervention_reports ALTER COLUMN id SET DEFAULT nextval('public.intervention_reports_id_seq'::regclass);


--
-- Name: interventions id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.interventions ALTER COLUMN id SET DEFAULT nextval('public.interventions_id_seq'::regclass);


--
-- Name: outcome_measures id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.outcome_measures ALTER COLUMN id SET DEFAULT nextval('public.outcome_measures_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: protocols id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.protocols ALTER COLUMN id SET DEFAULT nextval('public.protocols_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: studies id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.studies ALTER COLUMN id SET DEFAULT nextval('public.studies_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: findings findings_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_pkey PRIMARY KEY (id);


--
-- Name: intervention_reports intervention_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.intervention_reports
    ADD CONSTRAINT intervention_reports_pkey PRIMARY KEY (id);


--
-- Name: interventions interventions_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.interventions
    ADD CONSTRAINT interventions_pkey PRIMARY KEY (id);


--
-- Name: outcome_measures outcome_measures_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.outcome_measures
    ADD CONSTRAINT outcome_measures_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: protocols protocols_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.protocols
    ADD CONSTRAINT protocols_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: studies studies_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.studies
    ADD CONSTRAINT studies_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_findings_on_intervention_id; Type: INDEX; Schema: public; Owner: ypaulsussman
--

CREATE INDEX index_findings_on_intervention_id ON public.findings USING btree (intervention_id);


--
-- Name: index_findings_on_outcome_measure_id; Type: INDEX; Schema: public; Owner: ypaulsussman
--

CREATE INDEX index_findings_on_outcome_measure_id ON public.findings USING btree (outcome_measure_id);


--
-- Name: index_findings_on_review_id; Type: INDEX; Schema: public; Owner: ypaulsussman
--

CREATE INDEX index_findings_on_review_id ON public.findings USING btree (review_id);


--
-- Name: findings fk_rails_3f17f49da7; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT fk_rails_3f17f49da7 FOREIGN KEY (intervention_id) REFERENCES public.interventions(id);


--
-- Name: findings fk_rails_ce77558900; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT fk_rails_ce77558900 FOREIGN KEY (outcome_measure_id) REFERENCES public.outcome_measures(id);


--
-- Name: findings fk_rails_e7978a50b9; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT fk_rails_e7978a50b9 FOREIGN KEY (review_id) REFERENCES public.reviews(id);


--
-- PostgreSQL database dump complete
--

