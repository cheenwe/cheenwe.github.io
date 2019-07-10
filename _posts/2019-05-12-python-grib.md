---
layout: post
title: python2 解析 Grib/Grib2数据
tags:  python
category:   python
---

# python2 解析 Grib/Grib2数据

```shell
sudo apt-get install gfortran cmake  zlib1g-dev  libpng-dev jasper libjpeg-dev libgrib-api-dev python-tk libgeos++-dev
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple  numpy matplotlib  pyproj geos pygrib   eccodes
```

## install   jasper
```
mkdir build
cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=/usr/local/jasper
make -j 64
 #ctest
sudo make install
```

## install  ecCodes
```
  tar -xzf eccodes-2.6.0-Source.tar.gz
  mkdir build
  cd build
  cmake  ../ -DCMAKE_INSTALL_PREFIX=/usr/local/eccodes/
  make -j 64
  ctest
  make install

  1. 配置环境变量
  nano ~/.bashrc

  export ECCODES_HOME=/usr/local/eccodes
  PATH=$ECCODES_HOME/bin:$PATH:$HOME/bin
  export PATH

  LIBRARY_PATH=$ECCODES_HOME/lib/:$LIBRARY_PATH
  export LIBRARY_PATH

  source ~/.bashrc

  codes_info

  2. GRIB编解码的Python开发环境配置

    vi /home/ubuntu/.local/lib/python2.7/site-packages/gribapi.pth

    #-add

    /usr/local/eccodes/lib/python2.7/site-packages/

  3. 此时导入gribapi测试，如未报错，则说明配置成功

    python -c "from gribapi import *"

```


### 测试能否读取 grib文件
```

#!/usr/bin/env python
# -*- coding:utf-
from eccodes import *

#打开文件
ifile = open('example.grib')
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

```



## grib_api

```
tar -xzf grib_api-1.28.0-Source.tar.gz
cd grib_api-1.28.0-Source
mkdir build
cd build
cmake  ../ -DCMAKE_INSTALL_PREFIX=/usr/local/grib_api/
make -j 64
ctest
make install


grib_api-1.28.0-Source.tar.gz
 

 
```

 ### 0611 

```
 
  #basemap



pygrib-2.0.3]$ python3 setup.py install

 


## install basemap-1.0.7

<!-- tar zxvf basemap-1.0.7.tar.gz

cd basemap-1.0.7/geos-3.3.3/
export GEOS_DIR=/usr/local
./configure --prefix=$GEOS_DIR 
make -j 16
make install -->

pip install --user git+https://github.com/matplotlib/basemap.git
<!-- Collecting git+https://github.com/matplotlib/basemap.git -->

python -c "from mpl_toolkits.basemap import Basemap"# 测试安装成功

cd examples/
python simpletest.py



 
```

## CPP测试eccodes库

- read ECTHIN OK

  g++ main.cpp -L/usr/local/eccodes/lib/ -leccodes

  export LD_LIBRARY_PATH=/usr/local/eccodes/lib/:$LD_LIBRARY_PATH

  export PYTHONPATH=/usr/local/eccodes/lib/:$PYTHONPATH


```
/*
 * Copyright 2005-2018 ECMWF.
 *
 * This software is licensed under the terms of the Apache Licence Version 2.0
 * which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
 *
 * In applying this licence, ECMWF does not waive the privileges and immunities granted to it by
 * virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
 */

/*
 * C Implementation: grib_get_data
 *
 * Description: how to get lat/lon/values from a GRIB message
 *
 */
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include "eccodes.h"

using namespace std;

int main (int argc, char **argv)
{
    int err = 0;
    size_t i = 0;
    FILE *in = NULL;
    const char *filename = "/home/ubuntu/chenwei/C1D06031200060600001";
    codes_handle *h = NULL;
    long numberOfPoints = 0;
    const double missing = 9999.0;
    double *lats, *lons, *values;       /* arrays */

    in = fopen (filename, "r");
    if (!in) {
        printf ("ERROR: unable to open input file %s\n", filename);
        return 1;
    }

    /* create new handle from a message in a file */
    h = codes_handle_new_from_file (0, in, PRODUCT_GRIB, &err);
    if (h == NULL) {
        printf ("Error: unable to create handle from file %s\n", filename);
        return 1;
    }

    CODES_CHECK (codes_get_long (h, "numberOfPoints", &numberOfPoints), 0);
    CODES_CHECK (codes_set_double (h, "missingValue", missing), 0);

    lats = (double *) malloc (numberOfPoints * sizeof (double));
    if (!lats) {
        printf ("unable to allocate %ld bytes\n", (long) (numberOfPoints * sizeof (double)));
        return 1;
    }
    lons = (double *) malloc (numberOfPoints * sizeof (double));
    if (!lons) {
        printf ("unable to allocate %ld bytes\n", (long) (numberOfPoints * sizeof (double)));
        free (lats);
        return 1;
    }
    values = (double *) malloc (numberOfPoints * sizeof (double));
    if (!values) {
        printf ("unable to allocate %ld bytes\n", (long) (numberOfPoints * sizeof (double)));
        free (lats);
        free (lons);
        return 1;
    }

    CODES_CHECK (codes_grib_get_data (h, lats, lons, values), 0);

    for (i = 0; i < numberOfPoints; ++i) {
        if (values[i] != missing) {
            printf ("%f %f %f\n", lats[i], lons[i], values[i]);
        }
  }

    free (lats);
    free (lons);
    free (values);
    codes_handle_delete (h);

    fclose (in);
    return 0;
} 
```


