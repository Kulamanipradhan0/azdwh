#Dependency Library + Directory Structure :
sudo brew install gzip
sudo brew install split
sudo brew install unzip
sudo brew install wget

sudo mkdir -p /var/lib/postgresql/azdwh_data
sudo mkdir -p /var/lib/postgresql/azdwh_data_ix

sudo chown -R postgres /var/lib/postgresql/azdwh_data/
sudo chown -R postgres /var/lib/postgresql/azdwh_data_ix/

#cd ~
rm -r Amazon_DWH
mkdir -p Amazon_DWH/source_files/polling
mkdir -p Amazon_DWH/source_files/working
mkdir -p Amazon_DWH/source_files/error
mkdir -p Amazon_DWH/source_files/done

mkdir -p Amazon_DWH/log_files/staging
mkdir -p Amazon_DWH/log_files/dwh
mkdir -p Amazon_DWH/log_files/temp

mkdir -p Amazon_DWH/archive/logs

cd Amazon_DWH/archive/
wget https://github.com/Kulamanipradhan0/azdwh/archive/refs/heads/main.zip
unzip main.zip 

mv azdwh-main/azdwh_etl_repo ../

cd ../
current_dir=`pwd`
echo "log_file_dir=${current_dir}/log_files" >> ~/.kettle/kettle.properties
echo "stg_file_dir=${current_dir}/source_files" >> ~/.kettle/kettle.properties
echo "temp_file_location=${current_dir}/log_files" >> ~/.kettle/kettle.properties

mv ~/.kettle/repositories.xml ~/.kettle/repositories_backup.xml
echo '<?xml version="1.0" encoding="UTF-8"?>' > ~/.kettle/repositories.xml
echo "<repositories>  <repository>    <id>KettleFileRepository</id>    <name>azdwh</name>    <description>azdwh</description>    <is_default>true</is_default>" >> ~/.kettle/repositories.xml
echo "<base_directory>${current_dir}/azdwh_etl_repo</base_directory>    <read_only>N</read_only>    <hides_hidden_files>N</hides_hidden_files>  </repository>  </repositories>" >> ~/.kettle/repositories.xml

# mkdir -p tools
# cd tools
#wget https://sourceforge.net/projects/pentaho/files/latest/download
#unzip pdi-ce-9.2.0.0-290.zip
pwd

# psql -h localhost -p 5432 -U postgres -f archive/azdwh-main/db_scripts/admin_create_azdwh_database.sql > archive/logs/admin_create_azdwh_database.log

# echo "localhost:5432:*:azdwh_usr:azdwhusr123" >> ~/.pgpass

# psql -h localhost -p 5432 -U azdwh_usr azdwh -f archive/azdwh-main/db_scripts/azdwh_usr_create_azdwh_database_objects.sql > archive/logs/azdwh_usr_create_azdwh_database_objects.log









