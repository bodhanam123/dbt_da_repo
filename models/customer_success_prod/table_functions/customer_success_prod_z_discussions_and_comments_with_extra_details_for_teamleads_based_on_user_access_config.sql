{{
  config(
    alias = "z_discussions_and_comments_with_extra_details_for_teamleads_based_on_user_access_config",
    parameters = "DS_USER_EMAIL STRING"
    )
}}

{%- set sqlquery %}
SELECT
    z_users_discussions_and_comments_details_for_team_improvement.*
  FROM {{ ref('customer_success_prod_z_users_discussions_and_comments_details_for_team_improvement') }} AS z_users_discussions_and_comments_details_for_team_improvement
WHERE (
    REGEXP_CONTAINS(
       REPLACE(z_users_discussions_and_comments_details_for_team_improvement.comment_created_user_id,"-",""),(
            /* Start: filtering only mail accessed details */
            SELECT 
                STRING_AGG(REPLACE(access_restriction_config_based_on_unit_id.user_id,"-",""),"|")
            FROM {{ ref('customer_success_prod_z_query_resolving_team_related_stats_access_restriction_config_based_on_unit_id') }} AS access_restriction_config_based_on_unit_id
            WHERE (
                 LOWER(access_restriction_config_based_on_unit_id.team_lead_email) = LOWER(DS_USER_EMAIL)
            )
            /* End:  filtering only mail accessed details */
       )
    )
    AND z_users_discussions_and_comments_details_for_team_improvement.is_discussion_deleted = 0 
    AND (
        z_users_discussions_and_comments_details_for_team_improvement.is_comment_deleted = 0
        OR z_users_discussions_and_comments_details_for_team_improvement.is_comment_deleted IS NULL
    )
)
{%- endset %}

{{sqlquery}}