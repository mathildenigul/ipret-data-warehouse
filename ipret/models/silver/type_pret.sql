select distinct
    trim(cd_type_pret) as cd_type_pret,
    regexp_replace(trim(lb_type_pret), '\\s+', ' ') as lb_type_pret
from {{ source('bronze', 'tb_type_pret') }}