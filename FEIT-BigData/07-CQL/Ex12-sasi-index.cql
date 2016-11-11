/** This Exercise requires C* >= 3.4 */
USE songbrowser;

/** Create SASIIndex - PREFIX on column 'genre' */
CREATE CUSTOM INDEX album_genre ON albums (genre) USING 'org.apache.cassandra.index.sasi.SASIIndex';

/** Select album by genre */
SELECT * FROM albums WHERE genre = 'Funk';

/** Create SASIIndex - CONTAINS on column 'genre' */
CREATE CUSTOM INDEX album_genre_partial ON albums (genre) USING 'org.apache.cassandra.index.sasi.SASIIndex'
  WITH OPTIONS = { 'mode': 'CONTAINS' };

/** Select album by any part of the genre name */
SELECT * FROM albums WHERE genre LIKE '%rock%';
