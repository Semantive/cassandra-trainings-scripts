USE songbrowser;

/** Update song title */
UPDATE songs_by_albums SET song_title = 'Soldier Side (Intro)' 
WHERE id = 08634794-c526-4c6a-8f0e-832319651315 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET song_title = 'Soldier Side (Intro)' 
WHERE id = c6ca5434-86ac-4c4a-aa66-4feac34777d5 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Update song track number */
UPDATE songs_by_albums SET track_no = 11
WHERE id = 08634794-c526-4c6a-8f0e-832319651315 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET track_no = 11
WHERE id = c6ca5434-86ac-4c4a-aa66-4feac34777d5 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Update song album */
UPDATE songs_by_albums SET album_title = 'Mez'
WHERE id = 08634794-c526-4c6a-8f0e-832319651315 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET album_title = 'Mez'
WHERE id = c6ca5434-86ac-4c4a-aa66-4feac34777d5 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Update song artist */
UPDATE songs_by_albums SET artist = 'SOAD'
WHERE id = 08634794-c526-4c6a-8f0e-832319651315 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET artist = 'SOAD'
WHERE id = c6ca5434-86ac-4c4a-aa66-4feac34777d5 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';

/** Add song a performer */
UPDATE songs_by_albums SET performers = performers + ['Rubin']
WHERE id = 08634794-c526-4c6a-8f0e-832319651315 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1;

UPDATE songs_by_artists SET performers = performers + ['Rubin']
WHERE id = c6ca5434-86ac-4c4a-aa66-4feac34777d5 AND release_year = 2005 AND album_title = 'Mezmerize' AND track_no = 1 AND artist = 'System of a Down';


