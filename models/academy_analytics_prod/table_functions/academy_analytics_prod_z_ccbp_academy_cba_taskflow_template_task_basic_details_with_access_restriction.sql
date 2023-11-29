{{
  config(
    alias = 'z_ccbp_academy_cba_taskflow_template_task_basic_details_with_access_restriction',
    parameters = 'cba_team_user_email STRING'
    )
}}

{%- set sqlquery %}

  SELECT 
    ccbp_academy_cba_taskflow_template_task_basic_details.*
  FROM `academy_analytics_prod.ccbp_academy_cba_taskflow_template_task_basic_details` AS ccbp_academy_cba_taskflow_template_task_basic_details
  WHERE REGEXP_CONTAINS(LOWER(access_email_str),LOWER(CONCAT('"',cba_team_user_email,'"')))
   OR REGEXP_CONTAINS(
    (SELECT 
      STRING_AGG(DISTINCT LOWER(central_access))
    FROM `academy_analytics_prod.ccbp_4_0_academy_cba_v2_taskflow_access_emails_config` AS ccbp_4_0_academy_cba_v2_taskflow_access_emails_config)
    ,LOWER(CONCAT('"',cba_team_user_email,'"')))

{%- endset %}

{{sqlquery}}