from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine


DATABASE_URL = 'postgresql://postgres:123456@localhost:5432/spotify'

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(autoflush=False,bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close() 



