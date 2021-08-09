

CREATE MATERIALIZED VIEW dwh_own.mview_product_analysis_olap AS 
  SELECT c.category_name as "Category Name",
    p.title AS "Product Title",
    p.product_id as "Product ID",
	p.product_price,
	b.first_interval,
	b.second_interval,
	b.third_interval,
	b.fourth_interval,	
	b.reference_price
   FROM dwh_own.dim_product p 
     JOIN dwh_own.xref_product_category pc ON pc.product_key = p.product_key
     JOIN dwh_own.dim_category c ON c.category_key = pc.category_key
     JOIN dwh_own.dim_price_bucket b on b.price_bucket_key = c.price_bucket_key
  WHERE p.active_flag = 'Y'::bpchar
WITH DATA;

ALTER TABLE dwh_own.mview_product_analysis_olap
  OWNER TO azdwh_usr;


