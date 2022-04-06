-- this adds necessary tables to postgres database for the shiny app (see https://github.com/nmanich/eBird_to_postgreSQL for the full database)

-- *** This makes a new table to join the checklist url to the database 
CREATE TABLE url (
sampling_event_identifier VARCHAR(50) UNIQUE NOT NULL PRIMARY KEY,
checklistlink VARCHAR(110));

-- *** This adds a table to display the block names
CREATE TABLE bnm (
atlas_block VARCHAR(10) NOT NULL UNIQUE PRIMARY KEY,
block_name VARCHAR(100));


-- *** This loads the 2 new tables with data
COPY URL FROM 'C:\Users\nicho\Desktop\Jan2022Database\subids_with_url.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY BNM FROM 'C:\Users\nicho\Desktop\Jan2022Database\blocknames.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';



-- *** This queries the database to produce the output file for the shiny script to use
 
SET CLIENT_ENCODING TO 'utf8';

COPY (
SELECT  

obs.common_name,	
obs.observation_count,	
sub.observation_date,	
obs.breeding_code,	
obs.breeding_category,	
bnm.block_name,	
loc.locality,	
obs.approved,	
url.checklistlink,	
usr.last_name,
usr.first_name,
sub.duration_minutes,
sub.effort_distance_km,
sub.project_code,
obs.global_unique_identifier


FROM      obs LEFT JOIN sub
            ON obs.sampling_event_identifier = sub.sampling_event_identifier          
              LEFT JOIN loc
            ON sub.locality_id = loc.locality_id
   	          LEFT JOIN usr
            ON sub.observer_id = usr.observer_id          
             LEFT JOIN url
            ON sub.sampling_event_identifier = url.sampling_event_identifier
             LEFT JOIN bnm
            ON loc.atlas_block = bnm.atlas_block
)

TO 'C:\Users\nicho\Desktop\Jan2022Database\dataforshiny.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');





