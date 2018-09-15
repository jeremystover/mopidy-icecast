FROM resin/raspberrypi3-debian:jessie

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --force-yes \
        build-essential \
        gettext \
        gir1.2-gstreamer-1.0 \
        gir1.2-gst-plugins-base-1.0 \
        git \
        gstreamer1.0-alsa \
        gstreamer1.0-libav \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-tools \
        libasound2-dev \
        libssl-dev \
        libcurl4-gnutls-dev \
        libexpat1-dev \
	libffi-dev \
        python-dev \
        python-pip \
        python-gst-1.0 \
        unzip \
        wget

RUN wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
RUN sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list
RUN sudo apt-get update

RUN sudo apt-get install mopidy -y
RUN sudo apt-get install mopidy-spotify -y

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN sudo python get-pip.py
RUN pip install Mopidy-MusicBox-Webclient

EXPOSE 6680
EXPOSE 8000

RUN apt-get -qq -y install icecast2

RUN useradd -m pi
WORKDIR /home/pi

COPY icecast.xml .
COPY entrypoint.sh .
COPY mopidy.conf /root/.config/mopidy/
COPY ./mpd-spt-fix/ /home/pi/mpd-spt-fix/

RUN ["chmod", "+x", "/home/pi/entrypoint.sh"]
RUN chown nobody entrypoint.sh

RUN touch /var/log/icecast2/error.log
RUN touch /var/log/icecast2/access.log
RUN chown nobody /var/log/icecast2/error.log
RUN chown nobody /var/log/icecast2/access.log

#ENTRYPOINT ["/home/pi/entrypoint.sh", "${SPOTIFY_USER}",${SPOTIFY_PASS}]

#CMD mopidy", " -o audio/mixer=software -o audio/output='lamemp3enc ! shout2send mount=mopidy.mp3 ip=0.0.0.0 port=8000 password=G3sdgDTajbND1Cp' -o musicbox/enabled=true -o ",  "echo 'spotify/username='${SPOTIFY_USER}", "echo '-o spotify/password='${SPOTIFY_PASS}", "-o http/hostname=0.0.0.0 -o mpd/hostname=0.0.0.0 -o local/enabled=false"]
