/*Queries that provide answers to the questions from all projects.*/

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
