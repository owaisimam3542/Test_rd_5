# Stage 1: Base image with Ubuntu + Ollama installed
FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && apt-get install -y curl gnupg python3 python3-pip git sudo

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Set Ollama to run in background later
ENV OLLAMA_MODELS=mistral

# Set work directory
WORKDIR /app

# Copy app code
COPY . /app

# Install Python packages
RUN pip install fastapi uvicorn python-multipart fitz PyMuPDF requests pydantic

# Expose FastAPI port
EXPOSE 8000

# Run both Ollama and FastAPI using bash
CMD bash -c "ollama serve & uvicorn main:app --host 0.0.0.0 --port 8000"