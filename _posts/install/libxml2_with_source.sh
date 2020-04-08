# install libxml2

PACKAGE_NAME="libxml2-2.7.2"


wget ftp://xmlsoft.org/libxml2/$PACKAGE_NAME.tar.gz

tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME

./configure

make && sudo make install

cd ..

sudo rm -R $PACKAGE_NAME

rm $PACKAGE_NAME.tar.gz




