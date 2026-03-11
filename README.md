Sébastien Ramirez - Raphael De Robien
Mini-projet TI404 – Bases de données 1
Plateforme de réservation de voyages (type Booking / Expedia)

------------------------------------------------------------

1. Contexte du projet

Ce mini-projet consiste à appliquer la méthode MERISE pour concevoir une base de données relationnelle.

Le domaine choisi est celui d’une agence de voyages en ligne proposant des séjours incluant transport, hébergement et activités, à l’image de plateformes comme Booking ou Expedia.

L’objectif est de modéliser et implémenter une base de données permettant de gérer les informations relatives aux clients, aux offres de voyage, aux prestataires, aux réservations, aux paiements et aux promotions.

Références :
https://www.booking.com
https://www.expedia.fr


------------------------------------------------------------

2. Prompt utilisé (Framework RICARDO)

Rôle (R)
Agir en tant qu’analyste métier dans le domaine du tourisme et des voyages.

Instructions (I)
Fournir les règles de gestion de l’entreprise puis un dictionnaire de données brutes sous forme de tableau.

Contexte (C)
Entreprise de type plateforme de réservation de voyages et séjours (transport, hébergement, activités).

Contraintes additionnelles (A)
- Règles de gestion sous forme de liste à puces
- Dictionnaire de données contenant entre 25 et 35 données
- Format clair et structuré

Références (R)
https://www.booking.com
https://www.expedia.fr

Rendement désiré (D)
- Liste de règles de gestion
- Tableau de dictionnaire de données

Objectif (O)
Obtenir une analyse des besoins complète pour concevoir le Modèle Conceptuel de Données (MCD).


------------------------------------------------------------

3. Règles de gestion (règles métier)

- L’agence référence des clients avec leurs coordonnées et préférences.
- Un client peut effectuer plusieurs réservations.
- L’agence propose des offres de voyages avec destination, période de validité et durée.
- Une offre peut être fournie par un ou plusieurs prestataires.
- Les prestataires peuvent être des hôtels, compagnies de transport ou activités.
- Une réservation est effectuée par un client pour une offre donnée.
- Une réservation possède un statut : en option, confirmée, annulée ou terminée.
- Une réservation peut être réglée en un ou plusieurs paiements.
- Chaque paiement possède un montant et un statut.
- Des promotions peuvent être appliquées à certaines offres.
- Certaines réservations peuvent être suivies par un conseiller.
- Une réservation peut inclure plusieurs options supplémentaires.


------------------------------------------------------------

4. Dictionnaire de données

Signification | Type | Taille

Identifiant du client | Numérique | 10
Nom du client | Texte | 50
Prénom du client | Texte | 50
Date de naissance du client | Date | 8
Email du client | Texte | 120
Téléphone du client | Texte | 20
Pays de résidence | Texte | 50
Langue préférée | Texte | 10
Identifiant de l’offre | Numérique | 10
Titre de l’offre | Texte | 120
Description de l’offre | Texte | 1000
Pays de destination | Texte | 50
Ville de destination | Texte | 80
Date début validité offre | Date | 8
Date fin validité offre | Date | 8
Durée du séjour | Numérique | 3
Politique d’annulation | Texte | 300
Identifiant du prestataire | Numérique | 10
Nom du prestataire | Texte | 120
Type de prestataire | Texte | 30
Email du prestataire | Texte | 120
Téléphone du prestataire | Texte | 20
Identifiant réservation | Texte | 20
Date de création réservation | DateHeure | 14
Statut de la réservation | Texte | 20
Date de départ | Date | 8
Date de retour | Date | 8
Nombre de voyageurs | Numérique | 2
Prix total | Décimal | 10
Devise | Texte | 3
Code promotion | Texte | 20
Identifiant paiement | Numérique | 12
Statut du paiement | Texte | 20
Montant du paiement | Décimal | 10


------------------------------------------------------------

5. Modèle Conceptuel de Données (MCD)

Le MCD a été réalisé avec l’outil Looping.

Il inclut les entités principales suivantes :

- CLIENT
- OFFRE
- PRESTATAIRE
- RESERVATION
- PAIEMENT
- PROMOTION
- OPTION
- CONSEILLER

Certaines relations sont de type plusieurs-à-plusieurs, ce qui nécessite l’utilisation de tables d’association.

Les principales associations sont :

- Est_fournie_par : relation entre Offre et Prestataire
- Propose : relation entre Offre et Promotion
- Inclut : relation entre Réservation et Option

Le modèle respecte les principes de normalisation jusqu’à la troisième forme normale (3FN) afin d’éviter les redondances et garantir la cohérence des données.


------------------------------------------------------------

6. Organisation du travail (binôme)

Raphael De Robien :
Analyse des besoins et rédaction du README.

Sébastien Ramirez :
Conception du MCD et implémentation SQL.

Les différentes étapes du projet ont été réalisées en collaboration.


------------------------------------------------------------

7. MLD

Client
(client, nom_client, prenom_client, email_client, date_naissance, telephone, pays_residence, langue_pref)

Offre
(offre, titre, description, pays_destination, ville_destination, date_debut, date_fin, duree_sejour, politique_annulation)

Prestataire
(prestataire, nom_prestataire, type, email_prestataire, telephone)

Promotion
(promotion, code_promo, type_promo, valeur_promo)

Option
(option, libelle_option, prix_option, type_option)

Conseiller
(conseiller, nom_conseiller, prenom_conseiller, role)

Reservation
(reservation, date_creation_reserv, statut_reservation, date_depart, date_retour, nb_voyageurs, prix_tot, devise, #conseiller, #offre, #client)

Paiement
(paiement, statut_paiement, montant_paiement, #reservation)

Propose
(#offre, #promotion)

Est_fournie_par
(#offre, #prestataire)

Inclut
(#reservation, #option)


------------------------------------------------------------

8. Scénario d’utilisation de la base de données

La base de données est utilisée dans le contexte d’une plateforme de réservation de voyages similaire à Booking ou Expedia.

Elle permet de gérer les informations liées aux clients, aux offres de voyage, aux prestataires, aux réservations et aux paiements.

Dans ce contexte, un conseiller de l’agence utilise la base de données afin de suivre l’activité des clients et gérer les réservations.

Le conseiller doit pouvoir accéder rapidement aux informations nécessaires pour répondre aux demandes des clients et assurer le bon suivi des séjours.

Grâce à la base de données, le conseiller peut :

- consulter les informations des clients enregistrés sur la plateforme
- visualiser les réservations effectuées par les clients
- consulter les offres de voyage disponibles ainsi que leurs destinations
- vérifier les paiements associés aux réservations
- identifier les promotions appliquées aux offres
- connaître les prestataires qui fournissent les offres
- consulter les options supplémentaires incluses dans certaines réservations

Les requêtes SQL réalisées dans la dernière étape du projet permettent d’extraire ces informations à partir de la base de données afin de faciliter le travail du conseiller et l’analyse de l’activité de la plateforme.
