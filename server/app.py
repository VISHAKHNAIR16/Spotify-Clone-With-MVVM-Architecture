# app.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import auth
from routes import song
from models.base import dec_base
from database import engine


app = FastAPI()

app.include_router(auth.router,prefix="/auth")
app.include_router(song.router,prefix="/song")


dec_base.metadata.create_all(engine)







