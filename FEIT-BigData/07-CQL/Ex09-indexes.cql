USE songbrowser;

/** Create index on Genre on songs_by_artists */
CREATE INDEX ON songs_by_artists (genre);

/** Select songs by genre */
SELECT * FROM songs_by_artists WHERE genre = 'Funk';

/** Select songs by genre and artist */
SELECT * FROM songs_by_artists WHERE genre = 'Funk' AND artist = 'Red Hot Chili Peppers';
