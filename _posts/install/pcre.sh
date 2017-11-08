# install libxml2

PACKAGE_NAME="pcre-8.38"

wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$PACKAGE_NAME.tar.gz

tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME

./configure

make && sudo make install

cd ..

sudo rm -R $PACKAGE_NAME

rm $PACKAGE_NAME.tar.gz

