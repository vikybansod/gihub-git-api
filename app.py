from flask import Flask, jsonify
import requests

app = Flask(__name__)

GITHUB_API = "https://api.github.com/users/{user}/gists"


@app.route("/", methods=["GET"])
def index():
    return jsonify({
        "message": "GitHub Gists API",
        "usage": "GET /<username>",
        "example": "/octocat",
        "description": "Returns a list of publicly available GitHub gists for the given user"
    }), 200


@app.route("/<username>", methods=["GET"])
def get_gists(username):
    response = requests.get(GITHUB_API.format(user=username), timeout=5)

    if response.status_code != 200:
        return jsonify({"error": "User not found"}), 404

    gists = response.json()
    return jsonify([
        {
            "id": gist["id"],
            "url": gist["html_url"],
            "description": gist["description"]
        }
        for gist in gists
    ]), 200