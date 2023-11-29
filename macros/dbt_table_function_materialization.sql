-- start materialization macro
{% materialization table_function, adapter='bigquery' %}

-- start setting variables
    {%- set target_relation = this %}

    {% set parameters = config.get('parameters', default = '') %}

-- end setting varibales

    {%- set build_sql = create_table_function(target_relation, parameters, model) -%}

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

{% macro create_table_function(target_relation,parameters,model) %}

    CREATE OR REPLACE TABLE FUNCTION {{target_relation}}({{parameters}})
    AS (
        {{model.compiled_sql}}
    );

{% endmacro %}