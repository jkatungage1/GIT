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