# vscode-dev-container
Automated Development Environment Setup: Seamlessly set up a Dockerized Visual Studio Code environment with X11 on Linux using XQuartz on macOS. Ideal for developers looking to standardize their development environments across teams.

# Structure:
```
└── `vscode-dev-container`
    ├── vscode_data
    │     └── .gitkeep
    │          └── public
    │               └── public_list.html
    ├── workspace
    │     ├── .gitkeep
    │     └── .vscode
    │          └── settings.json
    ├── docker-compose.yml
    ├── Dockerfile
    ├── LICENSE
    ├── linux_setup_vscode_docker.sh
    ├── mac_setup_vscode_docker.sh
    └── README.md
```
`vscode_data` is a linked volume and where VSCode will be installed. This helps keep state
`workspace` is a linked volume and where you can start developing.
It is suggested that you clone your repos into `workspace` making multiple projects accessable in your workspace

The `workspace > .vscode > settings.json` is in place for a consistent IDE environment. if you need different settings for each project, consider using it as a base by copying `workspace > .vscode` to your own project e.g. `workspace > my_own_project > .vscode ` and adjust the `settings.json` acordingly.

# Installation

## Mac

### Give give `mac_setup_vscode_docker.sh` execute permissions
```shell
chmod +x mac_setup_vscode_docker.sh
```

### Run the script
```shell
./mac_setup_vscode_docker.sh
```

## Linux

### Give give `linux_setup_vscode_docker.sh` execute permissions
```shell
chmod +x linux_setup_vscode_docker.sh
```

### Run the script
```shell
./mac_setup_vscode_docker.sh
```

## Windows

