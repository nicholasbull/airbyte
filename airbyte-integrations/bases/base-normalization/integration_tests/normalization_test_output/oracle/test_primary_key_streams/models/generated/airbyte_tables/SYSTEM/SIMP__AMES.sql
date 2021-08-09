{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- Final base SQL model
select
    ID,
    {{ ADAPTER.QUOTE('DATE') }},
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('SIMP__AMES_AB3') }}
-- SIMP__AMES from {{ source('SYSTEM', '_AIRBYTE_RAW_SIMPLE_STREAM_WITH_NAMESPACE_RESULTING_INTO_LONG_NAMES') }}

