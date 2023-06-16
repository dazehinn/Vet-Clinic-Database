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


/* What animals belong to Melody Pond? */
SELECT name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name as animal_name, species.name as specie_name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT full_name, animals.name AS animal_name FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id;

/* How many animals are there per species? */
SELECT species.name as specie_name, count(animals.name) FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT owners.full_name, animals.name FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON animals.species_id = species.id
WHERE  species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name AS animal_name, owners.full_name from animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

/* Who owns the most animals? */
SELECT full_name, COUNT(animals.name) as nbr_of_animals FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY full_name
ORDER BY nbr_of_animals DESC;





/* Who was the last animal seen by William Tatcher? */
SELECT animals.name, vets.name, date_of_visit FROM animals
JOIN visits ON animals.id = animals_id
JOIN vets ON vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */ 
SELECT COUNT(DISTINCT animals.name) AS num_of_diff_animals FROM animals
JOIN visits ON animals.id = animals_id
JOIN vets ON vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties. */
SELECT vets.name, species.name FROM vets
LEFT JOIN specialization ON vets.id = specialization.vets_id
JOIN species ON species.id = specialization.species_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name, vets.name, date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets? */
SELECT name, COUNT(date_of_visit) AS nbr_of_visits FROM visits
JOIN animals ON animals.id = animals_id
GROUP BY name
ORDER by nbr_of_visits DESC
LIMIT 1;

/* Who was Maisy Smith's first visit? */
SELECT animals.name, vets.name, date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit
LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animals.*, vets.*, date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY date_of_visit DESC
LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(*) AS num_visits
FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON visits.vets_id = vets.id
WHERE NOT EXISTS (
	SELECT 1
	FROM specialization
	WHERE specialization.species_id = animals.species_id AND specialization.vets_id = vets.id
);

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */ 
SELECT species.name AS species_name, COUNT(*) AS number_of_visits
FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN species ON species.id = animals.species_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY (species_name);
