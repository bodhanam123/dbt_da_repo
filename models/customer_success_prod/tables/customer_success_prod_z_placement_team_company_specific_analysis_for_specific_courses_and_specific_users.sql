{{
  config(
    alias = "z_placement_team_company_specific_analysis_for_specific_courses_and_specific_users"
    )
}}

SELECT  
    base_table.*
FROM {{ ref('customer_success_prod_z_derived_tables_views_z_placement_team_company_specific_analysis_for_specific_courses_and_specific_users') }} AS base_table