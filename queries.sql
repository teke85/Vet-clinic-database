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

BEGIN;

/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, SUM(escape_attempts) as total_escape_attempts 
FROM animals 
GROUP BY neutered 
ORDER BY total_escape_attempts DESC 
LIMIT 1;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) AS avg_escape_attempts 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;

COMMIT;