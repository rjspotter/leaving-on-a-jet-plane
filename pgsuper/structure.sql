--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Debian 11.5-3.pgdg90+1)
-- Dumped by pg_dump version 11.5 (Debian 11.5-3.pgdg90+1)

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

--
-- Name: emaildeliverytype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.emaildeliverytype AS ENUM (
    'attachment',
    'inline'
);


ALTER TYPE public.emaildeliverytype OWNER TO postgres;

--
-- Name: objecttypes; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.objecttypes AS ENUM (
    'query',
    'chart',
    'dashboard'
);


ALTER TYPE public.objecttypes OWNER TO postgres;

--
-- Name: sliceemailreportformat; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sliceemailreportformat AS ENUM (
    'visualization',
    'data'
);


ALTER TYPE public.sliceemailreportformat OWNER TO postgres;

--
-- Name: tagtypes; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tagtypes AS ENUM (
    'custom',
    'type',
    'owner',
    'favorited_by'
);


ALTER TYPE public.tagtypes OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ab_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_permission (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.ab_permission OWNER TO postgres;

--
-- Name: ab_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_permission_id_seq OWNER TO postgres;

--
-- Name: ab_permission_view; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_permission_view (
    id integer NOT NULL,
    permission_id integer,
    view_menu_id integer
);


ALTER TABLE public.ab_permission_view OWNER TO postgres;

--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_permission_view_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_permission_view_id_seq OWNER TO postgres;

--
-- Name: ab_permission_view_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_permission_view_role (
    id integer NOT NULL,
    permission_view_id integer,
    role_id integer
);


ALTER TABLE public.ab_permission_view_role OWNER TO postgres;

--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_permission_view_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_permission_view_role_id_seq OWNER TO postgres;

--
-- Name: ab_register_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_register_user (
    id integer NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    password character varying(256),
    email character varying(64) NOT NULL,
    registration_date timestamp without time zone,
    registration_hash character varying(256)
);


ALTER TABLE public.ab_register_user OWNER TO postgres;

--
-- Name: ab_register_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_register_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_register_user_id_seq OWNER TO postgres;

--
-- Name: ab_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_role (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.ab_role OWNER TO postgres;

--
-- Name: ab_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_role_id_seq OWNER TO postgres;

--
-- Name: ab_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_user (
    id integer NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    password character varying(256),
    active boolean,
    email character varying(64) NOT NULL,
    last_login timestamp without time zone,
    login_count integer,
    fail_login_count integer,
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    created_by_fk integer,
    changed_by_fk integer
);


ALTER TABLE public.ab_user OWNER TO postgres;

--
-- Name: ab_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_user_id_seq OWNER TO postgres;

--
-- Name: ab_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_user_role (
    id integer NOT NULL,
    user_id integer,
    role_id integer
);


ALTER TABLE public.ab_user_role OWNER TO postgres;

--
-- Name: ab_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_user_role_id_seq OWNER TO postgres;

--
-- Name: ab_view_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_view_menu (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.ab_view_menu OWNER TO postgres;

--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_view_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_view_menu_id_seq OWNER TO postgres;

--
-- Name: access_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access_request (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    datasource_type character varying(200),
    datasource_id integer,
    changed_by_fk integer,
    created_by_fk integer
);


ALTER TABLE public.access_request OWNER TO postgres;

--
-- Name: access_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.access_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_request_id_seq OWNER TO postgres;

--
-- Name: access_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.access_request_id_seq OWNED BY public.access_request.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: annotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annotation (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    start_dttm timestamp without time zone,
    end_dttm timestamp without time zone,
    layer_id integer,
    short_descr character varying(500),
    long_descr text,
    changed_by_fk integer,
    created_by_fk integer,
    json_metadata text
);


ALTER TABLE public.annotation OWNER TO postgres;

--
-- Name: annotation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.annotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_id_seq OWNER TO postgres;

--
-- Name: annotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.annotation_id_seq OWNED BY public.annotation.id;


--
-- Name: annotation_layer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annotation_layer (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    name character varying(250),
    descr text,
    changed_by_fk integer,
    created_by_fk integer
);


ALTER TABLE public.annotation_layer OWNER TO postgres;

--
-- Name: annotation_layer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.annotation_layer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_layer_id_seq OWNER TO postgres;

--
-- Name: annotation_layer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.annotation_layer_id_seq OWNED BY public.annotation_layer.id;


--
-- Name: clusters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clusters (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    cluster_name character varying(250),
    broker_host character varying(255),
    broker_port integer,
    broker_endpoint character varying(255),
    metadata_last_refreshed timestamp without time zone,
    created_by_fk integer,
    changed_by_fk integer,
    cache_timeout integer,
    verbose_name character varying(250),
    broker_pass bytea,
    broker_user character varying(255)
);


ALTER TABLE public.clusters OWNER TO postgres;

--
-- Name: clusters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clusters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clusters_id_seq OWNER TO postgres;

--
-- Name: clusters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clusters_id_seq OWNED BY public.clusters.id;


--
-- Name: columns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.columns (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    column_name character varying(255) NOT NULL,
    is_active boolean,
    type character varying(32),
    groupby boolean,
    filterable boolean,
    description text,
    created_by_fk integer,
    changed_by_fk integer,
    dimension_spec_json text,
    verbose_name character varying(1024),
    datasource_id integer
);


ALTER TABLE public.columns OWNER TO postgres;

--
-- Name: columns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.columns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.columns_id_seq OWNER TO postgres;

--
-- Name: columns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.columns_id_seq OWNED BY public.columns.id;


--
-- Name: css_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.css_templates (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    template_name character varying(250),
    css text,
    changed_by_fk integer,
    created_by_fk integer
);


ALTER TABLE public.css_templates OWNER TO postgres;

--
-- Name: css_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.css_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.css_templates_id_seq OWNER TO postgres;

--
-- Name: css_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.css_templates_id_seq OWNED BY public.css_templates.id;


--
-- Name: dashboard_email_schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_email_schedules (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    active boolean,
    crontab character varying(50),
    recipients text,
    deliver_as_group boolean,
    delivery_type public.emaildeliverytype,
    dashboard_id integer,
    created_by_fk integer,
    changed_by_fk integer,
    user_id integer
);


ALTER TABLE public.dashboard_email_schedules OWNER TO postgres;

--
-- Name: dashboard_email_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_email_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_email_schedules_id_seq OWNER TO postgres;

--
-- Name: dashboard_email_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_email_schedules_id_seq OWNED BY public.dashboard_email_schedules.id;


--
-- Name: dashboard_slices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_slices (
    id integer NOT NULL,
    dashboard_id integer,
    slice_id integer
);


ALTER TABLE public.dashboard_slices OWNER TO postgres;

--
-- Name: dashboard_slices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_slices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_slices_id_seq OWNER TO postgres;

--
-- Name: dashboard_slices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_slices_id_seq OWNED BY public.dashboard_slices.id;


--
-- Name: dashboard_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_user (
    id integer NOT NULL,
    user_id integer,
    dashboard_id integer
);


ALTER TABLE public.dashboard_user OWNER TO postgres;

--
-- Name: dashboard_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_user_id_seq OWNER TO postgres;

--
-- Name: dashboard_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_user_id_seq OWNED BY public.dashboard_user.id;


--
-- Name: dashboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboards (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    dashboard_title character varying(500),
    position_json text,
    created_by_fk integer,
    changed_by_fk integer,
    css text,
    description text,
    slug character varying(255),
    json_metadata text,
    published boolean
);


ALTER TABLE public.dashboards OWNER TO postgres;

--
-- Name: dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboards_id_seq OWNER TO postgres;

--
-- Name: dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboards_id_seq OWNED BY public.dashboards.id;


--
-- Name: datasources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datasources (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    datasource_name character varying(255) NOT NULL,
    is_featured boolean,
    is_hidden boolean,
    description text,
    default_endpoint text,
    cluster_name character varying(250),
    created_by_fk integer,
    changed_by_fk integer,
    "offset" integer,
    cache_timeout integer,
    perm character varying(1000),
    filter_select_enabled boolean,
    params character varying(1000),
    fetch_values_from character varying(100)
);


ALTER TABLE public.datasources OWNER TO postgres;

--
-- Name: datasources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datasources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasources_id_seq OWNER TO postgres;

--
-- Name: datasources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datasources_id_seq OWNED BY public.datasources.id;


--
-- Name: dbs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dbs (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    database_name character varying(250),
    sqlalchemy_uri character varying(1024),
    created_by_fk integer,
    changed_by_fk integer,
    password bytea,
    cache_timeout integer,
    extra text,
    select_as_create_table_as boolean,
    allow_ctas boolean,
    expose_in_sqllab boolean,
    force_ctas_schema character varying(250),
    allow_run_async boolean,
    allow_dml boolean,
    perm character varying(1000),
    verbose_name character varying(250),
    impersonate_user boolean,
    allow_multi_schema_metadata_fetch boolean,
    allow_csv_upload boolean DEFAULT true NOT NULL
);


ALTER TABLE public.dbs OWNER TO postgres;

--
-- Name: dbs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dbs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbs_id_seq OWNER TO postgres;

--
-- Name: dbs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dbs_id_seq OWNED BY public.dbs.id;


--
-- Name: druiddatasource_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.druiddatasource_user (
    id integer NOT NULL,
    user_id integer,
    datasource_id integer
);


ALTER TABLE public.druiddatasource_user OWNER TO postgres;

--
-- Name: druiddatasource_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.druiddatasource_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.druiddatasource_user_id_seq OWNER TO postgres;

--
-- Name: druiddatasource_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.druiddatasource_user_id_seq OWNED BY public.druiddatasource_user.id;


--
-- Name: favstar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favstar (
    id integer NOT NULL,
    user_id integer,
    class_name character varying(50),
    obj_id integer,
    dttm timestamp without time zone
);


ALTER TABLE public.favstar OWNER TO postgres;

--
-- Name: favstar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favstar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favstar_id_seq OWNER TO postgres;

--
-- Name: favstar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favstar_id_seq OWNED BY public.favstar.id;


--
-- Name: keyvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keyvalue (
    id integer NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.keyvalue OWNER TO postgres;

--
-- Name: keyvalue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.keyvalue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keyvalue_id_seq OWNER TO postgres;

--
-- Name: keyvalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.keyvalue_id_seq OWNED BY public.keyvalue.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    action character varying(512),
    user_id integer,
    json text,
    dttm timestamp without time zone,
    dashboard_id integer,
    slice_id integer,
    duration_ms integer,
    referrer character varying(1024)
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_id_seq OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metrics (
    id integer NOT NULL,
    metric_name character varying(255) NOT NULL,
    verbose_name character varying(1024),
    metric_type character varying(32),
    json text NOT NULL,
    description text,
    changed_by_fk integer,
    changed_on timestamp without time zone,
    created_by_fk integer,
    created_on timestamp without time zone,
    is_restricted boolean,
    d3format character varying(128),
    warning_text text,
    datasource_id integer
);


ALTER TABLE public.metrics OWNER TO postgres;

--
-- Name: metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metrics_id_seq OWNER TO postgres;

--
-- Name: metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.metrics_id_seq OWNED BY public.metrics.id;


--
-- Name: query; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.query (
    id integer NOT NULL,
    client_id character varying(11) NOT NULL,
    database_id integer NOT NULL,
    tmp_table_name character varying(256),
    tab_name character varying(256),
    sql_editor_id character varying(256),
    user_id integer,
    status character varying(16),
    schema character varying(256),
    sql text,
    select_sql text,
    executed_sql text,
    "limit" integer,
    select_as_cta boolean,
    select_as_cta_used boolean,
    progress integer,
    rows integer,
    error_message text,
    start_time numeric(20,6),
    changed_on timestamp without time zone,
    end_time numeric(20,6),
    results_key character varying(64),
    start_running_time numeric(20,6),
    end_result_backend_time numeric(20,6),
    tracking_url text,
    extra_json text
);


ALTER TABLE public.query OWNER TO postgres;

--
-- Name: query_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.query_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_id_seq OWNER TO postgres;

--
-- Name: query_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.query_id_seq OWNED BY public.query.id;


--
-- Name: saved_query; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_query (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    user_id integer,
    db_id integer,
    label character varying(256),
    schema character varying(128),
    sql text,
    description text,
    changed_by_fk integer,
    created_by_fk integer,
    extra_json text
);


ALTER TABLE public.saved_query OWNER TO postgres;

--
-- Name: saved_query_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.saved_query_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saved_query_id_seq OWNER TO postgres;

--
-- Name: saved_query_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.saved_query_id_seq OWNED BY public.saved_query.id;


--
-- Name: slice_email_schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.slice_email_schedules (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    active boolean,
    crontab character varying(50),
    recipients text,
    deliver_as_group boolean,
    delivery_type public.emaildeliverytype,
    slice_id integer,
    email_format public.sliceemailreportformat,
    created_by_fk integer,
    changed_by_fk integer,
    user_id integer
);


ALTER TABLE public.slice_email_schedules OWNER TO postgres;

--
-- Name: slice_email_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.slice_email_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.slice_email_schedules_id_seq OWNER TO postgres;

--
-- Name: slice_email_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.slice_email_schedules_id_seq OWNED BY public.slice_email_schedules.id;


--
-- Name: slice_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.slice_user (
    id integer NOT NULL,
    user_id integer,
    slice_id integer
);


ALTER TABLE public.slice_user OWNER TO postgres;

--
-- Name: slice_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.slice_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.slice_user_id_seq OWNER TO postgres;

--
-- Name: slice_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.slice_user_id_seq OWNED BY public.slice_user.id;


--
-- Name: slices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.slices (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    slice_name character varying(250),
    datasource_type character varying(200),
    datasource_name character varying(2000),
    viz_type character varying(250),
    params text,
    created_by_fk integer,
    changed_by_fk integer,
    description text,
    cache_timeout integer,
    perm character varying(2000),
    datasource_id integer
);


ALTER TABLE public.slices OWNER TO postgres;

--
-- Name: slices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.slices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.slices_id_seq OWNER TO postgres;

--
-- Name: slices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.slices_id_seq OWNED BY public.slices.id;


--
-- Name: sql_metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sql_metrics (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    metric_name character varying(255) NOT NULL,
    verbose_name character varying(1024),
    metric_type character varying(32),
    table_id integer,
    expression text NOT NULL,
    description text,
    created_by_fk integer,
    changed_by_fk integer,
    is_restricted boolean,
    d3format character varying(128),
    warning_text text
);


ALTER TABLE public.sql_metrics OWNER TO postgres;

--
-- Name: sql_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sql_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sql_metrics_id_seq OWNER TO postgres;

--
-- Name: sql_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sql_metrics_id_seq OWNED BY public.sql_metrics.id;


--
-- Name: sqlatable_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sqlatable_user (
    id integer NOT NULL,
    user_id integer,
    table_id integer
);


ALTER TABLE public.sqlatable_user OWNER TO postgres;

--
-- Name: sqlatable_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sqlatable_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sqlatable_user_id_seq OWNER TO postgres;

--
-- Name: sqlatable_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sqlatable_user_id_seq OWNED BY public.sqlatable_user.id;


--
-- Name: table_columns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.table_columns (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    table_id integer,
    column_name character varying(255) NOT NULL,
    is_dttm boolean,
    is_active boolean,
    type character varying(32),
    groupby boolean,
    filterable boolean,
    description text,
    created_by_fk integer,
    changed_by_fk integer,
    expression text,
    verbose_name character varying(1024),
    python_date_format character varying(255)
);


ALTER TABLE public.table_columns OWNER TO postgres;

--
-- Name: table_columns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.table_columns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.table_columns_id_seq OWNER TO postgres;

--
-- Name: table_columns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.table_columns_id_seq OWNED BY public.table_columns.id;


--
-- Name: tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tables (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    table_name character varying(250),
    main_dttm_col character varying(250),
    default_endpoint text,
    database_id integer NOT NULL,
    created_by_fk integer,
    changed_by_fk integer,
    "offset" integer,
    description text,
    is_featured boolean,
    cache_timeout integer,
    schema character varying(255),
    sql text,
    params text,
    perm character varying(1000),
    filter_select_enabled boolean,
    fetch_values_predicate character varying(1000),
    is_sqllab_view boolean DEFAULT false,
    template_params text
);


ALTER TABLE public.tables OWNER TO postgres;

--
-- Name: tables_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tables_id_seq OWNER TO postgres;

--
-- Name: tables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tables_id_seq OWNED BY public.tables.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    name character varying(250),
    type public.tagtypes,
    created_by_fk integer,
    changed_by_fk integer
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: tagged_object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tagged_object (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    tag_id integer,
    object_id integer,
    object_type public.objecttypes,
    created_by_fk integer,
    changed_by_fk integer
);


ALTER TABLE public.tagged_object OWNER TO postgres;

--
-- Name: tagged_object_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tagged_object_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tagged_object_id_seq OWNER TO postgres;

--
-- Name: tagged_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tagged_object_id_seq OWNED BY public.tagged_object.id;


--
-- Name: url; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.url (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    url text,
    created_by_fk integer,
    changed_by_fk integer
);


ALTER TABLE public.url OWNER TO postgres;

--
-- Name: url_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.url_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_id_seq OWNER TO postgres;

--
-- Name: url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.url_id_seq OWNED BY public.url.id;


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    id integer NOT NULL,
    user_id integer,
    welcome_dashboard_id integer,
    created_by_fk integer,
    changed_by_fk integer
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_attribute_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_attribute_id_seq OWNER TO postgres;

--
-- Name: user_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_attribute_id_seq OWNED BY public.user_attribute.id;


--
-- Name: access_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_request ALTER COLUMN id SET DEFAULT nextval('public.access_request_id_seq'::regclass);


--
-- Name: annotation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation ALTER COLUMN id SET DEFAULT nextval('public.annotation_id_seq'::regclass);


--
-- Name: annotation_layer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_layer ALTER COLUMN id SET DEFAULT nextval('public.annotation_layer_id_seq'::regclass);


--
-- Name: clusters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters ALTER COLUMN id SET DEFAULT nextval('public.clusters_id_seq'::regclass);


--
-- Name: columns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.columns ALTER COLUMN id SET DEFAULT nextval('public.columns_id_seq'::regclass);


--
-- Name: css_templates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.css_templates ALTER COLUMN id SET DEFAULT nextval('public.css_templates_id_seq'::regclass);


--
-- Name: dashboard_email_schedules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_email_schedules ALTER COLUMN id SET DEFAULT nextval('public.dashboard_email_schedules_id_seq'::regclass);


--
-- Name: dashboard_slices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_slices ALTER COLUMN id SET DEFAULT nextval('public.dashboard_slices_id_seq'::regclass);


--
-- Name: dashboard_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_user ALTER COLUMN id SET DEFAULT nextval('public.dashboard_user_id_seq'::regclass);


--
-- Name: dashboards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboards ALTER COLUMN id SET DEFAULT nextval('public.dashboards_id_seq'::regclass);


--
-- Name: datasources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasources ALTER COLUMN id SET DEFAULT nextval('public.datasources_id_seq'::regclass);


--
-- Name: dbs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dbs ALTER COLUMN id SET DEFAULT nextval('public.dbs_id_seq'::regclass);


--
-- Name: druiddatasource_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.druiddatasource_user ALTER COLUMN id SET DEFAULT nextval('public.druiddatasource_user_id_seq'::regclass);


--
-- Name: favstar id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favstar ALTER COLUMN id SET DEFAULT nextval('public.favstar_id_seq'::regclass);


--
-- Name: keyvalue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keyvalue ALTER COLUMN id SET DEFAULT nextval('public.keyvalue_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: metrics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metrics ALTER COLUMN id SET DEFAULT nextval('public.metrics_id_seq'::regclass);


--
-- Name: query id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query ALTER COLUMN id SET DEFAULT nextval('public.query_id_seq'::regclass);


--
-- Name: saved_query id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_query ALTER COLUMN id SET DEFAULT nextval('public.saved_query_id_seq'::regclass);


--
-- Name: slice_email_schedules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_email_schedules ALTER COLUMN id SET DEFAULT nextval('public.slice_email_schedules_id_seq'::regclass);


--
-- Name: slice_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_user ALTER COLUMN id SET DEFAULT nextval('public.slice_user_id_seq'::regclass);


--
-- Name: slices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slices ALTER COLUMN id SET DEFAULT nextval('public.slices_id_seq'::regclass);


--
-- Name: sql_metrics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sql_metrics ALTER COLUMN id SET DEFAULT nextval('public.sql_metrics_id_seq'::regclass);


--
-- Name: sqlatable_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sqlatable_user ALTER COLUMN id SET DEFAULT nextval('public.sqlatable_user_id_seq'::regclass);


--
-- Name: table_columns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_columns ALTER COLUMN id SET DEFAULT nextval('public.table_columns_id_seq'::regclass);


--
-- Name: tables id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables ALTER COLUMN id SET DEFAULT nextval('public.tables_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: tagged_object id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tagged_object ALTER COLUMN id SET DEFAULT nextval('public.tagged_object_id_seq'::regclass);


--
-- Name: url id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.url ALTER COLUMN id SET DEFAULT nextval('public.url_id_seq'::regclass);


--
-- Name: user_attribute id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute ALTER COLUMN id SET DEFAULT nextval('public.user_attribute_id_seq'::regclass);


--
-- Data for Name: ab_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_permission (id, name) FROM stdin;
1	datasource_access
2	can_this_form_get
3	can_this_form_post
4	can_list
5	can_delete
6	can_download
7	can_userinfo
8	can_add
9	can_show
10	can_edit
11	resetmypassword
12	resetpasswords
13	userinfoedit
14	copyrole
15	can_chart
16	can_get
17	can_query_form_data
18	can_query
19	muldelete
20	refresh
21	yaml_export
22	can_download_dashboards
23	mulexport
24	can_get_value
25	can_store
26	can_shortner
27	can_available_domains
28	can_add_slices
29	can_profile
30	can_import_dashboards
31	can_stop_query
32	can_schemas_access_for_csv_upload
33	can_annotation_json
34	can_request_access
35	can_results
36	can_fave_slices
37	can_tables
38	can_csv
39	can_testconn
40	can_filter
41	can_extra_table_metadata
42	can_explore_json
43	can_cache_key_exist
44	can_slice_json
45	can_slice_query
46	can_sqllab
47	can_cached_key
48	can_explore
49	can_table
50	can_approve
51	can_copy_dash
52	can_user_slices
53	can_datasources
54	can_checkbox
55	can_search_queries
56	can_schemas
57	can_fave_dashboards_by_username
58	can_publish
59	can_save_dash
60	can_explorev2
61	can_queries
62	can_sql_json
63	can_fetch_datasource_metadata
64	can_sqllab_viz
65	can_created_slices
66	can_slice
67	can_sync_druid_source
68	can_validate_sql_json
69	can_csrf_token
70	can_select_star
71	can_warm_up_cache
72	can_dashboard
73	can_override_role_permissions
74	can_created_dashboards
75	can_favstar
76	can_recent_activity
77	can_fave_dashboards
78	can_my_queries
79	can_new
80	can_save
81	can_external_metadata
82	can_post
83	can_suggestions
84	can_tagged_objects
85	can_scan_new_datasources
86	can_refresh_datasources
87	menu_access
88	all_datasource_access
89	all_database_access
90	can_only_access_owned_queries
91	database_access
92	schema_access
\.


--
-- Data for Name: ab_permission_view; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_permission_view (id, permission_id, view_menu_id) FROM stdin;
1	1	1
2	1	2
3	2	7
4	3	7
5	2	8
6	3	8
7	2	9
8	3	9
9	4	11
10	5	11
11	6	11
12	7	11
13	8	11
14	9	11
15	10	11
16	11	11
17	12	11
18	13	11
19	4	12
20	5	12
21	6	12
22	8	12
23	9	12
24	10	12
25	14	12
26	15	13
27	4	14
28	4	15
29	4	16
30	16	17
31	17	18
32	18	18
33	4	19
34	5	19
35	6	19
36	8	19
37	9	19
38	10	19
39	4	20
40	5	20
41	6	20
42	8	20
43	9	20
44	10	20
45	4	21
46	5	21
47	6	21
48	8	21
49	9	21
50	10	21
51	19	21
52	20	21
53	21	21
54	4	22
55	5	22
56	8	22
57	9	22
58	10	22
59	4	23
60	5	23
61	6	23
62	8	23
63	9	23
64	10	23
65	19	23
66	21	23
67	2	24
68	3	24
69	4	25
70	5	25
71	6	25
72	8	25
73	9	25
74	10	25
75	19	25
76	21	25
77	6	22
78	19	22
79	21	22
80	4	26
81	5	26
82	6	26
83	8	26
84	9	26
85	10	26
86	19	26
87	4	27
88	5	27
89	6	27
90	8	27
91	9	27
92	10	27
93	19	27
94	4	28
95	5	28
96	6	28
97	8	28
98	9	28
99	10	28
100	19	28
101	4	29
102	5	29
103	6	29
104	22	29
105	8	29
106	9	29
107	10	29
108	19	29
109	23	29
110	4	30
111	5	30
112	6	30
113	22	30
114	8	30
115	9	30
116	10	30
117	19	30
118	23	30
119	4	31
120	5	31
121	6	31
122	22	31
123	8	31
124	9	31
125	10	31
126	19	31
127	23	31
128	24	32
129	25	32
130	26	33
131	27	34
132	28	34
133	29	34
134	30	34
135	31	34
136	32	34
137	33	34
138	34	34
139	35	34
140	36	34
141	37	34
142	38	34
143	39	34
144	40	34
145	41	34
146	42	34
147	43	34
148	44	34
149	45	34
150	46	34
151	47	34
152	48	34
153	49	34
154	50	34
155	51	34
156	52	34
157	53	34
158	54	34
159	55	34
160	56	34
161	57	34
162	58	34
163	59	34
164	60	34
165	61	34
166	62	34
167	63	34
168	64	34
169	65	34
170	66	34
171	67	34
172	68	34
173	69	34
174	70	34
175	71	34
176	72	34
177	73	34
178	74	34
179	75	34
180	76	34
181	77	34
182	4	35
183	5	35
184	6	35
185	8	35
186	9	35
187	10	35
188	19	35
189	4	36
190	5	36
191	6	36
192	8	36
193	9	36
194	10	36
195	19	36
196	4	37
197	5	37
198	6	37
199	8	37
200	9	37
201	10	37
202	4	38
203	5	38
204	6	38
205	8	38
206	9	38
207	10	38
208	19	38
209	4	39
210	5	39
211	6	39
212	8	39
213	9	39
214	10	39
215	19	39
216	78	40
217	79	41
218	4	42
219	5	42
220	6	42
221	8	42
222	9	42
223	10	42
224	19	42
225	4	43
226	5	43
227	6	43
228	8	43
229	9	43
230	10	43
231	19	43
232	80	44
233	81	44
234	16	44
235	82	45
236	5	45
237	16	45
238	83	45
239	84	45
240	4	46
241	5	46
242	6	46
243	8	46
244	9	46
245	10	46
246	4	47
247	5	47
248	6	47
249	8	47
250	9	47
251	10	47
252	4	48
253	5	48
254	6	48
255	8	48
256	9	48
257	10	48
258	4	49
259	5	49
260	6	49
261	8	49
262	9	49
263	10	49
264	19	49
265	21	49
266	4	50
267	5	50
268	6	50
269	8	50
270	9	50
271	10	50
272	19	50
273	21	50
274	85	51
275	86	51
276	87	52
277	87	53
278	87	54
279	87	55
280	87	56
281	87	57
282	87	58
283	87	59
284	87	60
285	87	61
286	87	62
287	87	63
288	87	64
289	87	65
290	87	66
291	87	67
292	87	68
293	87	69
294	87	70
295	87	71
296	87	72
297	87	73
298	87	74
299	87	75
300	87	76
301	87	77
302	87	78
303	87	79
304	88	80
305	89	81
306	90	82
307	91	1
308	91	2
309	92	83
310	92	84
311	1	85
312	91	85
313	1	86
\.


--
-- Data for Name: ab_permission_view_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_permission_view_role (id, permission_view_id, role_id) FROM stdin;
1	3	1
2	4	1
3	5	1
4	6	1
5	7	1
6	8	1
7	9	1
8	10	1
9	11	1
10	12	1
11	13	1
12	14	1
13	15	1
14	16	1
15	17	1
16	18	1
17	19	1
18	20	1
19	21	1
20	22	1
21	23	1
22	24	1
23	25	1
24	26	1
25	27	1
26	28	1
27	29	1
28	30	1
29	31	1
30	32	1
31	33	1
32	34	1
33	35	1
34	36	1
35	37	1
36	38	1
37	39	1
38	40	1
39	41	1
40	42	1
41	43	1
42	44	1
43	45	1
44	46	1
45	47	1
46	48	1
47	49	1
48	50	1
49	51	1
50	52	1
51	53	1
52	54	1
53	55	1
54	56	1
55	57	1
56	58	1
57	59	1
58	60	1
59	61	1
60	62	1
61	63	1
62	64	1
63	65	1
64	66	1
65	67	1
66	68	1
67	69	1
68	70	1
69	71	1
70	72	1
71	73	1
72	74	1
73	75	1
74	76	1
75	77	1
76	78	1
77	79	1
78	80	1
79	81	1
80	82	1
81	83	1
82	84	1
83	85	1
84	86	1
85	87	1
86	88	1
87	89	1
88	90	1
89	91	1
90	92	1
91	93	1
92	94	1
93	95	1
94	96	1
95	97	1
96	98	1
97	99	1
98	100	1
99	101	1
100	102	1
101	103	1
102	104	1
103	105	1
104	106	1
105	107	1
106	108	1
107	109	1
108	110	1
109	111	1
110	112	1
111	113	1
112	114	1
113	115	1
114	116	1
115	117	1
116	118	1
117	119	1
118	120	1
119	121	1
120	122	1
121	123	1
122	124	1
123	125	1
124	126	1
125	127	1
126	128	1
127	129	1
128	130	1
129	131	1
130	132	1
131	133	1
132	134	1
133	135	1
134	136	1
135	137	1
136	138	1
137	139	1
138	140	1
139	141	1
140	142	1
141	143	1
142	144	1
143	145	1
144	146	1
145	147	1
146	148	1
147	149	1
148	150	1
149	151	1
150	152	1
151	153	1
152	154	1
153	155	1
154	156	1
155	157	1
156	158	1
157	159	1
158	160	1
159	161	1
160	162	1
161	163	1
162	164	1
163	165	1
164	166	1
165	167	1
166	168	1
167	169	1
168	170	1
169	171	1
170	172	1
171	173	1
172	174	1
173	175	1
174	176	1
175	177	1
176	178	1
177	179	1
178	180	1
179	181	1
180	182	1
181	183	1
182	184	1
183	185	1
184	186	1
185	187	1
186	188	1
187	189	1
188	190	1
189	191	1
190	192	1
191	193	1
192	194	1
193	195	1
194	196	1
195	197	1
196	198	1
197	199	1
198	200	1
199	201	1
200	202	1
201	203	1
202	204	1
203	205	1
204	206	1
205	207	1
206	208	1
207	209	1
208	210	1
209	211	1
210	212	1
211	213	1
212	214	1
213	215	1
214	216	1
215	217	1
216	218	1
217	219	1
218	220	1
219	221	1
220	222	1
221	223	1
222	224	1
223	225	1
224	226	1
225	227	1
226	228	1
227	229	1
228	230	1
229	231	1
230	232	1
231	233	1
232	234	1
233	235	1
234	236	1
235	237	1
236	238	1
237	239	1
238	240	1
239	241	1
240	242	1
241	243	1
242	244	1
243	245	1
244	246	1
245	247	1
246	248	1
247	249	1
248	250	1
249	251	1
250	252	1
251	253	1
252	254	1
253	255	1
254	256	1
255	257	1
256	258	1
257	259	1
258	260	1
259	261	1
260	262	1
261	263	1
262	264	1
263	265	1
264	266	1
265	267	1
266	268	1
267	269	1
268	270	1
269	271	1
270	272	1
271	273	1
272	274	1
273	275	1
274	276	1
275	277	1
276	278	1
277	279	1
278	280	1
279	281	1
280	282	1
281	283	1
282	284	1
283	285	1
284	286	1
285	287	1
286	288	1
287	289	1
288	290	1
289	291	1
290	292	1
291	293	1
292	294	1
293	295	1
294	296	1
295	297	1
296	298	1
297	299	1
298	300	1
299	301	1
300	302	1
301	303	1
302	304	1
303	305	1
304	5	3
305	6	3
306	7	3
307	8	3
308	12	3
309	26	3
310	27	3
311	28	3
312	29	3
313	30	3
314	31	3
315	32	3
316	33	3
317	34	3
318	35	3
319	36	3
320	37	3
321	38	3
322	39	3
323	40	3
324	41	3
325	42	3
326	43	3
327	44	3
328	45	3
329	46	3
330	47	3
331	48	3
332	49	3
333	50	3
334	51	3
335	52	3
336	53	3
337	54	3
338	57	3
339	59	3
340	63	3
341	67	3
342	68	3
343	69	3
344	70	3
345	71	3
346	72	3
347	73	3
348	74	3
349	75	3
350	76	3
351	80	3
352	81	3
353	82	3
354	83	3
355	84	3
356	85	3
357	86	3
358	87	3
359	88	3
360	89	3
361	90	3
362	91	3
363	92	3
364	93	3
365	94	3
366	95	3
367	96	3
368	97	3
369	98	3
370	99	3
371	100	3
372	101	3
373	102	3
374	103	3
375	104	3
376	105	3
377	106	3
378	107	3
379	108	3
380	109	3
381	110	3
382	111	3
383	112	3
384	113	3
385	114	3
386	115	3
387	116	3
388	117	3
389	118	3
390	119	3
391	120	3
392	121	3
393	122	3
394	123	3
395	124	3
396	125	3
397	126	3
398	127	3
399	128	3
400	129	3
401	130	3
402	131	3
403	132	3
404	133	3
405	134	3
406	135	3
407	136	3
408	137	3
409	138	3
410	139	3
411	140	3
412	141	3
413	142	3
414	143	3
415	144	3
416	145	3
417	146	3
418	147	3
419	148	3
420	149	3
421	150	3
422	151	3
423	152	3
424	153	3
425	155	3
426	156	3
427	157	3
428	158	3
429	159	3
430	160	3
431	161	3
432	162	3
433	163	3
434	164	3
435	165	3
436	167	3
437	168	3
438	169	3
439	170	3
440	172	3
441	173	3
442	174	3
443	175	3
444	176	3
445	178	3
446	179	3
447	180	3
448	181	3
449	182	3
450	183	3
451	184	3
452	185	3
453	186	3
454	187	3
455	188	3
456	189	3
457	190	3
458	191	3
459	192	3
460	193	3
461	194	3
462	195	3
463	196	3
464	197	3
465	198	3
466	199	3
467	200	3
468	201	3
469	202	3
470	203	3
471	204	3
472	205	3
473	206	3
474	207	3
475	208	3
476	209	3
477	210	3
478	211	3
479	212	3
480	213	3
481	214	3
482	215	3
483	216	3
484	217	3
485	218	3
486	219	3
487	220	3
488	221	3
489	222	3
490	223	3
491	224	3
492	225	3
493	226	3
494	227	3
495	228	3
496	229	3
497	230	3
498	231	3
499	232	3
500	233	3
501	234	3
502	235	3
503	236	3
504	237	3
505	238	3
506	239	3
507	240	3
508	241	3
509	242	3
510	243	3
511	244	3
512	245	3
513	246	3
514	247	3
515	248	3
516	249	3
517	250	3
518	251	3
519	252	3
520	253	3
521	254	3
522	255	3
523	256	3
524	257	3
525	258	3
526	262	3
527	266	3
528	267	3
529	268	3
530	269	3
531	270	3
532	271	3
533	272	3
534	273	3
535	274	3
536	275	3
537	277	3
538	278	3
539	279	3
540	280	3
541	281	3
542	282	3
543	283	3
544	284	3
545	285	3
546	286	3
547	287	3
548	288	3
549	289	3
550	290	3
551	293	3
552	294	3
553	296	3
554	297	3
555	298	3
556	299	3
557	301	3
558	302	3
559	303	3
560	304	3
561	305	3
562	5	4
563	6	4
564	7	4
565	8	4
566	12	4
567	26	4
568	27	4
569	28	4
570	29	4
571	30	4
572	31	4
573	32	4
574	33	4
575	37	4
576	39	4
577	43	4
578	45	4
579	49	4
580	54	4
581	57	4
582	59	4
583	63	4
584	67	4
585	68	4
586	69	4
587	70	4
588	71	4
589	72	4
590	73	4
591	74	4
592	76	4
593	80	4
594	81	4
595	82	4
596	83	4
597	84	4
598	85	4
599	87	4
600	88	4
601	89	4
602	90	4
603	91	4
604	92	4
605	94	4
606	95	4
607	96	4
608	97	4
609	98	4
610	99	4
611	101	4
612	102	4
613	103	4
614	104	4
615	105	4
616	106	4
617	107	4
618	109	4
619	110	4
620	111	4
621	112	4
622	113	4
623	114	4
624	115	4
625	116	4
626	118	4
627	119	4
628	120	4
629	121	4
630	122	4
631	123	4
632	124	4
633	125	4
634	127	4
635	128	4
636	129	4
637	130	4
638	131	4
639	132	4
640	133	4
641	134	4
642	135	4
643	136	4
644	137	4
645	138	4
646	139	4
647	140	4
648	141	4
649	142	4
650	143	4
651	144	4
652	145	4
653	146	4
654	147	4
655	148	4
656	149	4
657	150	4
658	151	4
659	152	4
660	153	4
661	155	4
662	156	4
663	157	4
664	158	4
665	159	4
666	160	4
667	161	4
668	162	4
669	163	4
670	164	4
671	165	4
672	167	4
673	168	4
674	169	4
675	170	4
676	172	4
677	173	4
678	174	4
679	175	4
680	176	4
681	178	4
682	179	4
683	180	4
684	181	4
685	182	4
686	183	4
687	184	4
688	185	4
689	186	4
690	187	4
691	189	4
692	190	4
693	191	4
694	192	4
695	193	4
696	194	4
697	196	4
698	197	4
699	198	4
700	199	4
701	200	4
702	201	4
703	202	4
704	203	4
705	204	4
706	205	4
707	206	4
708	207	4
709	209	4
710	210	4
711	211	4
712	212	4
713	213	4
714	214	4
715	216	4
716	217	4
717	218	4
718	219	4
719	220	4
720	221	4
721	222	4
722	223	4
723	225	4
724	226	4
725	227	4
726	228	4
727	229	4
728	230	4
729	232	4
730	233	4
731	234	4
732	235	4
733	236	4
734	237	4
735	238	4
736	239	4
737	240	4
738	241	4
739	242	4
740	243	4
741	244	4
742	245	4
743	246	4
744	250	4
745	252	4
746	256	4
747	258	4
748	262	4
749	266	4
750	270	4
751	274	4
752	275	4
753	277	4
754	278	4
755	279	4
756	280	4
757	281	4
758	282	4
759	283	4
760	284	4
761	285	4
762	286	4
763	288	4
764	289	4
765	290	4
766	293	4
767	294	4
768	296	4
769	297	4
770	298	4
771	299	4
772	301	4
773	302	4
774	303	4
775	154	5
776	177	5
777	9	6
778	142	6
779	150	6
780	159	6
781	166	6
782	168	6
783	300	6
784	301	6
785	302	6
786	303	6
\.


--
-- Data for Name: ab_register_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_register_user (id, first_name, last_name, username, password, email, registration_date, registration_hash) FROM stdin;
\.


--
-- Data for Name: ab_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_role (id, name) FROM stdin;
1	Admin
2	Public
3	Alpha
4	Gamma
5	granter
6	sql_lab
\.


--
-- Data for Name: ab_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_user (id, first_name, last_name, username, password, active, email, last_login, login_count, fail_login_count, created_on, changed_on, created_by_fk, changed_by_fk) FROM stdin;
1	admin	user	admin	pbkdf2:sha256:150000$qkB7pJNw$e86a82bfd149f285b561777de32a332436142a78ec66681219cf4e026c35f809	t	admin@fab.org	\N	\N	\N	2019-10-31 21:22:06.693549	2019-10-31 21:22:06.693562	\N	\N
\.


--
-- Data for Name: ab_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_user_role (id, user_id, role_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: ab_view_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_view_menu (id, name) FROM stdin;
1	[main].(id:1)
2	[examples].(id:2)
3	MyIndexView
4	UtilView
5	LocaleView
6	SecurityApi
7	ResetPasswordView
8	ResetMyPasswordView
9	UserInfoEditView
10	AuthDBView
11	UserDBModelView
12	RoleModelView
13	UserStatsChartView
14	PermissionModelView
15	ViewMenuModelView
16	PermissionViewModelView
17	OpenApi
18	Api
19	TableColumnInlineView
20	SqlMetricInlineView
21	TableModelView
22	DatabaseAsync
23	DatabaseView
24	CsvToDatabaseView
25	DatabaseTablesAsync
26	SliceModelView
27	SliceAsync
28	SliceAddView
29	DashboardModelView
30	DashboardModelViewAsync
31	DashboardAddView
32	KV
33	R
34	Superset
35	CssTemplateModelView
36	CssTemplateAsyncModelView
37	QueryView
38	SavedQueryViewApi
39	SavedQueryView
40	SqlLab
41	Dashboard
42	AnnotationLayerModelView
43	AnnotationModelView
44	Datasource
45	TagView
46	LogModelView
47	DruidColumnInlineView
48	DruidMetricInlineView
49	DruidClusterModelView
50	DruidDatasourceModelView
51	Druid
52	Security
53	List Users
54	List Roles
55	User's Statistics
56	Base Permissions
57	Views/Menus
58	Permission on Views/Menus
59	Action Log
60	Sources
61	Tables
62	Databases
63	Upload a CSV
64	Druid Clusters
65	Druid Datasources
66	Scan New Datasources
67	Refresh Druid Metadata
68	Manage
69	Import Dashboards
70	CSS Templates
71	Queries
72	Annotation Layers
73	Annotations
74	Charts
75	Dashboards
76	SQL Lab
77	SQL Editor
78	Query Search
79	Saved Queries
80	all_datasource_access
81	all_database_access
82	can_only_access_owned_queries
83	[warehouse].[information_schema]
84	[warehouse].[public]
85	[warehouse].(id:3)
86	[warehouse].[vw_flights](id:1)
\.


--
-- Data for Name: access_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.access_request (created_on, changed_on, id, datasource_type, datasource_id, changed_by_fk, created_by_fk) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
def97f26fdfb
\.


--
-- Data for Name: annotation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annotation (created_on, changed_on, id, start_dttm, end_dttm, layer_id, short_descr, long_descr, changed_by_fk, created_by_fk, json_metadata) FROM stdin;
\.


--
-- Data for Name: annotation_layer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annotation_layer (created_on, changed_on, id, name, descr, changed_by_fk, created_by_fk) FROM stdin;
\.


--
-- Data for Name: clusters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clusters (created_on, changed_on, id, cluster_name, broker_host, broker_port, broker_endpoint, metadata_last_refreshed, created_by_fk, changed_by_fk, cache_timeout, verbose_name, broker_pass, broker_user) FROM stdin;
\.


--
-- Data for Name: columns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.columns (created_on, changed_on, id, column_name, is_active, type, groupby, filterable, description, created_by_fk, changed_by_fk, dimension_spec_json, verbose_name, datasource_id) FROM stdin;
\.


--
-- Data for Name: css_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.css_templates (created_on, changed_on, id, template_name, css, changed_by_fk, created_by_fk) FROM stdin;
\.


--
-- Data for Name: dashboard_email_schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_email_schedules (created_on, changed_on, id, active, crontab, recipients, deliver_as_group, delivery_type, dashboard_id, created_by_fk, changed_by_fk, user_id) FROM stdin;
\.


--
-- Data for Name: dashboard_slices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_slices (id, dashboard_id, slice_id) FROM stdin;
\.


--
-- Data for Name: dashboard_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_user (id, user_id, dashboard_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: dashboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboards (created_on, changed_on, id, dashboard_title, position_json, created_by_fk, changed_by_fk, css, description, slug, json_metadata, published) FROM stdin;
2019-10-31 21:28:45.434865	2019-10-31 21:28:45.434882	1	flights	\N	1	1	\N	\N	flights	\N	t
\.


--
-- Data for Name: datasources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datasources (created_on, changed_on, id, datasource_name, is_featured, is_hidden, description, default_endpoint, cluster_name, created_by_fk, changed_by_fk, "offset", cache_timeout, perm, filter_select_enabled, params, fetch_values_from) FROM stdin;
\.


--
-- Data for Name: dbs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dbs (created_on, changed_on, id, database_name, sqlalchemy_uri, created_by_fk, changed_by_fk, password, cache_timeout, extra, select_as_create_table_as, allow_ctas, expose_in_sqllab, force_ctas_schema, allow_run_async, allow_dml, perm, verbose_name, impersonate_user, allow_multi_schema_metadata_fetch, allow_csv_upload) FROM stdin;
2019-10-31 21:22:19.567916	2019-10-31 21:22:19.627471	1	main	postgresql+psycopg2://postgres:XXXXXXXXXX@pgsuper:5432/superset	\N	\N	\\x51615653556b664d742b6e53647452654543667341673d3d	\N	{\n    "metadata_params": {},\n    "engine_params": {},\n    "metadata_cache_timeout": {},\n    "schemas_allowed_for_csv_upload": []\n}\n	f	f	t	\N	f	f	[main].(id:1)	\N	f	f	f
2019-10-31 21:22:19.664969	2019-10-31 21:22:19.666406	2	examples	postgresql+psycopg2://postgres:XXXXXXXXXX@pgsuper:5432/superset	\N	\N	\\x51615653556b664d742b6e53647452654543667341673d3d	\N	{\n    "metadata_params": {},\n    "engine_params": {},\n    "metadata_cache_timeout": {},\n    "schemas_allowed_for_csv_upload": []\n}\n	f	f	t	\N	f	f	[examples].(id:2)	\N	f	f	f
2019-10-31 21:23:55.782884	2019-10-31 21:30:06.356809	3	warehouse	postgresql+psycopg2://postgres:XXXXXXXXXX@postgres:5432/warehouse	1	1	\\x51615653556b664d742b6e53647452654543667341673d3d	\N	{\r\n    "metadata_params": {},\r\n    "engine_params": {},\r\n    "metadata_cache_timeout": {},\r\n    "schemas_allowed_for_csv_upload": []\r\n}	f	f	t	\N	f	f	[warehouse].(id:3)	\N	f	t	f
\.


--
-- Data for Name: druiddatasource_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.druiddatasource_user (id, user_id, datasource_id) FROM stdin;
\.


--
-- Data for Name: favstar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favstar (id, user_id, class_name, obj_id, dttm) FROM stdin;
\.


--
-- Data for Name: keyvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keyvalue (id, value) FROM stdin;
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (id, action, user_id, json, dttm, dashboard_id, slice_id, duration_ms, referrer) FROM stdin;
1	sql_json	1	{"client_id": "4aRSF_TEO", "database_id": "3", "json": "true", "runAsync": "false", "schema": "public", "sql": "select * from vw_flights limit 20;\\n", "sql_editor_id": "Aq-me7H2r", "tab": "Untitled Query", "tmp_table_name": "", "select_as_cta": "false", "templateParams": "{}", "queryLimit": "1000"}	2019-10-31 21:24:08.468621	\N	0	243	http://data-drone:8088/superset/sqllab
2	sql_json	1	{"client_id": "-GxQ-I23Z", "database_id": "3", "json": "true", "runAsync": "false", "schema": "public", "sql": "select * from vw_flights limit 20;\\n", "sql_editor_id": "Aq-me7H2r", "tab": "Untitled Query", "tmp_table_name": "", "select_as_cta": "false", "templateParams": "{}", "queryLimit": "1000"}	2019-10-31 21:26:17.468329	\N	0	227	http://data-drone:8088/superset/sqllab
3	dashboard	1	{"dashboard_id": 1, "dashboard_version": "v2", "dash_edit_perm": true, "edit_mode": false}	2019-10-31 21:28:49.282214	1	0	0	http://data-drone:8088/dashboard/list/
4	log	1	{"source": "dashboard", "source_id": 1, "impression_id": "ybwFa1MdR", "version": "v2", "ts": 1572557330021, "event_name": "mount_dashboard", "event_type": "user", "event_id": "OXcG5dLAjj"}	2019-10-31 21:28:51.032746	1	0	0	http://data-drone:8088/superset/dashboard/flights/
5	log	1	{"source": "dashboard", "source_id": 1, "impression_id": "ybwFa1MdR", "version": "v2", "ts": 1572557333456, "event_name": "toggle_edit_dashboard", "edit_mode": true, "event_type": "user", "event_id": "Fm62qPVlI"}	2019-10-31 21:28:54.467375	1	0	0	http://data-drone:8088/superset/dashboard/flights/
6	explore	1	{"datasource_type": "table", "datasource_id": "1"}	2019-10-31 21:31:05.8404	\N	0	204	http://data-drone:8088/tablemodelview/list/?_flt_1_is_sqllab_view=y
7	explore_json	1	{"form_data": "{\\"datasource\\":\\"1__table\\",\\"viz_type\\":\\"table\\",\\"url_params\\":{},\\"granularity_sqla\\":\\"crsdeptime\\",\\"time_grain_sqla\\":\\"P1D\\",\\"time_range\\":\\"Last week\\",\\"groupby\\":[],\\"metrics\\":[\\"count\\"],\\"percent_metrics\\":[],\\"timeseries_limit_metric\\":null,\\"row_limit\\":10000,\\"include_time\\":false,\\"order_desc\\":true,\\"all_columns\\":[],\\"order_by_cols\\":[],\\"adhoc_filters\\":[],\\"table_timestamp_format\\":\\"%Y-%m-%d %H:%M:%S\\",\\"page_length\\":0,\\"include_search\\":false,\\"table_filter\\":false,\\"align_pn\\":false,\\"color_pn\\":true}"}	2019-10-31 21:31:07.484039	\N	0	258	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
8	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572557466803, "event_name": "mount_explorer", "event_type": "user", "event_id": "DKNwg5K1gX"}	2019-10-31 21:31:08.627157	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
9	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572557467499, "event_name": "load_chart", "slice_id": 0, "is_cached": false, "force_refresh": false, "row_count": 1, "datasource": "1__table", "start_offset": 1569, "duration": 322, "viz_type": "table", "event_type": "timing", "trigger_event": "DKNwg5K1gX"}	2019-10-31 21:31:08.627161	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
10	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572557467618, "event_name": "render_chart", "slice_id": 0, "viz_type": "table", "start_offset": 1903, "duration": 107, "event_type": "timing", "trigger_event": "DKNwg5K1gX"}	2019-10-31 21:31:08.627163	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
11	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572557495285, "event_name": "change_explore_controls", "event_type": "user", "event_id": "54hZuqa0v"}	2019-10-31 21:31:36.297471	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
12	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572557512603, "event_name": "change_explore_controls", "event_type": "user", "event_id": "zGb48RTJO"}	2019-10-31 21:31:53.613539	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
13	explore_json	1	{"form_data": "{\\"datasource\\":\\"1__table\\",\\"viz_type\\":\\"table\\",\\"url_params\\":{},\\"granularity_sqla\\":\\"crsdeptime\\",\\"time_grain_sqla\\":\\"P1D\\",\\"time_range\\":\\"Last week\\",\\"groupby\\":[],\\"metrics\\":[\\"count\\"],\\"percent_metrics\\":[],\\"timeseries_limit_metric\\":null,\\"row_limit\\":10000,\\"include_time\\":false,\\"order_desc\\":true,\\"all_columns\\":[],\\"order_by_cols\\":[],\\"adhoc_filters\\":[],\\"table_timestamp_format\\":\\"%Y-%m-%d %H:%M:%S\\",\\"page_length\\":0,\\"include_search\\":false,\\"table_filter\\":false,\\"align_pn\\":false,\\"color_pn\\":true}"}	2019-10-31 21:32:09.501725	\N	0	31	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
14	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572557529521, "event_name": "load_chart", "slice_id": 0, "is_cached": true, "force_refresh": false, "row_count": 1, "datasource": "1__table", "start_offset": 63832, "duration": 81, "viz_type": "table", "event_type": "timing", "trigger_event": "zGb48RTJO"}	2019-10-31 21:32:10.573191	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
15	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572557529562, "event_name": "render_chart", "slice_id": 0, "viz_type": "table", "start_offset": 63931, "duration": 23, "event_type": "timing", "trigger_event": "zGb48RTJO"}	2019-10-31 21:32:10.573196	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
16	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572558873916, "event_name": "change_explore_controls", "event_type": "user", "event_id": "VPHd86IMy"}	2019-10-31 21:54:34.925287	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
17	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572558891537, "event_name": "render_chart_container", "slice_id": 0, "has_err": true, "error_details": "TypeError: f.map is not a function", "duration": null, "event_type": "user", "event_id": "yelFZ-Olf"}	2019-10-31 21:54:52.548186	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
18	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572558901830, "event_name": "change_explore_controls", "event_type": "user", "event_id": "gwL1jpmqd"}	2019-10-31 21:55:02.840666	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
19	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572558912412, "event_name": "change_explore_controls", "event_type": "user", "event_id": "hpA-mjqed"}	2019-10-31 21:55:13.42688	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
20	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572558935089, "event_name": "change_explore_controls", "event_type": "user", "event_id": "orUeVAoKP"}	2019-10-31 21:55:36.098243	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
22	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572558974670, "event_name": "change_explore_controls", "event_type": "user", "event_id": "XulQSkxGF"}	2019-10-31 21:56:15.678755	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
24	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572559005100, "event_name": "change_explore_controls", "event_type": "user", "event_id": "90cshlVdS"}	2019-10-31 21:56:46.113001	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
25	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572559008747, "event_name": "change_explore_controls", "event_type": "user", "event_id": "oZLFuyFK5"}	2019-10-31 21:56:49.758713	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
26	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572559023435, "event_name": "change_explore_controls", "event_type": "user", "event_id": "XdGJym4j5"}	2019-10-31 21:57:04.445083	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
28	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572559063115, "event_name": "change_explore_controls", "event_type": "user", "event_id": "ZXclOFmsp"}	2019-10-31 21:57:44.127217	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
21	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572558942934, "event_name": "change_explore_controls", "event_type": "user", "event_id": "7UVbUErK9"}	2019-10-31 21:55:43.943438	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
23	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572559001508, "event_name": "change_explore_controls", "event_type": "user", "event_id": "23dt5M8TP"}	2019-10-31 21:56:42.51726	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
27	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572559040884, "event_name": "change_explore_controls", "event_type": "user", "event_id": "gUd4f4yey"}	2019-10-31 21:57:21.892903	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
29	log	1	{"source": "slice", "source_id": 0, "impression_id": "526noYaSO", "version": "v2", "ts": 1572559066285, "event_name": "change_explore_controls", "event_type": "user", "event_id": "5wgJFEWIk"}	2019-10-31 21:57:47.307067	\N	0	0	http://data-drone:8088/superset/explore/?form_data=%7B%22datasource%22%3A%221__table%22%2C%22viz_type%22%3A%22table%22%2C%22url_params%22%3A%7B%7D%2C%22granularity_sqla%22%3A%22crsdeptime%22%2C%22time_grain_sqla%22%3A%22P1D%22%2C%22time_range%22%3A%22Last+week%22%2C%22groupby%22%3A%5B%5D%2C%22metrics%22%3A%5B%22count%22%5D%2C%22percent_metrics%22%3A%5B%5D%2C%22timeseries_limit_metric%22%3Anull%2C%22row_limit%22%3A10000%2C%22include_time%22%3Afalse%2C%22order_desc%22%3Atrue%2C%22all_columns%22%3A%5B%5D%2C%22order_by_cols%22%3A%5B%5D%2C%22adhoc_filters%22%3A%5B%5D%2C%22table_timestamp_format%22%3A%22%25Y-%25m-%25d+%25H%3A%25M%3A%25S%22%2C%22page_length%22%3A0%2C%22include_search%22%3Afalse%2C%22table_filter%22%3Afalse%2C%22align_pn%22%3Afalse%2C%22color_pn%22%3Atrue%7D
\.


