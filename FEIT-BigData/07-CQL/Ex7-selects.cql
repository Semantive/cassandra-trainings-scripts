USE songbrowser;

/** Select by artist */
SELECT * FROM songs_by_artists WHERE artist = 'System of a Down';

/** Select by artist and album */
SELECT * FROM songs_by_artists WHERE artist = 'System of a Down' AND album_title = 'Mezmerize';

/** Select by album and release year */
SELECT * FROM songs_by_albums WHERE release_year = 2005 AND album_title = 'Mezmerize';

/** Select by release year */
SELECT * FROM songs_by_albums WHERE release_year = 2005;
