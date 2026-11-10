select
    id_emprunteur,
    lb_civilite_emprunteur,
    lb_nom_emprunteur,
    lb_prenom_emprunteur,
    dt_naissance_emprunteur,
    lb_email_emprunteur,
    cd_postal_emprunteur,
    cd_type_emprunteur,
    cd_statut_emprunteur
from {{ ref('emprunteur_prepared') }}
where reject_reason is null