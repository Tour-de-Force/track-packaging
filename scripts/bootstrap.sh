#! /bin/sh

echo "Installing PostgreSQL and other dependencies..."
echo "This may take a few minutes..."
apt-get install -y git unzip build-essential #&> /dev/null
apt-get install -y postgresql-9.3-postgis-2.1 #&> /dev/null
apt-get install -y postgresql-contrib-9.3 proj-bin libgeos-dev #&> /dev/null
echo "...Dependencies installed"

echo "Installing OpenStreetMap dependencies..."
add-apt-repository -y ppa:kakrueger/openstreetmap #&> /dev/null
apt-get update #&> /dev/null
apt-get install -y osm2pgsql osmctools #&> /dev/null
apt-get install -y mapnik-utils
echo "...Dependencies installed"

echo "Configuring PostGIS database..."
sudo -u postgres createuser -s -w vagrant
sudo -u postgres createdb gis
sudo -u vagrant psql -d gis -c 'CREATE EXTENSION hstore; CREATE EXTENSION postgis;'
echo "...database configured"

echo "Cloning openstreetmap-carto..."
mkdir osm
git clone https://github.com/gravitystorm/openstreetmap-carto.git osm/openstreetmap-carto
echo "...openstreetmap cloned"

echo "Converting openstreetmap-carto/project.mml to project.xml..."
apt-get install -y node-carto
carto osm/openstreetmap-carto/project.mml > osm/openstreetmap-carto/project.xml
sed --in-place -e '19,33d;37,47d;51,67d;' osm/openstreetmap-carto/project.xml
echo "...project file converted"

echo "Downloading shapefiles..."
cd osm/openstreetmap-carto
./get-shapefiles.sh

echo "VM provisioned"