--
-- Data for Name: metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.metrics (id, metric_name, verbose_name, metric_type, json, description, changed_by_fk, changed_on, created_by_fk, created_on, is_restricted, d3format, warning_text, datasource_id) FROM stdin;
\.


--
-- Data for Name: query; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.query (id, client_id, database_id, tmp_table_name, tab_name, sql_editor_id, user_id, status, schema, sql, select_sql, executed_sql, "limit", select_as_cta, select_as_cta_used, progress, rows, error_message, start_time, changed_on, end_time, results_key, start_running_time, end_result_backend_time, tracking_url, extra_json) FROM stdin;
1	4aRSF_TEO	3		Untitled Query	Aq-me7H2r	1	success	public	select * from vw_flights limit 20;\n	\N	select * from vw_flights limit 20	20	f	f	100	20	\N	1572557048234.762000	2019-10-31 21:24:08.450093	1572557048366.890000	\N	1572557048308.545200	\N	\N	{"progress": null}
2	-GxQ-I23Z	3		Untitled Query	Aq-me7H2r	1	success	public	select * from vw_flights limit 20;\n	\N	select * from vw_flights limit 20	20	f	f	100	20	\N	1572557177247.718000	2019-10-31 21:26:17.452214	1572557177374.290000	\N	1572557177319.565000	\N	\N	{"progress": null}
\.


