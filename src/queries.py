# queries.py
# Toutes les requêtes SQL centralisées ici

QUERIES = {
    # === Sections classiques ===
    "etudiants": """
        SELECT 
            e.id_etudiant,
            CONCAT(e.prenom_etd, ' ', e.nom_etd) AS nom_complet,
            e.filiere_etd,
            e.email_etd,
            e.telephone_etd,
            f.nom_form AS formation
        FROM etudiant e
        LEFT JOIN formation f ON e.id_formation = f.id_formation
        ORDER BY e.nom_etd, e.prenom_etd
    """,

    "formations": """
        SELECT * FROM formation ORDER BY niveau_form, nom_form
    """,

    "competences": """
        SELECT 
            c.id_competence,
            c.libelle_compt,
            c.description_compt,
            COUNT(epc.id_etudiant) AS nb_etudiants_possedant
        FROM competence c
        LEFT JOIN etudiant_possede_competence epc ON c.id_competence = epc.id_competence
        GROUP BY c.id_competence
        ORDER BY nb_etudiants_possedant DESC
    """,

    "entreprises": """
        SELECT 
            e.*,
            COUNT(o.id_offre) AS nombre_offres
        FROM entreprise e
        LEFT JOIN offre_stage o ON e.id_entreprise = o.id_entreprise
        GROUP BY e.id_entreprise
        ORDER BY nombre_offres DESC
    """,

    "offres_stage": """
        SELECT 
            o.id_offre,
            o.poste_stg,
            o.description_stg,
            o.duree_stg,
            o.remuneration_stg,
            o.date_publication_stg,
            e.nom AS entreprise,
            GROUP_CONCAT(c.libelle_compt SEPARATOR ', ') AS competences_requises
        FROM offre_stage o
        JOIN entreprise e ON o.id_entreprise = e.id_entreprise
        LEFT JOIN offre_require_competence orc ON o.id_offre = orc.id_offre
        LEFT JOIN competence c ON orc.id_competence = c.id_competence
        GROUP BY o.id_offre
        ORDER BY o.date_publication_stg DESC
    """,

    "candidatures": """
        SELECT 
            c.id_candidature,
            c.date_candit,
            c.statut_candit,
            c.commentaire_statut,
            CONCAT(e.prenom_etd, ' ', e.nom_etd) AS etudiant,
            o.poste_stg AS poste,
            ent.nom AS entreprise
        FROM candidature c
        JOIN etudiant e ON c.id_etudiant = e.id_etudiant
        JOIN offre_stage o ON c.id_offre = o.id_offre
        JOIN entreprise ent ON o.id_entreprise = ent.id_entreprise
        ORDER BY c.date_candit DESC
    """,

    "stages_acceptes": """
        SELECT 
            s.id_stage,
            s.date_debut,
            s.date_fin,
            CONCAT(e.prenom_etd, ' ', e.nom_etd) AS etudiant,
            o.poste_stg AS poste,
            ent.nom AS entreprise,
            CONCAT(enc.prenom_enc, ' ', enc.nom_enc) AS encadrant,
            GROUP_CONCAT(c.libelle_compt SEPARATOR ', ') AS competences_developpees
        FROM stage s
        JOIN etudiant e ON s.id_etudiant = e.id_etudiant
        JOIN offre_stage o ON s.id_offre = o.id_offre
        JOIN entreprise ent ON o.id_entreprise = ent.id_entreprise
        LEFT JOIN encadrant enc ON s.id_encadrant = enc.id_encadrant
        LEFT JOIN stage_competence sc ON s.id_stage = sc.id_stage
        LEFT JOIN competence c ON sc.id_competence = c.id_competence
        GROUP BY s.id_stage
        ORDER BY s.date_debut DESC
    """,

    "encadrants": """
        SELECT 
            enc.*,
            COUNT(s.id_stage) AS nombre_stages_encadres
        FROM encadrant enc
        LEFT JOIN stage s ON enc.id_encadrant = s.id_encadrant
        GROUP BY enc.id_encadrant
        ORDER BY nombre_stages_encadres DESC
    """,

    "evaluations": """
        SELECT 
            eval.id_evaluation,
            CONCAT(et.prenom_etd, ' ', et.nom_etd) AS etudiant,
            c.libelle_compt AS competence,
            eval.score_obtenu,
            eval.score_max,
            ROUND((eval.score_obtenu / eval.score_max) * 100, 1) AS pourcentage,
            eval.date_eval
        FROM evaluation eval
        JOIN etudiant et ON eval.id_etudiant = et.id_etudiant
        JOIN competence c ON eval.id_competence = c.id_competence
        ORDER BY eval.date_eval DESC
    """,

    # === Analyses Tableau de Bord ===
    "top_etudiants": """
        SELECT
          CONCAT(e.prenom_etd, ' ', e.nom_etd) AS etudiant,
          e.filiere_etd,
          ROUND(AVG(epc.proficiency), 2) AS avg_proficiency
        FROM etudiant e
        JOIN etudiant_possede_competence epc ON e.id_etudiant = epc.id_etudiant
        GROUP BY e.id_etudiant
        ORDER BY avg_proficiency DESC
        LIMIT 50
    """,

    "etudiants_difficulte": """
        SELECT 
          CONCAT(e.prenom_etd, ' ', e.nom_etd) AS etudiant,
          ROUND(AVG(epc.proficiency), 2) AS avg_proficiency
        FROM etudiant e
        JOIN etudiant_possede_competence epc ON e.id_etudiant = epc.id_etudiant
        GROUP BY e.id_etudiant
        HAVING avg_proficiency < 2.5
        ORDER BY avg_proficiency ASC
    """,

    "analyse_cohorte": """
        SELECT
          YEAR(f.date_debut_form) AS annee_entree,
          COUNT(DISTINCT e.id_etudiant) AS nb_etudiants,
          ROUND(AVG(epc.proficiency), 2) AS moyenne_competences
        FROM etudiant e
        JOIN formation f ON e.id_formation = f.id_formation
        JOIN etudiant_possede_competence epc ON e.id_etudiant = epc.id_etudiant
        GROUP BY YEAR(f.date_debut_form)
        ORDER BY annee_entree
    """,

    "taux_conversion": """
        SELECT 
          o.poste_stg,
          ent.nom AS entreprise,
          COUNT(c.id_candidature) AS total_candidatures,
          SUM(CASE WHEN c.statut_candit = 'accepte' THEN 1 ELSE 0 END) AS nb_acceptes,
          ROUND(SUM(CASE WHEN c.statut_candit = 'accepte' THEN 1 ELSE 0 END) / NULLIF(COUNT(c.id_candidature),0), 3) AS taux
        FROM offre_stage o
        LEFT JOIN candidature c ON o.id_offre = c.id_offre
        LEFT JOIN entreprise ent ON o.id_entreprise = ent.id_entreprise
        GROUP BY o.id_offre
        HAVING total_candidatures > 0
        ORDER BY taux DESC
    """,

    "offres_sans_candidature": """
        SELECT o.poste_stg, ent.nom AS entreprise, o.date_publication_stg
        FROM offre_stage o
        LEFT JOIN candidature c ON o.id_offre = c.id_offre
        JOIN entreprise ent ON o.id_entreprise = ent.id_entreprise
        GROUP BY o.id_offre
        HAVING COUNT(c.id_candidature) = 0
    """,

    "offres_anciennes": """
        SELECT poste_stg, date_publication_stg, DATEDIFF(CURDATE(), date_publication_stg) AS jours
        FROM offre_stage
        WHERE date_publication_stg < DATE_SUB(CURDATE(), INTERVAL 90 DAY)
    """,

    "gap_competences": """
        SELECT 
          c.libelle_compt,
          COUNT(DISTINCT orc.id_offre) AS demande,
          COUNT(DISTINCT epc.id_etudiant) AS possedees,
          COUNT(DISTINCT orc.id_offre) - COUNT(DISTINCT epc.id_etudiant) AS ecart
        FROM competence c
        LEFT JOIN offre_require_competence orc ON c.id_competence = orc.id_competence
        LEFT JOIN etudiant_possede_competence epc ON c.id_competence = epc.id_competence
        GROUP BY c.id_competence
        ORDER BY ecart DESC
    """,

    "outliers_competences": """
        WITH stats AS (
          SELECT id_competence, AVG(proficiency) AS mu, STDDEV_POP(proficiency) AS sigma
          FROM etudiant_possede_competence
          GROUP BY id_competence
        )
        SELECT
          CONCAT(e.prenom_etd, ' ', e.nom_etd) AS etudiant,
          c.libelle_compt,
          epc.proficiency,
          ROUND((epc.proficiency - s.mu)/s.sigma, 2) AS z_score
        FROM etudiant_possede_competence epc
        JOIN stats s ON epc.id_competence = s.id_competence
        JOIN competence c ON epc.id_competence = c.id_competence
        JOIN etudiant e ON epc.id_etudiant = e.id_etudiant
        WHERE s.sigma > 0 AND (epc.proficiency - s.mu)/s.sigma < -2
        ORDER BY z_score
    """
}