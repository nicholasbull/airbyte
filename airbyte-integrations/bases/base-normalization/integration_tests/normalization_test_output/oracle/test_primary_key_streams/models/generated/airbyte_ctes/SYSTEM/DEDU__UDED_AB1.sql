{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract_scalar('_airbyte_data', ['id']) }} as ID,
    {{ json_extract_scalar('_airbyte_data', ['name']) }} as NAME,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_lsn']) }} as _AB____LSN,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_updated_at']) }} as _AB___D_AT,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_deleted_at']) }} as _AB___AT_1,
    _airbyte_emitted_at
from {{ source('SYSTEM', '_AIRBYTE_RAW_DEDUP_CDC_EXCLUDED') }}
-- DEDU__UDED