--
-- Data for Name: saved_query; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_query (created_on, changed_on, id, user_id, db_id, label, schema, sql, description, changed_by_fk, created_by_fk, extra_json) FROM stdin;
\.


--
-- Data for Name: slice_email_schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.slice_email_schedules (created_on, changed_on, id, active, crontab, recipients, deliver_as_group, delivery_type, slice_id, email_format, created_by_fk, changed_by_fk, user_id) FROM stdin;
\.


--
-- Data for Name: slice_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.slice_user (id, user_id, slice_id) FROM stdin;
\.


--
-- Data for Name: slices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.slices (created_on, changed_on, id, slice_name, datasource_type, datasource_name, viz_type, params, created_by_fk, changed_by_fk, description, cache_timeout, perm, datasource_id) FROM stdin;
\.


--
-- Data for Name: sql_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sql_metrics (created_on, changed_on, id, metric_name, verbose_name, metric_type, table_id, expression, description, created_by_fk, changed_by_fk, is_restricted, d3format, warning_text) FROM stdin;
2019-10-31 21:30:57.414099	2019-10-31 21:30:57.414114	1	count	COUNT(*)	count	1	COUNT(*)	\N	1	1	f	\N	\N
\.


--
-- Data for Name: sqlatable_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sqlatable_user (id, user_id, table_id) FROM stdin;
\.


