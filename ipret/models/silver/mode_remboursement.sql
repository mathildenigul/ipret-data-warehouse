select distinct
    trim(cd_mode_remboursement) as cd_mode_remboursement,
    regexp_replace(trim(lb_mode_remboursement), '\\s+', ' ') as lb_mode_remboursement
from {{ source('bronze', 'tb_mode_remboursement') }}