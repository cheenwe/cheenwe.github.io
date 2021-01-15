## 部署 cuda10

ip=192.168.1.109 

ssh-copy-id root@$ip


### 裝 cuda10 

host=root@$ip
rsync -avz --progress /usr/bin/nvidia-cuda-mps-control     $host:/usr/bin/nvidia-cuda-mps-control
rsync -avz --progress /usr/bin/nvidia-cuda-mps-server     $host:/usr/bin/nvidia-cuda-mps-server
rsync -avz --progress /usr/include/cuda_stdint.h     $host:/usr/include/cuda_stdint.h
rsync -avz --progress /usr/include/generated_cudaGL_meta.h     $host:/usr/include/generated_cudaGL_meta.h
rsync -avz --progress /usr/include/generated_cudaVDPAU_meta.h     $host:/usr/include/generated_cudaVDPAU_meta.h
rsync -avz --progress /usr/include/generated_cuda_gl_interop_meta.h     $host:/usr/include/generated_cuda_gl_interop_meta.h
rsync -avz --progress /usr/include/generated_cuda_meta.h     $host:/usr/include/generated_cuda_meta.h
rsync -avz --progress /usr/include/generated_cuda_runtime_api_meta.h     $host:/usr/include/generated_cuda_runtime_api_meta.h
rsync -avz --progress /usr/include/generated_cuda_vdpau_interop_meta.h     $host:/usr/include/generated_cuda_vdpau_interop_meta.h
rsync -avz --progress /usr/include/hwloc/cuda.h     $host:/usr/include/hwloc/cuda.h
rsync -avz --progress /usr/include/hwloc/cudart.h     $host:/usr/include/hwloc/cudart.h
rsync -avz --progress /usr/include/linux/cuda.h     $host:/usr/include/linux/cuda.h
rsync -avz --progress /usr/include/unicode/icudataver.h     $host:/usr/include/unicode/icudataver.h
rsync -avz --progress /usr/lib/i386-linux-gnu/libcuda.*     $host:/usr/lib/i386-linux-gnu/
rsync -avz --progress /usr/lib/x86_64-linux-gnu/libcuda.*     $host:/usr/lib/x86_64-linux-gnu/
rsync -avz --progress /usr/lib/x86_64-linux-gnu/libicudata.*    $host:/usr/lib/x86_64-linux-gnu/
rsync -avz --progress /usr/local/cuda     $host:/usr/local/cuda
rsync -avz --progress /usr/local/cuda-10.0     $host:/usr/local/
rsync -avz --progress /usr/local/lib/libcudart.so.10.0     $host:/usr/local/lib/libcudart.so.10.0
rsync -avz --progress /usr/src/linux-headers-4.15.0-101/include/linux/cuda.h     $host:/usr/src/linux-headers-4.15.0-101/include/linux/cuda.h
rsync -avz --progress /usr/src/linux-headers-4.15.0-101/include/uapi/linux/cuda.h     $host:/usr/src/linux-headers-4.15.0-101/include/uapi/linux/cuda.h
rsync -avz --progress /usr/src/linux-headers-5.3.0-51/include/linux/cuda.h     $host:/usr/src/linux-headers-5.3.0-51/include/linux/cuda.h
rsync -avz --progress /usr/src/linux-headers-5.3.0-51/include/uapi/linux/cuda.h     $host:/usr/src/linux-headers-5.3.0-51/include/uapi/linux/cuda.h
rsync -avz --progress /usr/src/linux-headers-5.3.0-53/include/linux/cuda.h     $host:/usr/src/linux-headers-5.3.0-53/include/linux/cuda.h
rsync -avz --progress /usr/src/linux-headers-5.3.0-53/include/uapi/linux/cuda.h     $host:/usr/src/linux-headers-5.3.0-53/include/uapi/linux/cuda.h