--
-- Data for Name: table_columns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.table_columns (created_on, changed_on, id, table_id, column_name, is_dttm, is_active, type, groupby, filterable, description, created_by_fk, changed_by_fk, expression, verbose_name, python_date_format) FROM stdin;
2019-10-31 21:30:57.387564	2019-10-31 21:30:57.387576	1	1	transactionid	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.389278	2019-10-31 21:30:57.389292	2	1	distancegroup	f	t	VARCHAR	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.390045	2019-10-31 21:30:57.390054	3	1	depdelaygt15	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.390783	2019-10-31 21:30:57.390789	4	1	nextdayarr	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.391491	2019-10-31 21:30:57.391498	5	1	airlinename	f	t	VARCHAR	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.392142	2019-10-31 21:30:57.392148	6	1	origairportname	f	t	VARCHAR	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.39291	2019-10-31 21:30:57.392917	7	1	destairportname	f	t	VARCHAR	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.393403	2019-10-31 21:30:57.393409	8	1	tailnum	f	t	TEXT	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.393881	2019-10-31 21:30:57.393888	9	1	taxiout	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.39437	2019-10-31 21:30:57.394376	10	1	taxiin	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.394907	2019-10-31 21:30:57.394913	11	1	crsdeptime	t	t	TIME WITHOUT TIME ZONE	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.395395	2019-10-31 21:30:57.395401	12	1	deptime	t	t	TIME WITHOUT TIME ZONE	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.396143	2019-10-31 21:30:57.396151	13	1	depdelay	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.396828	2019-10-31 21:30:57.396837	14	1	crsarrtime	t	t	TIME WITHOUT TIME ZONE	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.39746	2019-10-31 21:30:57.397469	15	1	arrtime	t	t	TIME WITHOUT TIME ZONE	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.398129	2019-10-31 21:30:57.398137	16	1	arrdelay	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.398804	2019-10-31 21:30:57.398812	17	1	distance	f	t	INTEGER	t	t	\N	1	1	\N	\N	\N
2019-10-31 21:30:57.399591	2019-10-31 21:30:57.399602	18	1	distance_unit	f	t	VARCHAR	t	t	\N	1	1	\N	\N	\N
\.


