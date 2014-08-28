FROM ubuntu

RUN apt-get update -y -q

RUN apt-get install -y -q python-setuptools
RUN easy_install pip

RUN apt-get install -y -q python-pocketsphinx
RUN apt-get install -y -q python-yaml
RUN apt-get install -y -q python-tz
RUN apt-get install -y -q python-requests
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q python-pyaudio
RUN apt-get install -y -q git
RUN apt-get install -y -q python-dev
RUN apt-get install -y -q expect-dev

WORKDIR /

RUN git clone https://github.com/jasperproject/jasper-client.git

#sudo pip install -r jasper-client/client/requirements.txt
RUN pip install APScheduler CherryPy PyYAML Pykka RPi.GPIO argparse beautifulsoup4 facebook-sdk feedparser numpy pifacedigitalio --allow-external pygame python-dateutil python-mpd pytz quantities semantic six ws4py wsgiref requests sphinx

WORKDIR /jasper-client/client
RUN sed -i'.bak' 's/from apscheduler.scheduler /from apscheduler.schedulers.blocking /' notifier.py

#RUN python populate.py
#RUN python main.py

ADD script.exp /jasper-client/client/script.exp
RUN chmod 755 /jasper-client/client/script.exp


