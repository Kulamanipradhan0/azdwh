BEGIN;
REFRESH MATERIALIZED VIEW dwh_own.mview_review_olap;

REFRESH MATERIALIZED VIEW dwh_own.mview_product_analysis_olap;

END;