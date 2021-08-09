{{ config(schema="SYSTEM", tags=["top-level"]) }}
-- SQL model to build a Type 2 Slowly Changing Dimension (SCD) table for each record identified by their primary key
select
    ID,
    NAME,
    _AB____LSN,
    _AB___D_AT,
    _AB___AT_1,
    _airbyte_emitted_at as _airbyte_start_at,
    lag(_airbyte_emitted_at) over (
        partition by ID
        order by _airbyte_emitted_at is null asc, _airbyte_emitted_at desc, _airbyte_emitted_at desc
    ) as _airbyte_end_at,
    lag(_airbyte_emitted_at) over (
        partition by ID
        order by _airbyte_emitted_at is null asc, _airbyte_emitted_at desc, _airbyte_emitted_at desc, _ab_cdc_updated_at desc
    ) is null and _ab_cdc_deleted_at is null as _airbyte_active_row,
    _airbyte_emitted_at,
    _AIR__SHID
from {{ ref('DEDU__UDED_AB4') }}
-- DEDU__UDED from {{ source('SYSTEM', '_AIRBYTE_RAW_DEDUP_CDC_EXCLUDED') }}
where _airbyte_row_num = 1

