{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    *,
    {{ dbt_utils.surrogate_key([
        'ID',
        ADAPTER.QUOTE('DATE'),
    ]) }} as _AIR__SHID
from {{ ref('NON___AMES_AB2') }}
-- NON___AMES

