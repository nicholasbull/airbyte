{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- SQL model to build a Type 2 Slowly Changing Dimension (SCD) table for each record identified by their primary key
select
    ID,
    CURRENCY,
    {{ ADAPTER.QUOTE('DATE') }},
    {{ ADAPTER.QUOTE('HKD@__TERS') }},
    HKD___TERS,
    NZD,
    USD,
    {{ ADAPTER.QUOTE('DATE') }} as _airbyte_start_at,
    lag({{ ADAPTER.QUOTE('DATE') }}) over (
        partition by ID, CURRENCY, cast(NZD as {{ dbt_utils.type_string() }})
        order by {{ ADAPTER.QUOTE('DATE') }} is null asc, {{ ADAPTER.QUOTE('DATE') }} desc, _airbyte_emitted_at desc
    ) as _airbyte_end_at,
    lag({{ ADAPTER.QUOTE('DATE') }}) over (
        partition by ID, CURRENCY, cast(NZD as {{ dbt_utils.type_string() }})
        order by {{ ADAPTER.QUOTE('DATE') }} is null asc, {{ ADAPTER.QUOTE('DATE') }} desc, _airbyte_emitted_at desc
    ) is null as _airbyte_active_row,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('DEDU__RATE_AB4') }}
-- DEDU__RATE from {{ source('SYSTEM', '_AIRBYTE_RAW_DEDUP_EXCHANGE_RATE') }}
where _airbyte_row_num = 1

