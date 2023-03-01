/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT * FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, date_of_birth, AVG(escape_attempts) FROM animals GROUP BY species, date_of_birth HAVING date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

/* query-multiple-tables */

SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owner_id = 4;
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT full_name, name FROM animals FULL JOIN owners ON animals.owner_id = owners.id;
SELECT COUNT(animals.name), species.name FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE species_id = 2 AND owner_id = 2;
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0;
SELECT owners.full_name, COUNT(animals.name) AS animals_owned FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY full_name ORDER BY animals_owned DESC;

/*add-join-tables*/

SELECT animals.name from animals JOIN visits ON visits.animal_id = animals.id WHERE vet_id = 1 ORDER BY visits.date_of_visit DESC LIMIT 1;
SELECT COUNT(DISTINCT animal_id) FROM visits WHERE vet_id = 3;
SELECT v.name, s.species_id FROM vets v LEFT JOIN specializations s ON s.vet_id = v.id;
SELECT a.name FROM animals a JOIN visits v ON v.animal_id = a.id WHERE v.vet_id = 3 AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
SELECT a.name, COUNT(v.animal_id) FROM animals a JOIN visits v ON v.animal_id = a.id GROUP BY a.name ORDER BY COUNT(v.animal_id) DESC LIMIT 1;
SELECT a.name, v.date_of_visit FROM animals a JOIN visits v ON v.animal_id = a.id WHERE v.vet_id = 2 ORDER BY v.date_of_visit ASC LIMIT 1;
SELECT * FROM animals a JOIN visits v ON v.animal_id = a.id JOIN vets ON vets.id = v.vet_id ORDER BY v.date_of_visit DESC LIMIT 1;
SELECT COUNT(vi.animal_id) FROM visits vi JOIN vets ve ON ve.id = vi.vet_id WHERE vet_id = 2;
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT(animals.species_id) DESC LIMIT 1;
