FROM ubuntu

RUN apt-get update -y -q

RUN apt-get install -y -q python-setuptools
RUN easy_install pip

RUN apt-get install -y -q python-yaml
RUN apt-get install -y -q python-tz
RUN apt-get install -y -q python-requests
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q python-dev
RUN apt-get install -y -q expect-dev
RUN apt-get install -y -q locate
RUN apt-get install -y -q wget
RUN apt-get install -y -q curl
RUN apt-get install -y -q git
RUN apt-get install -y -q ack-grep
RUN apt-get install -y -q libncurses-dev
RUN apt-get install -y -q python-pocketsphinx
RUN apt-get install -y -q python-yaml
RUN apt-get install -y -q python-tz
RUN apt-get install -y -q python-requests
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q python-pyaudio
RUN apt-get install -y -q openjdk-7-jre-headless

RUN pip install --upgrade httpie

ADD lein /usr/local/bin/lein
RUN chmod 755 /usr/local/bin/lein
RUN LEINROOT=true lein

WORKDIR /

RUN git clone https://github.com/jasperproject/jasper-client.git

#sudo pip install -r jasper-client/client/requirements.txt
RUN pip install APScheduler CherryPy PyYAML Pykka RPi.GPIO argparse beautifulsoup4 facebook-sdk feedparser numpy pifacedigitalio --allow-external pygame python-dateutil python-mpd pytz quantities semantic six ws4py wsgiref requests sphinx

WORKDIR /jasper-client/client
RUN sed -i'.bak' 's/from apscheduler.scheduler import Scheduler/from apscheduler.schedulers.blocking import BlockingScheduler/' notifier.py

# To generate script.exp run 'python autoexpect populate.py'
# You will probably have to edit the script.exp to fix multiple glitches.  I've had horrible
# luck with the output of autoexpect against populate.py in docker.  I don't know where
# the problem lies. If only there were more hours in the day.
ADD script.exp /jasper-client/client/script.exp
RUN chmod 755 /jasper-client/client/script.exp

RUN ./script.exp

##############################
#### PUT NEW STUFF HERE ######

## replace me


####################################################################
# NONE SHALL PASS!
# Don't touch anything below this unless you know what you're doing.

RUN updatedb

#CMD ["python", "main.py"]
