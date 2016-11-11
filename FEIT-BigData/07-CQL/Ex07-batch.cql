USE songbrowser;

/** Prepare: add some albums: */
INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Nightwish', 1998, 'Oceanborn', 'Finland', 'Metal', 'Spineform') IF NOT EXISTS;

INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('P.O.D.', 2001, 'Satellite', 'USA', 'Nu Metal', 'Atlantic') IF NOT EXISTS;

INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('R.E.M.', 1988, 'Green', 'USA', 'Rock', 'Sub Pop') IF NOT EXISTS;

/** Add 3 Nightwish albums if Oceanborn (1998) is not added. */
BEGIN BATCH
  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Nightwish', 1998, 'Oceanborn', 'Finland', 'Metal', 'Spineform') IF NOT EXISTS;

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Nightwish', 1997, 'Angels Fall First', 'Finland', 'Metal', 'Spineform');

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Nightwish', 2000, 'Wishmaster', 'Finland', 'Metal', 'Spineform');

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Nightwish', 2002, 'Century Child', 'Finland', 'Metal', 'Spineform');
APPLY BATCH;

/** Add 3 P.O.D. albums if Satellite (2001) is not added. */
BEGIN BATCH 
  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('P.O.D.', 2001, 'Satellite', 'USA', 'Nu Metal', 'Atlantic') IF NOT EXISTS;

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('P.O.D.', 1993, 'Snuff the Punk', 'USA', 'Nu Metal', 'Atlantic');

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('P.O.D.', 1996, 'Brown', 'USA', 'Nu Metal', 'Atlantic');

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('P.O.D.', 2006, 'Testify', 'USA', 'Nu Metal', 'Atlantic');

APPLY BATCH;

/** Add 3 different artists' albums if R.E.M. - Green (1988) is not present. */
BEGIN BATCH 
  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('R.E.M.', 1988, 'Green', 'USA', 'Rock', 'Sub Pop') IF NOT EXISTS;

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Slipknot', 1997, 'Iowa', 'USA', 'Metal', 'Roadrunner');

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Nirvana', 1993, 'In Utero', 'USA', 'Grunge', 'DGC');

  INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label)
  VALUES ('Heart', 1977, 'Little Queen', 'USA', 'Rock', 'Portrait');
APPLY BATCH;

