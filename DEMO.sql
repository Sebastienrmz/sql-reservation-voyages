-- Demonstration complete - MySQL 8.0.16 ou plus recent.
-- Ouvrir ce fichier dans MySQL Workbench, se connecter puis executer tout le script.
-- La base voyages_demo doit etre inexistante. Pour refaire un essai, remplacer
-- voyages_demo par voyages_demo_2 dans les DEUX instructions ci-dessous.
-- Aucun schema existant n'est supprime. Donnees fictives uniquement.
-- Ce fichier rassemble les quatre scripts du depot pour un premier essai.

CREATE DATABASE voyages_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE voyages_demo;


-- ===== 1_creation.sql =====

-- Création des 11 tables — MySQL 8.0.16 ou plus récent

CREATE TABLE Client (
    client VARCHAR(50) PRIMARY KEY,
    nom_client VARCHAR(50) NOT NULL,
    prenom_client VARCHAR(50) NOT NULL,
    email_client VARCHAR(100),
    date_naissance DATE,
    telephone VARCHAR(20),
    pays_residence VARCHAR(50),
    langue_pref VARCHAR(20)
);

CREATE TABLE Offre (
    offre VARCHAR(50) PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    description TEXT,
    pays_destination VARCHAR(50),
    ville_destination VARCHAR(50),
    date_debut DATE,
    date_fin DATE,
    duree_sejour INT,
    politique_annulation TEXT
);

CREATE TABLE Prestataire (
    prestataire VARCHAR(50) PRIMARY KEY,
    nom_prestataire VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    email_prestataire VARCHAR(100),
    telephone VARCHAR(20)
);

CREATE TABLE Promotion (
    promotion VARCHAR(50) PRIMARY KEY,
    code_promo VARCHAR(50),
    type_promo VARCHAR(50),
    valeur_promo DECIMAL(10,2)
);

CREATE TABLE OptionVoyage (
    option_id VARCHAR(50) PRIMARY KEY,
    libelle_option VARCHAR(100) NOT NULL,
    prix_option DECIMAL(10,2),
    type_option VARCHAR(50)
);

CREATE TABLE Conseiller (
    conseiller VARCHAR(50) PRIMARY KEY,
    nom_conseiller VARCHAR(50) NOT NULL,
    prenom_conseiller VARCHAR(50) NOT NULL,
    role VARCHAR(50)
);

