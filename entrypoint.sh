#!/bin/sh

icecast2 -b -c icecast.xml

echo "username = "$1 >> /root/.config/mopidy/mopidy.conf
echo "password = "$2 >> /root/.config/mopidy/mopidy.conf
echo "client_id = "$3 >> /root/.config/mopidy/mopidy.conf
echo "client_secret = "$4 >> /root/.config/mopidy/mopidy.conf
eval echo ~$USER

#pip install https://github.com/mopidy/mopidy-spotify/archive/feature/oauth.zip --upgrade
#sudo apt-get install curl unzip
#curl -LO https://github.com/mopidy/mopidy-spotify/archive/feature/oauth.zip
#unzip oauth.zip
#cp mopidy-spotify-feature-oauth/mopidy_spotify/* /usr/lib/python2.7/dist-packages/mopidy_spotify/


#mopidy -o audio/mixer=software -o audio/output='lamemp3enc ! shout2send mount=mopidy.mp3 ip=0.0.0.0 port=8000 password=G3sdgDTajbND1Cp' -o musicbox/enabled=true -o spotify/username=$1 -o spotify/password=$2 -o http/hostname=0.0.0.0 -o mpd/hostname=0.0.0.0 -o local/enabled=false

cd /home/pi/mpd-spt-fix/
sudo python2 setup.py build install

mopidy

tail -f /dev/null

# Hand off to the CMD
#exec "$@"
