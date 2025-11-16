# app.py
from fastapi import FastAPI
from routes import auth
from models.base import dec_base
from database import engine


app = FastAPI()

app.include_router(auth.router,prefix="/auth")

dec_base.metadata.create_all(engine)







