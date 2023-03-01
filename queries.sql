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
