# install activemq

PACKAGE_NAME="apache-activemq-5.15.0"

wget https://archive.apache.org/dist/activemq/5.15.0/$PACKAGE_NAME-bin.tar.gz

tar -zxf $PACKAGE_NAME-bin.tar.gz

cd $PACKAGE_NAME

bin/activemq start