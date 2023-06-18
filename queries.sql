/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE EXTRACT (year FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Pikachu','Agumon');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Deleting all records inside a transaction*/
 BEGIN;
 DELETE FROM animals;
 SELECT * FROM animals;
 ROLLBACK;
 SELECT * FROM animals;

/* Updating negative weights inside a transaction*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01'; 
SAVEPOINT JAN2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO JAN2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* How many animals are there? */
SELECT count(name) FROM animals;

/* How many animals have never tried to escape? */
SELECT count(name) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT avg(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, max(escape_attempts) FROM animals group by neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, min(weight_kg), max(weight_kg) FROM animals GROUP BY species;

/* What is the average number of escape attempts per animal type of those born
 between 1990 and 2000? */
 SELECT species, avg(escape_attempts) FROM animals WHERE 
 date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
 GROUP BY species;
