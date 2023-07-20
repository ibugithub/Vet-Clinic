/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE NAME LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT * FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;




BEGIN;
UPDATE animals
SET species = 'unspecified'
SELECT * FROM animals;
ROLLBACk
SELECT * FROM animals;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM ANIMALS;
COMMIT;
SELECT * FROM ANIMALS;




Begin;
DELETE FROM animals;
SELECT  * FROM animals;
ROLLBACK;
SELECT * FROM animals;




BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT savePoint1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT savePoint1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;




SELECT COUNT(*) AS total_animals FROM animals;

SELECT COUNT(*) AS animals_never_escaped
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;

SELECT neutered, SUM(escape_attempts) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;



-- -- Query from query multiple tables
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name AS owners_name, animals.name AS animals_name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name AS species, COUNT(*) AS Total_animal_per_species
FROM animals 
JOIN species ON animals.species_id = species.id 
GROUP BY species.name;

SELECT owners.full_name AS owner, animals.name AS animal_name 
FROM animals 
JOIN species ON animals.species_id = species.id 
JOIN owners ON animals.owner_id = owners.id
WHERE  species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';


SELECT owners.full_name AS Owner, animals.name AS Animals
FROM animals
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;


SELECT owners.full_name AS Owner, COUNT(*) AS animals_count
FROM animals 
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY animals_count Desc LIMIT 1;