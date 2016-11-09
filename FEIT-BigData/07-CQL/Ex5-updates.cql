USE songbrowser;

/** Update song title */
UPDATE songs_by_albums SET song_title = 'Soldier Side (Intro)' 
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET song_title = 'Soldier Side (Intro)' 
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Update song track number */
UPDATE songs_by_albums SET track_no = 11
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET track_no = 11
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Update song album */
UPDATE songs_by_albums SET album_title = 'Mez'
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET album_title = 'Mez'
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Update song artist */
UPDATE songs_by_albums SET artist = 'SOAD'
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET artist = 'SOAD'
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Add song a performer */
UPDATE songs_by_albums SET performers = performers + ['Rubin']
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET performers = performers + ['Rubin']
WHERE id = ... AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';


