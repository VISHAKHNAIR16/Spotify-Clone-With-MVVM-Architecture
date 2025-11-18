
import uuid
import bcrypt
from fastapi import HTTPException, Header
from middleware.auth_middleware import auth_middleware
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from fastapi import Depends
from database import get_db
from sqlalchemy.orm import Session
import jwt
from sqlalchemy.orm import joinedload
from pydantic_schemas.user_login import UserLogin


router = APIRouter()


@router.post("/signup",status_code=201)
def signup_user(user: UserCreate,db: Session=Depends(get_db)):


    #extract the data coming from the request...(Specifically the body fields)
    #check if the user already exists in the database from the user
    # if user is not in db add the user into the db 
    
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(status_code=400,detail="user already exists!")
    

    hashed_pw = bcrypt.hashpw(user.password.encode(),salt=bcrypt.gensalt())
    user_db = User(id=str(uuid.uuid4()),name=user.name,email=user.email,password=hashed_pw)

    db.add(user_db)


    db.commit()

    db.refresh(instance=user_db)

    return user_db




@router.post('/login')
def login_user(user: UserLogin,db:Session= Depends(get_db)):

    user_db = db.query(User).filter(User.email == user.email).first()


    if not user_db:
        raise HTTPException(400,detail="User Does Not Exist!!")
    


    is_match = bcrypt.checkpw(user.password.encode(),user_db.password)


    if not is_match:
        raise HTTPException(400,"Incorrect Password")
    

    token = jwt.encode({'id':user_db.id},'password_key')


    return {'token': token,'user':user_db}    


@router.get("/")
def current_user_data(db: Session = Depends(get_db),user_dict= Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).options(
        joinedload(User.favourites)
    ).first()

    if not user:
        raise HTTPException(404,"User not Found")

    return user