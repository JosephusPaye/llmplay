# LLM Play

A space for playing with local LLMs and related tech (TTS engines, etc)

## Prereqs

Install Ollama and at least one model. On Mac I've installed the app directly via the DMG, as I prefer installing GUI apps not through docker. As of August 2025, Gemma 4B is a decent small model for testing purposes.

## Usage

1. Start with `./up.sh`. This will pull and create the containers and print the web URLs for connecting via the browser. When the Open WebUI container is started it should find and connect to Ollama automatically.

2. On first boot, connect Open WebUI with the Kokoro TTS container as follows:

(Instructions adapted from [Kokoro-FastAPI Using Docker](https://docs.openwebui.com/tutorials/text-to-speech/Kokoro-FastAPI-integration#setting-up-open-webui-to-use-kokoro-fastapi))

- Open the Admin Panel and go to Settings -> Audio
- Set TTS Settings to match the following:
  - Text-to-Speech Engine: `OpenAI`
  - API Base URL: `http://host.docker.internal:4101/v1` # may also use `localhost` if that works
  - API Key: `not-needed`
  - TTS Model: `kokoro`
  - TTS Voice: `af_bella` # also accepts mapping of existing OAI voices for compatibility

