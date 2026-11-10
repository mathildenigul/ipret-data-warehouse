select *
from {{ ref('emprunteur_prepared') }}
where reject_reason is not null