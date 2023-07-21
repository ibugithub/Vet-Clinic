/* Database schema to keep the structure of entire database. */
CREATE TABLE animals ( 
    id SERIAL PRIMARY KEY NOT NULL, 
    name VARCHAR(50), 
    date_of_birth DATE, 
    escape_attempts INTEGER, 
    neutered BOOLEAN, 
    weight_kg DECIMAL(10, 2) 
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);




-- -- schema from query multiple tables
CREATE TABLE owners (
    id SERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(100),
    age INTEGER
);


CREATE TABLE species (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100)
);

ALTER TABLE animals 
DROP COLUMN species

ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species(id);


ALTER TABLE animals 
ADD COLUMN owner_id INTEGER REFERENCES owners(id);



-- schema from join table for visits
CREATE TABLE vets (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50),
    age INTEGER,
    date_of_graduation DATE
);


CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id)
);


CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    date DATE
);