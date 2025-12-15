-- 1. Opprette database
DROP DATABASE IF EXISTS fiskekonkurranse;
CREATE DATABASE fiskekonkurranse;
USE fiskekonkurranse;

-- 2. Tabeller
-- DELTAKER
CREATE TABLE Deltaker (
    DeltakerID INT AUTO_INCREMENT PRIMARY KEY,
    Fornavn VARCHAR(50) NOT NULL,
    Etternavn VARCHAR(50) NOT NULL,
    Fodselsdato DATE NOT NULL
);

-- FISKETYPE
CREATE TABLE Fisketype (
    FisketypeID INT AUTO_INCREMENT PRIMARY KEY,
    Navn VARCHAR(50) NOT NULL,
    MaksVekt DECIMAL(10,2) NOT NULL,
    Vanntype VARCHAR(20) NOT NULL
);

-- LOKASJON
CREATE TABLE Lokasjon (
    LokasjonID INT AUTO_INCREMENT PRIMARY KEY,
    Stedsnavn VARCHAR(50) NOT NULL,
    Vanntype VARCHAR(20) NOT NULL
);

-- FANGST – oppdatert og mer interessant dataset
CREATE TABLE Fangst (
    FangstID INT AUTO_INCREMENT PRIMARY KEY,
    Dato DATE NOT NULL,
    Vekt DECIMAL(10,2) NOT NULL,
    Lengde DECIMAL(10,2) NOT NULL,
    BildeURL VARCHAR(255),
    DeltakerID INT NOT NULL,
    FisketypeID INT NOT NULL,
    LokasjonID INT NOT NULL,
    FOREIGN KEY (DeltakerID) REFERENCES Deltaker(DeltakerID),
    FOREIGN KEY (FisketypeID) REFERENCES Fisketype(FisketypeID),
    FOREIGN KEY (LokasjonID) REFERENCES Lokasjon(LokasjonID)
);

-- KONTINGENT
CREATE TABLE Kontingent (
    KontingentID INT AUTO_INCREMENT PRIMARY KEY,
    Ar YEAR NOT NULL,
    Pris DECIMAL(10,2) NOT NULL,
    DeltakerID INT NOT NULL,
    FOREIGN KEY (DeltakerID) REFERENCES Deltaker(DeltakerID)
);

-- 3. Eksempeldata
-- DELTAKERE
INSERT INTO Deltaker (Fornavn, Etternavn, Fodselsdato) VALUES
('Ola', 'Nordmann', '1985-04-12'),
('Kari', 'Nordmann', '1990-08-22'),
('Per', 'Hansen', '1978-01-30'),
('Astrid', 'Larsen', '1995-06-14'),
('Peder', 'Olsen', '2001-03-19');

-- FISKETYPER
INSERT INTO Fisketype (Navn, MaksVekt, Vanntype) VALUES
('Laks', 35.00, 'Ferskvann'),
('Ørret', 15.00, 'Ferskvann'),
('Torsk', 40.00, 'Saltvann'),
('Sei', 25.00, 'Saltvann'),
('Flyndre', 5.00, 'Saltvann');

-- LOKASJONER
INSERT INTO Lokasjon (Stedsnavn, Vanntype) VALUES
('Oslofjorden', 'Saltvann'),
('Mjøsa', 'Ferskvann'),
('Lofoten', 'Saltvann');


-- 4. FANGSTER
INSERT INTO Fangst (Dato, Vekt, Lengde, BildeURL, DeltakerID, FisketypeID, LokasjonID) VALUES
('2023-05-28', 3.40, 52.00, 'https://bilde.no/1', 1, 1, 2), -- Ola fanger laks i Mjøsa
('2023-05-30', 7.10, 75.00, 'https://bilde.no/2', 2, 1, 2), -- Kari fanger stor laks
('2023-06-01', 1.20, 39.00, 'https://bilde.no/3', 3, 2, 2), -- Per fanger ørret
('2023-06-02', 10.60, 90.00, 'https://bilde.no/4', 4, 3, 3), -- Astrid fanger torsk i Lofoten
('2023-06-03', 6.20, 68.00, 'https://bilde.no/5', 5, 4, 1), -- Peder fanger sei i Oslofjorden
('2023-06-10', 4.20, 55.00, 'https://bilde.no/6', 1, 2, 2), 
('2023-06-15', 9.80, 88.00, 'https://bilde.no/7', 2, 1, 2),
('2023-07-01', 2.50, 45.00, 'https://bilde.no/8', 3, 4, 1),
('2023-07-12', 12.30, 95.00, 'https://bilde.no/14', 4, 3, 3), -- Riktig stor torsk
('2023-07-18', 0.90, 32.00, 'https://bilde.no/15', 5, 5, 1), -- Flyndre
('2023-07-29', 8.40, 82.00, 'https://bilde.no/16', 1, 1, 3), -- Ola fanger laks i Lofoten
('2023-08-05', 1.80, 40.00, 'https://bilde.no/10', 5, 2, 2),
('2023-08-09', 9.10, 87.00, 'https://bilde.no/17', 3, 3, 3),
('2023-08-18', 11.30, 92.00, 'https://bilde.no/11', 1, 3, 3),
('2023-08-26', 5.50, 61.00, 'https://bilde.no/18', 2, 4, 1),
('2023-09-02', 5.40, 63.00, 'https://bilde.no/12', 2, 5, 1),
('2023-09-15', 3.90, 58.00, 'https://bilde.no/13', 3, 1, 2),
('2023-09-20', 7.90, 77.00, 'https://bilde.no/19', 4, 1, 3),
('2023-09-28', 4.70, 49.00, 'https://bilde.no/20', 5, 2, 2);


-- 5. KONTINGENT
INSERT INTO Kontingent (Ar, Pris, DeltakerID) VALUES
(2022, 150.00, 1),
(2023, 150.00, 1),
(2023, 150.00, 2),
(2023, 150.00, 3),
(2024, 150.00, 4),
(2024, 150.00, 5);
