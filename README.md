# BoardGame App

## Overview
BoardGame App is a web-based application that allows users to browse, create, and manage board games. The project is built using Node.js and is designed to be easily deployed and scalable.

## Features
- User-friendly interface for managing board games.
- RESTful API for game data management.
- Containerized for easy deployment.
- CI/CD pipeline with Jenkins for automated deployment.
- Future updates will include Terraform and Ansible for infrastructure automation.

## Technologies Used
- Node.js (Backend)
- Docker (Containerization)
- Jenkins (CI/CD Automation)
- GitHub (Version Control)
- Terraform & Ansible (Planned for future updates)

## Installation & Running the Project
You can run the project locally using Docker without Docker Compose.

### Steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/EslamMOsman/boardgame-app.git
   cd boardgame-app
   ```

2. Build the Docker image:
   ```bash
   docker build -t eslammagdy/boardgame-app:v1 .
   ```

3. Run the container:
   ```bash
   docker run -d -p 4040:4040 eslammagdy/boardgame-app:v1
   ```

4. The app will be available at `http://localhost:4040`.

## Running the Project with Jenkins
The project can also be deployed using Jenkins by configuring a pipeline with a `Jenkinsfile`. Jenkins will automate the build and deployment process.

## Future Enhancements
- **Terraform & Ansible:** Infrastructure as Code (IaC) tools will be integrated to manage cloud resources and automate deployment.
- **Additional Features:** More functionalities will be added to enhance the user experience.

Stay tuned for more updates! 🚀

