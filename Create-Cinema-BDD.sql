/*----- ETAPE 1: Création de la base -----*/

CREATE DATABASE multiplexe;

/*----- ETAPE 2: Création des tables -----*/

# Groupe du complexe cinéma
CREATE TABLE GroupeCinema (
    idGroup int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30) NOT NULL
);
# Cinéma
CREATE TABLE Cinema (
    idCinema int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nameOfCinema varchar(30) NOT NULL,
    city varchar(15),
    idGroup int(10) NOT NULL,
    FOREIGN KEY (idGroup) REFERENCES GroupeCinema(idGroup) ON DELETE CASCADE ON UPDATE CASCADE
);
# Genre
CREATE TABLE Gender(
    idGender int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    typeOFGender varchar(10) NOT NULL
);

#Language
CREATE TABLE Language(
    idLanguage int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(10) NOT NULL
);

# Film
CREATE TABLE Movie (
    idMovie int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title varchar(20) NOT NULL,
    author varchar(20) NOT NULL,
    language int NOT NULL,
    duration time NOT NULL,
    gender int NOT NULL,
    description varchar(400),
    FOREIGN KEY (gender) REFERENCES Gender(idGender),
    FOREIGN KEY (language) REFERENCES Language(idLanguage)
);

# Salle de cinéma
CREATE TABLE Hall (
    idHall int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nameHAll varchar(30),
    nbLimit int NOT NULL,
    idCinema int NOT NULL,
    FOREIGN KEY (idCinema) REFERENCES Cinema(idCinema) ON DELETE CASCADE ON UPDATE CASCADE
);

# Séance programmation
CREATE TABLE Seance (
     idSeance int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
     date date NOT NULL,
     hourStart time NOT NULL,
     endStart time NOT NULL,
     idHall int NOT NULL,
     idCinema int NOT NULL,
     idMovie int NOT NULL,
     FOREIGN KEY (idHall) REFERENCES Hall (idHall) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (idCinema) REFERENCES Cinema(idCinema) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (idMovie) REFERENCES Movie(idMovie) ON DELETE CASCADE ON UPDATE CASCADE
);

#Table des User avec accès
CREATE TABLE User (
     idUser int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
     firstName varchar(30) NOT NULL,
     lastName varchar(30) NOT NULL,
     dateOfBirth date NOT NULL,
     email varchar(30) NOT NULL
);

#Utilisateur Administrateur
CREATE TABLE Admin (
    idAdmin int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idUser int NOT NULL,
    idCinema int,
    idGroup int,
    FOREIGN KEY (idUser) REFERENCES User(idUser) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idCinema) REFERENCES Cinema(idCinema) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idGroup) REFERENCES GroupeCinema(idGroup) ON DELETE CASCADE ON UPDATE CASCADE
);

#Utilisateur Client
CREATE TABLE Customer (
    idCustomer int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idUser int NOT NULL,
    FOREIGN KEY (idUser) REFERENCES User(idUser) ON DELETE CASCADE ON UPDATE CASCADE
);

#Table des prix
CREATE TABLE Price (
    idPrice int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(10) NOT NULL,
    price float NOT NULL
);

#Moyen de paiement
CREATE TABLE Paiement (
    idPaiement int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(10) NOT NULL
);

# Reservation de la séance
CREATE TABLE Booking (
     idBooking int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
     idPaiement int NOT NULL,
     idSeance int NOT NULL,
     idPrice int NOT NULL,
     idCustomer int NOT NULL,
     idHall int NOT NULL,
     idCinema int NOT NULL,
     FOREIGN KEY (idSeance) REFERENCES Seance(idSeance) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (idPaiement) REFERENCES Paiement(idPaiement),
     FOREIGN KEY (idPrice) REFERENCES Price(idPrice),
     FOREIGN KEY (idCustomer) REFERENCES Customer (idCustomer),
     FOREIGN KEY (idHall) REFERENCES Hall (idHall) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (idCinema) REFERENCES Cinema(idCinema) ON DELETE CASCADE ON UPDATE CASCADE
);

/*----- ETAPE 3: Fixuture -----*/

/*----- ETAPE 3.1: Création du complexe et ses cinémas -----*/

# Crée d'un complexe de cinéma puis User puis Admin

INSERT INTO GroupeCinema (name) VALUES ('Complexe Cinéma Paris');

