USE songbrowser;

/** 2.1 Albums table */
CREATE TABLE IF NOT EXISTS albums (
  id             UUID,
  album_title    VARCHAR,
  artist         VARCHAR,
  genre          VARCHAR,
  producer       VARCHAR,
  record_label   VARCHAR,
  release_year   INT,
  PRIMARY KEY ((artist), release_year, album_title, id)
);

/** 2.2 Songs by album table */
CREATE TABLE IF NOT EXISTS songs_by_albums (
  id             UUID,
  album_title    VARCHAR,
  artist         VARCHAR,
  genre          VARCHAR,
  performers     LIST<VARCHAR>,
  release_year   INT,
  song_title     VARCHAR,
  track_no       INT,
  PRIMARY KEY ((release_year, album_title), track_no, id)
);

/** 2.3 Songs by artist table */
CREATE TABLE IF NOT EXISTS songs_by_artists (
  id             UUID,
  album_title    VARCHAR,
  artist         VARCHAR,
  genre          VARCHAR,
  performers     LIST<VARCHAR>,
  release_year   INT,
  song_title     VARCHAR,
  track_no       INT,
  PRIMARY KEY ((artist), release_year, album_title, track_no, id)
);

