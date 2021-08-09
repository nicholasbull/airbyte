{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    *,
    {{ dbt_utils.surrogate_key([
        'ID',
        'CURRENCY',
        ADAPTER.QUOTE('DATE'),
        ADAPTER.QUOTE('HKD@__TERS'),
        'HKD___TERS',
        'NZD',
        'USD',
    ]) }} as _AIR__SHID
from {{ ref('DEDU__RATE_AB2') }}
-- DEDU__RATE

