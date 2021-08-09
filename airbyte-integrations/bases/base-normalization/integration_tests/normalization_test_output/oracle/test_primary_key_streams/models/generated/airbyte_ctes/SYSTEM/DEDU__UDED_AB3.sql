{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    *,
    {{ dbt_utils.surrogate_key([
        'ID',
        'NAME',
        '_AB____LSN',
        '_AB___D_AT',
        '_AB___AT_1',
    ]) }} as _AIR__SHID
from {{ ref('DEDU__UDED_AB2') }}
-- DEDU__UDED

