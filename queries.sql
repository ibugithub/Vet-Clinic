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



-- query from join table for visits
SELECT vets.name AS vet_name, animals.name AS animal_name 
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY vistits.date_of_visit DESC
LIMIT 1;


SELECT vets.name AS vet_name, COUNT(DISTINCT animal_id) AS animal_count
FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name;


SELECT vets.name AS vet_name, species.name AS species_name, COALESCE(species.name, 'no specializations')
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.species_id;


SELECT vets.name AS vet_name, animals.name AS animal_name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE (vets.name = 'Stephanie Mendez') AND (vistits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-01');



SELECT animals.name AS animal_name, COUNT(*) AS animal_count
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY animal_count DESC
LIMIT 1;


SELECT vets.name AS vet_name, animals.name AS first_visit_animal_name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith' 
ORDER BY vistits.date_of_visit
LIMIT 1;


SELECT vets.name AS recent_visited_vet, animals.name AS recent_visit_animal, vistits.date_of_visit AS date 
FROM animals 
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY vistits.date_of_visit
LIMIT 1;


SELECT COUNT(*) AS num_visits_without_specialization
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.vet_id IS NULL;


SELECT species.name AS specialty, COUNT(visits.animal_id) AS num_visits
FROM species
LEFT JOIN animals ON species.id = animals.species_id
LEFT JOIN visits ON animals.id = visits.animal_id
LEFT JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY num_visits DESC
LIMIT 1;


-- Query for week2 database optimizations:

-- Results before adding indexes
SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';


-- Results after adding indexes
EXPLAIN ANALYZE  SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';