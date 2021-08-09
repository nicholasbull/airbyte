{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
{{ unnest_cte('NEST__TION', 'PARTITION', 'DATA') }}
select
    _AIR__SHID,
    {{ json_extract_scalar(unnested_column_value('DATA'), ['currency']) }} as CURRENCY,
    _airbyte_emitted_at
from {{ ref('NEST__TION') }}
{{ cross_join_unnest('PARTITION', 'DATA') }}
where DATA is not null
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA

