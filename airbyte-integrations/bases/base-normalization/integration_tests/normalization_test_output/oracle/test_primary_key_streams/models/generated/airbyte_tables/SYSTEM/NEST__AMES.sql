{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- Final base SQL model
select
    ID,
    {{ ADAPTER.QUOTE('DATE') }},
    PARTITION,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('NEST__AMES_SCD') }}
-- NEST__AMES from {{ source('SYSTEM', '_AIRBYTE_RAW_NESTED_STREAM_WITH_COMPLEX_COLUMNS_RESULTING_INTO_LONG_NAMES') }}
where _airbyte_active_row = True