--
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tables (created_on, changed_on, id, table_name, main_dttm_col, default_endpoint, database_id, created_by_fk, changed_by_fk, "offset", description, is_featured, cache_timeout, schema, sql, params, perm, filter_select_enabled, fetch_values_predicate, is_sqllab_view, template_params) FROM stdin;
2019-10-31 21:30:57.310164	2019-10-31 21:30:57.379797	1	vw_flights	crsdeptime	\N	3	1	1	0	\N	f	\N	public	\N	\N	[warehouse].[vw_flights](id:1)	f	\N	f	\N
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (created_on, changed_on, id, name, type, created_by_fk, changed_by_fk) FROM stdin;
\.


--
-- Data for Name: tagged_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tagged_object (created_on, changed_on, id, tag_id, object_id, object_type, created_by_fk, changed_by_fk) FROM stdin;
\.


--
-- Data for Name: url; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.url (created_on, changed_on, id, url, created_by_fk, changed_by_fk) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (created_on, changed_on, id, user_id, welcome_dashboard_id, created_by_fk, changed_by_fk) FROM stdin;
\.


--
-- Name: ab_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_permission_id_seq', 92, true);


--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_permission_view_id_seq', 313, true);


--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_permission_view_role_id_seq', 786, true);


--
-- Name: ab_register_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_register_user_id_seq', 1, false);


