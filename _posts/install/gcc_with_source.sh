#install gcc
wget http://gcc.parentingamerica.com/releases/gcc-6.4.0/gcc-6.4.0.tar.xz
tar -zxvf gcc-6.4.0.tar.xz
cd gcc-6.4.0
 ./contrib/download_prerequisites
./configure --enable-checking=release --enable-languages=c,c++ --disable-multilib
make -j4
sudo make install
gcc -v