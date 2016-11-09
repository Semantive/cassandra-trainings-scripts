USE songbrowser;

/** Add CountryRecorded column */
ALTER TABLE albums ADD country_recorded VARCHAR;

/** Remove Producer column */
ALTER TABLE albums DROP producer;
/** Remove Artist column */
ALTER TABLE albums DROP artist;
