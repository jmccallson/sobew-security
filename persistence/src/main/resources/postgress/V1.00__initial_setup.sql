-- psql -h localhost -p 5432 -U postgres -W

CREATE TABLE sec_user_account
 (
     user_id bigint NOT NULL,
     last_login_date timestamp without time zone,
     password character varying(130) COLLATE pg_catalog."default" NOT NULL,
     failed_login_count bigint,
     deleted_date timestamp without time zone,
     CONSTRAINT pk_user_account PRIMARY KEY (user_id)
)

CREATE TABLE sec_program_key
(
    program_key_id bigint NOT NULL,
    program_key character varying(50) COLLATE pg_catalog."default" NOT NULL,
    company_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    product_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    enabled boolean DEFAULT 'F'::boolean NOT NULL,
    user_agent character varying(100) COLLATE pg_catalog."default",
    owner_name character varying(100) COLLATE pg_catalog."default",
    partner_type bigint,
    refresh_token boolean DEFAULT 'F'::boolean,
    auto_create_account boolean DEFAULT 'F'::boolean,
    hmac_secret character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT pk_sec_dev_key PRIMARY KEY (program_key),
    CONSTRAINT idx_sec_dev_key_id UNIQUE (program_key_id)
)

CREATE SEQUENCE SEQ_SEC_PROG_KEY START WITH 1000;