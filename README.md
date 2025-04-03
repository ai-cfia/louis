# Louis Project

This repository contains the Louis project, which is built on top of Open WebUI.

## Structure

- `open-webui/` - Submodule containing the Open WebUI project
- `deployment/mcp-bridge/` - MCP-Bridge configuration for connecting to MCP tools
- Custom configurations and extensions for Open WebUI

## Setup

1. Clone this repository with submodules:
   ```
   git clone --recurse-submodules https://github.com/ai-cfia/louis.git
   ```

2. Follow the setup instructions in the Open WebUI directory.

## Development

When working with this repository, remember that changes to the Open WebUI code should be done in the submodule. To update the Open WebUI submodule to the latest version:

```
cd open-webui
git pull origin main
cd ..
git add open-webui
git commit -m "Update Open WebUI submodule to latest version"
git push
```

## Custom Configurations

Custom configurations and extensions specific to the Louis project should be stored in this repository outside the submodule.

## Working with the Open WebUI Submodule

There are several approaches for managing customizations to the Open WebUI submodule:

### Approach 1: Fork and Customize the Submodule (Recommended)

1. **Fork the Open WebUI repository** on GitHub to your own account or organization
2. **Update the submodule to point to your fork**:
   ```bash
   git submodule set-url open-webui https://github.com/your-org/open-webui-fork.git
   ```
3. **Making changes to your fork**:
   ```bash
   # Navigate into the submodule
   cd open-webui
   
   # Create a branch for your customizations
   git checkout -b custom-features
   
   # Make changes, commit them
   git add .
   git commit -m "Add custom features"
   
   # Push to your fork
   git push origin custom-features
   ```
4. **Update the parent repository**:
   ```bash
   cd ..
   git add open-webui
   git commit -m "Update submodule to use custom branch"
   git push
   ```

### Approach 2: Branch Within the Submodule

1. **Navigate into the submodule**:
   ```bash
   cd open-webui
   ```
2. **Create a branch for your customizations**:
   ```bash
   git checkout -b custom-features
   ```
3. **Make changes, commit them locally**
4. **Reference the specific branch in your parent repository**

### Approach 3: Overlay Approach

1. Keep the original submodule intact (no changes)
2. Create custom code in the parent repository that extends/overrides functionality
3. Configure your application to load these customizations

For example:
- Create a `custom-extensions/` directory in your parent repo
- Set up Docker volumes to overlay your custom files
- Use environment variables to load your custom extensions

### Keeping Up with Upstream Changes

To incorporate updates from the original Open WebUI repository:

1. **Add the original repo as a remote in your submodule**:
   ```bash
   cd open-webui
   git remote add upstream https://github.com/open-webui/open-webui.git
   ```

2. **Fetch updates**:
   ```bash
   git fetch upstream
   ```

3. **Merge upstream changes into your branch**:
   ```bash
   git checkout custom-features
   git merge upstream/main
   # Resolve any conflicts
   git push origin custom-features
   ```

4. **Update the parent repository**:
   ```bash
   cd ..
   git add open-webui
   git commit -m "Update submodule with latest upstream changes"
   git push
   ```

## Container Images

This repository builds and pushes Docker images for the included submodules to GitHub Container Registry (GHCR). These images are built automatically when changes are made to the submodules.

Available images:
- `ghcr.io/ai-cfia/louis/gpt-researcher-mcp:louis-main` - The GPT Researcher MCP Server (custom build)
- `ghcr.io/ai-cfia/louis/litellm:louis-main` - The LiteLLM service
- `ghcr.io/ai-cfia/louis/open-webui:louis-main` - The Open WebUI service

Each image is tagged with:
- `louis-main` - Most recent build from main branch
- `louis-{commit}` - Tagged with the short commit hash of the submodule (e.g., `ghcr.io/ai-cfia/louis/gpt-researcher-mcp:louis-a1b2c3d`)

To pull an image:
```
docker pull ghcr.io/ai-cfia/louis/litellm:louis-main
```

To use these images in your deployment, update your docker-compose.yml to reference these pre-built images instead of building them locally.

## MCP Tools Integration

This project uses [MCP-Bridge](https://github.com/SecretiveShell/MCP-Bridge) to provide OpenAI API compatibility for MCP (Model Context Protocol) tools. MCP-Bridge connects to the GPT Researcher MCP server and makes these tools available through a standard OpenAI API endpoint.

The MCP-Bridge configuration is located in the `deployment/mcp-bridge` directory. See the README in that directory for more information on customizing the MCP-Bridge configuration.
