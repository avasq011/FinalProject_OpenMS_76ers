FROM openms/contrib

WORKDIR /
RUN git clone --depth 1 https://github.com/avasq011/OpenMS.git -b master
RUN mkdir openms-build

WORKDIR /openms-build

RUN PATH=/openms-build/bin:$PATH

RUN apt-get update

RUN apt-get install libqt5opengl5-dev -y

RUN cmake -DOPENMS_CONTRIB_LIBS="/contrib-build" -DCMAKE_PREFIX_PATH="/usr;/usr/local" -DBOOST_USE_STATIC=OFF ../OpenMS

RUN make OpenMS

WORKDIR /openms-build

RUN make TOPP && make UTILS && rm -rf src doc CMakeFiles 

WORKDIR /

ENV PATH="/openms-build/bin/:${PATH}"