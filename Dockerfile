FROM ubuntu

RUN apt-get update -y -q

RUN apt-get install -y -q python-setuptools
RUN easy_install pip

RUN pip install --upgrade httpie

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
RUN apt-get install -y -q mercurial
RUN apt-get install -y -q ack-grep
RUN apt-get install -y -q libncurses-dev
RUN apt-get install -y -q python-pocketsphinx
RUN apt-get install -y -q python-yaml
RUN apt-get install -y -q python-tz
RUN apt-get install -y -q python-requests
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q python-pyaudio
RUN apt-get install -y -q openjdk-7-jre-headless
RUN apt-get install -y -q strace
RUN apt-get install -y -q man

WORKDIR /

RUN git clone https://github.com/jasperproject/jasper-client.git

RUN mkdir /src

WORKDIR /src

ADD fsmnlp-tutorial.tgz /src
WORKDIR /src/fsmnlp-tutorial

WORKDIR /src/fsmnlp-tutorial/3rdparty

RUN tar xf openfst-1.3.2.tar.gz
WORKDIR /src/fsmnlp-tutorial/3rdparty/openfst-1.3.2

RUN ./configure --enable-compact-fsts --enable-const-fsts --enable-far --enable-lookahead-fsts --enable-pdt
RUN make
RUN make install

WORKDIR /src/fsmnlp-tutorial/3rdparty

RUN tar xf opengrm-ngram-1.0.3.tar.gz

WORKDIR /src/fsmnlp-tutorial/3rdparty/opengrm-ngram-1.0.3/src/bin
RUN cp ngramrandgen.cc ngramrandgen.cc.orig
RUN cat ngramrandgen.cc.orig | awk 'NR==32{print "#include <sys/types.h>\n#include <unistd.h>\n"}1' > ngramrandgen.cc

WORKDIR /src/fsmnlp-tutorial/3rdparty/opengrm-ngram-1.0.3
RUN ./configure
RUN make
RUN make install

WORKDIR /src/fsmnlp-tutorial/src
RUN make

RUN ldconfig

WORKDIR /src/fsmnlp-tutorial/script
RUN mkdir -p toy

# RUN hg clone https://code.google.com/p/phonetisaurus -r 5431b8169d34

# ADD openfst-1.4.1.tar.gz /src

# # Maybe we need to peg to 1.0.3?
# ADD opengrm-ngram-1.2.1.tar.gz /src

# WORKDIR /src/openfst-1.4.1
# # RUN ./configure
# RUN ./configure --enable-compact-fsts --enable-const-fsts --enable-far --enable-lookahead-fsts --enable-pdt
# RUN make
# RUN make install

# WORKDIR /src/opengrm-ngram-1.2.1
# RUN ./configure
# RUN make
# RUN make install

# #WORKDIR /src/openfst-1.4.1/src/extensions
# #RUN make install

# #RUN cp -r /src/openfst-1.4.1/src/include/fst /usr/local/include

# WORKDIR /src/phonetisaurus/src

# RUN make -j 8

# # #WORKDIR /src/phonetisaurus
# # #RUN pip install -e .

# # #sudo pip install -r jasper-client/client/requirements.txt
# # RUN pip install APScheduler CherryPy PyYAML Pykka RPi.GPIO argparse beautifulsoup4 facebook-sdk feedparser numpy pifacedigitalio --allow-external pygame python-dateutil python-mpd pytz quantities semantic six ws4py wsgiref requests sphinx

ADD lein /usr/local/bin/lein
RUN chmod 755 /usr/local/bin/lein
RUN LEINROOT=true lein

# # WORKDIR /jasper-client/client
# # RUN sed -i'.bak' 's/from apscheduler.scheduler import Scheduler/from apscheduler.schedulers.blocking import BlockingScheduler/' notifier.py

# # # To generate script.exp run 'autoexpect python populate.py'
# # # You will probably have to edit the script.exp to fix multiple glitches.  I've had horrible
# # # luck with the output of autoexpect against populate.py in docker.  I don't know where
# # # the problem lies. If only there were more hours in the day.
# # ADD script.exp /jasper-client/client/script.exp
# # RUN chmod 755 /jasper-client/client/script.exp

# # RUN ./script.exp

# # ##############################
# # #### PUT NEW STUFF HERE ######

# # ## replace me


# ####################################################################
# # NONE SHALL PASS!
# # Don't touch anything below this unless you know what you're doing.

# RUN updatedb

# #CMD ["python", "main.py"]
