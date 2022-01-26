#!/usr/bin/env python3
import logging
import random

import spotipy
from spotipy.oauth2 import SpotifyOAuth


logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s][%(levelname)s][%(name)s] - %(message)s",
    datefmt="%Y-%m-%dT%H:%M:%S",
)
log = logging.getLogger("spotipy-bot")

SCOPE = 'user-library-read'

def extract_album(items: list) -> list:
    albums = []
    for item in items:
        album = item["album"]
        artists = [artist["name"] for artist in album["artists"]]
        albums.append({"artist": " // ".join(artists), "name": album["name"]})
    return albums

def get_albums(sp) -> list[dict]:
    albums = []
    log.info("Getting initial results")
    results = sp.current_user_saved_albums(limit=50)
    albums.extend(extract_album(results["items"]))
    while results["next"]:
        log.info(f"Getting {results['limit'] + results['offset']} of {results['total']}")
        results = sp.next(results)
        albums.extend(extract_album(results["items"]))
    return albums

def main():
    oauth = SpotifyOAuth(scope=SCOPE, cache_path=".cache-spotipy")
    sp = spotipy.Spotify(auth_manager=oauth)
    albums = get_albums(sp)
    log.info("Ready!")
    while input() == "":
        album = albums[random.randint(0, len(albums) - 1)]
        log.info(f"Next album: {album['artist']} | {album['name']}")

if __name__ == "__main__":
    main()
