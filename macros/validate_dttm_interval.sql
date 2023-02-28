{% macro  validate_dttm_interval(dttm, from_dttm, to_dttm) %}
    {{dttm}} >= {{from_dttm}} and {{dttm}} < coalesce({{to_dttm}}, {{ upper_infinity_datetime() }})
{% endmacro %}