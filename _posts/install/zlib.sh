# install zlib

PACKAGE_NAME="zlib-1.2.11"

wget http://www.zlib.net/$PACKAGE_NAME.tar.gz

tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME

./configure

make && sudo make install

cd ..

sudo rm -R $PACKAGE_NAME

rm $PACKAGE_NAME.tar.gz