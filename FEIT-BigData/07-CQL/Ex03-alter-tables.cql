USE songbrowser;

/** Add CountryRecorded column */
ALTER TABLE albums ADD country_recorded VARCHAR;

/** Remove Producer column */
ALTER TABLE albums DROP producer;
/** Remove Artist column */
ALTER TABLE albums DROP artist;

/** Add UDT for Producer column */
CREATE TYPE ProducerData (
  symbol        TEXT,
  name          TEXT,
  country_code  TEXT  
);

/** Add Producer column to Albums table */
ALTER TABLE albums ADD producer ProducerData;
