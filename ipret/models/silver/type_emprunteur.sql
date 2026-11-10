select distinct
    trim(cd_type_emprunteur) as cd_type_emprunteur,
    regexp_replace(trim(lb_type_emprunteur), '\\s+', ' ') as lb_type_emprunteur
from {{ source('bronze', 'tb_type_emprunteur') }}