--
-- Name: ab_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_role_id_seq', 6, true);


--
-- Name: ab_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_user_id_seq', 1, true);


--
-- Name: ab_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_user_role_id_seq', 1, true);


--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_view_menu_id_seq', 86, true);


--
-- Name: access_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.access_request_id_seq', 1, false);


--
-- Name: annotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annotation_id_seq', 1, false);


--
-- Name: annotation_layer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annotation_layer_id_seq', 1, false);


--
-- Name: clusters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clusters_id_seq', 1, false);


--
-- Name: columns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.columns_id_seq', 1, false);


--
-- Name: css_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.css_templates_id_seq', 1, false);


--
-- Name: dashboard_email_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_email_schedules_id_seq', 1, false);


--
-- Name: dashboard_slices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_slices_id_seq', 1, false);


--
-- Name: dashboard_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_user_id_seq', 1, true);


--
-- Name: dashboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboards_id_seq', 1, true);


--
-- Name: datasources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datasources_id_seq', 1, false);


--
-- Name: dbs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dbs_id_seq', 3, true);


--
-- Name: druiddatasource_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.druiddatasource_user_id_seq', 1, false);


--
-- Name: favstar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favstar_id_seq', 1, false);


--
-- Name: keyvalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.keyvalue_id_seq', 1, false);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_id_seq', 29, true);


