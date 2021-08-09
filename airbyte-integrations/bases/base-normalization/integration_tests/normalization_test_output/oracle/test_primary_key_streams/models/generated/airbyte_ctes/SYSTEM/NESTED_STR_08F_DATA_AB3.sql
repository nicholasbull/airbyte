{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    *,
    {{ dbt_utils.surrogate_key([
        '_AIR__SHID',
        'CURRENCY',
    ]) }} as _AIR__SHID
from {{ ref('NESTED_STR_08F_DATA_AB2') }}
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA

