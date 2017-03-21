USE songbrowser;

/** Create aggregate functions. */
CREATE OR REPLACE FUNCTION diffState (state tuple<int, int>, val int) 
CALLED ON NULL INPUT RETURNS tuple<int, int> LANGUAGE java AS 
  'if(val != null) { 
    state.setInt(0, Math.min(val, state.getInt(0))); 
    state.setInt(1, Math.max(val, state.getInt(1))); 
  } return state;';

CREATE OR REPLACE FUNCTION diffFinal (state tuple<int, int>) 
CALLED ON NULL INPUT RETURNS int LANGUAGE java AS 
  'return state.getInt(1) - state.getInt(0);';

/** Create aggregate - 9999 should be enough for release_year range,
 *  but for real data INT.MINVALUE or alike should be used. */
CREATE OR REPLACE AGGREGATE diff(int) 
SFUNC diffState STYPE tuple<int, int> 
FINALFUNC diffFinal INITCOND (9000, -9000);

/** Test function. No partition key, since we have too little data. */
SELECT diff(release_year) FROM albums;
