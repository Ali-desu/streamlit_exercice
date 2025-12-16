CREATE TABLE etudiant (
    id_etudiant INTEGER PRIMARY KEY,
    nom_etd VARCHAR(255),
    prenom_etd VARCHAR(255),
    filiere_etd VARCHAR(255),
    annee_etd VARCHAR(50),
    email_etd VARCHAR(255),
    telephone_etd VARCHAR(50)
);

CREATE TABLE formation (
    id_formation INTEGER PRIMARY KEY,
    nom_form VARCHAR(255),
    type_form VARCHAR(100),
    niveau_form VARCHAR(100),
    date_debut_form DATE,
    date_fin_form DATE,
    certification_disponible_form BOOLEAN,
    institution_form VARCHAR(255)
);

CREATE TABLE poursuivre (
    id_etudiant INTEGER,
    id_formation INTEGER,
    PRIMARY KEY (id_etudiant, id_formation),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant),
    FOREIGN KEY (id_formation) REFERENCES formation(id_formation)
);

CREATE TABLE entreprise (
    id_entreprise INTEGER PRIMARY KEY,
    nom VARCHAR(255),
    secteur_activite VARCHAR(255),
    adresse VARCHAR(255),
    nom_contact VARCHAR(255),
    tel_contact VARCHAR(50),
    email_contact VARCHAR(255)
);

CREATE TABLE offre_stage (
    id_offre INTEGER PRIMARY KEY,
    poste_stg VARCHAR(255),
    description_stg TEXT,
    duree_stg VARCHAR(100),
    remuneration_stg VARCHAR(100),
    date_publication_stg DATE,
    id_entreprise INTEGER,
    FOREIGN KEY (id_entreprise) REFERENCES entreprise(id_entreprise)
);

CREATE TABLE competence (
    id_competence INTEGER PRIMARY KEY,
    libelle_compt VARCHAR(255),
    description_compt TEXT
);

CREATE TABLE acquerir (
    id_competence INTEGER,
    id_formation INTEGER,
    PRIMARY KEY (id_competence, id_formation),
    FOREIGN KEY (id_competence) REFERENCES competence(id_competence),
    FOREIGN KEY (id_formation) REFERENCES formation(id_formation)
);

CREATE TABLE requerir (
    id_offre INTEGER,
    id_competence INTEGER,
    PRIMARY KEY (id_offre, id_competence),
    FOREIGN KEY (id_offre) REFERENCES offre_stage(id_offre),
    FOREIGN KEY (id_competence) REFERENCES competence(id_competence)
);

CREATE TABLE developper (
    id_Stage INTEGER,
    id_competence INTEGER,
    PRIMARY KEY (id_Stage, id_competence)
    -- FOREIGN KEY will be added later after Stage table is created
);

CREATE TABLE Candidature (
    id_Candidature INTEGER PRIMARY KEY,
    date_candit DATE,
    statut_candit VARCHAR(100),
    id_offre INTEGER,
    id_etudiant INTEGER,
    FOREIGN KEY (id_offre) REFERENCES offre_stage(id_offre),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant)
);

CREATE TABLE deposer (
    id_offre INTEGER,
    id_Candidature INTEGER,
    PRIMARY KEY (id_offre, id_Candidature),
    FOREIGN KEY (id_offre) REFERENCES offre_stage(id_offre),
    FOREIGN KEY (id_Candidature) REFERENCES Candidature(id_Candidature)
);

CREATE TABLE postuler (
    id_Candidature INTEGER,
    id_etudiant INTEGER,
    PRIMARY KEY (id_Candidature, id_etudiant),
    FOREIGN KEY (id_Candidature) REFERENCES Candidature(id_Candidature),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant)
);

CREATE TABLE Stage (
    id_Stage INTEGER PRIMARY KEY,
    date_debut DATE,
    date_fin DATE,
    competence_dev TEXT,  -- or could be split if needed
    id_etudiant INTEGER,
    id_offre INTEGER,
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant),
    FOREIGN KEY (id_offre) REFERENCES offre_stage(id_offre)
);

