{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- Final base SQL model
select
    ID,
    CURRENCY,
    {{ ADAPTER.QUOTE('DATE') }},
    {{ ADAPTER.QUOTE('HKD@__TERS') }},
    HKD___TERS,
    NZD,
    USD,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('DEDU__RATE_SCD') }}
-- DEDU__RATE from {{ source('SYSTEM', '_AIRBYTE_RAW_DEDUP_EXCHANGE_RATE') }}
where _airbyte_active_row = True

