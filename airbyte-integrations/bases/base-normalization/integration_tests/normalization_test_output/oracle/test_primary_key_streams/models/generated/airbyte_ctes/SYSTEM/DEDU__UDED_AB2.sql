{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
select
    cast(ID as {{ dbt_utils.type_bigint() }}) as ID,
    cast(NAME as {{ dbt_utils.type_string() }}) as NAME,
    cast(_AB____LSN as {{ dbt_utils.type_float() }}) as _AB____LSN,
    cast(_AB___D_AT as {{ dbt_utils.type_float() }}) as _AB___D_AT,
    cast(_AB___AT_1 as {{ dbt_utils.type_float() }}) as _AB___AT_1,
    _airbyte_emitted_at
from {{ ref('DEDU__UDED_AB1') }}
-- DEDU__UDED

