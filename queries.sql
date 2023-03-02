/*Queries that provide answers to the questions from all projects.*/

/* Update the species column to all animals to unspecified */
BEGIN;
UPDATE animals SET species = 'unspecified';

/* Verify that the change was made */
SELECT * FROM animals;

/* Rollback the transaction */
ROLLBACK;

/* Verify that the "species" column went back to the state before the transaction */
SELECT * FROM animals;

/* Inside a transaction, update the "species" column of all animals with a name ending in "mon" to "digimon" */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

/* Update the "species" column of all animals that don't have a species already set to "pokemon" */
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

/* Commit the transaction */
COMMIT;

/* Verify that the change was made and persists after commit */
SELECT * FROM animals;

/* Inside a transaction, delete all records in the "animals" table */
BEGIN;
DELETE FROM animals;

/* Roll back the transaction */
ROLLBACK;

/* Verify that all records in the "animals" table still exist */
SELECT * FROM animals;

/* Delete all animals born after Jan 1st, 2022 */
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

/* Create a savepoint for the transaction */
SAVEPOINT DELETE_ANIMALS_DOB;

/* Update all animals' weight to be their weight multiplied by -1 */
UPDATE animals SET weight_kg = -1 * weight_kg;

/* Rollback to the savepoint */
ROLLBACK TO DELETE_ANIMALS_DOB;

/* Update all animals' weights that are negative to be their weight multiplied by -1 */
UPDATE animals SET weight = -1 * weight WHERE weight < 0;

/* Commit the transaction */
COMMIT;

/* Write queries to answer the following questions */

/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
 SELECT neutered, AVG(escape_attempts) FROM animals
 GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) AS avg_escape_attempts 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;

/* To find all animals whose name ends in "mon" */

SELECT * FROM animals WHERE name LIKE '%mon';

/* To list the name of all animals born between 2016 and 2019 */

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* To list the name of all animals that are neutered and have less than 3 escape attempts */

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/* To list the date of birth of all animals named either "Agumon" or "Pikachu" */

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

/* To list name and escape attempts of animals that weigh more than 10.5kg */

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/* To find all animals that are neutered */

SELECT * FROM animals WHERE neutered = true;

/* To find all animals not named Gabumon */

SELECT * FROM animals WHERE name != 'Gabumon';

/* To find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

--Write queries (using JOIN) to answer the following questions:

-- What animals belong to Melody Pond?
SELECT animals.name 
FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name 
FROM animals 
JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, COALESCE(animals.name, 'No animals') 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) 
FROM animals 
JOIN species ON animals.species_id = species.id 
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name 
FROM animals 
JOIN species ON animals.species_id = species.id 
JOIN owners ON animals.owner_id = owners.id 
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name 
FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(*) 
FROM owners 
JOIN animals ON owners.id = animals.owner_id 
GROUP BY owners.full_name 
ORDER BY COUNT(*) DESC 
LIMIT 1;
