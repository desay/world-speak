
CREATE TABLE role
(
  id bigint NOT NULL DEFAULT nextval('seq_role'::regclass),
  name character varying,
  CONSTRAINT role_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE role
  OWNER TO "db-ams";


-- Table: users

-- DROP TABLE users;

CREATE TABLE users
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
ALTER TABLE users
  OWNER TO "db-ams";


-- Table: users_role

-- DROP TABLE users_role;

CREATE TABLE users_role
(
  id bigint NOT NULL,
  role_id bigint,
  user_id bigint,
  CONSTRAINT users_role_pkey PRIMARY KEY (id),
  CONSTRAINT users_role_role_id_fkey FOREIGN KEY (role_id)
      REFERENCES role (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT users_role_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE users_role
  OWNER TO "db-ams";
