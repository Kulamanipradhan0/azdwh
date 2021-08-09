
CREATE MATERIALIZED VIEW  IF NOT EXISTS dwh_own.mview_review_olap
    AS (
    select c.category_name,
    p.title product_title,
    r.review_date,
    overall product_rating,
    summary review_summary,
    review_text,
    helpful_score,
    helpful_total   
    from dwh_own.fac_review r join
    dwh_own.dim_product p on p.product_key=r.product_key join
    dwh_own.xref_product_category pc on pc.product_key=p.product_key 
    join    dwh_own.dim_category c on c.category_key=pc.category_key
    where r.active_flag='Y'
);