CREATE TABLE posseder (
    id_Stage INTEGER,
    id_etudiant INTEGER,
    PRIMARY KEY (id_Stage, id_etudiant),
    FOREIGN KEY (id_Stage) REFERENCES Stage(id_Stage),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant)
);

CREATE TABLE Encadrant (
    id_Encadrant INTEGER PRIMARY KEY,
    Nom_enc VARCHAR(255),
    prenom_enc VARCHAR(255),
    departement_enc VARCHAR(255)
);

CREATE TABLE encadrer (
    id_Stage INTEGER,
    id_Encadrant INTEGER,
    PRIMARY KEY (id_Stage, id_Encadrant),
    FOREIGN KEY (id_Stage) REFERENCES Stage(id_Stage),
    FOREIGN KEY (id_Encadrant) REFERENCES Encadrant(id_Encadrant)
);

-- Now add the deferred foreign keys in developper
ALTER TABLE developper
ADD FOREIGN KEY (id_Stage) REFERENCES Stage(id_Stage),
ADD FOREIGN KEY (id_competence) REFERENCES competence(id_competence);



-- =============================================
-- 1. Insert into etudiant (students)
-- =============================================
INSERT INTO etudiant (id_etudiant, nom_etd, prenom_etd, filiere_etd, annee_etd, email_etd, telephone_etd) VALUES
(1, 'Dupont', 'Marie', 'Informatique', 'L3', 'marie.dupont@student.univ.fr', '0612345678'),
(2, 'Martin', 'Lucas', 'Informatique', 'M1', 'lucas.martin@student.univ.fr', '0623456789'),
(3, 'Bernard', 'Sophie', 'Gestion', 'M2', 'sophie.bernard@student.univ.fr', '0634567890'),
(4, 'Lefèvre', 'Antoine', 'Informatique', 'L3', 'antoine.lefevre@student.univ.fr', '0645678901');

-- =============================================
-- 2. Insert into formation (training programs)
-- =============================================
INSERT INTO formation (id_formation, nom_form, type_form, niveau_form, date_debut_form, date_fin_form, certification_disponible_form, institution_form) VALUES
(1, 'Licence Informatique', 'Initiale', 'Bac+3', '2023-09-01', '2026-06-30', TRUE, 'Université de Paris'),
(2, 'Master Informatique - MIAGE', 'Initiale', 'Bac+5', '2024-09-01', '2026-06-30', TRUE, 'Université de Paris'),
(3, 'Master Gestion des Entreprises', 'Initiale', 'Bac+5', '2024-09-01', '2026-06-30', TRUE, 'Université de Paris');

-- =============================================
-- 3. poursuivre (students pursuing formations)
-- =============================================
INSERT INTO poursuivre (id_etudiant, id_formation) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1);

-- =============================================
-- 4. Insert into competence
-- =============================================
INSERT INTO competence (id_competence, libelle_compt, description_compt) VALUES
(1, 'Python', 'Programmation en Python'),
(2, 'Java', 'Programmation orientée objet en Java'),
(3, 'SQL', 'Requêtes et modélisation de bases de données'),
(4, 'JavaScript', 'Développement web front-end'),
(5, 'React', 'Framework JavaScript pour interfaces utilisateur'),
(6, 'Gestion de projet', 'Méthodologies Agile et Scrum'),
(7, 'Angular', 'Framework front-end Google');

-- =============================================
-- 5. acquerir (competencies acquired from formations)
-- =============================================
INSERT INTO acquerir (id_competence, id_formation) VALUES
(1, 1), (2, 1), (3, 1), -- Licence Info
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (7, 2), -- Master MIAGE
(6, 3); -- Master Gestion

-- =============================================
-- 6. Insert into entreprise (companies)
-- =============================================
INSERT INTO entreprise (id_entreprise, nom, secteur_activite, adresse, nom_contact, tel_contact, email_contact) VALUES
(1, 'TechCorp', 'Informatique', '12 rue de la Tech, Paris', 'Jean Dubois', '0145678901', 'jdubois@techcorp.fr'),
(2, 'DataSolutions', 'Big Data', '45 avenue des Données, Lyon', 'Claire Moreau', '0478901234', 'cmoreau@datasolutions.fr'),
(3, 'WebAgency Plus', 'Développement Web', '78 boulevard du Web, Marseille', 'Paul Roux', '0490123456', 'proux@webagency.fr');

