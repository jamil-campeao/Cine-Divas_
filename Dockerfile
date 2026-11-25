FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DB_PATH=/app/dados/banco_sistema.db

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn

COPY . .
RUN mkdir -p /app/dados

EXPOSE 5000

# Cria/atualiza o banco (o iniciar_bd.py não duplica nada) e sobe o servidor.
CMD ["sh", "-c", "python iniciar_bd.py && exec gunicorn --bind 0.0.0.0:5000 --workers 2 --access-logfile - run:app"]
