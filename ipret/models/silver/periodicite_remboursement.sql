select distinct
    trim(cd_periodicite_remboursement) as cd_periodicite_remboursement,
    regexp_replace(trim(lb_periodicite_remboursement), '\\s+', ' ') as lb_periodicite_remboursement
from {{ source('bronze', 'tb_periodicite_remboursement') }}