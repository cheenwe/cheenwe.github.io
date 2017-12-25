The most important thing for storage is to keep data safe and not losing them. It gives you a comfort of thought that your data is safely backup.

However, we do not want to always copy the whole data files over. We want to do it incrementally.

"weed backup" command is your friend.

Run "weed backup" command on any machine that have enough disk spaces. Assuming we want to backup volume 5.

    weed backup -server=master:port -dir=. -volumeId=5

If local volume 5 does not exist, it will be created. All remote needle entries are fetched and compared to local needle entries. The delta is calculated and local missing files are fetched from the volume server.

If you specify -volumeId=87, but volume 87 does not exist, it's ok. No files will be created locally. This gives the opportunity that you can create a backup script simply looping from 1 to 100. All existing volumes will be backed up. The non-existing volumes can also be backed up when they are created remotely.

The backup scripts is just one command, not a continuous running service though. High Availability servers will be added later.
