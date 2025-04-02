# Louis Project

This repository contains the Louis project, which is built on top of Open WebUI.

## Structure

- `open-webui/` - Submodule containing the Open WebUI project
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
```

## Custom Configurations

Custom configurations and extensions specific to the Louis project should be stored in this repository outside the submodule.
