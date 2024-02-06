FROM python:3-alpine

RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

WORKDIR /opt/redwarden

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 80 
COPY example-config.yaml config.yaml

# disable https because we would like to run behind a revers proxy by default
RUN sed -e '/.*443\/http/ s/^#*/#/' -i config.yaml
RUN sed -e '/.*ssl_ca/ s/^#*/#/' -i config.yaml

CMD [ "python", "./RedWarden.py", "-c", "config.yaml" ]                                                                                                                     
