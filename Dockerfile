# Use a base image with the necessary dependencies
FROM python:3.9
RUN pip install supervisor
# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY ./CourseRegistration/app/requirements.txt /app/requirements.txt

# Install dependencies for each service
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

# Copy the application code for each service into the container
COPY ./UserService/app/service /app/UserService/service
COPY ./CourseService/app/service /app/CourseService/service
COPY ./CourseRegistration/app/service /app/CourseRegistration/service

# Expose the ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./startup.sh /app/startup.sh
ENTRYPOINT ["bash", "/app/startup.sh"]
