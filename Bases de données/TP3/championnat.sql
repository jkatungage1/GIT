DROP DATABASE IF EXISTS championnat;
CREATE DATABASE IF NOT EXISTS championnat;
USE championnat;
CREATE TABLE IF NOT EXISTS Stade	(idStade INTEGER PRIMARY KEY,
									ville varchar(20) NOT NULL,
                                    nom varchar(40) NOT NULL,
                                    nbPlaces INTEGER,
                                    prixBillet FLOAT);
CREATE TABLE IF NOT EXISTS Equipe	(idEquipe INTEGER PRIMARY KEY,
									nomEquipe varchar(40),
									Ville varchar(20),
                                    siteWeb varchar(40),
                                    entraineur varchar (40));
CREATE TABLE IF NOT EXISTS Joueur	(idJoueur INTEGER PRIMARY KEY,
									idEquipe INTEGER,
                                    nom varchar(20),
                                    prenom varchar(20),
									dateNaissance date,
                                    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe));
CREATE TABLE IF NOT EXISTS Matchs	(idMatch INTEGER PRIMARY KEY,
									idStade INTEGER NOT NULL,
                                    dateMatch date,
                                    idEquipe1 INTEGER NOT NULL,
                                    idEquipe2 INTEGER NOT NULL,
                                    scoreEquipe1 INTEGER,
                                    scoreEquipe2 INTEGER,
                                    nbBilletsVendus INTEGER,
                                    FOREIGN KEY (idStade) REFERENCES Stade(idStade),
                                    FOREIGN KEY (idEquipe1) REFERENCES Equipe(idEquipe),
                                    FOREIGN KEY (idEquipe2) REFERENCES Equipe(idEquipe));

INSERT INTO Stade VALUES(1,"Bandoufle","Robert-Robin",21500,30);
INSERT INTO Stade VALUES(2,"poissy","Léo-Lagrange",3500,20);
INSERT INTO Stade VALUES(3,"Saint-Gratien","Michel-Hidalgo",8000,25);
INSERT INTO Stade VALUES(4,"Créteil","Dominique-Duvauchelle",12500,30);

INSERT INTO Equipe VALUES(1,"Football Club Montrouge 92","Montrouge","www.mfc92.fr","Stéphane BOURDIL");
INSERT INTO Equipe VALUES(2,"Cergy-Pontoise Football Club","Cergy-Pontoise","www.cergypontoisefc.footeo.com","Nassim Benkerrou");
INSERT INTO Equipe VALUES(3,"Red Star Football Club ","Saint-Ouen","www.redstar.fr","Habib Beye");
INSERT INTO Equipe VALUES(4,"Football Club Les Lilas","Torcy","www.torcyfoot.footeo.com","Xavier CAZENAVE");

INSERT INTO Joueur VALUES(11,1,"Toussi","Kamel",'1991-06-28'),
(12,1,"Clairica","Evann",'2001-10-01'),(13,1,"Merel","Allan",'1991-04-08'),(21,2,"Katende","Soki",'2000-01-10'),(22,2,"Diallo","Djime",'1992-03-21'),
(23,2,"Rézé","Thomas",'1997-09-15');
INSERT INTO Joueur VALUES(31,3,"Macalou","Issouf",'1998-12-27');
INSERT INTO Joueur VALUES(32,3,"Sparanga","Stéphane",'1995-02-17');
INSERT INTO Joueur VALUES(33,3,"Hachem","Ryad",'1998-05-26');
INSERT INTO Joueur VALUES(41,4,"Hamidi","Salim",'1993-05-19');
INSERT INTO Joueur VALUES(42,4,"Zennoubi","Younes",'1998-05-05');
INSERT INTO Joueur VALUES(43,4,"Diyazaya","Marthorel",'1992-03-31');


INSERT INTO Matchs VALUES(1,1,'2022-01-16',1,2,2,5,11578);
INSERT INTO Matchs VALUES(2,1,'2022-02-13',3,4,3,1,4586);
INSERT INTO Matchs VALUES(3,1,'2022-03-20',1,3,1,1,2785);
INSERT INTO Matchs VALUES(4,2,'2022-03-27',2,4,2,0,1244);
INSERT INTO Matchs VALUES(5,3,'2022-04-10',1,4,1,1,6230);
INSERT INTO Matchs VALUES(6,4,'2022-04-10',2,3,0,3,10001);
INSERT INTO Matchs VALUES(7,2,'2022-04-24',1,2,1,2,2417);
INSERT INTO Matchs VALUES(8,2,'2022-05-15',3,4,3,1,1584);
INSERT INTO Matchs VALUES(10,3,'2022-05-29',1,3,1,1,6458);
INSERT INTO Matchs VALUES(11,3,'2022-06-05',2,4,1,0,4863);
INSERT INTO Matchs VALUES(12,4,'2022-06-19',1,4,2,3,11548);
INSERT INTO Matchs VALUES(13,4,'2022-07-10',2,3,2,2,9874);
INSERT INTO Matchs VALUES(14,4,'2022-10-2',1,2,0,0,10266);

INSERT INTO Matchs VALUES(15,1,'2025-10-16',3,4,null,null,null);
INSERT INTO Matchs VALUES(16,2,'2025-11-20',1,2,null,null,null);