INSERT INTO Cinema(nameOfCinema, city, idGroup) VALUES (
                                                        ('Cinéma Paris 15', 'Paris 7','1'),
                                                        ('Cinéma Paris 12', 'Paris 12', '1'),
                                                        ('Cinéma Paris 7', 'Paris 7', '1')
                                                       );

/*----- ETAPE 3.2: Création des salles de diffusion -----*/

#Ajoute les Salles de cinéma
# Cinéma 15ème
INSERT INTO Hall(nameHall, nbLimit, idCinema) VALUES
                                            ('A', '50','1'),
                                            ('B', '60', '1'),
                                            ('C', '40', '1'),
                                            ('D', '70', '1'),
                                            ('E', '90', '1')
                                           ;
#Cinéma 12éme
INSERT INTO Hall(nameHall, nbLimit, idCinema) VALUES
                                            ('A1', '70','2'),
                                            ('B1', '60', '2'),
                                            ('C1', '50', '2'),
                                            ('D1', '90', '2'),
                                            ('E1', '100', '2')
                                           ;
#Cinéma 7éme
INSERT INTO Hall(nameHall, nbLimit, idCinema) VALUES
                                            ('A2', '70','3'),
                                            ('B2', '60', '3'),
                                            ('C2', '50', '3'),
                                            ('D2', '90', '3'),
                                            ('E2', '100', '3')
                                           ;


/*----- ETAPE 3.4: Création des utilisateur admistrateur -----*/

#Utilisateur (admin)
INSERT INTO User(firstName, lastName, dateOfBirth, email) VALUES
                                                                  ('Marcial', 'Ciné', '1960-06-30', 'marcial@cine.com'),
                                                                  ('Paul', 'Dupont', '1990-02-10','paul@dupont.com'),
                                                                  ('Olivier', 'Lapou', '1991-10-10','olivier@lapou.com'),
                                                                  ('Sandrine', 'Dupont', '1985-05-10','sandr@dupont.com')
                                                                 ;

# Rattachement des adminstrateurs au cinéma
INSERT INTO Admin(iduser, idcinema, idgroup) VALUES
                                                     ('1', '', '1'),
                                                     ('2', '2' , ''),
                                                     ('2', '2', '' ),
                                                     ('3', '3', '' )
                                                    ;

/*----- ETAPE 3.5: Ajout des moyens de paiement et tarif -----*/

# Moyen de paiement et prix général pour toute structure
INSERT INTO Paiement(name) VALUES
                                   ('cb'),
                                   ('cash'),
                                   ('gift'),
                                   ('cb-en-ligne')
                                  ;
INSERT INTO Price(name, price) VALUES
                                       ('Plein-Tarif' ,'9.80'),
                                       ('Etudiant', '7.60'),
                                       ('Enfant', '5.90')
                                      ;

/*----- ETAPE 3.6: Ajout des genres et langues pour les films -----*/
#Ajouter les genres pour les films
INSERT INTO Gender(typeOFGender) VALUES
                                         ('Action'),
                                         ('Animé'),
                                         ('Comédies'),
                                         ('Documentaires'),
                                         ('Drames'),
                                         ('Emotions à la française'),
                                         ('Fantastique'),
                                         ('Français'),
                                         ('Horreur'),
                                         ('Indépendants'),
                                         ('International'),
                                         ('Jeunesse et famille'),
                                         ('Musique et comédies musicales'),
                                         ('Policier'),
                                         ('Romance'),
                                         ('SF'),
                                         ('Thriller')
                                        ;

#Ajout langues
INSERT INTO Language(name) VALUES
                                   ('FR'),
                                   ('VO'),
                                   ('VOST')
                                  ;

/*----- ETAPE 3.6: Ajout de 4 film -----*/
#Ajout de film
INSERT INTO Movie(title, author, language, duration, gender, description)
VALUES ('The Green Knight', 'David Lowery', '1', '2:10', '7',
        'Sire Gauvain, chevalier de la table ronde du roi Arthur, dont il est également le neveu, accepte le défi lancé par un mystérieux Chevalier vert. Il doit le décapiter. Gauvain s\'exécute. Le Chevalier vert repart avec sa tête sous son bras et lui rappelle que, dans un an, ils vont devoir se retrouver...',
        ),
       ('En attendant Bojangles', 'Regis Roinsard', '1', '2:05', '15',
        'Camille et Georges dansent tout le temps sur leur chanson préférée Mr Bojangles. Chez eux, il n\'y a de place que pour le plaisir, la fantaisie et les amis. Jusqu\'au jour où la mère va trop loin, contraignant Georges et leur fils Gary à tout faire pour éviter l\'inéluctable coûte que coûte.',
        ),
       ('Licorice Pizza', 'Paul Thomas Anderson', '1', '2:13', '5',
        'LICORICE PIZZA est l\’histoire d\’Alana Kane et Gary Valentine, deux adolescents qui grandissent, s\’égarent et tombent amoureux dans la vallée de San Fernando, en 1973.',
        ),
       ('Scream', 'Matt Bettinelli-Olpin, Tyler Gillett', '3', '1:55', '17',
        'Vingt-cinq ans après que la paisible ville de Woodsboro a été frappée par une série de meurtres violents, un nouveau tueur revêt le masque de Ghostface et prend pour cible un groupe d\'adolescents. Il est déterminé à faire ressurgir les sombres secrets du passé.',
       )
