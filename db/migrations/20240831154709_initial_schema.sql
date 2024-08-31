-- Create "shops" table
CREATE TABLE "shops" ("id" uuid NOT NULL, "owner_id" uuid NOT NULL, "title" character varying(50) NOT NULL, "default_domain" character varying(50) NOT NULL, "favicon_url" text NULL, "currency_code" character varying(3) NOT NULL, "status" character varying(10) NOT NULL, "about" text NULL, "seo_description" text NULL, "seo_keywords" text NULL, "seo_title" character varying(255) NULL, "updated_at" timestamptz NOT NULL DEFAULT now(), "created_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id"), CONSTRAINT "shops_default_domain_key" UNIQUE ("default_domain"));
