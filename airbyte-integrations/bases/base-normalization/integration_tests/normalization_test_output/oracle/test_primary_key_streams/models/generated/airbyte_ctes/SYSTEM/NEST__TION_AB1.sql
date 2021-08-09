{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    _AIR__SHID,
    {{ json_extract_array('PARTITION', ['double_array_data']) }} as DOUB__DATA,
    {{ json_extract_array('PARTITION', ['DATA']) }} as DATA,
    _airbyte_emitted_at
from {{ ref('NEST__AMES') }}
where PARTITION is not null
-- PARTITION at nested_stream_with_complex_columns_resulting_into_long_names/partition

