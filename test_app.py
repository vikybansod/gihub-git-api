from app import app

def test_octocat_gists():
    client = app.test_client()
    response = client.get("/octocat")

    assert response.status_code == 200
    data = response.get_json()

    assert isinstance(data, list)
    if data:
        assert "id" in data[0]
        assert "url" in data[0]
        assert "description" in data[0]