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
