USE songbrowser;

/** Albums */
INSERT INTO albums (artist, release_year, album_title, id, country_recorded, genre, record_label)
VALUES ('Red Hot Chili Peppers', 2002, 'By the Way', uuid(), 'USA', 'Funk', 'WMG');

INSERT INTO albums (artist, release_year, album_title, id, country_recorded, genre, record_label)
VALUES ('System of a Down', 2005, 'Hypnotize', uuid(), 'USA', 'Hard rock', 'American');

INSERT INTO albums (artist, release_year, album_title, id, country_recorded, genre, record_label)
VALUES ('System of a Down', 2005, 'Mezmerize', uuid(), 'USA', 'Hard rock', 'American');

/** Songs by album */
INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 1, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Mezmerize', 2, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'BYOB');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Mezmerize', 3, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Revenga');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Mezmerize', 4, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Cigaro');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Mezmerize', 1, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Hypnotize', 2, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Attack');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Hypnotize', 3, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Dreaming');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2002, 'By the Way', 1, uuid(), 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'By the Way');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 2, uuid(), 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'Universally Speaking');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 3, uuid(), 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'This Is the Place');

/** Songs by artist */
INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 1, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 2, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'BYOB');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 3, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Revenga');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 4, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Cigaro');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 1, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Hypnotize', 2, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Attack');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Hypnotize', 3, uuid(), 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Dreaming');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 1, uuid(), 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'By the Way');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 2, uuid(), 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'Universally Speaking');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 3, uuid(), 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'This Is the Place');


