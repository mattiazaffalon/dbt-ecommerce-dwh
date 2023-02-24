{% macro  validate_dttm_interval(dttm, from_dttm, to_dttm) %}
    {{dttm}} >= {{from_dttm}} and {{dttm}} < coalesce({{to_dttm}}, DATETIME('9999-12-31 23:59:59.999999'))
{% endmacro %}