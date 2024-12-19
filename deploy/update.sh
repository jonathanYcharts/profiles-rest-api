#!/usr/bin/env bash

set -e

PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'

# Ensure the virtual environment exists
if [ ! -d "$PROJECT_BASE_PATH/env" ]; then
    echo "Virtual environment not found! Creating it..."
    python3 -m venv $PROJECT_BASE_PATH/env
fi

# Activate the virtual environment
source $PROJECT_BASE_PATH/env/bin/activate

# Pull the latest changes from the repository
echo "Pulling latest changes..."
git -C $PROJECT_BASE_PATH pull

# Install or update dependencies
echo "Installing/updating dependencies..."
pip install --upgrade pip setuptools wheel
pip install -r $PROJECT_BASE_PATH/requirements.txt

# Run database migrations
echo "Running migrations..."
python $PROJECT_BASE_PATH/manage.py migrate

# Collect static files
echo "Collecting static files..."
python $PROJECT_BASE_PATH/manage.py collectstatic --noinput

# Restart Supervisor to apply changes
echo "Restarting Supervisor..."
supervisorctl restart profiles_api

echo "DONE! :)"
