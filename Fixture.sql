INSERT INTO GroupeCinema (name) VALUES ('Complexe Cinéma Paris');

INSERT INTO Cinema(nameOfCinema, city, idGroup) VALUES (
                                                        ('Cinéma Paris 15', 'Paris 7',''),
                                                        ('Cinéma Paris 12', 'Paris 12', ''),
                                                        ('Cinéma Paris 7', 'Paris 7', '')
                                                       );

#Ajoute les Halls de
INSERT INTO Hall(nameHall, nbLimit, idCinema) VALUES (
                                            ('A', '50',),
                                            ('B', '60',),
                                            ('C', '40',),
                                            ('D', '70',),
                                            ('E', '90',)
                                           );
INSERT INTO User(firstName, lastName, dateOfBirth, email) VALUES (
                                                                  ('Marcial', 'Ciné', '1960-06-30', 'marcial@cine.com'),
                                                                  ('Paul', 'Dupont', '1990-02-10','paul@dupont.com'),
                                                                  ('Olivier', 'Lapou', '1991-10-10','olivier@lapou.com'),
                                                                  ('Sandrine', 'Dupont', '1985-05-10','sandr@dupont.com')
                                                                 );

# Rattachement des adminstrateurs au cinéma

INSERT INTO Admin(iduser, idcinema, idgroup) VALUES (
                                                     ('1', '', '1'),
                                                     ('2', '2' , ''),
                                                     ('2', '2', '' ),
                                                     ('3', '3', '' )
                                                    );

# Moyen de paiement et prix général pour toute structure
INSERT INTO Paiement(name) VALUES (
                                   ('cb'),
                                   ('cash'),
                                   ('gift')
                                  );

INSERT INTO Price(name, price) VALUES (
                                       ('Plein Tarif' ,'9.80'),
                                       ('Etudiant', '7.60'),
                                       ('Enfant', '5.90')
                                      );
