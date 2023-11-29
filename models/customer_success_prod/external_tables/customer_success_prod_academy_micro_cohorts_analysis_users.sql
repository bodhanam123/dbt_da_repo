{{
    config(
        alias="academy_micro_cohorts_analysis_users",
        materialized='external_table',
        upload_as='external_table', 
        uri='https://docs.google.com/spreadsheets/d/11LfwMZC8AWQT2U7Vew0-I-yb_9k04kIeK0t_oBr6Wl0/edit#gid=2096929014',
        sheet_range='micro_cohort!A:C',
        skip_leading_rows=1,
    )
}}

{%- set schema %}
        (
        user_id STRING,
        class_name	STRING,
        class_creation_date DATE
        )
{%- endset %}
{{schema}}