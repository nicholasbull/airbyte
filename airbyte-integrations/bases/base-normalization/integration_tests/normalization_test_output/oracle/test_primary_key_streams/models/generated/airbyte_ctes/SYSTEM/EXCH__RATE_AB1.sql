{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract_scalar('_airbyte_data', ['id']) }} as ID,
    {{ json_extract_scalar('_airbyte_data', ['currency']) }} as CURRENCY,
    {{ json_extract_scalar('_airbyte_data', ['date']) }} as {{ ADAPTER.QUOTE('DATE') }},
    {{ json_extract_scalar('_airbyte_data', ['HKD@spéçiäl & characters']) }} as {{ ADAPTER.QUOTE('HKD@__TERS') }},
    {{ json_extract_scalar('_airbyte_data', ['HKD_special___characters']) }} as HKD___TERS,
    {{ json_extract_scalar('_airbyte_data', ['NZD']) }} as NZD,
    {{ json_extract_scalar('_airbyte_data', ['USD']) }} as USD,
    _airbyte_emitted_at
from {{ source('SYSTEM', '_AIRBYTE_RAW_EXCHANGE_RATE') }}
-- EXCH__RATE

