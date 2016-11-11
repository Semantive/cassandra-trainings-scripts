USE songbrowser;

/** Albums */
INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label, producer)
VALUES ('Red Hot Chili Peppers', 2002, 'By the Way', 'USA', 'Funk', 'WMG', { symbol: 'WMG', name: 'Warner Music Group', country_code: 'US' });

INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label, producer)
VALUES ('System of a Down', 2005, 'Hypnotize', 'USA', 'Hard rock', 'American', { symbol: 'AR', name: 'American Records', country_code: 'US' });

INSERT INTO albums (artist, release_year, album_title, country_recorded, genre, record_label, producer)
VALUES ('System of a Down', 2005, 'Mezmerize', 'USA', 'Hard rock', 'American', { symbol: 'AR', name: 'American Records', country_code: 'US' });

/** Songs by album */
INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 1, 08634794-c526-4c6a-8f0e-832319651315, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Mezmerize', 2, 3b9fefc5-1e39-4dd4-ae8d-bdd134481181, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'BYOB');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Mezmerize', 3, ceb5b455-b04d-4ea2-aea4-a50426c508eb, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Revenga');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Mezmerize', 4, 57f1d137-a7f1-4428-aa68-de1f7701423d, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Cigaro');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Hypnotize', 1, c2658427-dfc3-4e96-9b5c-c78434fc5c13, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Hypnotize', 2, 10ba9e1b-a656-4c0d-81a5-3c8747000bf9, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Attack');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2005, 'Hypnotize', 3, 2c02feae-f7ac-4a26-8710-e3dff53ea207, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Dreaming');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title) 
VALUES (2002, 'By the Way', 1, 8df9993d-7909-478a-883b-356255af75a3, 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'By the Way');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 2, 0ad03f1b-6328-4e62-982f-e1a084bab866, 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'Universally Speaking');

INSERT INTO songs_by_albums (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 3, 320c35ad-fc51-40b9-9f45-d751c407fa4b, 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'This Is the Place');

/** Songs by artist */
INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 1, c6ca5434-86ac-4c4a-aa66-4feac34777d5, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 2, a54845cd-1a4a-4ca3-9e4b-5f30a499349d, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'BYOB');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 3, f92ff845-8f73-4573-b3a0-a7ade596fcf2, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Revenga');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Mezmerize', 4, 18de83c1-ef7c-418a-8d25-f26be95163c7, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Cigaro');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Hypnotize', 1, 9ff16600-6b4a-4b80-9a02-f9d6bae5b064, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Soldier Side');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Hypnotize', 2, e18376dd-1f9c-4cb3-8048-2f6d305c0f37, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Attack');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2005, 'Hypnotize', 3, 9bb3866a-8972-4bee-a1c3-123bc81de030, 'System of a Down', 'Hard rock', ['Tankian', 'Malakian', 'Odadjian', 'Dolmayan'], 'Dreaming');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 1, fb75df6a-f529-4f41-a390-22c1046d28c2, 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'By the Way');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 2, c2f469ba-b480-4b7b-9012-b7f303b4ffc4, 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'Universally Speaking');

INSERT INTO songs_by_artists (release_year, album_title, track_no, id, artist, genre, performers, song_title)
VALUES (2002, 'By the Way', 3, 0b41e4d0-ac12-4cbb-b3de-75733ef91b05, 'Red Hot Chili Peppers', 'Funk', ['Kiedis', 'Frusciante', 'Flea', 'Smith'], 'This Is the Place');


