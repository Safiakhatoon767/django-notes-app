# Use official Python runtime as base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app/backend

# Copy requirements file first to leverage Docker cache
COPY requirements.txt /app/backend

# Install system dependencies for MySQL client
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . /app/backend

# Expose port 8000 for the Django application
EXPOSE 8000

# Set the entrypoint to start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
