# MCP-Bridge for Louis

This directory contains the configuration for [MCP-Bridge](https://github.com/SecretiveShell/MCP-Bridge), a middleware that provides an OpenAI-compatible endpoint capable of calling MCP tools.

## Configuration

The `config.json` file is mounted into the container and sets up:

1. Connection to the LiteLLM inference server
2. Integration with the GPT Researcher MCP service
3. Network and logging settings

## Usage

MCP-Bridge exposes its OpenAI-compatible API on port 8080, which the Open WebUI can connect to for accessing MCP tools.

## Customization

To add more MCP tools or modify the configuration, edit the `config.json` file. See the [MCP-Bridge documentation](https://github.com/SecretiveShell/MCP-Bridge) for more details on the available configuration options. 