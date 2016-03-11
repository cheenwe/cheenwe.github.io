VERSION="5.3.0"

curl -O http://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz
tar zxf node-v$VERSION.tar.gz
cd node-v$VERSION
./configure
rm node-v$VERSION.tar.gz
rm -R node-v$VERSION
make && sudo make install