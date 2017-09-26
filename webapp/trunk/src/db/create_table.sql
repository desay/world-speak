-- Table: public.role

-- DROP TABLE public.role;

CREATE TABLE public.role
(
  id bigint NOT NULL DEFAULT nextval('seq_role'::regclass),
  name character varying,
  CONSTRAINT role_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.role
  OWNER TO postgres;


-- Table: public.users

-- DROP TABLE public.users;

CREATE TABLE public.users
(
  id bigint NOT NULL DEFAULT nextval('seq_users'::regclass),
  email character varying,
  password_hash character varying,
  role character varying,
  CONSTRAINT users_id_key UNIQUE (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.users
  OWNER TO postgres;


  -- Table: public.users_role

-- DROP TABLE public.users_role;

CREATE TABLE public.users_role
(
  id bigint NOT NULL,
  role_id bigint,
  user_id bigint,
  CONSTRAINT users_role_pkey PRIMARY KEY (id),
  CONSTRAINT users_role_role_id_fkey FOREIGN KEY (role_id)
      REFERENCES public.role (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.users_role
  OWNER TO postgres;

