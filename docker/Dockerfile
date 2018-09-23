FROM python:3.6

RUN mkdir -p /usr/src/matlab \
    && apt-get update \
    && apt-get install -y  zip \
    && apt-get install -y unzip

RUN cd  /usr/src/matlab \
    && wget -O matlab.zip "http://ssd.mathworks.com/supportfiles/downloads/R2018b/deployment_files/R2018b/installers/glnxa64/MCR_R2018b_glnxa64_installer.zip" \
    && unzip matlab.zip \
    && ./install -mode silent -agreeToLicense yes -destinationFolder /usr/local \
    && mv /usr/local/v95/bin/glnxa64/libexpat.so.1 /usr/local/v95/bin/glnxa64/libexpat.so.1.NOFIND # BUG
    

ENV PATH /usr/local/v95:$PATH
ENV LD_LIBRARY_PATH /usr/local/v95/runtime/glnxa64:/usr/local/v95/bin/glnxa64:/usr/local/v95/sys/os/glnxa64:/usr/local/v95/extern/bin/glnxa64:$LD_LIBRARY_PATH
CMD ["/bin/bash"]
