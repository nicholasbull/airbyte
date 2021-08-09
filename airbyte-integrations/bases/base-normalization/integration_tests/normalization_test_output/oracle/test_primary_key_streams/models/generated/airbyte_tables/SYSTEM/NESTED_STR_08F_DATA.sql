{{ config(schema="SYSTEM", tags=["nested"]) }}
-- Final base SQL model
select
    _AIR__SHID,
    CURRENCY,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('NESTED_STR_08F_DATA_AB3') }}
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA from {{ ref('NEST__TION') }}

