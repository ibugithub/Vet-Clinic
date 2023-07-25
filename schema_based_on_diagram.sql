/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(12,2),
    species_id INT,
    owner_id INT,
    FOREIGN KEY (species_id) REFERENCES species(id),
    FOREIGN KEY (owner_id) REFERENCES owners(id)
);

CREATE TABLE owners (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  age INT
);

CREATE TABLE species (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE vets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL ,
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id, visit_date)
);

-- Add indexes to foreign keys
CREATE INDEX idx_animals_species_id ON animals (species_id);
CREATE INDEX idx_animals_owner_id ON animals (owner_id);
CREATE INDEX idx_vet_specializations_vet_id ON vet_specializations (vet_id);
CREATE INDEX idx_vet_specializations_species_id ON vet_specializations (species_id);
CREATE INDEX idx_visits_animal_id ON visits (animal_id);
CREATE INDEX idx_visits_vet_id ON visits (vet_id);
