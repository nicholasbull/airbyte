{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- Final base SQL model
select
    ID,
    CURRENCY,
    {{ QUOTE('DATE') }},
    {{ QUOTE('HKD@__TERS') }},
    HKD___TERS,
    NZD,
    USD,
    airbyte_emitted_at,
    HASH_COLUMN_NAME
from {{ ref('EXCH__RATE_AB3') }}
-- EXCH__RATE from {{ source('SYSTEM', 'AIRBYTE_RAW_EXCHANGE_RATE') }}

