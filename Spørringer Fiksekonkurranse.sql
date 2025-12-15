--  Alle spørringer mot databasen: Fiskekokurranse

-- Spørring nr 1 a og b
SELECT * FROM Deltaker;
SELECT * FROM Fangst;

-- Spørring nr 2: Koble sammen flere tabeller med JOIN
SELECT 
    D.Fornavn,
    D.Etternavn,
    F.Dato,
    FT.Navn AS Fisketype,
    F.Vekt,
    F.Lengde,
    L.Stedsnavn
FROM Fangst F
JOIN Deltaker D   ON F.DeltakerID   = D.DeltakerID
JOIN Fisketype FT ON F.FisketypeID = FT.FisketypeID
JOIN Lokasjon L   ON F.LokasjonID  = L.LokasjonID;

-- Spørring nr. 3a: INNER JOIN — kun rader som matcher
SELECT 
    FT.Navn AS Fisketype,
    COUNT(F.FangstID) AS AntallFangster
FROM Fisketype FT
LEFT JOIN Fangst F ON FT.FisketypeID = F.FisketypeID
GROUP BY FT.Navn;

-- Spørring nr. 3b: LEFT JOIN — viser ALLE rader i venstre tabell (I denne tabellen FISKETYPE)
SELECT 
    FT.Navn AS Fisketype,
    COUNT(F.FangstID) AS AntallFangster,
    AVG(F.Vekt) AS Gjennomsnittsvekt
FROM Fisketype FT
LEFT JOIN Fangst F ON FT.FisketypeID = F.FisketypeID
GROUP BY FT.Navn;

-- Spørring nr 3c: RIGHT JOIN - 

SELECT 
    D.Fornavn,
    D.Etternavn,
    K.Ar
FROM Deltaker D
RIGHT JOIN Kontingent K ON D.DeltakerID = K.DeltakerID;

-- Spørring nr. 4: COUNT + AVG - Mer statestikk
SELECT 
    FT.Navn AS Fisketype,
    COUNT(F.FangstID) AS AntallFangster,
    AVG(F.Vekt) AS Gjennomsnittsvekt
FROM Fisketype FT
LEFT JOIN Fangst F ON FT.FisketypeID = F.FisketypeID
GROUP BY FT.Navn;

-- Spørring nr. 5 - Hvilke deltakere som er mest aktive. Having
SELECT 
    D.Fornavn,
    D.Etternavn,
    COUNT(F.FangstID) AS AntallFangster,
    SUM(F.Vekt) AS TotalVekt
FROM Deltaker D
LEFT JOIN Fangst F ON D.DeltakerID = F.DeltakerID
GROUP BY D.DeltakerID, D.Fornavn, D.Etternavn
HAVING COUNT(F.FangstID) > 0;

-- Spørring nr 6 - Hente kontingent for et bestemt år. Here bruker vi: WHERE
SELECT 
    D.Fornavn,
    D.Etternavn,
    K.Ar,
    K.Pris
FROM Deltaker D
JOIN Kontingent K ON D.DeltakerID = K.DeltakerID
WHERE K.Ar = 2023;

-- SPørring nr. 7: View – gjøre databasen lettere å jobbe med
CREATE OR REPLACE VIEW FangstDetaljer AS
SELECT 
    F.FangstID,
    F.Dato,
    F.Vekt,
    F.Lengde,
    D.Fornavn,
    D.Etternavn,
    FT.Navn AS FisketypeNavn,
    L.Stedsnavn
FROM Fangst F
JOIN Deltaker D   ON F.DeltakerID = D.DeltakerID
JOIN Fisketype FT ON F.FisketypeID = FT.FisketypeID
JOIN Lokasjon L   ON F.LokasjonID = L.LokasjonID;

-- Spørring nr 8: Spørring mot VIEW: FangstDetaljer
SELECT *
FROM FangstDetaljer
WHERE FisketypeNavn = 'Laks';
