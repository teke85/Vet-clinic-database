/* Insert the provided data into the animals table. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
       ('Gabumon', '2018-11-15', 2, true, 8),
       ('Pikachu', '2021-01-07', 1, false, 15.04),
       ('Devimon', '2017-05-12', 5, true, 11);

/* Insert more data into the animals table. */
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', '2020-02-08', -11, false, 0),
       ('Plantmon', '2021-11-15', -5.7, true, 2),
       ('Squirtle', '1993-04-02', -12.13, false, 3),
       ('Angemon', '2005-06-12', -45, true, 1),
       ('Boarmon', '2005-06-07', 20.4, true, 7),
       ('Blossom', '1998-10-13', 17, true, 3),
       ('Ditto', '2022-05-14', 22, true, 4);


/* Insert the following data into owners table*/
INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Insert the following data into species table
INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');


-- Modify your inserted animals so it includes the species_id value
UPDATE animals SET species_id = 
CASE 
  WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
  ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

--Modify your inserted animals to include owner information (owner_id):
UPDATE animals SET owner_id =
CASE 
  WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
  WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;

INSERT INTO vets (name, age, date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');


INSERT INTO specializations (vet_id, species) VALUES
  (1, 'Pokemon'),
  (3, 'Digimon'),
  (3, 'Pokemon'),
  (4, 'Digimon');

INSERT INTO visits (animal, vet_id, visit_date) VALUES
  ('Agumon', 1, '2020-05-24'),
  ('Agumon', 3, '2020-07-22'),
  ('Gabumon', 4, '2021-02-02'),
  ('Pikachu', 2, '2020-01-05'),
  ('Pikachu', 2, '2020-03-08'),
  ('Pikachu', 2, '2020-05-14'),
  ('Devimon', 3, '2021-05-04'),
  ('Charmander', 4, '2021-02-24'),
  ('Plantmon', 2, '2019-12-21'),
  ('Plantmon', 1, '2020-08-10'),
  ('Plantmon', 2, '2021-04-07'),
  ('Squirtle', 3, '2019-09-29'),
  ('Angemon', 4, '2020-10-03'),
  ('Angemon', 4, '2020-11-04'),
  ('Boarmon', 2, '2019-01-24'),
  ('Boarmon', 2, '2019-05-15'),
  ('Boarmon', 2, '2020-02-27'),
  ('Boarmon', 2, '2020-08-03'),
  ('Blossom', 3, '2020-05-24'),
  ('Blossom', 1, '2021-01-11');
