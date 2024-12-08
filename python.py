import streamlit as st
import subprocess

# Define a function to query the Llama model via Ollama CLI
def query_llama(prompt):
    try:
        result = subprocess.run(
            ['/usr/local/bin/ollama', 'run', 'llama3.1:latest', prompt],
            capture_output=True, text=True, check=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        return f"Error: {e.stderr}"

# Streamlit UI
st.title("Llama 3.1 Chatbot")
st.write("Enter your prompt below:")

# Textbox for the user to enter prompt
user_prompt = st.text_input("Your Prompt", value="")

if user_prompt:
    # Display loader while waiting for the model's response
    with st.spinner('Generating response...'):
        # Send the prompt to the model and get the response
        response = query_llama(user_prompt)
    
    # Display the model's response
    st.write("### Response:")
    st.write(response)
