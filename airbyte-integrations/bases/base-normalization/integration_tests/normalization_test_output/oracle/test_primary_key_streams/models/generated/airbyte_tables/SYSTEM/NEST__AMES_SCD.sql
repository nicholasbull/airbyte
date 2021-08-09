{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- SQL model to build a Type 2 Slowly Changing Dimension (SCD) table for each record identified by their primary key
select
    ID,
    {{ ADAPTER.QUOTE('DATE') }},
    PARTITION,
    {{ ADAPTER.QUOTE('DATE') }} as _airbyte_start_at,
    lag({{ ADAPTER.QUOTE('DATE') }}) over (
        partition by ID
        order by {{ ADAPTER.QUOTE('DATE') }} is null asc, {{ ADAPTER.QUOTE('DATE') }} desc, _airbyte_emitted_at desc
    ) as _airbyte_end_at,
    lag({{ ADAPTER.QUOTE('DATE') }}) over (
        partition by ID
        order by {{ ADAPTER.QUOTE('DATE') }} is null asc, {{ ADAPTER.QUOTE('DATE') }} desc, _airbyte_emitted_at desc
    ) is null as _airbyte_active_row,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('NEST__AMES_AB4') }}
-- NEST__AMES from {{ source('SYSTEM', '_AIRBYTE_RAW_NESTED_STREAM_WITH_COMPLEX_COLUMNS_RESULTING_INTO_LONG_NAMES') }}
where _airbyte_row_num = 1

