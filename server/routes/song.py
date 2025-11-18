import uuid
import cloudinary
import cloudinary.uploader
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session
from database import get_db
from dotenv import load_dotenv
import os
from sqlalchemy.orm import joinedload
from middleware.auth_middleware import auth_middleware
from models.favourite import Favourite
from models.song import Song
from pydantic_schemas.favourite_song import FavouriteSong

router = APIRouter()
load_dotenv() 

api_key = os.getenv("API_KEY")
cloudinary.config( 
    cloud_name = "dsdi7m7gk", 
    api_key = "321752287526271", 
    api_secret = api_key,
    secure=True
)

@router.post("/upload",status_code=201)
async def upload_song(song: UploadFile = File(...),
                thumbnail:UploadFile = File(...),
                artist: str = Form(...),
                song_name: str = Form(...),
                hex_code:str = Form(...),
                db: Session = Depends(get_db)):
    
    song_id = str(uuid.uuid4())
    
    song_result = cloudinary.uploader.upload(
        song.file,
        folder=f'songs/{song_id}',
        public_id='song',
        resource_type='auto'
    )

    thumbnail_result = cloudinary.uploader.upload(
        thumbnail.file,
        folder=f'songs/{song_id}',
        public_id='thumbnail',
        resource_type='image'
    )

    new_song = Song(
        id = song_id,
        song_name = song_name,
        artist = artist,
        hex_code = hex_code,
        song_url = song_result['url'],
        thumbnail_url = thumbnail_result['url']
    )
    
    db.add(new_song)
    db.commit()
    db.refresh(new_song)

    return new_song


@router.get('/list')
def list_songs(db: Session=Depends(get_db),auth_details=Depends(auth_middleware)):
    songs = db.query(Song).all()
    return songs


@router.post('/favourite')
def favourite_song(song:FavouriteSong,db:Session=Depends(get_db),auth_details=Depends(auth_middleware)):
    user_id = auth_details['uid']

    fav_song = db.query(Favourite).filter(Favourite.song_id == song.song_id,Favourite.user_id == user_id).first()

    if fav_song:
        db.delete(fav_song)
        db.commit()
        return {'message': False}
    else:
        new_fav = Favourite(id = str(uuid.uuid4()),song_id=song.song_id,user_id=user_id)
        db.add(new_fav)
        db.commit()
        return {'message': True}
    

@router.get('/list/favourites')
def list_songs(db: Session=Depends(get_db),auth_details=Depends(auth_middleware)):
    user_id = auth_details['uid']
    fav_song = db.query(Favourite).filter(Favourite.user_id == user_id).options(
        joinedload(Favourite.song)
    ).all()
    return fav_song