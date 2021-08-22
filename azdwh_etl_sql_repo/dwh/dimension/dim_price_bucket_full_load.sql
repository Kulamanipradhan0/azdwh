truncate table dwh_own.dim_price_bucket cascade;
INSERT INTO dwh_own.dim_price_bucket(
            price_bucket_key, batch_identifier, insert_datetime, reference_price, 
            first_interval, second_interval, third_interval, fourth_interval)
    VALUES (1, 1, now(), 100, 
            10, 20, 40, 80);
INSERT INTO dwh_own.dim_price_bucket(
            price_bucket_key, batch_identifier, insert_datetime, reference_price, 
            first_interval, second_interval, third_interval, fourth_interval)
    VALUES (2, 1, now(),500, 25, 
            50, 100, 200);
INSERT INTO dwh_own.dim_price_bucket(
            price_bucket_key, batch_identifier, insert_datetime, reference_price, 
            first_interval, second_interval, third_interval, fourth_interval)
    VALUES (3, 1, now(),1000, 100, 
            200, 400, 800);
INSERT INTO dwh_own.dim_price_bucket(
            price_bucket_key, batch_identifier, insert_datetime, reference_price, 
            first_interval, second_interval, third_interval, fourth_interval)
    VALUES (4, 1, now(),5000, 500, 
            1000, 2000, 4000);
INSERT INTO dwh_own.dim_price_bucket(
            price_bucket_key, batch_identifier, insert_datetime, reference_price, 
            first_interval, second_interval, third_interval, fourth_interval)
    VALUES (5, 1, now(),10000, 1000, 
            2000, 4000, 8000);
INSERT INTO dwh_own.dim_price_bucket(
            price_bucket_key, batch_identifier, insert_datetime, reference_price, 
            first_interval, second_interval, third_interval, fourth_interval)
    VALUES (6, 1, now(),20000, 2000, 
            4000, 8000, 16000);