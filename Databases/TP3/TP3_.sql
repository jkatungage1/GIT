-- Les deux idEquipes des matchs terminés avec égalité
SELECT idEquipe1, idEquipe2 
FROM Matchs 
WHERE scoreEquipe1 = scoreEquipe2;

-- Toutes les informations des matchs qui n'ont pas encore eu lieu
SELECT * 
FROM Matchs 
WHERE dateMatch > CURRENT_DATE;

-- Le prix du billet le plus cher
SELECT MAX(prixBillet) 
FROM Stade;

-- Le nom du stade avec le plus cher prix de billet
SELECT nom 
FROM Stade 
WHERE prixBillet = (SELECT MAX(prixBillet) FROM Stade);

-- La date des matchs qui n'ont pas encore eu lieu
SELECT dateMatch 
FROM Matchs 
WHERE dateMatch > CURRENT_DATE;

-- Les noms et prénoms des joueurs de l'équipe ayant un idEquipe 3
SELECT nom, prenom 
FROM Joueur 
WHERE idEquipe = 3;

-- Les informations des équipes dont le nom commence par « Football »
SELECT * 
FROM Equipe 
WHERE nomEquipe LIKE 'Football%';

-- Les villes des stades ayant un nombre de sièges supérieur à 5000
SELECT ville 
FROM Stade 
WHERE nbPlaces > 5000;

-- Les joueurs dans l'ordre croissant de leurs idEquipe, Nom et prénom
SELECT * 
FROM Joueur 
ORDER BY idEquipe, nom, prenom;

-- La liste des matchs accueillis par l'équipe 2
SELECT * 
FROM Matchs 
WHERE idEquipe1 = 2 OR idEquipe2 = 2;

-- La somme de buts qu'a reçu l'équipe 2 en jouant chez soi
SELECT SUM(scoreEquipe2) 
FROM Matchs 
WHERE idEquipe1 = 2;

-- Le nombre de match joués par l'équipe 4
SELECT COUNT(*) 
FROM Matchs 
WHERE idEquipe1 = 4 OR idEquipe2 = 4;

-- Le prix moyen des prix des billets
SELECT AVG(prixBillet) 
FROM Stade;

-- La liste des joueurs et les idEquipe
SELECT idJoueur, nom, prenom, idEquipe 
FROM Joueur;

-- La liste des joueurs par idEquipe.
SELECT idEquipe, idJoueur, nom, prenom 
FROM Joueur 
ORDER BY idEquipe;

-- #############################EXO 2 1################################### --

-- Liste des coureurs n'ayant pas terminé une course
SELECT DISTINCT c.nomCoureur, c.prenomCoureur
FROM Coureur c
JOIN Resultat r ON c.idCoureur = r.idCoureur
WHERE r.position IS NULL OR r.position = 'DSQ' OR r.position = 'DNF';

-- Combien de coureurs ont été disqualifiés au Critère de première neige
SELECT COUNT(DISTINCT r.idCoureur)
FROM Resultat r
JOIN Course co ON r.idCourse = co.idCourse
WHERE co.nomCourse LIKE 'Critère première neige%' AND r.position = 'DSQ';

-- Nombre de coureurs qui n'ont pas terminé la course par course
SELECT co.nomCourse, COUNT(r.idCoureur) AS nb_non_termines
FROM Course co
LEFT JOIN Resultat r ON co.idCourse = r.idCourse AND (r.position IS NULL OR r.position = 'DSQ' OR r.position = 'DNF')
GROUP BY co.nomCourse;

-- Resultats de Simone Lajoie
SELECT co.nomCourse, r.position
FROM Course co
JOIN Resultat r ON co.idCourse = r.idCourse
JOIN Coureur c ON r.idCoureur = c.idCoureur
WHERE c.nomCoureur = 'Lajoie' AND c.prenomCoureur = 'Simone';

-- Nom et prénom des coureurs disqualifiés dans la course de Noël
SELECT DISTINCT c.nomCoureur, c.prenomCoureur
FROM Coureur c
JOIN Resultat r ON c.idCoureur = r.idCoureur
JOIN Course co ON r.idCourse = co.idCourse
WHERE co.nomCourse LIKE 'Course de Noel%' AND r.position = 'DSQ';

-- Nom et prénom des coureurs dont le nom commençant par la lettre C
SELECT nomCoureur, prenomCoureur
FROM Coureur
WHERE nomCoureur LIKE 'C%';

-- L'idCoureur et le nom des coureurs qui ont participé aux courses 'Critère première neige' ou 'Championnat'
SELECT DISTINCT c.idCoureur, c.nomCoureur
FROM Coureur c
JOIN Resultat r ON c.idCoureur = r.idCoureur
JOIN Course co ON r.idCourse = co.idCourse
WHERE co.nomCourse LIKE 'Critère première neige%' OR co.nomCourse LIKE 'Championnat%';

