# Profiles REST API

Profiles REST API course code,

Steps to run python files on docker:
<!-- Run container -->
1. docker-compose up -d
<!-- Lists all running containers so you can se the names -->
2. docker ps
<!-- same as ssh of vagrant -->
3. docker exec -it profiles-rest-api-app-1 bash
<!-- Stop Container -->
4. docker-compose down

Steps for Python virtual env:
<!-- Create python virtual env -->
1. python -m venv ~/env
<!-- Activate virtual env. (env) prefix should appear -->
2. source ~/env/bin/activate
<!-- Deactivate virtual env -->
3. deactivate
<!-- Install venv requirements -->
4. pip install -r requirements.txt

Django:
<!-- Create project -->
1. django-admin.py startproject profiles_project .
<!-- Create app -->
2. python manage.py startapp profiles_api
<!-- 
You install apps in your django project by
adding them to the list variable in the settings.py file
INSTALLED_APPS
 -->
<!-- Start server inside (env) -->
3. python manage.py runserver 0.0.0.0:8000
4. Navigate to http://127.0.0.1:8000/

Super User:
jonathan@ycharts.com
Password123

Super User:
naydelin@ycharts.com
Password123