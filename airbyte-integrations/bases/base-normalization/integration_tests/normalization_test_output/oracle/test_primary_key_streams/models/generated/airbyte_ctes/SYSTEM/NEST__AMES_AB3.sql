{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    *,
    {{ dbt_utils.surrogate_key([
        'ID',
        ADAPTER.QUOTE('DATE'),
        'PARTITION',
    ]) }} as _AIR__SHID
from {{ ref('NEST__AMES_AB2') }}
-- NEST__AMES

