{{ config(materialized='ephemeral') }}

with cleaned as (

    select
        try_to_number(trim(id_emprunteur))                           as id_emprunteur,
        nullif(trim(lb_civilite_emprunteur), '')                     as lb_civilite_emprunteur,
        nullif(trim(lb_nom_emprunteur), '')                          as lb_nom_emprunteur,
        nullif(trim(lb_prenom_emprunteur), '')                       as lb_prenom_emprunteur,
        try_to_date(trim(dt_naissance_emprunteur), 'DD/MM/YYYY')     as dt_naissance_emprunteur,
        nullif(nullif(trim(lb_email_emprunteur), ''), '-')           as lb_email_emprunteur,
        nullif(nullif(trim(cd_postal_emprunteur), ''), '-')          as cd_postal_emprunteur,
        trim(cd_type_emprunteur)                                     as cd_type_emprunteur,
        trim(cd_statut_emprunteur)                                   as cd_statut_emprunteur
    from {{ source('bronze', 'tb_emprunteur') }}

),

numbered as (

    select
        *,
        row_number() over (
            partition by id_emprunteur
            order by id_emprunteur
        ) as rn
    from cleaned

)

select
    id_emprunteur,
    lb_civilite_emprunteur,
    lb_nom_emprunteur,
    lb_prenom_emprunteur,
    dt_naissance_emprunteur,
    lb_email_emprunteur,
    cd_postal_emprunteur,
    cd_type_emprunteur,
    cd_statut_emprunteur,
    case
        when id_emprunteur is null
            then 'ID invalide'
        when rn > 1
            then 'Doublon sur ID'
        when dt_naissance_emprunteur is null
            then 'Date de naissance illisible'
        when dt_naissance_emprunteur > current_date()
          or dt_naissance_emprunteur < '1900-01-01'::date
            then 'Date de naissance incohérente'
    end as reject_reason
from numbered