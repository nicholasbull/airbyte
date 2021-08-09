{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- Final base SQL model
select
    ID,
    {{ ADAPTER.QUOTE('DATE') }},
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('NON___AMES_AB3') }}
-- NON___AMES from {{ source('SYSTEM', '_AIRBYTE_RAW_NON_NESTED_STREAM_WITHOUT_NAMESPACE_RESULTING_INTO_LONG_NAMES') }}

