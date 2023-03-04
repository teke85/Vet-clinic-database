/* Database schema to keep the structure of entire database. */

/* Create vet clinic database*/
CREATE DATABASE vet_clinic;

/* Connect to the database */

\ c vet_clinic

--create animals table
CREATE TABLE animals (
  id serial PRIMARY KEY,
  name varchar(255),
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species TEXT;

/* Create a table named species */
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

/* create a table named species */
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

/* modify animals table */
ALTER TABLE animals
ADD COLUMN species_id INTEGER,
ADD COLUMN owner_id INTEGER,
DROP COLUMN species;

--Create the vets table:
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INT,
  date_of_graduation DATE
);

--create the specialization table:
CREATE TABLE specializations (
  vet_id INT,
  species TEXT,
  FOREIGN KEY (vet_id) REFERENCES vets(id)
);

--create the visits table:
CREATE TABLE visits (
  animal VARCHAR(255),
  vet_id INT,
  visit_date DATE,
  FOREIGN KEY (vet_id) REFERENCES vets(id)
);







