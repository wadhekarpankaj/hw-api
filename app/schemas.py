from pydantic import BaseModel
from datetime import date

class UserCreate(BaseModel):
    date_of_birth: date

class BirthdayMessage(BaseModel):
    message: str
