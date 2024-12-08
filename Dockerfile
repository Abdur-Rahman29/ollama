# Start with the official Python image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Streamlit app and entrypoint script into the container
COPY . /app

# Install system dependencies and curl for Ollama installation
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama CLI
RUN curl -sSL https://ollama.com/install.sh | bash

# Install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Create a user with non-root permissions
RUN useradd -m appuser

# Give full access to the /app directory for the appuser
RUN chown -R appuser:appuser /app
RUN chmod -R 755 /app  # This ensures appuser has read, write, and execute permissions

# Create the necessary directories for Ollama and give appuser full access
RUN mkdir -p /app/.ollama && chown -R appuser:appuser /app/.ollama

# Copy the entrypoint.sh script and make it executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Switch to the non-root user for running the app
USER appuser

# Expose the port that Streamlit runs on
EXPOSE 8501

# Set entrypoint to run entrypoint.sh
ENTRYPOINT ["/bin/bash","/app/entrypoint.sh"]
# Start with the official Python image
# FROM python:3.12-slim

# # Set the working directory inside the container
# WORKDIR /app

# # Copy the Streamlit app and entrypoint script into the container
# COPY . /app

# # Install system dependencies and curl for Ollama installation
# RUN apt-get update && apt-get install -y \
#     curl \
#     && rm -rf /var/lib/apt/lists/*

# # Install Ollama CLI
# RUN curl -sSL https://ollama.com/install.sh | bash

# # Install Python dependencies
# COPY requirements.txt /app/requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Create a user with non-root permissions
# RUN useradd -m appuser

# # Create the necessary directories for Ollama under /app/.ollama and set permissions
# # Set the ownership to appuser
# RUN chown -R appuser:appuser /app

# # Set permissions so that only the owner (appuser) has full access, and others can read/execute
# RUN chmod -R 755 /app

# RUN mkdir -p /app/.ollama 


# # Set environment variable for Ollama directory
# ENV OLLAMA_HOME=/app/.ollama

# # Copy the entrypoint.sh script and make it executable
# COPY entrypoint.sh /app/entrypoint.sh
# RUN chmod +x /app/entrypoint.sh

# # Switch to the non-root user for running the app
# USER appuser

# # Expose the port that Streamlit runs on
# EXPOSE 8501

# # Set entrypoint to run entrypoint.sh using bash explicitly
# ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]



