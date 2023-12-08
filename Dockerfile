FROM python:3.8-slim


ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update \
&& apt-get install -y --no-install-recommends build-essential

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt


COPY . /app
WORKDIR /app/

EXPOSE 5001

CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "--reload", "main:app"]