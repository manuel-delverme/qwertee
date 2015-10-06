qwertee(){
    OLDIFS=$IFS
    IFS=$'\n'
    for URL in $(curl --silent https://www.qwertee.com/ | tr -d "\n" | tr -s ' ' | sed 's/</\n</g' | awk -F\  '/dynamic-image-design/ || /dynamic-image-colour/ {print $0}' | head -n 6);
    do
        if [[ $URL == *"design"* ]]
        then
            URI=$(echo $URL | tr ' ' '\n')
            SRC=https:$(echo $URI | grep src | tr -d \" | sed 's/^src=//')
            #MARGIN-TOP=$(echo $URI | grep margin-top | sed "s/.*://" | sed "s
            #MARGIN-LEFT=$(echo $URI | grep margin-left | sed "s/.*://" | sed 
            #WIDTH=$(echo $URI | grep wdith | sed "s/.*://" | sed "s/%.*//")

            FILENAME=/tmp/tee__NAMESPACE__$RANDOM.png
            wget --quiet -O $FILENAME $SRC
            #montage $FILENAME -texture $FILECOLUR -geometry '$(WIDTH)x-$(MARG
            img2txt -W $(tput cols) $FILENAME | less
            rm $FILENAME
            #rm $FILEDESIGN
        else
            #FILECOLOUR=/tmp/colour__NAMESPACE__$RANDOM.png
            #wget --quiet -O $FILECOLOUR https:$URL
        fi
    done
    IFS=$OLDIFS
}
