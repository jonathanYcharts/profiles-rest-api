#!/usr/bin/env bash

set -e

# TODO: Set to URL of git repo.
PROJECT_GIT_URL='https://github.com/jonathanYcharts/profiles-rest-api.git'

PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'

# Set Ubuntu Language
locale-gen en_GB.UTF-8

# Install Python, SQLite, and required packages
echo "Installing dependencies..."
apt-get update
apt-get install -y python3-dev python3-venv sqlite3 python3-pip supervisor nginx git build-essential libssl-dev

# Create project directory and clone the repo
mkdir -p $PROJECT_BASE_PATH
git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH

# Set up Python virtual environment
python3 -m venv $PROJECT_BASE_PATH/env

# Upgrade pip, setuptools, and wheel
echo "Upgrading pip, setuptools, and wheel..."
$PROJECT_BASE_PATH/env/bin/pip install --upgrade pip setuptools wheel

# Install project dependencies, including uWSGI
echo "Installing project dependencies..."
$PROJECT_BASE_PATH/env/bin/pip install -r $PROJECT_BASE_PATH/requirements.txt uwsgi==2.0.21

# Run database migrations
echo "Running migrations..."
$PROJECT_BASE_PATH/env/bin/python $PROJECT_BASE_PATH/manage.py migrate

# Set up Supervisor to manage uWSGI process
echo "Configuring Supervisor..."
cp $PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf /etc/supervisor/conf.d/profiles_api.conf
supervisorctl reread
supervisorctl update
supervisorctl restart profiles_api

# Set up Nginx to serve the application
echo "Configuring Nginx..."
cp $PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf /etc/nginx/sites-available/profiles_api.conf
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/profiles_api.conf /etc/nginx/sites-enabled/profiles_api.conf
systemctl restart nginx.service

echo "DONE! :)"
