

create table dwh_own.xref_product_category(
category_key bigint REFERENCES dwh_own.dim_category,
product_key bigint REFERENCES dwh_own.dim_product,
CONSTRAINT xref_product_category_pkey PRIMARY KEY (category_key,product_key)
);
