-- Create the animals table
CREATE TABLE animals ( 
    id SERIAL PRIMARY KEY NOT NULL, 
    name VARCHAR(50), 
    date_of_birth DATE, 
    escape_attempts INTEGER, 
    neutered BOOLEAN, 
    weight_kg DECIMAL(10, 2),
    species_id INTEGER REFERENCES species(id),
    owner_id INTEGER REFERENCES owners(id)
);

-- Create the owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(100),
    age INTEGER,
    email VARCHAR(120)
);

-- Create the species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100)
);

-- Create the vets table
CREATE TABLE vets (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50),
    age INTEGER,
    date_of_graduation DATE
);

-- Create the specializations table
CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id)
);

-- Create the visits table
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    date_of_visit DATE
);

-- Add FK indexes
CREATE INDEX ON animals (species_id);
CREATE INDEX ON animals (owner_id);
CREATE INDEX ON visits (animal_id);
CREATE INDEX ON visits (vet_id);
CREATE INDEX ON specializations (vet_id);
CREATE INDEX ON specializations (species_id);