CREATE TABLE Reservation (
    reservation VARCHAR(50) PRIMARY KEY,
    date_creation_reserv DATETIME,
    statut_reservation VARCHAR(50),
    date_depart DATE,
    date_retour DATE,
    nb_voyageurs INT,
    prix_tot DECIMAL(10,2),
    devise VARCHAR(10),
    conseiller VARCHAR(50),
    offre VARCHAR(50) NOT NULL,
    client VARCHAR(50) NOT NULL,

    FOREIGN KEY (conseiller)
    REFERENCES Conseiller(conseiller)
    ON DELETE SET NULL
    ON UPDATE CASCADE,

    FOREIGN KEY (offre)
    REFERENCES Offre(offre)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (client)
    REFERENCES Client(client)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Paiement (
    paiement VARCHAR(50) PRIMARY KEY,
    statut_paiement VARCHAR(50),
    montant_paiement DECIMAL(10,2),
    reservation VARCHAR(50) NOT NULL,

    FOREIGN KEY (reservation)
    REFERENCES Reservation(reservation)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Propose (
    offre VARCHAR(50),
    promotion VARCHAR(50),

    PRIMARY KEY (offre, promotion),

    FOREIGN KEY (offre)
    REFERENCES Offre(offre)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (promotion)
    REFERENCES Promotion(promotion)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Est_Fournie_Par (
    offre VARCHAR(50),
    prestataire VARCHAR(50),

    PRIMARY KEY (offre, prestataire),

    FOREIGN KEY (offre)
    REFERENCES Offre(offre)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (prestataire)
    REFERENCES Prestataire(prestataire)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Inclut (
    reservation VARCHAR(50),
    option_id VARCHAR(50),

    PRIMARY KEY (reservation, option_id),

    FOREIGN KEY (reservation)
    REFERENCES Reservation(reservation)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (option_id)
    REFERENCES OptionVoyage(option_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ===== 2_contraintes.sql =====

-- Contraintes de domaine — MySQL 8.0.16 ou plus récent

ALTER TABLE Reservation
ADD CONSTRAINT ck_nbvoyageur CHECK (nb_voyageurs > 0);

ALTER TABLE Reservation
ADD CONSTRAINT ck_prix_tot CHECK (prix_tot >= 0);

ALTER TABLE Reservation
ADD CONSTRAINT ck_date CHECK (date_retour >= date_depart);

ALTER TABLE Reservation
ADD CONSTRAINT ck_statut CHECK (
    statut_reservation IN ('en_option','confirmee','annulee','terminee')
);

ALTER TABLE Reservation
ADD CONSTRAINT ck_devise CHECK (
    devise IN ('EUR','USD','GBP')
);

ALTER TABLE Paiement
ADD CONSTRAINT ck_paiement CHECK (montant_paiement > 0);

ALTER TABLE Paiement
ADD CONSTRAINT ck_statut_p CHECK (
    statut_paiement IN ('en_attente','valide','refuse','rembourse')
);

ALTER TABLE Offre
ADD CONSTRAINT ck_date_offre CHECK (date_fin >= date_debut);

ALTER TABLE Offre
ADD CONSTRAINT ck_duree CHECK (duree_sejour > 0);

ALTER TABLE Promotion
ADD CONSTRAINT ck_valeur CHECK (valeur_promo >= 0);

ALTER TABLE Promotion
ADD CONSTRAINT ck_type_promo CHECK (
    type_promo IN ('pourcentage','montant')
);

ALTER TABLE Promotion
ADD CONSTRAINT ck_promo_pourcentage CHECK (
    (type_promo = 'pourcentage' AND valeur_promo <= 100)
    OR (type_promo = 'montant')
);

ALTER TABLE OptionVoyage
ADD CONSTRAINT ck_option CHECK (prix_option >= 0);

ALTER TABLE Client
ADD CONSTRAINT ck_date_naissance CHECK (date_naissance >= '1900-01-01');

ALTER TABLE Client
ADD CONSTRAINT ck_email_client CHECK (email_client LIKE '%@%');

ALTER TABLE Prestataire
ADD CONSTRAINT ck_email_prestataire CHECK (email_prestataire LIKE '%@%');

ALTER TABLE Prestataire
ADD CONSTRAINT ck_type_prestataire CHECK (
    type IN ('hotel','transport','activite')
);

-- ===== 3_insertion.sql =====

-- Données de démonstration — MySQL 8.0.16 ou plus récent

START TRANSACTION;

INSERT INTO Client (client, nom_client, prenom_client, email_client, date_naissance, telephone, pays_residence, langue_pref) VALUES
('C001', 'Dupont', 'Jean', 'jean.dupont@example.invalid', '1990-05-14', '0612345678', 'France', 'fr'),
('C002', 'Martin', 'Claire', 'claire.martin@example.invalid', '1988-09-22', '0623456789', 'Belgique', 'fr'),
('C003', 'Bernard', 'Lucas', 'lucas.bernard@example.invalid', '1995-03-10', '0634567891', 'France', 'fr'),
('C004', 'Petit', 'Emma', 'emma.petit@example.invalid', '1992-12-01', '0645678912', 'Suisse', 'fr'),
('C005', 'Robert', 'Hugo', 'hugo.robert@example.invalid', '1985-07-18', '0656789123', 'France', 'fr'),
('C006', 'Richard', 'Ines', 'ines.richard@example.invalid', '1998-02-27', '0667891234', 'Espagne', 'es'),
('C007', 'Durand', 'Nina', 'nina.durand@example.invalid', '1991-11-09', '0678912345', 'France', 'fr'),
('C008', 'Moreau', 'Leo', 'leo.moreau@example.invalid', '1987-06-30', '0689123456', 'Canada', 'fr'),
('C009', 'Simon', 'Jade', 'jade.simon@example.invalid', '1994-04-15', '0691234567', 'France', 'fr'),
('C010', 'Laurent', 'Tom', 'tom.laurent@example.invalid', '1996-08-21', '0609876543', 'Belgique', 'fr');

INSERT INTO Offre (offre, titre, description, pays_destination, ville_destination, date_debut, date_fin, duree_sejour, politique_annulation) VALUES
('O001', 'Séjour romantique à Rome', 'Voyage de 5 jours avec hôtel et visites culturelles.', 'Italie', 'Rome', '2025-06-01', '2025-06-30', 5, 'Annulation gratuite jusqu à 7 jours avant le départ'),
('O002', 'Week-end à Barcelone', 'Court séjour avec vol inclus et hébergement central.', 'Espagne', 'Barcelone', '2025-07-01', '2025-07-31', 3, 'Annulation partielle jusqu à 5 jours avant'),
('O003', 'Découverte de Lisbonne', 'Séjour urbain avec activités et petit-déjeuner.', 'Portugal', 'Lisbonne', '2025-05-15', '2025-08-15', 4, 'Non remboursable'),
('O004', 'Escapade à Prague', 'Séjour historique avec hôtel 4 étoiles.', 'Tchequie', 'Prague', '2025-09-01', '2025-10-15', 4, 'Annulation gratuite jusqu à 10 jours avant'),
('O005', 'Vacances à Marrakech', 'Séjour avec riad, transfert et excursion.', 'Maroc', 'Marrakech', '2025-06-10', '2025-09-10', 7, 'Annulation gratuite jusqu à 14 jours avant'),
('O006', 'City trip à Amsterdam', 'Séjour avec hébergement et pass transport.', 'Pays-Bas', 'Amsterdam', '2025-04-20', '2025-07-20', 3, 'Annulation partielle jusqu à 3 jours avant');

INSERT INTO Prestataire (prestataire, nom_prestataire, type, email_prestataire, telephone) VALUES
('P001', 'Hotel Roma Centro', 'hotel', 'contact@example.invalid', '0155551111'),
('P002', 'Air Europa Travel', 'transport', 'resa@example.invalid', '0155552222'),
('P003', 'Barcelona Stay', 'hotel', 'booking@example.invalid', '0155553333'),
('P004', 'City Activities Group', 'activite', 'info@example.invalid', '0155554444'),
('P005', 'Riad Atlas Premium', 'hotel', 'contact@example.invalid', '0155555555'),
('P006', 'EuroMove Transport', 'transport', 'support@example.invalid', '0155556666');

INSERT INTO Promotion (promotion, code_promo, type_promo, valeur_promo) VALUES
('PR001', 'SUMMER10', 'pourcentage', 10.00),
('PR002', 'WELCOME50', 'montant', 50.00),
('PR003', 'CITY15', 'pourcentage', 15.00),
('PR004', 'FLASH20', 'pourcentage', 20.00);

INSERT INTO OptionVoyage (option_id, libelle_option, prix_option, type_option) VALUES
('OP001', 'Petit-déjeuner inclus', 25.00, 'hebergement'),
('OP002', 'Transfert aéroport', 40.00, 'transport'),
('OP003', 'Visite guidée', 60.00, 'activite'),
('OP004', 'Assurance annulation', 35.00, 'assurance'),
('OP005', 'Bagage supplémentaire', 45.00, 'transport');

INSERT INTO Conseiller (conseiller, nom_conseiller, prenom_conseiller, role) VALUES
('CO001', 'Leroy', 'Sophie', 'senior'),
('CO002', 'Roux', 'Antoine', 'junior'),
('CO003', 'Fontaine', 'Camille', 'support'),
('CO004', 'Mercier', 'Julie', 'senior');

INSERT INTO Reservation (reservation, date_creation_reserv, statut_reservation, date_depart, date_retour, nb_voyageurs, prix_tot, devise, conseiller, offre, client) VALUES
('R001', '2025-03-10 10:15:00', 'confirmee', '2025-06-05', '2025-06-10', 2, 980.00, 'EUR', 'CO001', 'O001', 'C001'),
('R002', '2025-03-11 14:20:00', 'en_option', '2025-07-12', '2025-07-15', 1, 520.00, 'EUR', 'CO002', 'O002', 'C002'),
('R003', '2025-03-12 09:40:00', 'annulee', '2025-06-20', '2025-06-24', 3, 1350.00, 'EUR', 'CO003', 'O003', 'C003'),
('R004', '2025-03-13 16:30:00', 'terminee', '2025-04-25', '2025-04-28', 2, 760.00, 'EUR', 'CO001', 'O006', 'C004'),
('R005', '2025-03-14 11:10:00', 'confirmee', '2025-09-05', '2025-09-09', 2, 890.00, 'EUR', 'CO004', 'O004', 'C005'),
('R006', '2025-03-15 13:00:00', 'confirmee', '2025-07-01', '2025-07-08', 4, 2100.00, 'EUR', 'CO002', 'O005', 'C006'),
('R007', '2025-03-16 15:45:00', 'en_option', '2025-07-23', '2025-07-26', 2, 680.00, 'USD', 'CO003', 'O002', 'C007'),
('R008', '2025-03-17 17:25:00', 'confirmee', '2025-06-18', '2025-06-22', 1, 610.00, 'EUR', 'CO004', 'O003', 'C008'),
('R009', '2025-03-18 08:55:00', 'terminee', '2025-06-02', '2025-06-07', 2, 1020.00, 'GBP', 'CO001', 'O001', 'C009'),
('R010', '2025-03-19 12:35:00', 'confirmee', '2025-08-15', '2025-08-22', 3, 1750.00, 'EUR', 'CO002', 'O005', 'C010'),
('R011', '2025-03-20 10:05:00', 'annulee', '2025-07-16', '2025-07-19', 1, 540.00, 'EUR', 'CO003', 'O006', 'C001'),
('R012', '2025-03-21 18:10:00', 'confirmee', '2025-10-02', '2025-10-06', 2, 870.00, 'EUR', 'CO004', 'O004', 'C002');

INSERT INTO Paiement (paiement, statut_paiement, montant_paiement, reservation) VALUES
('PA001', 'valide', 500.00, 'R001'),
('PA002', 'valide', 480.00, 'R001'),
('PA003', 'en_attente', 520.00, 'R002'),
('PA004', 'rembourse', 1350.00, 'R003'),
('PA005', 'valide', 760.00, 'R004'),
('PA006', 'valide', 445.00, 'R005'),
('PA007', 'valide', 445.00, 'R005'),
('PA008', 'valide', 1050.00, 'R006'),
('PA009', 'valide', 1050.00, 'R006'),
('PA010', 'en_attente', 680.00, 'R007'),
('PA011', 'valide', 610.00, 'R008'),
('PA012', 'valide', 1020.00, 'R009'),
('PA013', 'valide', 875.00, 'R010'),
('PA014', 'valide', 875.00, 'R010'),
('PA015', 'rembourse', 540.00, 'R011'),
('PA016', 'valide', 870.00, 'R012');

INSERT INTO Propose (offre, promotion) VALUES
('O001', 'PR001'),
('O002', 'PR003'),
('O003', 'PR002'),
('O004', 'PR004'),
('O005', 'PR001'),
('O005', 'PR002'),
('O006', 'PR003');

INSERT INTO Est_Fournie_Par (offre, prestataire) VALUES
('O001', 'P001'),
('O001', 'P002'),
('O002', 'P003'),
('O002', 'P006'),
('O003', 'P004'),
('O004', 'P001'),
('O005', 'P005'),
('O005', 'P006'),
('O006', 'P003'),
('O006', 'P004');

INSERT INTO Inclut (reservation, option_id) VALUES
('R001', 'OP001'),
('R001', 'OP003'),
('R002', 'OP002'),
('R003', 'OP004'),
('R004', 'OP001'),
('R005', 'OP003'),
('R006', 'OP002'),
('R006', 'OP004'),
('R007', 'OP005'),
('R008', 'OP001'),
('R009', 'OP003'),
('R010', 'OP002'),
('R010', 'OP005'),
('R011', 'OP004'),
('R012', 'OP001');

COMMIT;

-- ===== 4_interrogation.sql =====

-- 40 requêtes de consultation — MySQL 8.0.16 ou plus récent

-- Filtres et tris
-- --------------------------------------------------

-- 1. Afficher le nom, le prénom et l'email des clients

SELECT nom_client, prenom_client, email_client
FROM Client;

-- 2. Afficher les réservations ayant le statut "confirmee" ou "en_option"

SELECT reservation, statut_reservation
FROM Reservation
WHERE statut_reservation IN ('confirmee', 'en_option');

-- 3. Afficher les offres triées par durée du séjour décroissante

SELECT offre, titre, duree_sejour
FROM Offre
ORDER BY duree_sejour DESC;

-- 4. Afficher les clients dont le nom commence par la lettre D

SELECT nom_client
FROM Client
WHERE nom_client LIKE 'D%';

-- 5. Afficher les offres triées par ville de destination

SELECT offre, titre, ville_destination
FROM Offre
ORDER BY ville_destination ASC;

-- 6. Afficher les devises utilisées dans les réservations sans doublons

SELECT DISTINCT devise
FROM Reservation;

-- 7. Afficher les clients résidant en France, Belgique ou Suisse

SELECT nom_client, prenom_client
FROM Client
WHERE pays_residence IN ('France', 'Belgique', 'Suisse');

-- 8. Afficher les prestataires de type hotel ou transport

SELECT nom_prestataire
FROM Prestataire
WHERE type IN ('hotel', 'transport');

-- 9. Afficher les offres dont la date de début est entre deux dates

SELECT offre, titre, date_debut
FROM Offre
WHERE date_debut BETWEEN '2025-06-01' AND '2025-08-31';

-- 10. Afficher les réservations dont le prix total est supérieur à 500

SELECT reservation, prix_tot
FROM Reservation
WHERE prix_tot > 500;

-- Agrégations
-- --------------------------------------------------

-- 1. Compter le nombre total de clients

SELECT COUNT(*) AS total_clients
FROM Client;

-- 2. Calculer le prix moyen des réservations

SELECT AVG(prix_tot) AS prix_moyen_reservations
FROM Reservation;

-- 3. Afficher le nombre de réservations par statut

SELECT statut_reservation, COUNT(*) AS nb_reservations
FROM Reservation
GROUP BY statut_reservation;

-- 4. Afficher le nombre de réservations par client

SELECT client, COUNT(*) AS nb_reservations
FROM Reservation
GROUP BY client;

-- 5. Afficher les clients qui ont effectué plus d’une réservation

SELECT client, COUNT(*) AS nb_reservations
FROM Reservation
GROUP BY client
HAVING COUNT(*) > 1;

-- 6. Afficher le montant total des paiements validés par réservation

SELECT reservation, SUM(montant_paiement) AS total_paiements
FROM Paiement
WHERE statut_paiement = 'valide'
GROUP BY reservation;

-- 7. Afficher le nombre d’offres par pays de destination

SELECT pays_destination, COUNT(*) AS nb_offres
FROM Offre
GROUP BY pays_destination;

-- 8. Calculer la durée moyenne des séjours par pays de destination

SELECT pays_destination, AVG(duree_sejour) AS duree_moyenne
FROM Offre
GROUP BY pays_destination;

-- 9. Afficher le nombre de prestataires par type

SELECT type, COUNT(*) AS nb_prestataires
FROM Prestataire
GROUP BY type;

-- 10. Afficher les offres ayant au moins deux prestataires

SELECT offre, COUNT(*) AS nb_prestataires
FROM Est_Fournie_Par
GROUP BY offre
HAVING COUNT(*) >= 2;

-- Jointures
-- --------------------------------------------------

-- 1. Afficher les réservations avec le nom et prénom du client

SELECT Reservation.reservation, Client.nom_client, Client.prenom_client
FROM Reservation
JOIN Client ON Reservation.client = Client.client;

-- 2. Afficher les paiements avec l'identifiant de la réservation correspondante

SELECT Paiement.paiement, Paiement.montant_paiement, Reservation.reservation
FROM Paiement
JOIN Reservation ON Paiement.reservation = Reservation.reservation;

-- 3. Afficher les offres avec les prestataires qui les fournissent

SELECT Offre.titre, Prestataire.nom_prestataire
FROM Est_Fournie_Par
JOIN Offre ON Est_Fournie_Par.offre = Offre.offre
JOIN Prestataire ON Est_Fournie_Par.prestataire = Prestataire.prestataire;

-- 4. Afficher les offres avec les promotions associées

SELECT Offre.titre, Promotion.code_promo
FROM Propose
JOIN Offre ON Propose.offre = Offre.offre
JOIN Promotion ON Propose.promotion = Promotion.promotion;

-- 5. Afficher les réservations avec les options incluses

SELECT Reservation.reservation, OptionVoyage.libelle_option
FROM Inclut
JOIN Reservation ON Inclut.reservation = Reservation.reservation
JOIN OptionVoyage ON Inclut.option_id = OptionVoyage.option_id;

-- 6. Afficher les réservations avec le client, l’offre et le conseiller

SELECT Reservation.reservation, Client.nom_client, Offre.titre, Conseiller.nom_conseiller
FROM Reservation
JOIN Client ON Reservation.client = Client.client
JOIN Offre ON Reservation.offre = Offre.offre
LEFT JOIN Conseiller ON Reservation.conseiller = Conseiller.conseiller;

-- 7. Afficher tous les clients et leurs réservations éventuelles

SELECT Client.nom_client, Client.prenom_client, Reservation.reservation
FROM Client
LEFT JOIN Reservation ON Client.client = Reservation.client;

-- 8. Afficher toutes les offres et leurs promotions éventuelles

SELECT Offre.titre, Promotion.code_promo
FROM Offre
LEFT JOIN Propose ON Offre.offre = Propose.offre
LEFT JOIN Promotion ON Propose.promotion = Promotion.promotion;

-- 9. Afficher le nom du client, la destination de l’offre et le statut de la réservation

SELECT Client.nom_client, Client.prenom_client, Offre.ville_destination, Reservation.statut_reservation
FROM Reservation
JOIN Client ON Reservation.client = Client.client
JOIN Offre ON Reservation.offre = Offre.offre;

-- 10. Afficher les paiements avec le client associé à la réservation

SELECT Paiement.paiement, Paiement.montant_paiement, Client.nom_client, Client.prenom_client
FROM Paiement
JOIN Reservation ON Paiement.reservation = Reservation.reservation
JOIN Client ON Reservation.client = Client.client;

-- Sous-requêtes
-- --------------------------------------------------

-- 1. Afficher les clients qui ont effectué au moins une réservation

SELECT nom_client, prenom_client
FROM Client
WHERE client IN (
    SELECT client
    FROM Reservation
);

-- 2. Afficher les clients qui n'ont effectué aucune réservation

SELECT nom_client, prenom_client
FROM Client
WHERE client NOT IN (
    SELECT client
    FROM Reservation
);

-- 3. Afficher les offres qui sont utilisées dans au moins une réservation

SELECT titre
FROM Offre
WHERE offre IN (
    SELECT offre
    FROM Reservation
);

-- 4. Afficher les offres qui ne sont utilisées dans aucune réservation

SELECT titre
FROM Offre
WHERE offre NOT IN (
    SELECT offre
    FROM Reservation
);

-- 5. Afficher les réservations dont le prix total est supérieur au prix moyen des réservations

SELECT reservation, prix_tot
FROM Reservation
WHERE prix_tot > (
    SELECT AVG(prix_tot)
    FROM Reservation
);

-- 6. Afficher les clients qui ont effectué une réservation confirmée

SELECT nom_client, prenom_client
FROM Client
WHERE client IN (
    SELECT client
    FROM Reservation
    WHERE statut_reservation = 'confirmee'
);

-- 7. Afficher les offres fournies par des prestataires de type hotel

SELECT titre
FROM Offre
WHERE offre IN (
    SELECT offre
    FROM Est_Fournie_Par
    WHERE prestataire IN (
        SELECT prestataire
        FROM Prestataire
        WHERE type = 'hotel'
    )
);

-- 8. Afficher les réservations ayant au moins un paiement validé

SELECT reservation
FROM Reservation
WHERE reservation IN (
    SELECT reservation
    FROM Paiement
    WHERE statut_paiement = 'valide'
);

-- 9. Afficher les promotions associées à des offres réservées

SELECT code_promo
FROM Promotion
WHERE promotion IN (
    SELECT promotion
    FROM Propose
    WHERE offre IN (
        SELECT offre
        FROM Reservation
    )
);

-- 10. Afficher les clients ayant réservé une offre en Italie

SELECT nom_client, prenom_client
FROM Client
WHERE client IN (
    SELECT client
    FROM Reservation
    WHERE offre IN (
        SELECT offre
        FROM Offre
        WHERE pays_destination = 'Italie'
    )
);

-- Verification finale : resultats attendus 11 tables, 10 clients et 12 reservations.
SELECT COUNT(*) AS nombre_tables_attendu_11 FROM information_schema.tables
WHERE table_schema = DATABASE() AND table_type = 'BASE TABLE';
SELECT COUNT(*) AS nombre_clients_attendu_10 FROM Client;
SELECT COUNT(*) AS nombre_reservations_attendu_12 FROM Reservation;
