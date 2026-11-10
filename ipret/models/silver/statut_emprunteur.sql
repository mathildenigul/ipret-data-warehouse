select distinct
    trim(cd_statut_emprunteur) as cd_statut_emprunteur,
    regexp_replace(trim(lb_statut_emprunteur), '\\s+', ' ') as lb_statut_emprunteur
from {{ source('bronze', 'tb_statut_emprunteur') }}