#!/bin/bash

# MinIO  同服务器一样的目录  https://docs.min.io/cn/minio-docker-quickstart-guide.html
wget https://dl.min.io/server/minio/release/linux-amd64/minio

sudo chmod +x minio
sudo cp minio /usr/local/bin/

export MINIO_ACCESS_KEY=chenwei
export MINIO_SECRET_KEY=chenwei123
minio --config-dir /disk4/minio/config/chenwei server --address :9001 /disk4/data/chenwei &

export MINIO_ACCESS_KEY=user1
export MINIO_SECRET_KEY=123456789
minio --config-dir /disk4/minio/config/user1  server --address :9002 /disk4/data/user1 &

export MINIO_ACCESS_KEY=user2
export MINIO_SECRET_KEY=123456789
minio --config-dir  /disk4/minio/config/user2 server --address :9003 /disk4/data/user2 &

