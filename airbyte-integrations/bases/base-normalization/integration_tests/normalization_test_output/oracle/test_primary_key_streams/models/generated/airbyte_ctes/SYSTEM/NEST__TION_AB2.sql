{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
select
    _AIR__SHID,
    DOUB__DATA,
    DATA,
    _airbyte_emitted_at
from {{ ref('NEST__TION_AB1') }}
-- PARTITION at nested_stream_with_complex_columns_resulting_into_long_names/partition

