Sébastien Ramirez- Raphael De Robien
# Mini-projet TI404 – Bases de données 1  
## Partie 1 – Analyse des besoins & MCD  
**Domaine : Plateforme de réservation de voyages (type Booking / Expedia)**

---

## 1. Contexte du projet
Ce mini-projet consiste à appliquer la méthode MERISE pour concevoir une base de données.
Le domaine choisi est celui d’une agence de voyages en ligne proposant des séjours incluant
transport, hébergement et activités, à l’image de plateformes comme Booking ou Expedia.

Références :
- https://www.booking.com  
- https://www.expedia.fr  

---

## 2. Prompt utilisé (Framework RICARDO)

**Rôle (R)**  
Agir en tant qu’analyste métier dans le domaine du tourisme et des voyages.

**Instructions (I)**  
Fournir les règles de gestion de l’entreprise puis un dictionnaire de données brutes
sous forme de tableau.

**Contexte (C)**  
Entreprise de type plateforme de réservation de voyages et séjours (transport, hébergement, activités).

**Contraintes additionnelles (A)**  
- Règles de gestion sous forme de liste à puces  
- Dictionnaire de données contenant entre 25 et 35 données  
- Format clair et structuré

**Références (R)**  
- https://www.booking.com  
- https://www.expedia.fr  

**Rendement désiré (D)**  
- Liste de règles de gestion  
- Tableau de dictionnaire de données (signification, type, taille)

**Objectif (O)**  
Obtenir une analyse des besoins complète pour concevoir le MCD.

---

## 3. Règles de gestion (règles métier)

- L’agence référence des clients avec leurs coordonnées et préférences.  
- Un client peut effectuer plusieurs réservations.  
- L’agence propose des offres de voyages avec destination, période de validité et durée.  
- Une offre peut inclure transport, hébergement et activités.  
- Les prix varient selon la période et les promotions.  
- L’agence gère des prestataires (hôtels, compagnies de transport, activités).  
- Un prestataire peut fournir plusieurs offres.  
- Une réservation est effectuée par un client pour une offre donnée.  
- Une réservation possède un statut (en option, confirmée, annulée, terminée).  
- Une réservation peut être réglée en un ou plusieurs paiements.  
- Chaque paiement possède un montant, une date, un moyen de paiement et un statut.  
- Des promotions peuvent être appliquées à certaines réservations.  
- Certaines réservations sont suivies par un conseiller de l’agence.  

---

## 4. Dictionnaire de données

| Signification de la donnée | Type | Taille |
|---------------------------|------|--------|
| Identifiant du client | Numérique | 10 |
| Civilité du client | Texte | 10 |
| Nom du client | Texte | 50 |
| Prénom du client | Texte | 50 |
| Date de naissance du client | Date | 8 |
| Email du client | Texte | 120 |
| Téléphone du client | Texte | 20 |
| Pays de résidence | Texte | 50 |
| Langue préférée | Texte | 10 |
| Identifiant de l’offre | Numérique | 10 |
| Titre de l’offre | Texte | 120 |
| Description de l’offre | Texte | 1000 |
| Pays de destination | Texte | 50 |
| Ville de destination | Texte | 80 |
| Date début validité offre | Date | 8 |
| Date fin validité offre | Date | 8 |
| Durée du séjour | Numérique | 3 |
| Politique d’annulation | Texte | 300 |
| Identifiant du prestataire | Numérique | 10 |
| Nom du prestataire | Texte | 120 |
| Type de prestataire | Texte | 30 |
| Email du prestataire | Texte | 120 |
| Téléphone du prestataire | Texte | 20 |
| Identifiant réservation | Texte | 20 |
| Date de création réservation | DateHeure | 14 |
| Statut de la réservation | Texte | 20 |
| Date de départ | Date | 8 |
| Date de retour | Date | 8 |
| Nombre de voyageurs | Numérique | 2 |
| Prix total | Décimal | 10 |
| Devise | Texte | 3 |
| Code promotion | Texte | 20 |
| Identifiant paiement | Numérique | 12 |
| Statut du paiement | Texte | 20 |
| Montant du paiement | Décimal | 10 |

