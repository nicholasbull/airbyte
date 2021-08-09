{{ config(schema="SYSTEM", tags=["nested"]) }}
-- Final base SQL model
select
    _AIR__SHID,
    ID,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('NESTED_STR_47B_DOUB__DATA_AB3') }}
-- DOUB__DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/double_array_data from {{ ref('NEST__TION') }}

