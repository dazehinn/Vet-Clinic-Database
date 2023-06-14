/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE table animals (
  id int,
  name text,
  date_of_birth date,
  escape_attempts int,
  neutered boolean,
  weight_kg real 
);
