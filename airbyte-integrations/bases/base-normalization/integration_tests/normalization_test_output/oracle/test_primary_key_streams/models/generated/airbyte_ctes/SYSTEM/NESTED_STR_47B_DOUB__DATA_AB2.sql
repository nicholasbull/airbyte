{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
select
    _AIR__SHID,
    cast(ID as {{ dbt_utils.type_string() }}) as ID,
    _airbyte_emitted_at
from {{ ref('NESTED_STR_47B_DOUB__DATA_AB1') }}
-- DOUB__DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/double_array_data

