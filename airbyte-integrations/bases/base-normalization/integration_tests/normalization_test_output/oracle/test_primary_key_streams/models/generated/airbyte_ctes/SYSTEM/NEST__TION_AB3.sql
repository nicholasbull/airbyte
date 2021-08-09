{{ config(schema="_AIRBYTE_SYSTEM", tags=["nested-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    *,
    {{ dbt_utils.surrogate_key([
        '_AIR__SHID',
        array_to_string('DOUB__DATA'),
        array_to_string('DATA'),
    ]) }} as _AIR__SHID
from {{ ref('NEST__TION_AB2') }}
-- PARTITION at nested_stream_with_complex_columns_resulting_into_long_names/partition

