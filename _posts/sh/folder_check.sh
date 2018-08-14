for i in 0 1 2 3 4 5
do
    folder="/data/${i}/"
    for line in `ls $folder`
    do
        filename="$folder${line}/0"

        filesize=`ls $filename |wc -l`
        maxsize=0
        if [ $filesize -gt $maxsize ]
        then
            #echo "$filesize > $maxsize"
            echo "$line" `ls -m $filename`
        #else
            #echo "$filesize < $maxsize"
            #echo ''
        fi
    done
done
