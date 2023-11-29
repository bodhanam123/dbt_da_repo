{{
  config(
    alias = "z_query_resolving_team_related_stats_access_restriction_config_based_on_unit_id"
    )
}}

WITH xpm_ccbp_plan_program_course_topic_unit_details AS (
  SELECT
    xpm_ccbp_plan_program_course_topic_unit_details.unit_id,
    xpm_ccbp_plan_program_course_topic_unit_details.topic_id,
   xpm_ccbp_plan_program_course_topic_unit_details.course_id,
   xpm_ccbp_plan_program_course_topic_unit_details.program_id
  FROM {{ source('customer_success_prod', 'xpm_ccbp_plan_program_course_topic_unit_details')}} AS xpm_ccbp_plan_program_course_topic_unit_details
)

SELECT 
  DISTINCT
  query_resolving_team_related_stats_access_restriction_config.user_id,
  query_resolving_team_related_stats_access_restriction_config.team_name,
  query_resolving_team_related_stats_access_restriction_config.email,
  query_resolving_team_related_stats_access_restriction_config.team_lead_user_id,
  query_resolving_team_related_stats_access_restriction_config.team_lead_email,
  query_resolving_team_related_stats_access_restriction_config.team_lead_name,

  CASE
    WHEN query_resolving_team_related_stats_access_restriction_config.resource_type = "PROGRAM"
    THEN program_details.unit_id
    WHEN query_resolving_team_related_stats_access_restriction_config.resource_type = "COURSE"
    THEN course_details.unit_id
    WHEN query_resolving_team_related_stats_access_restriction_config.resource_type = "TOPIC"
    THEN topic_details.unit_id
    ELSE query_resolving_team_related_stats_access_restriction_config.resource_id
  END AS unit_id
FROM {{ ref('customer_success_prod_query_resolving_team_related_stats_access_restriction_config') }} AS query_resolving_team_related_stats_access_restriction_config

LEFT JOIN `xpm_ccbp_plan_program_course_topic_unit_details` AS program_details
ON REPLACE(query_resolving_team_related_stats_access_restriction_config.resource_id,"-","") = program_details.program_id

LEFT JOIN `xpm_ccbp_plan_program_course_topic_unit_details` AS course_details
ON REPLACE(query_resolving_team_related_stats_access_restriction_config.resource_id,"-","") = course_details.course_id

LEFT JOIN `xpm_ccbp_plan_program_course_topic_unit_details` AS topic_details
ON REPLACE(query_resolving_team_related_stats_access_restriction_config.resource_id,"-","") = topic_details.topic_id