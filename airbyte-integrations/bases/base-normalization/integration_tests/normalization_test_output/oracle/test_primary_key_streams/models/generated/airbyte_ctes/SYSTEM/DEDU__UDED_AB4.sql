{{ config(schema="_AIRBYTE_SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to prepare for deduplicating records based on the hash record column
select
  *,
  row_number() over (
    partition by _AIR__SHID
    order by _airbyte_emitted_at asc
  ) as _airbyte_row_num
from {{ ref('DEDU__UDED_AB3') }}
-- DEDU__UDED from {{ source('SYSTEM', '_AIRBYTE_RAW_DEDUP_CDC_EXCLUDED') }}

