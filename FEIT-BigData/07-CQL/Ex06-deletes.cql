USE songbrowser;

/** Delete a song */
DELETE FROM songs_by_albums  
WHERE id = 08634794-c526-4c6a-8f0e-832319651315 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

DELETE FROM songs_by_artists
WHERE id = c6ca5434-86ac-4c4a-aa66-4feac34777d5 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Delete a song genre */
DELETE genre FROM songs_by_albums
WHERE id = 3b9fefc5-1e39-4dd4-ae8d-bdd134481181 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 2;

DELETE genre FROM songs_by_artists
WHERE id = a54845cd-1a4a-4ca3-9e4b-5f30a499349d AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 2 AND artist = 'System of a Down';

/** Delete artist from a song */
DELETE artist FROM songs_by_albums                  
WHERE id = ceb5b455-b04d-4ea2-aea4-a50426c508eb AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 3;

DELETE artist FROM songs_by_artists                  
WHERE id = f92ff845-8f73-4573-b3a0-a7ade596fcf2 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 3 AND artist = 'System of a Down';

