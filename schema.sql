/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

\c vet_clinic

CREATE TABLE animals (
    id INT,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species TEXT;

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name TEXT,
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
    PRIMARY KEY (id)
);

ALTER TABLE animals ADD PRIMARY KEY (id);
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT species_const FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE;
ALTER TABLE animals ADD COLUMN owner_id INT, ADD CONSTRAINT owners_const FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE;
