#!/bin/bash

# Step 1: Update Package List
echo "Updating package list..."
sudo apt-get update

# Step 2: Install Docker if not installed
if ! command -v docker &>/dev/null; then
    echo "Docker not found. Installing..."
    sudo apt-get install -y docker.io
else
    echo "Docker is already installed."
fi

# Step 3: Install Docker Compose if not installed
if ! command -v docker-compose &>/dev/null; then
    echo "Docker Compose not found. Installing..."
    sudo apt-get install -y docker-compose
else
    echo "Docker Compose is already installed."
fi

# Step 4: Install X11 if not installed
if ! dpkg -l | grep x11-apps &>/dev/null; then
    echo "X11 not found. Installing..."
    sudo apt-get install -y x11-apps
else
    echo "X11 is already installed."
fi

# Step 5: Allow local machine to connect to X11
echo "Allowing local machine to connect to X11..."
xhost +local:root

# Step 6: Run Docker Compose
echo "Running Docker Compose..."
docker-compose up --build --detach

# Step 7: Install Extensions
# Install Standard Extensions
echo "Installing Standard Extensions..."
docker exec -it vscode-container code --install-extension eamodio.gitlens --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension Gruntfuggly.todo-tree --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension streetsidesoftware.code-spell-checker --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-vscode-remote.vscode-remote-extensionpack --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension ms-azuretools.vscode-docker --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode && \
docker exec -it vscode-container code --install-extension SonarSource.sonarlint-vscode --extensions-dir /root/.vscode/extensions --no-sandbox --user-data-dir /root/.vscode
echo ""

# Install Python Extensions
echo "Installing Python Extensions..."
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
