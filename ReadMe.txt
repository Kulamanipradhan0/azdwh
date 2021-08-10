#########################################################################################################
##### This Document describes how to set up all required softwares related to AMAZON DWH assignment #####
#########################################################################################################
#####                           System Specification                                                #####    
##### Ubuntu 18                                                                                     #####   
##### Java 1.8 jdk                                                                                  #####   
##### Python 3.7                                                                                    #####               
##### Tableau 20                                                                                    #####              
##### Pentaho 9.2   (It can only start with Java 1.8 jdk)                                           #####   
##### Postgres 11.7 (Tableau Higher version is not supporting postgres 12 or higher)                #####   
##### Apache Airflow                                                                                #####    
#########################################################################################################

Assumption : We are in home directory.
cd ~

#########################################################################################################
##### Java 1.8 jdk Installation                                                                     #####
#########################################################################################################

1. Update the ubuntu repository.
sudo apt-get update

2. Install Java 8 jdk.
sudo apt-get install openjdk-8-jdk

3. Test it.
java -version


#########################################################################################################
##### Python 3.7 Installation                                                                       #####
#########################################################################################################

1. Update the ubuntu repository.
sudo apt-get update

2. Install Python 3.7 .
sudo apt install python3.7

3. Test it.
python3.7 --version

#########################################################################################################
##### Pentaho Installation                                                                          #####
#########################################################################################################

1. set JAVA_HOME environment variable .
export PATH="$PATH:<JAVA HOME PATH for jdk 1.8>"

2. Lets Create a New directory where we will keep all the tools and assignment codebase.
Ex : Assignment_KP/tools
mkdir -p Assignment_KP/tools
cd Assignment_KP/tools

3. Download the pentaho data integration from the below URL.
sudo apt install -y wget
wget https://sourceforge.net/projects/pentaho/files/latest/download

4. Wait for the download to finish, there will be a pdi-ce-9.2.0.0-290.zip file.Lets unzip it.
sudo apt-get install unzip
unzip pdi-ce-9.2.0.0-290.zip

4. Lets do a sanity test if Pentaho carte server is up and running as expected.
sh data-integration/carte.sh localhost 8080

5. Wait for Carte server to start. Test it using << http://localhost:8080/kettle/status >> .

6. CTRL+C to close the carte server. We will run it once we configure all properties file.


#########################################################################################################
##### Tableau Desktop Installation                                                                  #####
#########################################################################################################


1. Go to this page and follow instructions to download Tableau 20 version.
https://www.tableau.com/products/desktop?utm_campaign_id=2017049&utm_campaign=Prospecting-PROD-ALL-ALL-ALL-ALL&utm_medium=Paid+Search&utm_source=Google+Search&utm_language=EN&utm_country=BENX&kw=%2Bdesktop%20%2Btableau&adgroup=CTX-Brand-Tableau+Desktop-EN-B&adused=504457958298&matchtype=b&placement=&gclid=CjwKCAjwx8iIBhBwEiwA2quaqzKKJSFBitUqH9sMiGMmHSZolyijp0BrKb3CeD38KNe4WMQI-RGcVxoCKy0QAvD_BwE&gclsrc=aw.ds


2. Once downloaded install it and open the Taleau desktop icon to see if it works.


#########################################################################################################
##### Postgres 11.7 Installation                                                                    #####
#########################################################################################################

1. Update the ubuntu repository.
sudo apt update && sudo apt -y upgrade

2. Install wget and vim to download a package.
sudo apt install -y wget vim

3. Add Postgres repository keys into local.
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RELEASE=$(lsb_release -cs)
echo "deb http://apt.postgresql.org/pub/repos/apt/ ${RELEASE}"-pgdg main | sudo tee  /etc/apt/sources.list.d/pgdg.list
cat /etc/apt/sources.list.d/pgdg.list

4. Install Postgres 11.7 version.
sudo apt -y install postgresql-11 or sudo apt -y install postgresql-11.7

5. Lets test if postgres Installation.
sudo su - postgres
psql -c "alter user postgres with password 'SuperUserPassword'"


#########################################################################################################
##### Apache Airflow Installation                                                                   #####
#########################################################################################################


1. Create a airflow directory, where we will place all our dags and code base
mkdir ~/Assignment_KP/tools/airflow
cd ~/Assignment_KP/tools/airflow

2. Lets install virtualenv utility.
sudo pip install virtualenv

3. Lets create a virtual environment for airflow.
sudo virtualenv airflow-venv

4. Lets active our new virtualenv for airfow.
source airflow-venv/bin/active

5. Lets declare our AIRFLOW_HOME path.
export AIRFLOW_HOME=~/Assignment_KP/tools/airflow/airflow-venv

6. Lets Install airflow in this virtualenv. Follow this url to see the steps.
https://airflow.apache.org/docs/apache-airflow/stable/installation.html

AIRFLOW_VERSION=2.1.2
PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
# For example: 3.6
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-no-providers-${PYTHON_VERSION}.txt"
# For example: https://raw.githubusercontent.com/apache/airflow/constraints-no-providers-2.1.2/constraints-3.6.txt
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

7. Lets Initialize the DB for airflow.
airflow db init

8. Lets Create an admin user with password as admin.
airflow users  create --role Admin --username admin --email admin --firstname admin --lastname admin --password admin

9. Create a dags directory. Where we will keep all our codebase.
mkdir dags

10. Lets change airflow.conf configuration file for pointing to this newly created dags directory
Variable name to change : dags_folder 
Replace the line with :
dags_folder = ~/Assignment_KP/tools/airflow/airflow-venv/dags

11. Lets install postgresql python package, which is used in airflow for flow validation.
pip install psycopg2
pip install psycopg2-binary

12. Let's test the apache webserver. 
airflow webserver --port 9000

13. Let's test the apache scheduler in another terminal.
airflow scheduler

14. Keep it running


#########################################################################################################
#####                                           END                                                 #####
#########################################################################################################