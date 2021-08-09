{{ config(schema="SYSTEM", tags=["nested"]) }}
-- Final base SQL model
select
    _AIR__SHID,
    DOUB__DATA,
    DATA,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('NEST__TION_AB3') }}
-- PARTITION at nested_stream_with_complex_columns_resulting_into_long_names/partition from {{ ref('NEST__AMES') }}

