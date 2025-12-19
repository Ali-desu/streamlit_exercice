# main.py
import streamlit as st
import mysql.connector
from mysql.connector import Error
import pandas as pd
import os
from dotenv import load_dotenv
from queries import QUERIES  # Import des requêtes

load_dotenv()

# =============================================
# Configuration
# =============================================
st.set_page_config(page_title="ISCAE - Gestion des Stages", layout="wide")
st.title("📚 Système de Gestion des Stages - ISCAE")

# =============================================
# Connexion DB
# =============================================
@st.cache_resource
def get_connection():
    try:
        return mysql.connector.connect(
            host=os.getenv("AVN_HOST", "127.0.0.1"),
            port=int(os.getenv("AVN_PORT", 3306)),
            user=os.getenv("AVN_USER", "root"),
            password=os.getenv("AVN_PASS", ""),
            database=os.getenv("AVN_DB", "iscaeproject")
        )
    except Error as e:
        st.error(f"Erreur de connexion : {e}")
        return None

connection = get_connection()
if connection is None:
    st.stop()

def fetch(query_key):
    """Récupère une requête par clé et retourne un DataFrame"""
    query = QUERIES.get(query_key)
    if not query:
        st.error(f"Requête '{query_key}' non trouvée dans queries.py")
        return pd.DataFrame()
    try:
        cursor = connection.cursor(dictionary=True)
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        return pd.DataFrame(results)
    except Error as e:
        st.error(f"Erreur SQL ({query_key}) : {e}")
        return pd.DataFrame()

# =============================================
# Navigation
# =============================================
st.sidebar.header("Navigation")
sections = [
    "Accueil", "Étudiants", "Formations", "Compétences", "Entreprises",
    "Offres de Stage", "Candidatures", "Stages Acceptés", "Encadrants",
    "Évaluations", "📊 Tableau de Bord & Statistiques"
]
choice = st.sidebar.radio("Aller à", sections)

# =============================================
# Sections
# =============================================
if choice == "Accueil":
    st.header("🏫 Bienvenue dans le Système de Gestion des Stages - ISCAE")

    st.markdown("""
    **Une plateforme complète pour gérer et analyser les stages :**
    - Suivi des étudiants, formations et compétences
    - Publication et gestion des offres d'entreprises
    - Candidatures, matching intelligent et statistiques avancées
    - Tableau de bord analytique pour optimiser l'insertion professionnelle
    """)

    st.markdown("### 📊 Aperçu Global")
    col1, col2, col3, col4 = st.columns(4)
    with col1: st.metric("Étudiants", len(fetch("etudiants")))
    with col2: st.metric("Offres", len(fetch("offres_stage")))
    with col3: st.metric("Candidatures", len(fetch("candidatures")))
    with col4: st.metric("Stages", len(fetch("stages_acceptes")))

elif choice == "Étudiants":
    st.header("👥 Étudiants")
    st.dataframe(fetch("etudiants"), use_container_width=True)

elif choice == "Formations":
    st.header("🎓 Formations")
    st.dataframe(fetch("formations"), use_container_width=True)

elif choice == "Compétences":
    st.header("🛠 Compétences")
    st.dataframe(fetch("competences"), use_container_width=True)

elif choice == "Entreprises":
    st.header("🏢 Entreprises")
    st.dataframe(fetch("entreprises"), use_container_width=True)

elif choice == "Offres de Stage":
    st.header("💼 Offres de Stage")
    st.dataframe(fetch("offres_stage"), use_container_width=True)

elif choice == "Candidatures":
    st.header("📄 Candidatures")
    df = fetch("candidatures")
    if not df.empty:
        def color_status(val):
            colors = {'accepte': '#d4edda', 'refuse': '#f8d7da'}
            return f'background-color: {colors.get(val, "#fff3cd")}'
        st.dataframe(df.style.applymap(color_status, subset=['statut_candit']), use_container_width=True)
    else:
        st.info("Aucune candidature.")

elif choice == "Stages Acceptés":
    st.header("✅ Stages Acceptés")
    st.dataframe(fetch("stages_acceptes"), use_container_width=True)

elif choice == "Encadrants":
    st.header("👔 Encadrants")
    st.dataframe(fetch("encadrants"), use_container_width=True)

elif choice == "Évaluations":
    st.header("📊 Évaluations")
    st.dataframe(fetch("evaluations"), use_container_width=True)

# =============================================
# Tableau de Bord
# =============================================
elif choice == "📊 Tableau de Bord & Statistiques":
    st.header("📊 Tableau de Bord Analytique")

    tab1, tab2, tab3 = st.tabs(["Étudiants", "Offres", "Marché"])

    with tab1:
        st.subheader("Performance Étudiants")
        if st.button("🥇 Top 50 par maîtrise moyenne"):
            st.dataframe(fetch("top_etudiants"), use_container_width=True)
        if st.button("📉 En difficulté (< 2.5)"):
            df = fetch("etudiants_difficulte")
            if not df.empty:
                st.dataframe(df.style.highlight_min(subset=['avg_proficiency'], color='lightcoral'), use_container_width=True)
            else:
                st.success("Tous les étudiants ≥ 2.5 !")
        if st.button("👥 Analyse par cohorte"):
            df = fetch("analyse_cohorte")
            if not df.empty:
                st.dataframe(df, use_container_width=True)
                st.line_chart(df.set_index('annee_entree')['moyenne_competences'])

    with tab2:
        st.subheader("Performance Offres")
        if st.button("📈 Taux de conversion"):
            st.dataframe(fetch("taux_conversion"), use_container_width=True)
        if st.button("⚠️ Sans candidature"):
            df = fetch("offres_sans_candidature")
            st.dataframe(df if not df.empty else pd.DataFrame(), use_container_width=True)
        if st.button("🗓️ Anciennes (>90j)"):
            df = fetch("offres_anciennes")
            st.dataframe(df if not df.empty else pd.DataFrame(), use_container_width=True)

    with tab3:
        st.subheader("Marché des Compétences")
        if st.button("🔥 Gap demande/offre"):
            st.dataframe(fetch("gap_competences"), use_container_width=True)
        if st.button("🔍 Outliers (très faibles)"):
            df = fetch("outliers_competences")
            if not df.empty:
                st.dataframe(df.style.background_gradient(cmap='Reds', subset=['z_score']), use_container_width=True)
            else:
                st.success("Aucun outlier critique détecté.")

# =============================================
# Footer
# =============================================
st.sidebar.markdown("---")
st.sidebar.success("✅ Connecté à  la base de données.")
st.sidebar.caption("ISCAE • Gestion des Stages • 2025")