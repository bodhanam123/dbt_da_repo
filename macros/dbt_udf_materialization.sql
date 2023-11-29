-- start materialization macro
{% materialization user_defined_function, adapter='bigquery' %}

-- start setting variables
    {%- set target_relation = this %}

    {% set parameters = config.get('parameters', default = '') %}

    {% set return_datatype = config.get('return_datatype', default=None) %}

    {% if return_datatype is none %}
        {% do exceptions.raise_compiler_error("Mention the return_datatype for the user defined function.") %}
    {% endif %}

-- end setting varibales

    {%- set build_sql = create_udf(target_relation, parameters, model, return_datatype) -%}

-- start running build_sql 

    {%- call statement('main') -%}
        {{ build_sql }}
    {% endcall %}
        
--end running build_sql

    {% set target_relation = this.incorporate(type='table') %}
    {% do persist_docs(target_relation, model) %}
    {{ return({'relations': [target_relation]}) }}

{% endmaterialization %}

-- end materialization macro

-- macro for stored procedure creation

{% macro create_udf(target_relation, parameters, model, return_datatype) %}

    CREATE OR REPLACE FUNCTION {{target_relation}}({{parameters}})
    RETURNS {{return_datatype}}
    AS (
        (
            {{model.compiled_sql}}
        )
    );

{% endmacro %}