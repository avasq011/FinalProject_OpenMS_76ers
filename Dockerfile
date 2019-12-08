FROM openms/contrib

WORKDIR /
RUN git clone --depth 1 https://github.com/avasq011/FinalProject_OpenMS_76ers.git -b master
RUN mkdir openms-build

WORKDIR /openms-build

RUN cmake -DOPENMS_CONTRIB_LIBS="/contrib-build" -DCMAKE_PREFIX_PATH="/usr;/usr/local" -DBOOST_USE_STATIC=OFF ../FinalProject_OpenMS_76ers
RUN make OpenMS

WORKDIR /openms-build

RUN make TOPP && make UTILS && rm -rf src doc CMakeFiles 

WORKDIR /
ENV PATH="/openms-build/bin/:${PATH}"