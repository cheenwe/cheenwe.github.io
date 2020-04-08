#!/usr/bin/python3
#coding = utf-8
#
# 通过 python 往 ActiveMQ 中发送消息
# pip install stompest

from stompest.config import StompConfig
from stompest.protocol import StompSpec
from stompest.sync import Stomp

queue_name = '/queue/test'
# queue_name = '/topics/test'
queue_url = 'tcp://192.168.70.71:61613'

config = StompConfig(queue_url, StompSpec.VERSION_1_0)
client = Stomp(config)
client.connect()

# 发送
def send_mq(msg="test"):
    client.send(queue_name, msg.encode(), {StompSpec.RECEIPT_HEADER: str(msg)})
    frame = client.receiveFrame()
    print('resp: %s' % frame.info())

send_mq("tes1t")

# client.disconnect()

# 接收端
client.subscribe(queue_name,
    {
        StompSpec.ACK_HEADER: StompSpec.ACK_CLIENT_INDIVIDUAL,
        StompSpec.ID_HEADER: '001',
        StompSpec.RECEIPT_HEADER: "R001"
    })

frame = client.receiveFrame()
print('recv: %s' % frame.info())

while True:
    frame = client.receiveFrame()
    print('recv: %s' % frame.info())
    client.ack(frame)

client.disconnect()
