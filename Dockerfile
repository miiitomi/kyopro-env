FROM ubuntu:latest

COPY requirements.txt .

RUN apt-get update && \
    apt-get install -y git time libboost-all-dev python3-pip && \
    pip3 install --upgrade pip && pip3 install -r requirements.txt && \
    apt-get clean && rm -rf /var/lib/apt/lists/* requirements.txt
