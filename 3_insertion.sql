INSERT INTO Client (client, nom_client, prenom_client, email_client, date_naissance, telephone, pays_residence, langue_pref) VALUES
('C001', 'Dupont', 'Jean', 'jean.dupont@email.com', '1990-05-14', '0612345678', 'France', 'fr'),
('C002', 'Martin', 'Claire', 'claire.martin@email.com', '1988-09-22', '0623456789', 'Belgique', 'fr'),
('C003', 'Bernard', 'Lucas', 'lucas.bernard@email.com', '1995-03-10', '0634567891', 'France', 'fr'),
('C004', 'Petit', 'Emma', 'emma.petit@email.com', '1992-12-01', '0645678912', 'Suisse', 'fr'),
('C005', 'Robert', 'Hugo', 'hugo.robert@email.com', '1985-07-18', '0656789123', 'France', 'fr'),
('C006', 'Richard', 'Ines', 'ines.richard@email.com', '1998-02-27', '0667891234', 'Espagne', 'es'),
('C007', 'Durand', 'Nina', 'nina.durand@email.com', '1991-11-09', '0678912345', 'France', 'fr'),
('C008', 'Moreau', 'Leo', 'leo.moreau@email.com', '1987-06-30', '0689123456', 'Canada', 'fr'),
('C009', 'Simon', 'Jade', 'jade.simon@email.com', '1994-04-15', '0691234567', 'France', 'fr'),
('C010', 'Laurent', 'Tom', 'tom.laurent@email.com', '1996-08-21', '0609876543', 'Belgique', 'fr');

INSERT INTO Offre (offre, titre, description, pays_destination, ville_destination, date_debut, date_fin, duree_sejour, politique_annulation) VALUES
('O001', 'Séjour romantique à Rome', 'Voyage de 5 jours avec hôtel et visites culturelles.', 'Italie', 'Rome', '2025-06-01', '2025-06-30', 5, 'Annulation gratuite jusqu à 7 jours avant le départ'),
('O002', 'Week-end à Barcelone', 'Court séjour avec vol inclus et hébergement central.', 'Espagne', 'Barcelone', '2025-07-01', '2025-07-31', 3, 'Annulation partielle jusqu à 5 jours avant'),
('O003', 'Découverte de Lisbonne', 'Séjour urbain avec activités et petit-déjeuner.', 'Portugal', 'Lisbonne', '2025-05-15', '2025-08-15', 4, 'Non remboursable'),
('O004', 'Escapade à Prague', 'Séjour historique avec hôtel 4 étoiles.', 'Tchequie', 'Prague', '2025-09-01', '2025-10-15', 4, 'Annulation gratuite jusqu à 10 jours avant'),
('O005', 'Vacances à Marrakech', 'Séjour avec riad, transfert et excursion.', 'Maroc', 'Marrakech', '2025-06-10', '2025-09-10', 7, 'Annulation gratuite jusqu à 14 jours avant'),
('O006', 'City trip à Amsterdam', 'Séjour avec hébergement et pass transport.', 'Pays-Bas', 'Amsterdam', '2025-04-20', '2025-07-20', 3, 'Annulation partielle jusqu à 3 jours avant');

INSERT INTO Prestataire (prestataire, nom_prestataire, type, email_prestataire, telephone) VALUES
('P001', 'Hotel Roma Centro', 'hotel', 'contact@roma-centro.com', '0155551111'),
('P002', 'Air Europa Travel', 'transport', 'resa@aireuropa-travel.com', '0155552222'),
('P003', 'Barcelona Stay', 'hotel', 'booking@barcelonastay.com', '0155553333'),
('P004', 'City Activities Group', 'activite', 'info@cityactivities.com', '0155554444'),
('P005', 'Riad Atlas Premium', 'hotel', 'contact@riadatlas.com', '0155555555'),
('P006', 'EuroMove Transport', 'transport', 'support@euromove.com', '0155556666');

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
('R007', '2025-03-16 15:45:00', 'en_option', '2025-08-03', '2025-08-06', 2, 680.00, 'USD', 'CO003', 'O002', 'C007'),
('R008', '2025-03-17 17:25:00', 'confirmee', '2025-06-18', '2025-06-22', 1, 610.00, 'EUR', 'CO004', 'O003', 'C008'),
('R009', '2025-03-18 08:55:00', 'terminee', '2025-05-02', '2025-05-07', 2, 1020.00, 'GBP', 'CO001', 'O001', 'C009'),
('R010', '2025-03-19 12:35:00', 'confirmee', '2025-08-15', '2025-08-22', 3, 1750.00, 'EUR', 'CO002', 'O005', 'C010'),
('R011', '2025-03-20 10:05:00', 'annulee', '2025-09-18', '2025-09-21', 1, 540.00, 'EUR', 'CO003', 'O006', 'C001'),
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