;

/*----- ETAPE 3.7: Ajout des séances pour les cinémas -----*/
# Ajout séance Cinema 1
INSERT INTO Seance(date, hourStart, endStart, idHall, idCinema, idMovie)
VALUES ('2022-12-28','10:00', '12:25', 1, 1, 1),
       ('2022-12-28','10:00', '12:15', 2, 1, 2),
       ('2022-12-28','10:00', '12:25', 3, 1, 3),
       ('2022-12-28','18:00', '20:10', 4, 1, 4),
       ('2022-12-28','18:00', '20:25', 1, 1, 1),
       ('2022-12-28','18:00', '20:15', 2, 1, 2),
       ('2022-12-28','18:00', '20:25', 3, 1, 3),
       ('2022-12-28','18:00', '20:10', 4, 1, 4)
;
# Ajout séance Cinema 2
INSERT INTO Seance(date, hourStart, endStart, idHall, idCinema, idMovie)
VALUES ('2022-12-28','10:00', '12:25', '', 2, 1),
       ('2022-12-28','10:00', '12:15', '', 2, 2),
       ('2022-12-28','10:00', '12:25', '', 2, 3),
       ('2022-12-28','10:00', '12:10', '', 2, 4),
       ('2022-12-28','18:00', '20:10', '', 2, 4),
       ('2022-12-28','18:00', '20:25', '', 2, 1),
       ('2022-12-28','18:00', '20:15', '', 2, 2),
       ('2022-12-28','18:00', '20:25', '', 2, 3),
       ('2022-12-28','18:00', '20:10', '', 2, 4)
;
# Ajout séance Cinema 2
INSERT INTO Seance(date, hourStart, endStart, idHall, idCinema, idMovie)
VALUES ('2022-12-28','10:00', '12:25', '', 3, 1),
       ('2022-12-28','10:00', '12:15', '', 3, 2),
       ('2022-12-28','10:00', '12:25', '', 3, 3),
       ('2022-12-28','10:00', '12:10', '', 3, 4),
       ('2022-12-28','18:00', '20:10', '', 3, 4),
       ('2022-12-28','18:00', '20:25', '', 3, 1),
       ('2022-12-28','18:00', '20:15', '', 3, 2),
       ('2022-12-28','18:00', '20:25', '', 3, 3),
       ('2022-12-28','18:00', '20:10', '', 3, 4)
;

/*----- ETAPE 3.8: Ajout d'utilisateur/client -----*/
# Ajout de user
INSERT INTO User(firstName, lastName, dateOfBirth, email)
VALUES ('Rachel', 'Turam', '1999-12-01', 'rach@turam.com'),
       ('Camille', 'Lipozzi', '1999-03-01', 'cam@lipozzi.com'),
       ('Léna', 'Moreno', '1999-05-30', 'lena@moreno.com'),
       ('Fabien', 'Pizollo', '1995-10-01', 'fab@pizo.com'),
       ('Vincent', 'Rouleur', '1992-06-01', 'vince@roul.com'),
       ('Hugo', 'Trico', '1994-09-01', 'hugo@trico.com'),
       ('Bryan', 'Xamp', '1999-01-01', 'bryan@xamp.com')
;
INSERT INTO Customer(idUser) VALUES ();

/*----- ETAPE 3.9: Ajout des réservations de séance -----*/
INSERT INTO Booking(idPaiement, idSeance, idPrice, idCustomer, idHall, idCinema)
VALUES (1, 1, 1, 4, 1, 1);


/*----- ETAPE 4: Vérification de la fiabilité de la BDD -----*/

# Différent mode paiement
SELECT *
FROM Paiement;

#Vérifier si la réservation et paiement a eu lieu en ligne
