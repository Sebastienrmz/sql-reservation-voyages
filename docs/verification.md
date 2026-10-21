# Vérifications et corrections

Vérification effectuée le **21 octobre 2026**, avec **MySQL Community Server 8.0.45 sous Windows**, sur une instance de test séparée.

## Exécution

- Création des 11 tables avec InnoDB, puis application des 17 contraintes `CHECK`.
- Insertion complète du jeu de données : 10 clients, 6 offres, 6 prestataires, 4 promotions, 5 options, 4 conseillers, 12 réservations, 16 paiements et 32 lignes dans les trois tables d'association.
- Exécution des 40 requêtes sans erreur. Le nombre de lignes renvoyées par chaque requête a été comparé à un résultat attendu.
- Vérification de plusieurs totaux : `R001 = 980.00`, `R006 = 2100.00`, `R010 = 1750.00` pour les paiements validés. Les paiements en attente et remboursés sont exclus.
- Contrôle des périodes : aucun séjour de l'exemple ne dépasse la validité de l'offre associée après correction des données.

## Contraintes et relations

Les essais ont volontairement tenté des opérations invalides, annulées ou rejetées dans la base de test :

- 17 violations des contraintes de domaine : nombre de voyageurs nul, prix négatif, retour avant le départ, statut inconnu, pourcentage supérieur à 100, etc. Chaque contrainte a rejeté sa valeur invalide.
- 10 références vers un identifiant inexistant : client, offre, conseiller, réservation, promotion, prestataire ou option. Chaque clé étrangère a rejeté l'opération.
- Client obligatoire mis à `NULL` et association d'option ajoutée deux fois : deux opérations rejetées.
- Suppression d'un conseiller : les réservations sont conservées avec une valeur `NULL` et restent présentes dans la jointure de consultation.
- Suppression d'un client : ses réservations, leurs paiements et leurs options sont supprimés en cascade ; l'essai est ensuite annulé.
- Un pourcentage de 100 et une promotion de type montant supérieure à 100 restent autorisés. Un conseiller absent reste autorisé.

## Changements par rapport au dépôt d'origine

Le modèle, les noms de tables, les clés et les contraintes du binôme sont conservés.

- Ajout de titres dans les scripts et séparation des quatre familles de requêtes.
- Affichage de l'identifiant des réservations filtrées et du titre des offres triées, pour identifier les résultats.
- Filtrage des paiements validés avant leur somme : le total représente désormais les sommes encaissées, sans les montants en attente ou remboursés.
- Jointure externe avec le conseiller : une réservation sans conseiller ne disparaît plus de cette consultation.
- Correction des séjours `R007`, `R009` et `R011`, hors de la période de leur offre, en conservant leur durée.
- Utilisation de domaines `example.invalid` dans les adresses de démonstration.
- Encadrement des insertions par une transaction.
- Modèle Looping, analyse initiale et prompts regroupés dans `docs/`. Le nouveau README décrit les scripts finaux et explique les écarts avec l'analyse initiale.

## Limites des essais

Ces tests portent sur MySQL 8.0.45, les données fournies et les cas décrits ci-dessus. Ils ne constituent pas une validation de MariaDB, PostgreSQL ou SQLite, ni une garantie sur toutes les opérations possibles. La base ne gère pas automatiquement les remises, la conversion des devises ou l'équilibre entre paiements et prix total.
