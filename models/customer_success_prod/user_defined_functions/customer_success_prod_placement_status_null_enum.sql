{{
  config(
        alias = "placement_status_null_enum",
        return_datatype = "STRING"
    )
}}

{%- set sqlquery %}
"To Be Placed"
{%- endset %}
{{sqlquery}}

---------------------------------------------
{# {{
  config(
        alias = "python_idp_normalized_score",
        parameters = "best_score_for_before_level_1 FLOAT64, best_score_for_level_1 FLOAT64",
        return_datatype = "FLOAT64"
    )
}}

{%- set sqlquery %}
CASE
    WHEN best_score_for_before_level_1 > (
        CASE
            WHEN best_score_for_level_1 > 50
            THEN ((((best_score_for_level_1 - 75)*50)/25)+50)
            ELSE 0
        END 
        )
    THEN best_score_for_before_level_1
    ELSE
        (
        CASE
            WHEN best_score_for_level_1 > 50
            THEN ((((best_score_for_level_1 - 75)*50)/25)+50)
            ELSE 0
        END 
        )
END
{%- endset %}
{{sqlquery}} #}