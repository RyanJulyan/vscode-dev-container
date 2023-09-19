#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Update Homebrew
echo "Updating Homebrew"
brew update

# Install Docker if not installed
if ! command -v docker &>/dev/null; then
    echo "Docker not found. Installing..."
    brew install --cask docker
else
    echo "Docker is already installed."
fi

# Install Docker Compose if not installed
if ! command -v docker-compose &>/dev/null; then
    echo "Docker Compose not found. Installing..."
    brew install docker-compose
else
    echo "Docker Compose is already installed."
fi

# Install XQuartz
if ! brew list --cask xquartz &>/dev/null; then
    echo "Installing XQuartz..."
    brew install --cask xquartz
else
    echo "XQuartz is already installed."
fi

# Open XQuartz to configure settings
open -a XQuartz

# Step 1: Install XQuartz (Manual Step)
echo ""
echo "Please make sure XQuartz is installed. It should have automaically installed. If it did not You can download it from https://www.xquartz.org/"
read -p "Press enter to continue"

# Step 2: Configure XQuartz
echo ""
echo "Configuring XQuartz..."
defaults write org.macosforge.xquartz.X11 enable_auth 1

# Step 3: Restart XQuartz (Manual Step)
# Reminder for steps that can't be automated
echo ""
echo "Please make sure you've configured XQuartz:"
echo ""
echo "1. Open XQuartz and go to XQuartz -> Preferences -> Input."
echo "2. Check the option 'Follow system keyboard layout'."
echo ""
echo "1. Open XQuartz and go to XQuartz -> Preferences -> Security."
echo "2. Check the option 'Allow connections from network clients'."
echo "3. Restart XQuartz to apply the changes."
echo ""
read -p "Press enter to continue after you've restarted XQuartz"

# Step 4: Allow local machine to connect to XQuartz
echo ""
echo "Allowing local machine to connect to XQuartz..."
xhost + 127.0.0.1

# Step 5: Get your IP
IP=$(ipconfig getifaddr en0)
echo "Your IP address is $IP"

# Step 6   : Run Docker Compose
echo "Running Docker Compose..."
docker-compose up --build --detach

# Step 7   : Install Extensions
# Install Standard Extensions
echo "Install Standard Extensions"
docker exec -it vscode-container code --install-extension eamodio.gitlens --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension Gruntfuggly.todo-tree --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension streetsidesoftware.code-spell-checker --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-vscode-remote.vscode-remote-extensionpack --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-azuretools.vscode-docker --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension SonarSource.sonarlint-vscode --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode
echo ""

# Install Python Extensions
echo "Install Python Extensions"
docker exec -it vscode-container code --install-extension ms-python.python --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-python.black-formatter --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-python.flake8 --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-python.mypy-type-checker --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension njpwerner.autodocstring --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension tamasfe.even-better-toml --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-toolsai.datawrangler --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode
echo ""

# Step 8   : Run VSCode
echo "Running VSCode"
docker exec -it vscode-container code --no-sandbox --user-data-dir=/root/.vscode --extensions-dir /root/.vscode/extensions

# Done
echo ""
echo "Setup complete. You should now be able to access VS Code in the Docker container."
