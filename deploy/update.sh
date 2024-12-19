#!/usr/bin/env bash

set -e

PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'

# Activate the virtual environment
source $PROJECT_BASE_PATH/env/bin/activate

# Pull the latest changes from the repository
echo "Pulling latest changes..."
git -C $PROJECT_BASE_PATH pull

# Upgrade Django REST Framework and dependencies
echo "Upgrading dependencies..."
pip install --upgrade djangorestframework six

# Run database migrations
echo "Running migrations..."
python $PROJECT_BASE_PATH/manage.py migrate

# Collect static files
echo "Collecting static files..."
python $PROJECT_BASE_PATH/manage.py collectstatic --noinput

# Restart Supervisor
echo "Restarting Supervisor..."
supervisorctl restart profiles_api

echo "DONE! :)"