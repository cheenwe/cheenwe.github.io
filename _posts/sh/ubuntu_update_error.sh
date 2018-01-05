sudo mv /var/lib/dpkg/info /var/lib/dpkg/info_old //现将info文件夹更名
sudo mkdir /var/lib/dpkg/info //再新建一个新的info文件夹
sudo apt-get update && sudo apt-get -f install //不用解释了吧
sudo mv /var/lib/dpkg/info/* /var/lib/dpkg/info_old //执行完上一步操作后会在新的info文件夹下生成一些文件，现将这些文件全部移到info_old文件夹下
sudo rm -rf /var/lib/dpkg/info //把自己新建的info文件夹删掉
sudo mv /var/lib/dpkg/info_old /var/lib/dpkg/info //把以前的info文件夹重新改回名字




