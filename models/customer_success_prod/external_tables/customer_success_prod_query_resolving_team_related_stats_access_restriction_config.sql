{{
    config(
        alias="query_resolving_team_related_stats_access_restriction_config",
        materialized='external_table',
        upload_as='external_table', 
        uri='https://docs.google.com/spreadsheets/d/14RnmIUC0AC3AlkS10kTigPdgB5fsfGMeZOg6FzIHVLY/edit#gid=0',
        sheet_range='query_resolving_team_related_stats_access_restriction_config!A:H',
        skip_leading_rows=1,
    )
}}

{%- set schema %}
        (
            user_id	STRING,	
            email STRING,	
            resource_id STRING,	
            resource_type STRING,	
            team_name STRING,	
            team_lead_user_id STRING,	
            team_lead_email STRING,	
            team_lead_name STRING	
        )
{%- endset %}
{{schema}}