{{ config(schema="SYSTEM", tags=["top-level-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    ORA_HASH(ID) AS "HASH_COLUMN_NAME",
    a.*
from {{ ref('EXCH__RATE_AB2') }} a
-- EXCH__RATE

