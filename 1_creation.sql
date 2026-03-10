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