-- =============================================
-- 7. Insert into offre_stage (internship offers)
-- =============================================
INSERT INTO offre_stage (id_offre, poste_stg, description_stg, duree_stg, remuneration_stg, date_publication_stg, id_entreprise) VALUES
(1, 'Développeur Backend Python', 'Développement d\'API REST avec Django', '6 mois', '800€/mois', '2025-01-10', 1),
(2, 'Développeur Fullstack Java/Angular', 'Application web bancaire', '6 mois', '1000€/mois', '2025-02-01', 1),
(3, 'Data Analyst', 'Analyse de données avec Python et SQL', '4 mois', '700€/mois', '2025-01-20', 2),
(4, 'Développeur Front-end React', 'Refonte interface e-commerce', '5 mois', '900€/mois', '2025-02-15', 3),
(5, 'Stagiaire Gestion de Projet IT', 'Suivi de projets Agile', '6 mois', '600€/mois', '2025-03-01', 2);

-- =============================================
-- 8. requerir (competencies required by offers)
-- =============================================
INSERT INTO requerir (id_offre, id_competence) VALUES
(1, 1), (1, 3), -- Python + SQL
(2, 2), (2, 7), -- Java + Angular
(3, 1), (3, 3), -- Python + SQL
(4, 4), (4, 5), -- JavaScript + React
(5, 6); -- Gestion de projet

-- =============================================
-- 9. Insert into Candidature
-- =============================================
INSERT INTO Candidature (id_Candidature, date_candit, statut_candit, id_offre, id_etudiant) VALUES
(1, '2025-01-15', 'Acceptée', 1, 1),
(2, '2025-02-05', 'Acceptée', 2, 2),
(3, '2025-01-25', 'Refusée', 3, 1),
(4, '2025-02-20', 'Acceptée', 4, 4),
(5, '2025-03-05', 'En attente', 5, 3),
(6, '2025-02-10', 'Acceptée', 1, 2);

-- =============================================
-- 10. deposer and postuler (junction tables for candidature)
-- =============================================
-- deposer: entreprise dépose l'offre → candidature
INSERT INTO deposer (id_offre, id_Candidature) VALUES
(1,1), (1,6), (2,2), (3,3), (4,4), (5,5);

-- postuler: étudiant postule via candidature
INSERT INTO postuler (id_Candidature, id_etudiant) VALUES
(1,1), (2,2), (3,1), (4,4), (5,3), (6,2);

-- =============================================
-- 11. Insert into Encadrant (supervisors)
-- =============================================
INSERT INTO Encadrant (id_Encadrant, Nom_enc, prenom_enc, departement_enc) VALUES
(1, 'Durand', 'Pierre', 'Développement'),
(2, 'Leroy', 'Isabelle', 'Ressources Humaines'),
(3, 'Simon', 'Marc', 'Data');

-- =============================================
-- 12. Insert into Stage (accepted internships)
-- =============================================
INSERT INTO Stage (id_Stage, date_debut, date_fin, competence_dev, id_etudiant, id_offre) VALUES
(1, '2025-04-01', '2025-09-30', 'Django, API REST', 1, 1),   -- Marie chez TechCorp
(2, '2025-04-01', '2025-09-30', 'Spring Boot, Angular', 2, 2), -- Lucas chez TechCorp
(3, '2025-05-01', '2025-09-30', 'React, Redux', 4, 4);         -- Antoine chez WebAgency

-- =============================================
-- 13. posseder and encadrer
-- =============================================
INSERT INTO posseder (id_Stage, id_etudiant) VALUES
(1,1), (2,2), (3,4);

INSERT INTO encadrer (id_Stage, id_Encadrant) VALUES
(1,1), (2,1), (3,2);

-- =============================================
-- 14. developper (competencies developed during internship)
-- =============================================
INSERT INTO developper (id_Stage, id_competence) VALUES
(1,1), (1,3), -- Marie développe Python et SQL
(2,2), (2,7), -- Lucas développe Java et Angular
(3,4), (3,5); -- Antoine développe JavaScript et React