--
-- Name: metrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.metrics_id_seq', 1, false);


--
-- Name: query_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.query_id_seq', 2, true);


--
-- Name: saved_query_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.saved_query_id_seq', 1, false);


--
-- Name: slice_email_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.slice_email_schedules_id_seq', 1, false);


--
-- Name: slice_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.slice_user_id_seq', 1, false);


--
-- Name: slices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.slices_id_seq', 1, false);


--
-- Name: sql_metrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sql_metrics_id_seq', 1, true);


--
-- Name: sqlatable_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sqlatable_user_id_seq', 1, false);


--
-- Name: table_columns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.table_columns_id_seq', 18, true);


--
-- Name: tables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tables_id_seq', 1, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: tagged_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tagged_object_id_seq', 1, false);


--
-- Name: url_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.url_id_seq', 1, false);


--
-- Name: user_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_attribute_id_seq', 1, false);


--
-- Name: tables _customer_location_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT _customer_location_uc UNIQUE (database_id, schema, table_name);


--
-- Name: ab_permission ab_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission
    ADD CONSTRAINT ab_permission_name_key UNIQUE (name);


--
-- Name: ab_permission ab_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission
    ADD CONSTRAINT ab_permission_pkey PRIMARY KEY (id);


--
-- Name: ab_permission_view ab_permission_view_permission_id_view_menu_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_permission_id_view_menu_id_key UNIQUE (permission_id, view_menu_id);


--
-- Name: ab_permission_view ab_permission_view_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_pkey PRIMARY KEY (id);


--
-- Name: ab_permission_view_role ab_permission_view_role_permission_view_id_role_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_permission_view_id_role_id_key UNIQUE (permission_view_id, role_id);


--
-- Name: ab_permission_view_role ab_permission_view_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_pkey PRIMARY KEY (id);


--
-- Name: ab_register_user ab_register_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_register_user
    ADD CONSTRAINT ab_register_user_pkey PRIMARY KEY (id);


--
-- Name: ab_register_user ab_register_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_register_user
    ADD CONSTRAINT ab_register_user_username_key UNIQUE (username);


--
-- Name: ab_role ab_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_role
    ADD CONSTRAINT ab_role_name_key UNIQUE (name);


--
-- Name: ab_role ab_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_role
    ADD CONSTRAINT ab_role_pkey PRIMARY KEY (id);


--
-- Name: ab_user ab_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_email_key UNIQUE (email);


--
-- Name: ab_user ab_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_pkey PRIMARY KEY (id);


--
-- Name: ab_user_role ab_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_pkey PRIMARY KEY (id);


--
-- Name: ab_user_role ab_user_role_user_id_role_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_user_id_role_id_key UNIQUE (user_id, role_id);


--
-- Name: ab_user ab_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_username_key UNIQUE (username);


--
-- Name: ab_view_menu ab_view_menu_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_view_menu
    ADD CONSTRAINT ab_view_menu_name_key UNIQUE (name);


--
-- Name: ab_view_menu ab_view_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_view_menu
    ADD CONSTRAINT ab_view_menu_pkey PRIMARY KEY (id);


--
-- Name: access_request access_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_request
    ADD CONSTRAINT access_request_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: annotation_layer annotation_layer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_layer
    ADD CONSTRAINT annotation_layer_pkey PRIMARY KEY (id);


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT annotation_pkey PRIMARY KEY (id);


--
-- Name: query client_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query
    ADD CONSTRAINT client_id UNIQUE (client_id);


--
-- Name: clusters clusters_cluster_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_cluster_name_key UNIQUE (cluster_name);


--
-- Name: clusters clusters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_pkey PRIMARY KEY (id);


--
-- Name: clusters clusters_verbose_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_verbose_name_key UNIQUE (verbose_name);


--
-- Name: columns columns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.columns
    ADD CONSTRAINT columns_pkey PRIMARY KEY (id);


--
-- Name: css_templates css_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.css_templates
    ADD CONSTRAINT css_templates_pkey PRIMARY KEY (id);


--
-- Name: dashboard_email_schedules dashboard_email_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_email_schedules
    ADD CONSTRAINT dashboard_email_schedules_pkey PRIMARY KEY (id);


--
-- Name: dashboard_slices dashboard_slices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_slices
    ADD CONSTRAINT dashboard_slices_pkey PRIMARY KEY (id);


--
-- Name: dashboard_user dashboard_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_user
    ADD CONSTRAINT dashboard_user_pkey PRIMARY KEY (id);


--
-- Name: dashboards dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboards
    ADD CONSTRAINT dashboards_pkey PRIMARY KEY (id);


--
-- Name: datasources datasources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasources
    ADD CONSTRAINT datasources_pkey PRIMARY KEY (id);


--
-- Name: dbs dbs_database_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dbs
    ADD CONSTRAINT dbs_database_name_key UNIQUE (database_name);


--
-- Name: dbs dbs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dbs
    ADD CONSTRAINT dbs_pkey PRIMARY KEY (id);


--
-- Name: dbs dbs_verbose_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dbs
    ADD CONSTRAINT dbs_verbose_name_key UNIQUE (verbose_name);


--
-- Name: druiddatasource_user druiddatasource_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.druiddatasource_user
    ADD CONSTRAINT druiddatasource_user_pkey PRIMARY KEY (id);


--
-- Name: favstar favstar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favstar
    ADD CONSTRAINT favstar_pkey PRIMARY KEY (id);


--
-- Name: dashboards idx_unique_slug; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboards
    ADD CONSTRAINT idx_unique_slug UNIQUE (slug);


--
-- Name: keyvalue keyvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keyvalue
    ADD CONSTRAINT keyvalue_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: metrics metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT metrics_pkey PRIMARY KEY (id);


--
-- Name: query query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query
    ADD CONSTRAINT query_pkey PRIMARY KEY (id);


--
-- Name: saved_query saved_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_query
    ADD CONSTRAINT saved_query_pkey PRIMARY KEY (id);


--
-- Name: slice_email_schedules slice_email_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_email_schedules
    ADD CONSTRAINT slice_email_schedules_pkey PRIMARY KEY (id);


--
-- Name: slice_user slice_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_user
    ADD CONSTRAINT slice_user_pkey PRIMARY KEY (id);


--
-- Name: slices slices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slices
    ADD CONSTRAINT slices_pkey PRIMARY KEY (id);


--
-- Name: sql_metrics sql_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sql_metrics
    ADD CONSTRAINT sql_metrics_pkey PRIMARY KEY (id);


