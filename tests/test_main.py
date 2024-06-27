import os
import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from datetime import date

from app.main import app, get_db
from app.models import Base

# Configure test database
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://user:password@localhost:5433/testdb")
engine = create_engine(DATABASE_URL)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create the database tables
Base.metadata.create_all(bind=engine)

# Dependency override
def override_get_db():
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()

app.dependency_overrides[get_db] = override_get_db

client = TestClient(app)

@pytest.fixture(scope="module")
def setup_database():
    # Initialize database with a clean slate
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)
    yield
    # Teardown the database after tests
    Base.metadata.drop_all(bind=engine)

def test_put_user():
    response = client.put("/hello/Alice", json={"date_of_birth": "1994-04-07"})
    assert response.status_code == 204

def test_update_birthdate():
    response = client.put("/hello/Alice", json={"date_of_birth": "1990-05-15"})
    assert response.status_code == 204

def test_wrong_date_format():
    response = client.put("/hello/Bob", json={"date_of_birth": "12-13-1897"})
    assert response.status_code == 422
    assert response.json()["detail"][0]["msg"] == "Input should be a valid date or datetime, invalid character in year"

def test_wrong_username_format():
    response = client.put("/hello/Tom123", json={"date_of_birth": "1991-03-14"})
    assert response.status_code == 422
    assert response.json()["detail"][0]["msg"] == "String should match pattern '^[a-zA-Z]+$'"

def test_put_user_invalid_date():
    response = client.put("/hello/Bob", json={"date_of_birth": "2099-04-07"})
    assert response.status_code == 400
    assert response.json() == {"detail": "Date of birth must be in the past"}

def test_get_user_birthday_message():
    client.put("/hello/Charlie", json={"date_of_birth": "1986-05-12"})
    response = client.get("/hello/Charlie")
    assert response.status_code == 200
    assert "Hello, Charlie!" in response.json()["message"]

def test_get_user_not_found():
    response = client.get("/hello/NonExistentUser")
    assert response.status_code == 404
    assert response.json() == {"detail": "User not found"}

def test_get_user_happy_birthday():
    # Set the date_of_birth to today's date to test the happy birthday message
    today = date.today().isoformat()
    client.put("/hello/Dave", json={"date_of_birth": today})
    response = client.get("/hello/Dave")
    assert response.status_code == 200
    assert response.json() == {"message": f"Hello, Dave! Happy birthday!"}
