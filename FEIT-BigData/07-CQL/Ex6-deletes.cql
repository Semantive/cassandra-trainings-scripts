USE songbrowser;

/** Delete a song */
DELETE FROM songs_by_albums  
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

DELETE FROM songs_by_artists
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Delete a song genre */
DELETE genre FROM songs_by_albums
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 2;

DELETE genre songs_by_artists
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 2 AND artist = 'System of a Down';

/** Delete artist from a song */
DELETE artist FROM songs_by_albums                  
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 3;

DELETE artist songs_by_artists                  
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 3 AND artist = 'System of a Down';

