# Use a base image with the necessary dependencies
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY ./UserService/app/requirements.txt /app/UserService/requirements.txt
COPY ./CourseService/app/requirements.txt /app/CourseService/requirements.txt
COPY ./CourseRegistration/app/requirements.txt /app/CourseRegistration/requirements.txt

# Install dependencies for each service
RUN pip install --no-cache-dir --upgrade -r /app/UserService/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/CourseService/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/CourseRegistration/requirements.txt

# Copy the application code for each service into the container
COPY ./UserService/app/service /app/UserService/service
COPY ./CourseService/app/service /app/CourseService/service
COPY ./CourseRegistration/app/service /app/CourseRegistration/service

# Expose ports if needed
# EXPOSE 8080  # Adjust the port based on your application

# Define an entry point (this might vary based on your specific requirements)
CMD ["uvicorn", "UserService.app.service.userservice.py:app", "--host", "0.0.0.0", "--port", "80"]
