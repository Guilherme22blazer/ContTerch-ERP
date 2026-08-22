FROM python:3.12-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    SIMPLESCALC_HOST=0.0.0.0 \
    SIMPLESCALC_PORT=4173 \
    GESTAOFISCAL_NO_BROWSER=1 \
    CONTTECH_PRODUCTION=1

WORKDIR /app

COPY app/requirements.txt ./requirements.txt
RUN python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir -r requirements.txt

COPY app/ ./
RUN python -m py_compile server.py

EXPOSE 4173

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD python -c "import json,urllib.request; assert json.load(urllib.request.urlopen('http://127.0.0.1:4173/api/health', timeout=4))['ok']" || exit 1

CMD ["python", "server.py"]
