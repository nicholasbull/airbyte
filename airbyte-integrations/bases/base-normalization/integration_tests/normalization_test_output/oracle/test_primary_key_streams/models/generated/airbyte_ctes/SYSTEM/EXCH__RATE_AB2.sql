{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
select
    cast(ID as {{ dbt_utils.type_bigint() }}) as ID,
    cast(CURRENCY as {{ dbt_utils.type_string() }}) as CURRENCY,
    cast({{ ADAPTER.QUOTE('DATE') }} as {{ dbt_utils.type_string() }}) as {{ ADAPTER.QUOTE('DATE') }},
    cast({{ ADAPTER.QUOTE('HKD@__TERS') }} as {{ dbt_utils.type_float() }}) as {{ ADAPTER.QUOTE('HKD@__TERS') }},
    cast(HKD___TERS as {{ dbt_utils.type_string() }}) as HKD___TERS,
    cast(NZD as {{ dbt_utils.type_float() }}) as NZD,
    cast(USD as {{ dbt_utils.type_float() }}) as USD,
    _airbyte_emitted_at
from {{ ref('EXCH__RATE_AB1') }}
-- EXCH__RATE

