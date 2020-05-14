## install grafana


sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# Alternatively you can add the beta repository, see in the table above
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

sudo apt-get update
sudo apt-get install -y grafana





### new 2020.05
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_6.7.3_amd64.deb
sudo dpkg -i grafana_6.7.3_amd64.deb




### Start the server with systemd
# To start the service and verify that the service has started:

sudo systemctl daemon-reload

sudo systemctl start grafana-server
sudo systemctl status grafana-server

### Configure the Grafana server to start at boot:
sudo systemctl enable grafana-server.service
sudo update-rc.d grafana-server defaults


