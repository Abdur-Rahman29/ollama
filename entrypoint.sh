#!/bin/bash
export OLLAMA_HOME=/app/.ollama

# Start the Ollama API in the background
ollama start &

# Wait a few seconds for the API to fully start
sleep 10

# Pull the Llama model (this will download the model if not already present)
ollama pull llama3.1

# Run the Streamlit app
streamlit run python.py
#!/bin/bash

# #!/bin/bash
# export OLLAMA_HOME=/app/.ollama

# # Start the Ollama API in the background
# ollama start &

# # Wait for Ollama API to become available
# until curl -s http://localhost:5005; do
#   echo "Waiting for Ollama API to start..."
#   sleep 2
# done

# # Pull the Llama model (this will download the model if not already present)
# ollama pull llama3.1

# # Run the Streamlit app
# streamlit run python.py
