{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract_scalar('_airbyte_data', ['id']) }} as ID,
    {{ json_extract_scalar('_airbyte_data', ['date']) }} as {{ ADAPTER.QUOTE('DATE') }},
    _airbyte_emitted_at
from {{ source('SYSTEM', '_AIRBYTE_RAW_SIMPLE_STREAM_WITH_NAMESPACE_RESULTING_INTO_LONG_NAMES') }}
-- SIMP__AMES

