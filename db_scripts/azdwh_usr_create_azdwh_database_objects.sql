\echo Executing DB Objects

\i setup/2.create_schema.sql


\echo Creating auditing_own objects
\i auditing/3.auditing_own_batch_information.sql
\i auditing/3.auditing_own_process_information.sql
\i auditing/3.auditing_own_error_log.sql

\echo Creating stage_own objects
\i staging/3.stage_own_categories.sql
\i staging/3.stage_own_metadata.sql
\i staging/3.stage_own_related_metadata.sql
\i staging/3.stage_own_review.sql
\i staging/3.stage_own_sales_rank.sql



\echo Creating dwh_own objects
\i dwh/4.dwh_own_dim_price_bucket.sql
\i dwh/4.dwh_own_dim_category.sql
\i dwh/4.dwh_own_dim_product.sql
\i dwh/4.xref_product_category.sql
\i dwh/4.dwh_own_dim_reviewer.sql
\i dwh/5.dwh_own_fac_review.sql
\i dwh/4.dwh_own_dim_calendar_date.sql
\i dwh/6.mview_review_olap.sql
