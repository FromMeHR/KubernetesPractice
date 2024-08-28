FROM python:3.11-slim

ARG DJANGO_ENV

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    bash \
    build-essential \
    curl \
    libpq-dev \
  && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && useradd -m appuser

USER appuser

ENV DJANGO_ENV=${DJANGO_ENV} \
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_NO_CACHE_DIR=off

WORKDIR /project

COPY --chown=appuser:appuser requirements.txt /project/

RUN pip install --upgrade pip \
  && pip install -r requirements.txt

COPY --chown=appuser:appuser app /project/app

ENV PYTHONPATH="/app"

WORKDIR /project/app

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]