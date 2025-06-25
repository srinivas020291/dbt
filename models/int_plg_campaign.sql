{{
    config(
        materialized="incremental",
        unique_key="CAMPAIGN_ID_18",
        TAGS=["mds-dca-web-plg-campaign-journey"],
    )
}}

    WITH cte_hdm_campaign as (
        select distinct
            campaign_id as CAMPAIGN_ID_18,
            campaign_id_15,
            campaign_name,
            campaign_vendor,
            parent_tactic,
            campaign_website,
            driver_campaign_flag,
            campaign_ou,
            campaign_region,
            campaign_offer_type,
            lower(campaign_id) as Lowercase_campaign_id_18,
            lower(campaign_id_15) as Lowercase_campaign_id_15,
            case
                when campaign_name ILIKE '%Foundation%' THEN 'Foundations'
            ELSE 'Starter/Pro'
            END AS PRODUCT_NAME
        from {{ source('sse_dm_mkt_prd_dm','MDW_CAMPAIGNS')}}
    )

    select * from cte_hdm_campaign