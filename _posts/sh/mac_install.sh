# mac


# new install mac

## install xcode
then
>xcode-select —install

## brew

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

```

## shell - oh my zsh

```sh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)”


```

** oh my zsh theme **
nanotech
jonathan


## git
git config --global user.name "cheenwe"
git config --global user.name "cheenwe@gmail.com"




## ruby dev

```
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
# 用来编译安装 ruby
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# 用来管理 gemset, 可选, 因为有 bundler 也没什么必要
git clone git://github.com/jamis/rbenv-gemset.git  ~/.rbenv/plugins/rbenv-gemset
# 通过 gem 命令安装完 gem 后无需手动输入 rbenv rehash 命令, 推荐
git clone git://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
# 通过 rbenv update 命令来更新 rbenv 以及所有插件, 推荐
git clone git://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
# 使用 Ruby China 的镜像安装 Ruby, 国内用户推荐
git clone git://github.com/AndorChen/rbenv-china-mirror.git ~/.rbenv/plugins/rbenv-china-mirror
```


放到 ~/.bashrc 里, zsh用户是 ~/.zshrc

```
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```


# soft

## 定时提醒
https://difgbq95ss5ww.cloudfront.net/20171104/234696c139e0fbaa4ac42de6be39bd5f29faeb2c/Magican%20Rest.dmg

## 查看快捷键
CheatSheet


## dash

- license

https://kapeli.com/licenses/Dash/2015/181/A9xyvwUTgNKIjFMPNX3Uh4byRMmZgk/license.dash-license


## sublimetext 3

- license
```
—– BEGIN LICENSE —–
TwitterInc
200 User License
EA7E-890007
1D77F72E 390CDD93 4DCBA022 FAF60790
61AA12C0 A37081C5 D0316412 4584D136
94D7F7D4 95BC8C1C 527DA828 560BB037
D1EDDD8C AE7B379F 50C9D69D B35179EF
2FE898C4 8E4277A8 555CE714 E1FB0E43
D5D52613 C3D12E98 BC49967F 7652EED2
9D2D2E61 67610860 6D338B72 5CF95C69
E36B85CC 84991F19 7575D828 470A92AB
—— END LICENSE ——

```

- add quick link
>sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

- install package control

```
import urllib.request,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```




# db


## mysql
> brew install mysql

```
We've installed your MySQL database without a root password. To secure it run:
mysql_secure_installation

MySQL is configured to only allow connections from localhost by default

To connect run:
mysql -uroot

To have launchd start mysql now and restart at login:
brew services start mysql
Or, if you don't want/need a background service you can just run:
mysql.server start

```

修改  配置文件允许远程访问, 注释 127.0.0.1
/usr/local/Cellar/mysql/5.7.20/.bottle/etc/my.cnf

/usr/local/etc/my.cnf

mysql> GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "123456";
mysql> flush privileges;

远程登录命令：
mysql -h 223.4.92.130 -uroot -p（-h后跟的是要登录主机的ip地址）


## postgresql
> brew install postgresql


```
To migrate existing data from a previous major version of PostgreSQL, see:
https://www.postgresql.org/docs/10/static/upgrading.html

You will need your previous PostgreSQL installation from brew to perform
`pg_upgrade` or `pg_dumpall` depending on your upgrade method.

Do not run `brew cleanup postgresql` until you have performed the migration.

To have launchd start postgresql now and restart at login:
brew services start postgresql
Or, if you don't want/need a background service you can just run:
pg_ctl -D /usr/local/var/postgres start


```


## mongodb

https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/


> brew install mongodb


```
To have launchd start mongodb now and restart at login:
brew services start mongodb
Or, if you don't want/need a background service you can just run:
mongod --config /usr/local/etc/mongod.conf



The following example command creates the default /data/db directory:

mkdir -p /data/db
```

## redis
> brew install redis


```
To have launchd start redis now and restart at login:
  brew services start redis
Or, if you don't want/need a background service you can just run:
  redis-server /usr/local/etc/redis.conf

```



## nginx

>brew install nginx

```
Docroot is: /usr/local/var/www

The default port has been set in /usr/local/etc/nginx/nginx.conf to 8080 so that
nginx can run without sudo.

nginx will load all files in /usr/local/etc/nginx/servers/.

To have launchd start nginx now and restart at login:
  brew services start nginx
Or, if you don't want/need a background service you can just run:
  nginx

```

## go

>brew install go

A valid GOPATH is required to use the `go get` command.

If $GOPATH is not specified, $HOME/go will be used by default:

  https://golang.org/doc/code.html#GOPATH



You may wish to add the GOROOT-based install location to your PATH:

  export PATH=$PATH:/usr/local/opt/go/libexec/bin



## python3
>brew install python3

🍺  /usr/local/Cellar/openssl/1.0.2n: 1,792 files, 12.3MB

==> Installing python3

==> Downloading https://homebrew.bintray.com/bottles/python3-3.6.4_2.high_sierra.bottle.tar.gz

######################################################################## 100.0%

==> Pouring python3-3.6.4_2.high_sierra.bottle.tar.gz

Error: An unexpected error occurred during the `brew link` step

The formula built, but is not symlinked into /usr/local

Permission denied @ dir_s_mkdir - /usr/local/Frameworks

Error: Permission denied @ dir_s_mkdir - /usr/local/Frameworks



解决方法:

sudo chown -R $(whoami):admin /usr/local

sudo chown -R $(whoami) /Library/Caches/Homebrew

brew doctor

brew prune

brew update

brew linkapps python3



Brew 安装完成的 python3 无 pip3, 建议使用官方源安装.

OR

Download form

https://www.python.org/ftp/python/3.7.0/



## pyqt

>brew install pyqt
