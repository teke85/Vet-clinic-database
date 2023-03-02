/* Database schema to keep the structure of entire database. */


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




