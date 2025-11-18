from models.base import dec_base
from sqlalchemy import LargeBinary, TEXT ,Column ,VARCHAR
from sqlalchemy.orm import relationship 

class User(dec_base):
    __tablename__ = 'users'
    
    id =Column(TEXT,primary_key=True)
    name = Column(VARCHAR(100),)
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)


    favourites = relationship("Favourite",back_populates="user")