#!/bin/bash
# Anaconda指的是一个开源的Python发行版本，其包含了conda、Python等180多个科学包及其依赖项。

wget https://repo.anaconda.com/archive/Anaconda2-2019.03-Linux-x86_64.sh

bash Anaconda2-2019.03-Linux-x86_64.sh



scp chewnei@192.168.30.29:/disk4/data/chenwei/files/Anaconda2-2019.03-Linux-x86_64.sh .



###

 #我的安装路径: /var/soft/anaconda2
export PYTHONPATH=/home/chenwei/anaconda2:$PYTHONPATH
export PATH=/home/chenwei/anaconda2/bin:$PATH

conda install -c conda-forge cfgrib

sudo apt-get install libeccodes0

pip install netcdf4


PYTHONPATH




import xarray as xr

file = "C1D06031200060600001"
#file = "gfs190604.t12z.pgrb2f00"
#file = "Z_NAFP_C_BCSH_20190604000000_P_surface-warms-f00.BIN"
ifile = open('/home/ubuntu/chenwei/'+file)

ds = xr.open_dataset(ifile, engine='cfgrib')

ds


import cf2cdm

ds = xr.open_dataset('/home/ubuntu/chenwei/gfs190604.t12z.pgrb2f00', engine='cfgrib')
cf2cdm.translate_coords(ds, cf2cdm.ECMWF)




file = "C1D06031200060600001"
#file = "gfs190604.t12z.pgrb2f00"
#file = "Z_NAFP_C_BCSH_20190604000000_P_surface-warms-f00.BIN"
ifile = open('/home/ubuntu/chenwei/'+file)
while 1:
    igrib = codes_grib_new_from_file(ifile)
    if igrib is None: break

    #从加载的message中解码/编码数据
    date = codes_get(igrib,"dataDate")
    levtype = codes_get(igrib,"typeOfLevel")
    level = codes_get(igrib,"level")
    values = codes_get_values(igrib)
    print (date,levtype,level,values[0],values[len(values)-1])

    #释放
    codes_release(igrib)
ifile.close()
