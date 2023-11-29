{{
  config(
    alias = "z_academy_users_daily_login_details"
    )
}}

SELECT 
    ccbp_user_login_details.user_id,
    ccbp_user_login_details.login_datetime,
    master_db_users.starts_on_datetime AS batch_start_datetime, 
    master_db_users.product
    
FROM {{ source('customer_success_prod', 'xpm_ccbp_users_login_details') }} AS ccbp_user_login_details 

INNER JOIN {{ source('customer_success_prod', 'xpm_ccbp_users_master_db') }} AS master_db_users 
ON master_db_users.user_id = ccbp_user_login_details.user_id 
AND master_db_users.product IN (
    "CCBP_ACADEMY_SMART",
    "CCBP_ACADEMY_GENIUS",
    "CCBP_ACADEMY_EDGE",
    "CCBP_ACADEMY_GENIUS_CAREER_PLUS",
    "CCBP_ACADEMY_SMART_CAREER_PLUS"
)