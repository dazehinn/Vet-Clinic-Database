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
