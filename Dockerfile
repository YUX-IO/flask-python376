FROM python:3.7.6-slim

LABEL maintainer="XIAO Yu <yu.xiao.fr@gmail.com>"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir meinheld gunicorn flask

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

ONBUILD COPY . /app
ONBUILD RUN pip install --no-cache-dir -r requirements.txt
WORKDIR /app/

ENV PYTHONPATH=/app

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/start.sh"]