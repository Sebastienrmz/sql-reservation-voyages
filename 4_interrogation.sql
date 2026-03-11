-- 1. Afficher le nom, le prénom et l'email des clients

SELECT nom_client, prenom_client, email_client
FROM Client;


-- 2. Afficher les réservations ayant le statut "confirmee" ou "en_option"

SELECT statut_reservation
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

SELECT ville_destination
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


-- 6. Afficher le montant total des paiements par réservation

SELECT reservation, SUM(montant_paiement) AS total_paiements
FROM Paiement
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
JOIN Conseiller ON Reservation.conseiller = Conseiller.conseiller;


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







