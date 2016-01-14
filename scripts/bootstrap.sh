

echo "Installing PostgreSQL and other dependencies..."
apt-get install -y git unzip build-essential &> /dev/null
apt-get install -y postgresql-9.3-postgis-2.1 &> /dev/null
apt-get install -y postgresql-contrib-9.3 proj-bin libgeos-dev &> /dev/null
echo "...Dependencies installed"

echo "Installing OpenStreetMap dependencies..."
add-apt-repository -y ppa:kakrueger/openstreetmap &> /dev/null
apt-get update &> /dev/null
apt-get install -y osm2pgsql osmctools &> /dev/null
echo "...Dependencies installed"

echo "Configuring PostGIS database..."
sudo -u postgres createuser -s -w vagrant
createdb gis
psql -d gis -c 'CREATE EXTENSION hstore; CREATE EXTENSION postgis;'
echo "...database configured"