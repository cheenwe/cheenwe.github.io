# install golang

PACKAGE_NAME="5.3.5"

curl -R -O http://www.lua.org/ftp/lua-$PACKAGE_NAME.tar.gz
tar zxf lua-$PACKAGE_NAME.tar.gz
cd lua-$PACKAGE_NAME
make linux test