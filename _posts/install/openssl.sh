# install openssl

PACKAGE_NAME="openssl-1.1.0g"

wget http://ftp.openssl.org/source/$PACKAGE_NAME.tar.gz

tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME

./config -fPIC --prefix=/usr/local/openssl enable-shared

./config -t

make && sudo make install

openssl version

cd ..

sudo rm -R $PACKAGE_NAME

rm $PACKAGE_NAME.tar.gz


