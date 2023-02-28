SELECT
  c.*
FROM
  {{ ref('dim_customers') }} c INNER JOIN {{ ref('dim_customers') }} c1 ON (c.customer_cd = c1.customer_cd)
WHERE
  c.customer_id <> c1.customer_id
  AND ((c.valid_from >= c1.valid_from
      AND COALESCE(c.valid_to, {{ upper_infinity_datetime() }}) <= COALESCE(c1.valid_to, {{ upper_infinity_datetime() }}))
    OR (c1.valid_from >= c.valid_from
      AND COALESCE(c1.valid_to, {{ upper_infinity_datetime() }}) <= COALESCE(c.valid_to, {{ upper_infinity_datetime() }})))