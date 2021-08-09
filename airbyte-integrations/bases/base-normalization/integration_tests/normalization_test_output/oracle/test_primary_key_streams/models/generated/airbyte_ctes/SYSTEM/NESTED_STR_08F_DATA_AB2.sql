{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
select
    _AIR__SHID,
    cast(CURRENCY as {{ dbt_utils.type_string() }}) as CURRENCY,
    _airbyte_emitted_at
from {{ ref('NESTED_STR_08F_DATA_AB1') }}
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA

