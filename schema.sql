/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE table animals (
  id int not null generated always as identity,
  name varchar(250),
  date_of_birth date,
  escape_attempts int,
  neutered boolean,
  weight_kg decimal,
  primary key (id) 
);

ALTER TABLE animals
ADD species varchar(250);

/* Owners table */
DROP TABLE IF EXISTS owners;

CREATE TABLE owners (
  id int PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  full_name varchar(250),
  age int
);

/* Species table*/
DROP TABLE IF EXISTS species;
CREATE TABLE species (
  id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name varchar(10)
);

/* Modify animals table */
ALTER TABLE animals
DROP COLUMN species,
ADD species_id int,
ADD owner_id int;

ALTER TABLE animals
ADD CONSTRAINT owners_constraint
 FOREIGN KEY(owner_id) REFERENCES owners(id),
ADD CONSTRAINT species_constraint
 FOREIGN KEY (species_id) REFERENCES species(id);

/* vets table */
DROP TABLE IF EXISTS vets;
CREATE TABLE vets (
  id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name varchar(250),
  age int,
  date_of_graduation date
);

/* specialization table table */
DROP TABLE IF EXISTS specialization;
CREATE TABLE specialization (
  vets_id int,
  species_id int,
  CONSTRAINT vet_fk
  FOREIGN KEY (vets_id) REFERENCES vets(id),
  CONSTRAINT  species_fk
  FOREIGN KEY (species_id) REFERENCES species(id)
);

/* visits table */
DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
  animals_id int,
  vets_id int,
  date_of_visit date ,
  CONSTRAINT vet_fk
  FOREIGN KEY (vets_id) REFERENCES vets(id),
  CONSTRAINT  animals_fk
  FOREIGN KEY (animals_id) REFERENCES animals(id)
);