--
-- Name: sqlatable_user sqlatable_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sqlatable_user
    ADD CONSTRAINT sqlatable_user_pkey PRIMARY KEY (id);


--
-- Name: table_columns table_columns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_columns
    ADD CONSTRAINT table_columns_pkey PRIMARY KEY (id);


--
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (id);


--
-- Name: tag tag_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_name_key UNIQUE (name);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tagged_object tagged_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tagged_object
    ADD CONSTRAINT tagged_object_pkey PRIMARY KEY (id);


--
-- Name: columns uq_columns_column_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.columns
    ADD CONSTRAINT uq_columns_column_name UNIQUE (column_name, datasource_id);


--
-- Name: dashboard_slices uq_dashboard_slice; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_slices
    ADD CONSTRAINT uq_dashboard_slice UNIQUE (dashboard_id, slice_id);


--
-- Name: datasources uq_datasources_cluster_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasources
    ADD CONSTRAINT uq_datasources_cluster_name UNIQUE (cluster_name, datasource_name);


--
-- Name: metrics uq_metrics_metric_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT uq_metrics_metric_name UNIQUE (metric_name, datasource_id);


--
-- Name: sql_metrics uq_sql_metrics_metric_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sql_metrics
    ADD CONSTRAINT uq_sql_metrics_metric_name UNIQUE (metric_name, table_id);


--
-- Name: table_columns uq_table_columns_column_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_columns
    ADD CONSTRAINT uq_table_columns_column_name UNIQUE (column_name, table_id);


--
-- Name: url url_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.url
    ADD CONSTRAINT url_pkey PRIMARY KEY (id);


--
-- Name: user_attribute user_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT user_attribute_pkey PRIMARY KEY (id);


--
-- Name: ix_dashboard_email_schedules_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dashboard_email_schedules_active ON public.dashboard_email_schedules USING btree (active);


--
-- Name: ix_query_results_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_query_results_key ON public.query USING btree (results_key);


--
-- Name: ix_slice_email_schedules_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_slice_email_schedules_active ON public.slice_email_schedules USING btree (active);


--
-- Name: ix_tagged_object_object_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tagged_object_object_id ON public.tagged_object USING btree (object_id);


--
-- Name: ti_dag_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_dag_state ON public.annotation USING btree (layer_id, start_dttm, end_dttm);


--
-- Name: ti_user_id_changed_on; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_user_id_changed_on ON public.query USING btree (user_id, changed_on);


--
-- Name: ab_permission_view ab_permission_view_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.ab_permission(id);


--
-- Name: ab_permission_view_role ab_permission_view_role_permission_view_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_permission_view_id_fkey FOREIGN KEY (permission_view_id) REFERENCES public.ab_permission_view(id);


--
-- Name: ab_permission_view_role ab_permission_view_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.ab_role(id);


--
-- Name: ab_permission_view ab_permission_view_view_menu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_view_menu_id_fkey FOREIGN KEY (view_menu_id) REFERENCES public.ab_view_menu(id);


--
-- Name: ab_user ab_user_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: ab_user ab_user_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: ab_user_role ab_user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.ab_role(id);


--
-- Name: ab_user_role ab_user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: access_request access_request_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_request
    ADD CONSTRAINT access_request_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: access_request access_request_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_request
    ADD CONSTRAINT access_request_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: annotation annotation_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT annotation_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: annotation annotation_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT annotation_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: annotation_layer annotation_layer_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_layer
    ADD CONSTRAINT annotation_layer_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: annotation_layer annotation_layer_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation_layer
    ADD CONSTRAINT annotation_layer_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: annotation annotation_layer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT annotation_layer_id_fkey FOREIGN KEY (layer_id) REFERENCES public.annotation_layer(id);


--
-- Name: clusters clusters_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: clusters clusters_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: columns columns_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.columns
    ADD CONSTRAINT columns_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: columns columns_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.columns
    ADD CONSTRAINT columns_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: css_templates css_templates_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.css_templates
    ADD CONSTRAINT css_templates_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: css_templates css_templates_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.css_templates
    ADD CONSTRAINT css_templates_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: dashboard_email_schedules dashboard_email_schedules_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_email_schedules
    ADD CONSTRAINT dashboard_email_schedules_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: dashboard_email_schedules dashboard_email_schedules_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_email_schedules
    ADD CONSTRAINT dashboard_email_schedules_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: dashboard_email_schedules dashboard_email_schedules_dashboard_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_email_schedules
    ADD CONSTRAINT dashboard_email_schedules_dashboard_id_fkey FOREIGN KEY (dashboard_id) REFERENCES public.dashboards(id);


--
-- Name: dashboard_email_schedules dashboard_email_schedules_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_email_schedules
    ADD CONSTRAINT dashboard_email_schedules_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: dashboard_slices dashboard_slices_dashboard_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_slices
    ADD CONSTRAINT dashboard_slices_dashboard_id_fkey FOREIGN KEY (dashboard_id) REFERENCES public.dashboards(id);


--
-- Name: dashboard_slices dashboard_slices_slice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_slices
    ADD CONSTRAINT dashboard_slices_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES public.slices(id);


--
-- Name: dashboard_user dashboard_user_dashboard_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_user
    ADD CONSTRAINT dashboard_user_dashboard_id_fkey FOREIGN KEY (dashboard_id) REFERENCES public.dashboards(id);


--
-- Name: dashboard_user dashboard_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_user
    ADD CONSTRAINT dashboard_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: dashboards dashboards_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboards
    ADD CONSTRAINT dashboards_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: dashboards dashboards_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboards
    ADD CONSTRAINT dashboards_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: datasources datasources_cluster_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasources
    ADD CONSTRAINT datasources_cluster_name_fkey FOREIGN KEY (cluster_name) REFERENCES public.clusters(cluster_name);


--
-- Name: datasources datasources_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasources
    ADD CONSTRAINT datasources_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: dbs dbs_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dbs
    ADD CONSTRAINT dbs_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: dbs dbs_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dbs
    ADD CONSTRAINT dbs_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: druiddatasource_user druiddatasource_user_datasource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.druiddatasource_user
    ADD CONSTRAINT druiddatasource_user_datasource_id_fkey FOREIGN KEY (datasource_id) REFERENCES public.datasources(id);


--
-- Name: druiddatasource_user druiddatasource_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.druiddatasource_user
    ADD CONSTRAINT druiddatasource_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: favstar favstar_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favstar
    ADD CONSTRAINT favstar_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: columns fk_columns_datasource_id_datasources; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.columns
    ADD CONSTRAINT fk_columns_datasource_id_datasources FOREIGN KEY (datasource_id) REFERENCES public.datasources(id);


--
-- Name: metrics fk_metrics_datasource_id_datasources; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT fk_metrics_datasource_id_datasources FOREIGN KEY (datasource_id) REFERENCES public.datasources(id);


--
-- Name: logs logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: metrics metrics_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT metrics_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: metrics metrics_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT metrics_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: query query_database_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query
    ADD CONSTRAINT query_database_id_fkey FOREIGN KEY (database_id) REFERENCES public.dbs(id);


--
-- Name: query query_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query
    ADD CONSTRAINT query_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: saved_query saved_query_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_query
    ADD CONSTRAINT saved_query_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: saved_query saved_query_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_query
    ADD CONSTRAINT saved_query_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: saved_query saved_query_db_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_query
    ADD CONSTRAINT saved_query_db_id_fkey FOREIGN KEY (db_id) REFERENCES public.dbs(id);


--
-- Name: saved_query saved_query_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_query
    ADD CONSTRAINT saved_query_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: slice_email_schedules slice_email_schedules_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_email_schedules
    ADD CONSTRAINT slice_email_schedules_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: slice_email_schedules slice_email_schedules_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_email_schedules
    ADD CONSTRAINT slice_email_schedules_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: slice_email_schedules slice_email_schedules_slice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_email_schedules
    ADD CONSTRAINT slice_email_schedules_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES public.slices(id);


--
-- Name: slice_email_schedules slice_email_schedules_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_email_schedules
    ADD CONSTRAINT slice_email_schedules_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: slice_user slice_user_slice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_user
    ADD CONSTRAINT slice_user_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES public.slices(id);


--
-- Name: slice_user slice_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slice_user
    ADD CONSTRAINT slice_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: slices slices_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slices
    ADD CONSTRAINT slices_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: slices slices_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slices
    ADD CONSTRAINT slices_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: sql_metrics sql_metrics_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sql_metrics
    ADD CONSTRAINT sql_metrics_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: sql_metrics sql_metrics_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sql_metrics
    ADD CONSTRAINT sql_metrics_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: sql_metrics sql_metrics_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sql_metrics
    ADD CONSTRAINT sql_metrics_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(id);


--
-- Name: sqlatable_user sqlatable_user_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sqlatable_user
    ADD CONSTRAINT sqlatable_user_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(id);


--
-- Name: sqlatable_user sqlatable_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sqlatable_user
    ADD CONSTRAINT sqlatable_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: table_columns table_columns_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_columns
    ADD CONSTRAINT table_columns_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: table_columns table_columns_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_columns
    ADD CONSTRAINT table_columns_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: table_columns table_columns_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_columns
    ADD CONSTRAINT table_columns_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(id);


--
-- Name: tables tables_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: tables tables_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: tables tables_database_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_database_id_fkey FOREIGN KEY (database_id) REFERENCES public.dbs(id);


--
-- Name: tag tag_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: tag tag_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: tagged_object tagged_object_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tagged_object
    ADD CONSTRAINT tagged_object_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: tagged_object tagged_object_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tagged_object
    ADD CONSTRAINT tagged_object_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: tagged_object tagged_object_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tagged_object
    ADD CONSTRAINT tagged_object_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: url url_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.url
    ADD CONSTRAINT url_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: url url_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.url
    ADD CONSTRAINT url_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: user_attribute user_attribute_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT user_attribute_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: user_attribute user_attribute_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT user_attribute_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: user_attribute user_attribute_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT user_attribute_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: user_attribute user_attribute_welcome_dashboard_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT user_attribute_welcome_dashboard_id_fkey FOREIGN KEY (welcome_dashboard_id) REFERENCES public.dashboards(id);


--
-- PostgreSQL database dump complete
--

