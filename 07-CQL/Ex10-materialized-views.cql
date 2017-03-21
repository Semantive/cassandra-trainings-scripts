USE songbrowser;

/** 9 albums_by_release_year materialized view */
CREATE MATERIALIZED VIEW IF NOT EXISTS albums_by_release_year
AS SELECT album_title, artist, genre, record_label, release_year
FROM albums
WHERE artist IS NOT NULL and release_year IS NOT NULL and album_title IS NOT NULL
PRIMARY KEY (release_year, artist, album_title);