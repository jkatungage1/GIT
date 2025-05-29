-- Informations contenues dans la relation VIN
SELECT * FROM VIN;

-- Informations contenues dans la relation PRODUCTEUR
SELECT * FROM PRODUCTEUR;

-- Liste des producteurs qui n'ont pas de prénom
SELECT * 
FROM PRODUCTEUR 
WHERE prenom = '';

-- Liste des régions distinctes de production des vins
SELECT DISTINCT region 
FROM PRODUCTEUR;

-- Liste des vins de 1980
SELECT * 
FROM VIN 
WHERE annee = 1980;

-- Liste des noms et des prénoms des producteurs de vins n'appartenant pas aux régions spécifiées
SELECT nom, prenom 
FROM PRODUCTEUR 
WHERE region NOT IN ('Corse', 'Beaujolais', 'Bourgogne', 'Rhône');

-- Liste des crus récoltés en 1979
SELECT v.cru, r.nprod, r.quantité
FROM VIN v
JOIN RECOLTE r ON v.numV = r.nvin
WHERE v.annee = 1979;

-- Noms des producteurs du cru Etoile, leurs régions et la quantité de vins récoltée
SELECT p.nom, p.region, r.quantité
FROM PRODUCTEUR p
JOIN RECOLTE r ON p.numP = r.nprod
JOIN VIN v ON r.nvin = v.numV
WHERE v.cru = 'Etoile';

-- Nombre de récoltes
SELECT COUNT(*) FROM RECOLTE;

-- Producteurs de vin dans la région Savoie et Jura
SELECT COUNT(*) 
FROM PRODUCTEUR 
WHERE region IN ('Savoie', 'Jura');

-- Producteurs de vin ayant récoltés au moins un vin dans la région Savoie ou Jura
SELECT COUNT(DISTINCT p.numP)
FROM PRODUCTEUR p
JOIN RECOLTE r ON p.numP = r.nprod
WHERE p.region IN ('Savoie', 'Jura');

-- Quantités de vin produites par région, liste ordonnée décroissante
SELECT p.region, SUM(r.quantité) AS total_quantite
FROM PRODUCTEUR p
JOIN RECOLTE r ON p.numP = r.nprod
GROUP BY p.region
ORDER BY total_quantite DESC;

-- Quantité de vin produite de degré > 12 par numéro de vin
SELECT v.numV, SUM(r.quantité) AS quantite_totale
FROM VIN v
JOIN RECOLTE r ON v.numV = r.nvin
WHERE v.degre > 12
GROUP BY v.numV;

-- Le cru ou les crus au plus fort degré?
SELECT cru 
FROM VIN 
WHERE degre = (SELECT MAX(degre) FROM VIN);

-- Liste ordonnée des crus
SELECT DISTINCT cru 
FROM VIN 
ORDER BY cru;

-- Liste ordonnée des crus récoltés
SELECT DISTINCT v.cru 
FROM VIN v
JOIN RECOLTE r ON v.numV = r.nvin
ORDER BY v.cru;

-- Cru non récolté
SELECT cru 
FROM VIN 
WHERE numV NOT IN (SELECT nvin FROM RECOLTE);

-- Liste ordonnée des crus et la quantité par cru
SELECT v.cru, SUM(r.quantité) AS quantite_totale
FROM VIN v
JOIN RECOLTE r ON v.numV = r.nvin
GROUP BY v.cru
ORDER BY v.cru;

-- Degré moyen des crus
SELECT AVG(degre) 
FROM VIN;

-- Crus de degré supérieur au degré moyen des crus
SELECT cru, degre, annee
FROM VIN
WHERE degre > (SELECT AVG(degre) FROM VIN)
ORDER BY degre, annee;