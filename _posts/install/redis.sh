# install redis


PACKAGE_NAME="tcl8.5.10-src"
wget  ftp://mirror.ovh.net/gentoo-distfiles/distfiles/$PACKAGE_NAME.tar.gz
tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME
make &

sudo make install

cd ..

sudo rm -R $PACKAGE_NAME


PACKAGE_NAME="redis-3.2.9"

wget http://download.redis.io/releases/$PACKAGE_NAME.tar.gz

tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME

make &

make test

sudo make install

cd ..

sudo rm -R $PACKAGE_NAME

rm $PACKAGE_NAME.tar.gz

