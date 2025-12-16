# Système de Gestion des Stages et Formations

## Description
Cette application Streamlit permet de gérer les stages et formations des étudiants. Elle se connecte à une base de données MySQL pour afficher et gérer les données relatives aux étudiants, formations, compétences, entreprises, offres de stage, candidatures, stages acceptés et encadrants.

## Prérequis
- Python 3.x
- MySQL Server
- Une base de données MySQL nommée `iscae` (ou modifier dans le fichier `.env`)

## Installation
1. Clonez ou téléchargez ce projet dans un répertoire local.
2. Installez les dépendances :
   ```
   pip install -r requirements.txt
   ```
3. Configurez la base de données dans le fichier `.env` :
   - `DB_HOST`: Adresse du serveur MySQL (par défaut : localhost)
   - `DB_PORT`: Port du serveur MySQL (par défaut : 4306)
   - `DB_USER`: Nom d'utilisateur MySQL (par défaut : root)
   - `DB_PASSWORD`: Mot de passe MySQL (par défaut : admin)
   - `DB_NAME`: Nom de la base de données (par défaut : iscae)
4. Configurez la base de données en exécutant le fichier `db.sql` dans votre client MySQL (par exemple, MySQL Workbench ou en ligne de commande : `mysql -u [utilisateur] -p < db.sql`).

## Utilisation
1. Lancez l'application :
   ```
   python -m streamlit run main.py
   ```
2. Ouvrez votre navigateur à l'adresse indiquée (généralement http://localhost:8501).
3. Utilisez la barre latérale pour naviguer entre les différentes sections : Étudiants, Formations, Compétences, etc.

## Fonctionnalités
- Affichage des données des étudiants avec leurs formations.
- Gestion des formations et compétences associées.
- Liste des entreprises et offres de stage.
- Suivi des candidatures et stages acceptés.
- Informations sur les encadrants.

## Dépendances
- streamlit
- pandas
- mysql-connector-python

## Notes
- Assurez-vous que la base de données MySQL est accessible et contient les tables appropriées.
- L'application utilise des requêtes SQL pour récupérer les données.
