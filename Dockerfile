# Use an official Python runtime as a parent image
FROM python:3.11

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install TA-Lib
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
&& tar -xzf ta-lib-0.4.0-src.tar.gz \
&& cd ta-lib/ \
&& ./configure --prefix=/usr \
&& make \
&& make install \
&& cd .. \
&& pip install TA-Lib

# Install Uvicorn and FastAPI
RUN pip install uvicorn fastapi

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py with Uvicorn when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
