============================================================
Mini-Projet TI404 – Bases de données 1
Plateforme de réservation de voyages
============================================================

Auteurs :
Sébastien Ramirez
Raphael De Robien

Formation : TI404 – Bases de données
Projet : Conception et implémentation d'une base de données
Thème : Plateforme de réservation de voyages (type Booking / Expedia)

------------------------------------------------------------
1. Présentation du projet
------------------------------------------------------------

Ce mini-projet a pour objectif de concevoir et d’implémenter une base de données relationnelle en appliquant la méthode MERISE.

Le domaine choisi est celui d’une plateforme de réservation de voyages en ligne similaire à des services comme Booking ou Expedia. La base de données doit permettre de gérer l’ensemble des informations nécessaires à l’activité d’une agence de voyages :

- gestion des clients
- gestion des offres de voyages
- gestion des prestataires (hôtels, transport, activités)
- gestion des réservations
- gestion des paiements
- gestion des promotions
- gestion des options de voyage
- gestion des conseillers

L’objectif est de passer par les différentes étapes de conception d’une base de données, depuis l’analyse des besoins jusqu’à l’interrogation de la base à l’aide de requêtes SQL.

Références utilisées pour le domaine étudié :
https://www.booking.com
https://www.expedia.fr


------------------------------------------------------------
2. Méthodologie utilisée
------------------------------------------------------------

La conception de la base de données a été réalisée en suivant la méthode MERISE.

Les étapes principales du projet sont :

1. Analyse des besoins
2. Définition des règles de gestion
3. Création du dictionnaire de données
4. Conception du Modèle Conceptuel de Données (MCD)
5. Transformation en Modèle Logique de Données (MLD)
6. Implémentation du Modèle Physique en SQL
7. Ajout de contraintes d’intégrité
8. Insertion de données de test
9. Réalisation de requêtes d’interrogation

Cette démarche permet de structurer les données et de garantir la cohérence du modèle.


------------------------------------------------------------
3. Règles de gestion
------------------------------------------------------------

Les principales règles métier identifiées pour la plateforme sont les suivantes :

- L’agence référence des clients avec leurs coordonnées et informations personnelles.
- Un client peut effectuer plusieurs réservations.
- L’agence propose différentes offres de voyages avec destination et durée.
- Une offre peut être fournie par un ou plusieurs prestataires.
- Les prestataires peuvent être des hôtels, des compagnies de transport ou des activités.
- Une réservation est effectuée par un client pour une offre donnée.
- Une réservation possède un statut : en option, confirmée, annulée ou terminée.
- Une réservation peut être suivie par un conseiller.
- Une réservation peut être réglée en un ou plusieurs paiements.
- Chaque paiement possède un montant et un statut.
- Des promotions peuvent être appliquées à certaines offres.
- Une réservation peut inclure plusieurs options supplémentaires.


------------------------------------------------------------
4. Dictionnaire de données
------------------------------------------------------------

Le dictionnaire de données regroupe les principales informations manipulées dans la base de données.

Exemples de données :

Identifiant client
Nom client
Prénom client
Email client
Date de naissance
Téléphone
Pays de résidence
Langue préférée

Identifiant offre
Titre de l’offre
Description
Pays destination
Ville destination
Date début
Date fin
Durée du séjour
Politique d’annulation

Identifiant prestataire
Nom prestataire
Type prestataire
Email prestataire
Téléphone prestataire

Identifiant réservation
Date de création
Statut réservation
Date de départ
Date de retour
Nombre de voyageurs
Prix total
Devise

Identifiant paiement
Statut paiement
Montant paiement

Code promotion


------------------------------------------------------------
5. Modèle Conceptuel de Données (MCD)
------------------------------------------------------------

Le Modèle Conceptuel de Données a été réalisé à l’aide de l’outil Looping.

Les principales entités du système sont :

CLIENT
OFFRE
PRESTATAIRE
RESERVATION
PAIEMENT
PROMOTION
OPTION
CONSEILLER

Certaines relations sont de type plusieurs-à-plusieurs. Elles sont donc modélisées par des tables d’association :

PROPOSE (Offre – Promotion)
EST_FOURNIE_PAR (Offre – Prestataire)
INCLUT (Reservation – Option)

Le modèle respecte les principes de normalisation afin de limiter les redondances et garantir la cohérence des données.


------------------------------------------------------------
6. Modèle Logique de Données (MLD)
------------------------------------------------------------

Client
(client, nom_client, prenom_client, email_client, date_naissance,
telephone, pays_residence, langue_pref)

Offre
(offre, titre, description, pays_destination, ville_destination,
date_debut, date_fin, duree_sejour, politique_annulation)

Prestataire
(prestataire, nom_prestataire, type, email_prestataire, telephone)

Promotion
(promotion, code_promo, type_promo, valeur_promo)

Option
(option, libelle_option, prix_option, type_option)

Conseiller
(conseiller, nom_conseiller, prenom_conseiller, role)

Reservation
(reservation, date_creation_reserv, statut_reservation,
date_depart, date_retour, nb_voyageurs, prix_tot, devise,
#conseiller, #offre, #client)

Paiement
(paiement, statut_paiement, montant_paiement, #reservation)

Propose
(#offre, #promotion)

Est_fournie_par
(#offre, #prestataire)

Inclut
(#reservation, #option)


------------------------------------------------------------
7. Implémentation SQL
------------------------------------------------------------

La base de données a été implémentée en SQL à l’aide de plusieurs scripts :

1_creation.sql
Création des tables avec les clés primaires et étrangères.

2_contraintes.sql
Ajout des contraintes d’intégrité (CHECK, validation des valeurs, etc.).

3_insertion.sql
Insertion de données de test permettant de vérifier le fonctionnement de la base.

4_interrogation.sql
Requêtes SQL permettant d’interroger la base de données.


------------------------------------------------------------
8. Exemple d’utilisation de la base
------------------------------------------------------------

La base de données est utilisée par les conseillers d’une agence de voyages afin de suivre l’activité des clients et gérer les réservations.

Un conseiller peut :

- consulter les informations des clients
- visualiser les réservations effectuées
- analyser les offres de voyage disponibles
- vérifier les paiements associés aux réservations
- identifier les promotions appliquées
- consulter les prestataires associés aux offres
- consulter les options incluses dans les réservations

Les requêtes SQL permettent ainsi d’extraire rapidement les informations nécessaires au suivi de l’activité de la plateforme.


------------------------------------------------------------
9. Conclusion
------------------------------------------------------------

Ce projet nous a permis de mettre en pratique la conception complète d’une base de données relationnelle.

Nous avons appliqué les différentes étapes de la méthode MERISE : analyse des besoins, modélisation des données, implémentation SQL et interrogation de la base.

Ce travail permet de mieux comprendre la conception et la gestion des bases de données dans un contexte réel d’application.

Des améliorations pourraient être apportées au modèle, par exemple :

- ajout d’un système d’avis clients
- gestion de plusieurs moyens de paiement
- gestion des disponibilités en temps réel
- historique des réservations et modifications
