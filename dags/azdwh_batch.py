#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

"""Example DAG demonstrating the usage of the BashOperator."""

from datetime import timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.utils.trigger_rule import TriggerRule

args = {
    'owner': 'airflow',
}

ETL_REPO_HOME="%2Fhome%2Fkulamani%2FDesktop%2FAmazon_DWH%2Fazdwh_etl_repo%2F"
PYTHON_PROCESS_SCRIPT_DIR="/home/kulamani/PycharmProjects/pythonProject/dags"
REVIEW_FILE_NAME='reviews_Musical_Instruments_1000'
METADATA_FILE_NAME='meta_Musical_Instruments_1000'
pentaho_usr='cluster'
pentaho_pwd='cluster'

wrapper_job='job_wrapper'
staging_job_dir='%2Fstaging'
dim_job_dir='%2Fdwh%2Fdimension'
fac_job_dir='%2Fdwh%2Ffact'
xref_job_dir='%2Fdwh%2Fxref'
auditing_job_dir='%2Fauditing'
olap_job_dir='%2Folap'

wrapper_url=' "http://localhost:8080/kettle/executeJob?job='+ETL_REPO_HOME+wrapper_job+'.kjb'
carte_url=' "http://localhost:8080/kettle/executeJob?job='+ETL_REPO_HOME

with DAG(
    dag_id='azdwh_batch',
    default_args=args,
    schedule_interval='0 0 * * *',
    start_date=days_ago(2),
    dagrun_timeout=timedelta(minutes=240),
    tags=['olap', 'azdwh'],
    params={"example_key": "example_value"},
) as dag:

    task_id = 'job_batch_start.kjb'
    param = '&level=Basic&job_name=' + '&job_dir=' + ETL_REPO_HOME + '&inp_file_name=' + '"'
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + carte_url +auditing_job_dir+ '%2F'+ task_id + param
    run_batch_start = BashOperator(
            task_id=task_id,
            bash_command=command,
        )

    #Staging Job Start

    task_id = 'job_load_review_stg_main'
    inp_file_name = REVIEW_FILE_NAME
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + staging_job_dir+'&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_review_stg = BashOperator(
        task_id=task_id,
        bash_command=command,
    )


    task_id = 'job_load_metadata_stg'
    inp_file_name = METADATA_FILE_NAME
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + staging_job_dir+'&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_metadata_stg = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    run_staging_done = DummyOperator(
        task_id="run_staging_done",
        trigger_rule=TriggerRule.ONE_SUCCESS,
    )

    #Dimension Job Start



    task_id = 'job_load_dim_calendar_date'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + dim_job_dir + '&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_dim_calendar_date = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    task_id = 'job_load_dim_price_bucket'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + dim_job_dir + '&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_dim_price_bucket = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    task_id = 'job_load_dim_product'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + dim_job_dir+'&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_dim_product = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    task_id = 'job_load_dim_reviewer'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + dim_job_dir+'&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_dim_reviewer = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    task_id = 'job_load_dim_category'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + dim_job_dir+'&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_dim_category = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    task_id = 'job_load_xref_product_category'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + xref_job_dir+'&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_xref_product_category = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    #Fact Jobs

    task_id = 'job_load_fac_review'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + fac_job_dir+'&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_fac_review = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    task_id = 'job_batch_end.kjb'
    param = '&level=Basic&job_name=' + '&job_dir=' + ETL_REPO_HOME + '&inp_file_name=' + '"'
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + carte_url +auditing_job_dir+ '%2F'+ task_id + param
    run_batch_end = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    #refresh olap views
    task_id = 'job_refresh_olap_views'
    inp_file_name = ''
    param = '&level=Basic&job_name=' + task_id + '&job_dir=' + ETL_REPO_HOME + olap_job_dir + '&inp_file_name=' + inp_file_name + '"'
    python_process_check='; python '+PYTHON_PROCESS_SCRIPT_DIR+'/process_status_check.py '+task_id
    command = 'curl -L -u ' + pentaho_usr + ':' + pentaho_pwd + wrapper_url + param + python_process_check
    run_refresh_olap_views = BashOperator(
        task_id=task_id,
        bash_command=command,
    )

    run_batch_start >> [run_review_stg, run_metadata_stg]
    [run_review_stg, run_metadata_stg] >> run_staging_done
    run_staging_done  >> [run_dim_calendar_date, run_dim_price_bucket, run_dim_product, run_dim_reviewer]

    run_dim_price_bucket >> run_dim_category
    [run_dim_product, run_dim_category] >> run_xref_product_category
    [run_dim_product, run_dim_reviewer] >> run_fac_review

    [run_dim_calendar_date, run_xref_product_category, run_fac_review] >> run_batch_end
    run_batch_end >> run_refresh_olap_views

if __name__ == "__main__":
    dag.cli()