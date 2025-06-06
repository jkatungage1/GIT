-- Drop Database SKI;
create database SKI;
use SKI;

CREATE TABLE Club(
	idClub int  PRIMARY KEY,
	nomClub VARCHAR(20) NOT NULL
	);

CREATE TABLE Categorie(
	idCategorie int PRIMARY KEY,
	nomCategorie VARCHAR(20) NOT NULL
	);

CREATE TABLE TypeCourse(
	idTypeCourse int  PRIMARY KEY,
	codeTypeCourse VARCHAR(20) NOT NULL,
	nomTypeCourse VARCHAR(20) NOT NULL
	);

CREATE TABLE Coureur(
	idCoureur int  PRIMARY KEY,
	nomCoureur VARCHAR(20) NOT NULL,
	prenomCoureur VARCHAR(20) NOT NULL,
	sexeCoureur CHAR(1) NOT NULL,
	nomPhoto VARCHAR(20),
	idCategorie int,
   FOREIGN KEY (idCategorie) REFERENCES Categorie(idCategorie),
	idClub INT,
    FOREIGN KEY (idClub) REFERENCES Club(idClub)

	);
	
CREATE TABLE Course(
	idCourse INT PRIMARY KEY,
	nomCourse VARCHAR(40) NOT NULL,
	dateCourse DATE,
	sexeCourse CHAR(1) NOT NULL ,
	idClub INT,
    FOREIGN KEY (idClub) REFERENCES Club(idClub),
	idCategorie INT,
     FOREIGN KEY (idCategorie) REFERENCES Categorie(idCategorie),
	idTypeCourse INT,
     FOREIGN KEY (idTypeCourse) REFERENCES TypeCourse(idTypeCourse)

	);
/* la position peut prendre les valeurs 000 jusqu a 200 ou DSQ pour disqualifié , 
DNF pour celui qui n a pas terminé une course*/

CREATE TABLE Resultat(
	idCoureur INT ,
	 FOREIGN KEY (idCoureur) REFERENCES Coureur(idCoureur),
	idCourse INT ,
	 FOREIGN KEY (idCourse) REFERENCES Course(idCourse),
	dossard INT,
	position VARCHAR(3),
	PRIMARY KEY (idCoureur, idCourse)
	);

	
INSERT INTO Club VALUES (1,'Les Saisies');
INSERT INTO Club VALUES (2,'Chamonix');
INSERT INTO Club VALUES (3,'La Plagne');
INSERT INTO Club VALUES (4,'Crest Voland');
INSERT INTO Club VALUES (5,'Val Cenis');

INSERT INTO Categorie VALUES (1,'0-6 ans');
INSERT INTO Categorie VALUES (2,'6-8 ans');
INSERT INTO Categorie VALUES (3,'9-10 ans');
INSERT INTO Categorie VALUES (4,'11-12 ans');
INSERT INTO Categorie VALUES (5,'13-14 ans');
INSERT INTO Categorie VALUES (6,'15 ans et +');

INSERT INTO TypeCourse VALUES (1,'SL', 'Slalom spécial');
INSERT INTO TypeCourse VALUES (2,'GS', 'Slalom géant');
INSERT INTO TypeCourse VALUES (3,'SG', 'Super G');
INSERT INTO TypeCourse VALUES (4,'DH', 'Descente');
INSERT INTO TypeCourse VALUES (5,'BI', 'Biathlon');

INSERT INTO Coureur VALUES (1,'Bolduc','Jean','M','1bolduc.gif',4,1);
INSERT INTO Coureur VALUES (2,'Codere','Aline','F','2codere.gif',4,1);
INSERT INTO Coureur VALUES (3,'Lajoie','Simone','F','3lajoie.gif',4,4);
INSERT INTO Coureur VALUES (4,'Lajoie','Michel','M','4lajoie.gif',2,4);
INSERT INTO Coureur VALUES (5,'Desmarais','Sylvie','F','5desmarais.gif',2,4);
INSERT INTO Coureur VALUES (6,'Bouchard','Jeanne','F',null,2,1);
INSERT INTO Coureur VALUES (7,'Wall','Eddy','M','7wall.gif',2,1);

INSERT INTO Course VALUES (1,'Course de Noel','2021/12/24','F',1,2,2);
INSERT INTO Course VALUES (2,'Course de Noel','2021/12/24','M',1,2,2);
INSERT INTO Course VALUES (3,'Course de Noel','2021/12/24','F',1,4,2);
INSERT INTO Course VALUES (4,'Course de Noel','2021/12/24','M',1,4,2);
INSERT INTO Course VALUES (5,'Critère première neige','2021/01/12','F',1,4,2);
INSERT INTO Course VALUES (6,'Critère première neige','2021/01/12','M',1,4,2);
INSERT INTO Course VALUES (7,'Championnat','2021/02/15','F',1,4,1);
INSERT INTO Course VALUES (8,'Championnat','2021/02/15','M',1,4,1);

INSERT INTO Course VALUES (9,'Championnat','2021/02/15','M',2,4,1);
INSERT INTO Course VALUES (10,'Championnat','2021/03/15','M',2,3,2);

INSERT INTO Resultat VALUES (4,2,23,'002');
INSERT INTO Resultat VALUES (5,1,34,'002');
INSERT INTO Resultat VALUES (6,1,48,'006');
INSERT INTO Resultat VALUES (7,2,11,'005');
INSERT INTO Resultat VALUES (1,4,34,'001');
INSERT INTO Resultat VALUES (2,3, 8,'012');
INSERT INTO Resultat VALUES (3,3,12,'017');
INSERT INTO Resultat VALUES (1,6,23,'002');
INSERT INTO Resultat VALUES (2,5,12,'DSQ');
INSERT INTO Resultat VALUES (3,5,18,'016');
INSERT INTO Resultat VALUES (1,5,50,'DNF');
INSERT INTO Resultat(idCoureur, idCourse) VALUES (1,8);
INSERT INTO Resultat(idCoureur, idCourse) VALUES (2,7);
INSERT INTO Resultat(idCoureur, idCourse) VALUES (3,7);
-- INSERT INTO Resultat VALUES (3,5,18,'016');
-- INSERT INTO Resultat VALUES (5,3,14,'001');