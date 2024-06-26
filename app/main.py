from fastapi import FastAPI, HTTPException, Depends, Path, Body
from sqlalchemy.orm import Session
from datetime import date, datetime
from . import models, schemas
from .database import engine, get_db

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.put("/hello/{username}", status_code=204)
async def save_user_data(
    username: str = Path(..., pattern="^[a-zA-Z]+$"),
    user_data: schemas.UserCreate = Body(...),
    db: Session = Depends(get_db),
):
    today = date.today()
    if user_data.date_of_birth > today:
        raise HTTPException(status_code=400, detail="Date of birth must be in the past")

    db_user = db.query(models.User).filter(models.User.username == username).first()
    if db_user:
        db_user.date_of_birth = user_data.date_of_birth
    else:
        db_user = models.User(username=username, date_of_birth=user_data.date_of_birth)
        db.add(db_user)
    db.commit()
    return None

@app.get("/hello/{username}", response_model=schemas.BirthdayMessage)
async def get_birthday_message(username: str = Path(..., pattern="^[a-zA-Z]+$"), db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.username == username).first()
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")

    dob = db_user.date_of_birth
    today = date.today()
    next_birthday = datetime(today.year, dob.month, dob.day).date()

    if next_birthday < today:
        next_birthday = datetime(today.year + 1, dob.month, dob.day).date()

    days_until_birthday = (next_birthday - today).days

    if days_until_birthday == 0:
        message = f"Hello, {username}! Happy birthday!"
    else:
        message = f"Hello, {username}! Your birthday is in {days_until_birthday} day(s)"

    return {"message": message}
