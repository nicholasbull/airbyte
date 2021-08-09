{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
{{ unnest_cte('NEST__TION', 'PARTITION', 'DOUB__DATA') }}
select
    _AIR__SHID,
    {{ json_extract_scalar(unnested_column_value('DOUB__DATA'), ['id']) }} as ID,
    _airbyte_emitted_at
from {{ ref('NEST__TION') }}
{{ cross_join_unnest('PARTITION', 'DOUB__DATA') }}
where DOUB__DATA is not null
-- DOUB__DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/double_array_data

