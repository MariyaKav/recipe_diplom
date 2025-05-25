FROM python:3.12

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY my_site/. .

RUN python manage.py migrate --noinput
RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "recipe_project.wsgi:application", "--bind", "0.0.0.0:8000"]
