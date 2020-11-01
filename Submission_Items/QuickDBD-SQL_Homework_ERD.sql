-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/gnIBKP
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Tables

CREATE TABLE "card_holder" (
    "id" int   NOT NULL,
    "name" varchar(100)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "credit_card" (
    "card" varchar(100)   NOT NULL,
    "id_card_holder" int   NOT NULL,
    CONSTRAINT "pk_credit_card" PRIMARY KEY (
        "card"
     )
);

CREATE TABLE "merchant_category" (
    "id" int   NOT NULL,
    "name" varchar(100)   NOT NULL,
    CONSTRAINT "pk_merchant_category" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "merchant" (
    "id" int   NOT NULL,
    "name" varchar(100)   NOT NULL,
    "id_merchant_category" int   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "transaction" (
    "id" int   NOT NULL,
    "date" timestamp   NOT NULL,
    "amount" float   NOT NULL,
    "card" varchar(100)   NOT NULL,
    "id_merchant" int   NOT NULL
);

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_id_card_holder" FOREIGN KEY("id_card_holder")
REFERENCES "card_holder" ("id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_id_merchant_category" FOREIGN KEY("id_merchant_category")
REFERENCES "merchant_category" ("id");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_card" FOREIGN KEY("card")
REFERENCES "credit_card" ("card");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_id_merchant" FOREIGN KEY("id_merchant")
REFERENCES "merchant" ("id");

