select distinct --removes the duplicates after cleaning
    trim(cd_statut_pret) as cd_statut_pret, --removes the leading and trailing spaces
    regexp_replace(trim(lb_statut_pret), '\\s+', ' ') as lb_statut_pret --collapses repeated inner spaces
from {{ source('bronze', 'tb_statut_pret') }}