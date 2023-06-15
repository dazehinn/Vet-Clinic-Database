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
