import psycopg2 as pg
import time,sys

try:
    conn=pg.connect(host='localhost',
           port=5432,
           database='azdwh',
           user='azdwh_usr',
           password='azdwhusr123')
    print('Connected to Database azdwh')
except:
    print("Connection unsuccessful to azdwh database. Please check if Postgres is running in 5432 port")
    exit(1)
task_id=sys.argv[1]
print(task_id)
with conn.cursor() as cur:
        cur.execute(
            "select max(batch_identifier) from auditing_own.batch_information where batch_status in ('Started','Error') and batch_end_time is null")
        current_batch_id = str(cur.fetchone()[0])
        print('Current Batch ID :',current_batch_id)
        pi_max_start_time = "(select max(process_start_time) from auditing_own.process_information  where batch_identifier=" + current_batch_id + " and process_name='" + task_id + "') "
        pi_status_query = "select process_status from auditing_own.process_information  where batch_identifier=" + current_batch_id + " and process_name='"+task_id+"' and process_start_time=" + pi_max_start_time
        print(pi_status_query)
        cur.execute(pi_status_query)
        row = cur.fetchone()
        if row is not None:
            current_status=str(row[0])
        else:
            current_status = 'S'
        while current_status != 'C' and current_status != 'F':
            time.sleep(5)
            cur.execute(pi_status_query)
            current_status = str(cur.fetchone()[0])
if current_status=='C':
    exit(0)
exit(1)