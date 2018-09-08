FROM shaunmulligan/rpi3-jessie-mopidy

ENV SPOTIFY_USER=''
ENV SPOTIFY_PASS=''

EXPOSE 6680
EXPOSE 8000

RUN apt-get update
RUN apt-get -qq -y install icecast2
RUN pip install Mopidy-MusicBox-Webclient

COPY icecast.xml .
RUN touch /var/log/icecast2/error.log
RUN touch /var/log/icecast2/access.log
RUN chown nobody /var/log/icecast2/error.log
RUN chown nobody /var/log/icecast2/access.log

CMD icecast2 -b -c icecast.xml  && mopidy -o audio/mixer=software -o audio/output='lamemp3enc ! shout2send mount=mopidy.mp3 ip=0.0.0.0 port=8000 password=G3sdgDTajbND1Cp' -o musicbox/enabled=true  -o spotify/username='$SPOTIFY_USER' -o spotify/password='$SPOTIFY_PASS' -o http/hostname=0.0.0.0 -o mpd/hostname=0.0.0.0 -o local/enabled=false