-- Liste des coureurs (nom et prenom) avec pour chacun sa position la pire
SELECT c.nomCoureur, c.prenomCoureur, MAX(r.position) AS pire_position
FROM Coureur c
JOIN Resultat r ON c.idCoureur = r.idCoureur
WHERE r.position IS NOT NULL AND r.position NOT IN ('DSQ', 'DNF')
GROUP BY c.idCoureur, c.nomCoureur, c.prenomCoureur
ORDER BY c.nomCoureur, c.prenomCoureur;

-- Noms des clubs ayant le plus grand nombre de coureurs masculins
SELECT cl.nomClub, COUNT(*) AS nb_coureurs_masculins
FROM Club cl
JOIN Coureur c ON cl.idClub = c.idClub
WHERE c.sexeCoureur = 'M'
GROUP BY cl.idClub, cl.nomClub
ORDER BY nb_coureurs_masculins DESC
LIMIT 1;

-- Nom du ou des clubs ayant le plus de première place
SELECT cl.nomClub
FROM Club cl
JOIN Coureur c ON cl.idClub = c.idClub
JOIN Resultat r ON c.idCoureur = r.idCoureur
WHERE r.position = 1
GROUP BY cl.idClub, cl.nomClub
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Resultat
    WHERE position = 1
    GROUP BY idCoureur
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- #############################EXO 2 2################################### --

-- Liste des tuples de la table résultat triée par le numéro de la course et le dossard
SELECT *
FROM Resultat
ORDER BY idCourse, dossard;

-- Liste des coureurs avec pour chacun sa meilleure position
SELECT c.nomCoureur, c.prenomCoureur, MIN(r.position) AS meilleure_position
FROM Coureur c
JOIN Resultat r ON c.idCoureur = r.idCoureur
WHERE r.position IS NOT NULL AND r.position NOT IN ('DSQ', 'DNF')
GROUP BY c.idCoureur, c.nomCoureur, c.prenomCoureur;

-- Liste des coureurs avec le nombre de courses auxquelles ils ont participé
SELECT c.nomCoureur, c.prenomCoureur, COUNT(r.idCourse) AS nb_participations
FROM Coureur c
LEFT JOIN Resultat r ON c.idCoureur = r.idCoureur
GROUP BY c.idCoureur, c.nomCoureur, c.prenomCoureur;

-- Liste des coureurs avec le nombre de courses auxquelles ils sont inscrits
SELECT c.nomCoureur, c.prenomCoureur, COUNT(r.idCourse) AS nb_inscriptions
FROM Coureur c
LEFT JOIN Resultat r ON c.idCoureur = r.idCoureur
GROUP BY c.idCoureur, c.nomCoureur, c.prenomCoureur;

-- Liste des clubs et le nombre de courses qu'ils ont organisé
SELECT cl.nomClub, COUNT(co.idCourse) AS nb_courses
FROM Club cl
LEFT JOIN Course co ON cl.idClub = co.idClub
GROUP BY cl.idClub, cl.nomClub;

-- Nom du ou des clubs ayant organisé le plus grand nombre de courses
SELECT cl.nomClub
FROM Club cl
JOIN Course co ON cl.idClub = co.idClub
GROUP BY cl.idClub, cl.nomClub
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Course
    GROUP BY idClub
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Noms des clubs ayant le plus grand nombre de coureurs féminins
SELECT cl.nomClub, COUNT(*) AS nb_coureurs_feminins
FROM Club cl
JOIN Coureur c ON cl.idClub = c.idClub
WHERE c.sexeCoureur = 'F'
GROUP BY cl.idClub, cl.nomClub
ORDER BY nb_coureurs_feminins DESC
LIMIT 1;

-- Nom des clubs ayant eu un coureur en première position dans une course
SELECT DISTINCT cl.nomClub
FROM Club cl
JOIN Coureur c ON cl.idClub = c.idClub
JOIN Resultat r ON c.idCoureur = r.idCoureur
WHERE r.position = 1;

-- Nombre de coureurs n'ayant pas de photos
SELECT COUNT(*)
FROM Coureur
WHERE nomPhoto IS NULL OR nomPhoto = 'TITLE';

-- Liste des coureurs n'ayant jamais été disqualifiés
SELECT c.nomCoureur, c.prenomCoureur
FROM Coureur c
WHERE c.idCoureur NOT IN (
    SELECT DISTINCT r.idCoureur
    FROM Resultat r
    WHERE r.position = 'DSQ'
);

-- #############################EXO 3################################### --

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

-- Quantité de vin produite de degré suépieur à 12 par numéro de vin
SELECT v.numV, SUM(r.quantité) AS quantite_totale
FROM VIN v
JOIN RECOLTE r ON v.numV = r.nvin
WHERE v.degre > 12
GROUP BY v.numV;

-- Le cru ou les crus au plus fort degrés
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