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