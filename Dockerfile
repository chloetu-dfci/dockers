FROM ubuntu:18.04
RUN apt-get -y update
RUN apt-get -y upgrade

# Essentials
RUN apt-get update && apt-get install software-properties-common -y  && \
apt-get update && apt-get install build-essential git samtools ca-certificates python3 zlib1g-dev libgsl-dev libboost-iostreams-dev libncurses5-dev libbz2-dev liblzma-dev curl wget -y
		
# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Install zip + unzip
RUN apt-get update && \
    apt-get install zip unzip

# Install MixCR
RUN wget --no-check-certificate -P opt/ https://github.com/milaboratory/mixcr/releases/download/v4.3.2/mixcr-4.3.2.zip
RUN unzip opt/mixcr-4.3.2.zip -d opt
RUN chmod 777 opt/mixcr.jar
RUN rm opt/mixcr-4.3.2.zip

RUN echo 'alias mixcr="java -jar opt/mixcr.jar"' >> ~/.bashrc

# Install requirements for IgCaller
RUN apt-get update && \
    apt-get install -y python3-setuptools && \
    apt-get install -y python3-pip

RUN pip3 install --upgrade pip && \
    pip3 install statistics regex argparse==1.1 numpy==1.19.5 scipy==1.5.4

# Install IgCaller
RUN cd / && \
    git clone https://github.com/ferrannadeu/IgCaller && \
    chmod 777 IgCaller/IgCaller

ENV PATH=/IgCaller/:${PATH}

# Install packages for sequence extraction task
RUN pip3 install --upgrade pip && \
    pip3 install pandas biopython

RUN echo 'alias pip="pip3"' >> ~/.bashrc


