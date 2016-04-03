#! /bin/sh

echo "Installing GNU dependencies..."
apt-get install -y git zip unzip build-essential python-pip
echo "...Dependencies installed"

echo "Installing OpenStreetMap dependencies..."
add-apt-repository -y ppa:kakrueger/openstreetmap
apt-get update
apt-get install -y osm2pgsql osmctools mapnik-utils
echo "...Dependencies installed"

echo "Cloning mapnik-stylesheets..."
git clone https://github.com/openstreetmap/mapnik-stylesheets.git
echo "...mapnik-stylesheets cloned"

echo "Installing polytiles.py dependencies..."
apt-get install -y python-dev libpq-dev
pip install psycopg2
pip install shapely
apt-get install -y python-gdal
echo "...polytiles.py dependencies installed"

echo "Cloning openstreetmap-carto..."
mkdir osm
git clone https://github.com/gravitystorm/openstreetmap-carto.git osm/openstreetmap-carto
git clone https://github.com/bikelomatic-complexity/gpx-tiles.git gpx-tiles
echo "...openstreetmap cloned"

echo "Converting openstreetmap-carto/project.mml to project.xml..."
apt-get install -y node-carto
carto osm/openstreetmap-carto/project.mml > osm/openstreetmap-carto/project.xml
sed --in-place -e '19,33d;37,47d;51,67d;' osm/openstreetmap-carto/project.xml
echo "...project file converted"

echo "Downloading shapefiles..."
cd osm/openstreetmap-carto
./get-shapefiles.sh

echo "Installing gpx-tiles..."
cd ../../
apt-get install -y npm
cd gpx-tiles
npm install
cd ../
echo "...gpx-tiles installed"


echo "Installing and Configuring PostgreSQL database..."
apt-get install -y postgresql-9.3-postgis-2.1
apt-get install -y postgresql-contrib-9.3 proj-bin libgeos-dev
echo "Configuring PostGIS database..."
sudo -u postgres createuser -s -w root
sudo -u postgres createdb gis
psql -d gis -c 'CREATE EXTENSION hstore; CREATE EXTENSION postgis;'
echo "...database configured"

echo "VM provisioned"
