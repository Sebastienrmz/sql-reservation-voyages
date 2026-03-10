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
