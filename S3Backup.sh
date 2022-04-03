#!/bin/bash

export AWS_ACCESS_KEY_ID=<ACCESS KEY>
export AWS_SECRET_ACCESS_KEY=<SECRET ACCESS KEY>

DAY=`date +%Y-%m-%d`
LOGFILE='/backup/sys-backup/S3Live_Backup/backup.log'
EMAILID='admin@gmail.com'

sudo echo "******************** BACKUP STARTED ********************" &>> $LOGFILE
sudo date &>> $LOGFILE

sudo echo "****************** CREATING DIRECTORY ******************" &>> $LOGFILE
sudo mkdir /backup/sys-backup/S3Live_Backup/${DAY}
BACKUPDIR=/backup/sys-backup/S3Live_Backup/${DAY}

sudo echo "**************** DOWNLOADING S3 CONTENT ****************" &>> $LOGFILE
time sudo aws s3 cp s3://live-env-mum/ $BACKUPDIR --recursive | tee -a ${DAY}.txt

if [ $? -ne 0 ];
then
        sudo echo "**************** BACKUP FAILED ****************" &>> $LOGFILE
        sudo echo "Error occurred while processing S3 downloading, Exiting script." | mail -s "ERROR: Backup script while downloading s3 content" ${EMAILID}
        exit 1
fi

sudo echo "****************** DOWNLOAD COMPLETE *******************" &>> $LOGFILE
sudo echo "" &>> $LOGFILE
sudo echo "" &>> $LOGFILE
sudo echo "" &>> $LOGFILE
