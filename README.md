GitHub Gists API Service

A simple Python-based HTTP API that fetches public GitHub Gists for a given user.
The service is containerized using Docker, uses Gunicorn for production serving, includes automated tests, and exposes a health check.

Note: As a Infrastructure Consultant/Devops Engineer, I have taken the hepl of Gen AI to write down the test cases.

🚀 Features
	•	HTTP API to fetch public GitHub gists
	•	Endpoint format: GET /<username>
	•	Uses GitHub public REST API
	•	Built with Flask
	•	Served via Gunicorn
	•	Automated tests using pytest
	•	Multi-stage Docker build
	•	Runs as a non-root user
	•	Exposes port 8080
	•	Docker HEALTHCHECK enabled

Project Structure
.
├── app.py              # Flask application
├── test_app.py         # Automated tests
├── requirements.txt    # Python dependencies
├── Dockerfile          # Multi-stage Docker build
└── README.md           # Project documentation


🐳 Docker
Build the Docker image
	•	docker build -t github-gists-api .

Run the container (background mode)
	•	docker run -p 8080:8080 --rm --name gists-api github-gists-api

Verify the service
	•	curl http://localhost:8080/
	•	curl http://localhost:8080/octocat


📌 Requirements
	•	Docker
	•	Internet access (for GitHub API calls)