---

## 5. Modèle Conceptuel de Données (MCD)

Le MCD a été réalisé avec un outil de modélisation (ex : Looping, Draw.io).  
Il inclut les entités CLIENT, OFFRE, PRESTATAIRE, RESERVATION, PAIEMENT, CONSEILLER.

Éléments avancés de modélisation intégrés :
- Association récursive : parrainage entre clients  
- Entité faible : paiement dépendant de la réservation  
- Association ternaire : gestion Client–Offre–Conseiller  



## 6. Organisation du travail (binôme)

- Raphael&Sébastien: Analyse des besoins, rédaction du README  
- Raphael&Sébastien: Conception du MCD


## 7. MLD 
Client = (client VARCHAR(50), nom_client VARCHAR(50), prénom_client VARCHAR(50), email_client VARCHAR(50), date_naissance VARCHAR(50), téléphone VARCHAR(50), pays_résidence VARCHAR(50), langue_préf VARCHAR(50));
Offre = (offre VARCHAR(50), titre VARCHAR(50), description VARCHAR(50), pays_destination VARCHAR(50), ville_destination VARCHAR(50), date_début VARCHAR(50), date_fin VARCHAR(50), durée_séjour VARCHAR(50), politique_annulation VARCHAR(50));
Prestataire = (préstataire VARCHAR(50), nom_préstataire VARCHAR(50), type VARCHAR(50), email_préstataire VARCHAR(50), téléphone_préstataire VARCHAR(50));
Promotion = (promotion VARCHAR(50), code_promo VARCHAR(50), type_promo VARCHAR(50), valeur_promo VARCHAR(50));
Option = (option VARCHAR(50), libelle_option VARCHAR(50), prix_option VARCHAR(50), type_option VARCHAR(50));
Conseiller = (conseiller VARCHAR(50), nom_conseiller VARCHAR(50), prénom_conseiller VARCHAR(50), role VARCHAR(50));
Réservation = (réservation VARCHAR(50), date_création_réserv VARCHAR(50), statut_réservation VARCHAR(50), date_départ VARCHAR(50), date_retour VARCHAR(50), nb_voyageurs VARCHAR(50), prix_tot VARCHAR(50), devise VARCHAR(50), #conseiller*, #offre, #client);
Paiement = (paiement VARCHAR(50), statut_paiement VARCHAR(50), montant_paiement VARCHAR(50), #réservation);
Propose = (#offre, #promotion);
est_fournie_par = (#offre, #préstataire);
Inclut = (#réservation, #option);


## 8. Scénario d’utilisation de la base de données

La base de données est utilisée dans le contexte d’une plateforme de réservation de voyages similaire à Booking ou Expedia. Elle permet de gérer les informations liées aux clients, aux offres de voyage, aux prestataires, aux réservations et aux paiements.

Dans ce contexte, un conseiller de l’agence utilise la base de données afin de suivre l’activité des clients et gérer les réservations. Le conseiller doit pouvoir accéder rapidement aux différentes informations nécessaires pour répondre aux demandes des clients et assurer le bon suivi des séjours.

Grâce à la base de données, le conseiller peut :

consulter les informations des clients enregistrés sur la plateforme ;

visualiser les réservations effectuées par les clients ;

consulter les offres de voyage disponibles ainsi que leurs destinations ;

vérifier les paiements associés aux réservations ;

identifier les promotions appliquées aux offres ;

connaître les prestataires (hôtels, transport ou activités) qui fournissent les offres ;

consulter les options supplémentaires incluses dans certaines réservations.

Les requêtes SQL réalisées dans la prochaine étape permettront d’extraire ces informations à partir de la base de données afin de faciliter le travail du conseiller et l’analyse de l’activité de la plateforme.
