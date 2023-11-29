{{
  config(
    alias = "z_ccbp_academy_cba_flow_ai_workshop_task_basic_details"
    )
}}

SELECT
  all_tasks_base.task_id, 
  all_tasks_base.task_created_datetime, 
  all_tasks_base.channel, 
  all_tasks_base.source, 
  all_tasks_base.inbound_source, 
  all_tasks_base.user_id, 
  all_tasks_base.single_preferred_language,
  all_tasks_base.college_name,
  all_tasks_base.other_college, 
  all_tasks_base.degree_branch, 
  all_tasks_base.expected_graduation_year, 
  all_tasks_base.expected_graduation_other_year,
  all_tasks_base.bdm_id, 
  all_tasks_base.bdm_name, 
  all_tasks_base.cba_id, 
  all_tasks_base.cba_name, 
  all_tasks_base.cba_code,
  all_tasks_base.ai_workshop_attendance_status,
  all_tasks_base.ai_workshop_watch_bucket,
  all_tasks_base.ai_workshop_watch_duration_in_minutes,
  all_tasks_base.ai_workshop_registered_datetime,
  all_tasks_base.ai_workshop_source,
  all_tasks_base.ai_workshop_mother_tongue,
  all_tasks_base.ai_workshop_cba_invite_code,
  all_tasks_base.ai_workshop_bdm_invite_code

FROM {{ source('academy_analytics_prod', 'ccbp_academy_cba_flow_taskflow_template_task_details_base') }} AS all_tasks_base

WHERE all_tasks_base.channel = "AI Workshop"