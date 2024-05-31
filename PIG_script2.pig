--Load labels and gps_gpu_left data
pvs1_gps = LOAD '/user/hdfs/dataset_gps.csv' USING PigStorage(',') AS (timestamp: long, latitude: double, longitude: double, elevation: double, accuracy:double, bearing: double, speed_meters_per_second: double, satellites: int, provider: chararray, hdop: double, vdop: double, pdop: double, geoidheight: double, ageofdgpsdata: int, dgpsid: int, activity: chararray, battery: int, annotation: chararray, distance_meters: double, elapsed_time_seconds: long);

pvs1_gps_mpu_right = LOAD '/user/hdfs/dataset_gps_mpu_right.csv' USING PigStorage(',') AS (timestamp:long, acc_x_dashboard: double, acc_y_dashboard: double,	acc_z_dashboard:double, acc_x_above_suspension: double, acc_y_above_suspension: double,	acc_z_above_suspension: double,	acc_x_below_suspension: double,	acc_y_below_suspension: double,	acc_z_below_suspension: double,	gyro_x_dashboard: double, gyro_y_dashboard: double, gyro_z_dashboard: double, gyro_x_above_suspension: double, gyro_y_above_suspension: double,	gyro_z_above_suspension: double, gyro_x_below_suspension: double, gyro_y_below_suspension: double, gyro_z_below_suspension: double, mag_x_dashboard: double, mag_y_dashboard: double, mag_z_dashboard: double, mag_x_above_suspension: double,	mag_y_above_suspension: double,	mag_z_above_suspension: double,	temp_dashboard: double,	temp_above_suspension: double, temp_below_suspension: double, timestamp_gps: double, latitude: double, longitude: double, speed: double);

pvs1_labels = LOAD '/user/hdfs/dataset_labels.csv' USING PigStorage(',') AS (paved_road: int, unpaved_road: int,	dirt_road: int,	cobblestone_road: int, asphalt_road: int, no_speed_bump: int, speed_bump_asphalt: int, speed_bump_cobblestone: int, good_road_left: int, regular_road_left: int, bad_road_left: int, good_road_right: int, regular_road_right: int, bad_road_right: int);

-- Rank the rows in both datasets
ranked_gps = RANK pvs1_gps_mpu_right;
ranked_labels = RANK pvs1_labels;

-- Join the tables on the 'id' field
pvs1_right = JOIN ranked_gps BY $0, ranked_labels BY $0;

-- Rename table columns
final_pvs1_right = FOREACH pvs1_right GENERATE ranked_gps::rank_pvs1_gps_mpu_right AS rank_pvs1_gps_mpu_right, ranked_gps::timestamp AS timestamp,ranked_gps::acc_x_dashboard AS acc_x_dashboard,ranked_gps::acc_y_dashboard AS acc_y_dashboard, ranked_gps::acc_z_dashboard AS acc_z_dashboard, ranked_gps::acc_x_above_suspension AS acc_x_above_suspension, ranked_gps::acc_y_above_suspension AS acc_y_above_suspension, ranked_gps::acc_z_above_suspension AS acc_z_above_suspension , ranked_gps::acc_x_below_suspension AS acc_x_below_suspension, ranked_gps::acc_y_below_suspension AS acc_y_below_suspension,ranked_gps::acc_z_below_suspension AS acc_z_below_suspension,ranked_gps::gyro_x_dashboard AS gyro_x_dashboard, ranked_gps::gyro_y_dashboard AS gyro_y_dashboard, ranked_gps::gyro_z_dashboard AS gyro_z_dashboard, ranked_gps::gyro_x_above_suspension AS gyro_x_above_suspension,ranked_gps::gyro_y_above_suspension AS gyro_y_above_suspension, ranked_gps::gyro_z_above_suspension AS gyro_z_above_suspension, ranked_gps::gyro_x_below_suspension AS gyro_x_below_suspension, ranked_gps::gyro_y_below_suspension AS gyro_y_below_suspension, ranked_gps::gyro_z_below_suspension AS gyro_z_below_suspension,ranked_gps::mag_x_dashboard AS mag_x_dashboard,ranked_gps::mag_y_dashboard AS mag_y_dashboard, ranked_gps::mag_z_dashboard AS mag_z_dashboard, ranked_gps::mag_x_above_suspension AS mag_x_above_suspension, ranked_gps::mag_y_above_suspension AS mag_y_above_suspension, ranked_gps::mag_z_above_suspension AS mag_z_above_suspension, ranked_gps::temp_dashboard AS temp_dashboard, ranked_gps::temp_above_suspension AS temp_above_suspension, ranked_gps::temp_below_suspension AS temp_below_suspension, ranked_gps::timestamp_gps AS timestamp_gps, ranked_gps::latitude AS latitude,ranked_gps::longitude AS longitude,ranked_gps::speed AS speed, ranked_labels::rank_pvs1_labels AS rank_pvs1_labels , ranked_labels::paved_road AS paved_road, ranked_labels::unpaved_road AS unpaved_road, ranked_labels::dirt_road AS dirt_road, ranked_labels::cobblestone_road AS cobblestone_road, ranked_labels::asphalt_road AS asphalt_road , ranked_labels::no_speed_bump AS no_speed_bump, ranked_labels::speed_bump_asphalt AS speed_bump_asphalt, ranked_labels::speed_bump_cobblestone AS speed_bump_cobblestone, ranked_labels::good_road_left AS good_road_left, ranked_labels::regular_road_left AS regular_road_left, ranked_labels::bad_road_left AS bad_road_left, ranked_labels::good_road_right AS good_road_right, ranked_labels::regular_road_right AS regular_road_right, ranked_labels::bad_road_right AS bad_road_right;


--Filter data by surface condition
paved_road = FILTER final_pvs1_right BY paved_road == 1;
unpaved_road = FILTER final_pvs1_right BY unpaved_road == 1;
dirt_road = FILTER final_pvs1_right BY dirt_road == 1;
cobblestone_road = FILTER final_pvs1_right BY cobblestone_road == 1;
asphalt_road = FILTER final_pvs1_right BY asphalt_road == 1;
no_speed_bump = FILTER final_pvs1_right BY no_speed_bump == 1;
speed_bump_asphalt = FILTER final_pvs1_right BY speed_bump_asphalt == 1;
speed_bump_cobblestone= FILTER final_pvs1_right BY speed_bump_cobblestone == 1;
good_road_left = FILTER final_pvs1_right BY good_road_left == 1;
regular_road_left = FILTER final_pvs1_right BY regular_road_left == 1;
bad_road_left = FILTER final_pvs1_right BY bad_road_left == 1;
good_road_right = FILTER final_pvs1_right BY good_road_right == 1;
regular_road_right = FILTER final_pvs1_right BY regular_road_right == 1;
bad_road_right = FILTER final_pvs1_right BY bad_road_right== 1;

--Group the data
grouped_paved_road = GROUP paved_road all;
grouped_unpaved_road = GROUP unpaved_road all;
grouped_dirt_road = GROUP dirt_road all;
grouped_cobblestone_road = GROUP cobblestone_road all;
grouped_asphalt_road = GROUP asphalt_road all;
grouped_no_speed_bump = GROUP no_speed_bump all;
grouped_speed_bump_asphalt = GROUP speed_bump_asphalt all;
grouped_speed_bump_cobblestone = GROUP speed_bump_cobblestone all;
grouped_good_road_left = GROUP good_road_left all;
grouped_regular_road_left = GROUP regular_road_left all;
grouped_bad_road_left = GROUP bad_road_left all;
grouped_good_road_right = GROUP good_road_right all;
grouped_regular_road_right = GROUP regular_road_right all;
grouped_bad_road_right = GROUP bad_road_right all;

-- Aggegrate Data to get stastics
-- Calculate max, min, and mean for each sensor type

aggregated_paved_road = FOREACH grouped_paved_road GENERATE AVG(paved_road.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(paved_road.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(paved_road.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(paved_road.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(paved_road.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(paved_road.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(paved_road.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(paved_road.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(paved_road.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(paved_road.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(paved_road.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(paved_road.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(paved_road.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(paved_road.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(paved_road.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(paved_road.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(paved_road.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(paved_road.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(paved_road.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(paved_road.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(paved_road.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(paved_road.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(paved_road.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(paved_road.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(paved_road.temp_dashboard) AS mean_temp_dashboard, 
AVG(paved_road.temp_above_suspension) AS mean_temp_above_suspension, AVG(paved_road.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(paved_road.speed) AS mean_speed,'paved_road' AS road_type;

aggregated_unpaved_road = FOREACH grouped_unpaved_road GENERATE AVG(unpaved_road.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(unpaved_road.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(unpaved_road.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(unpaved_road.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(unpaved_road.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(unpaved_road.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(unpaved_road.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(unpaved_road.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(unpaved_road.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(unpaved_road.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(unpaved_road.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(unpaved_road.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(unpaved_road.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(unpaved_road.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(unpaved_road.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(unpaved_road.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(unpaved_road.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(unpaved_road.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(unpaved_road.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(unpaved_road.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(unpaved_road.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(unpaved_road.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(unpaved_road.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(unpaved_road.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(unpaved_road.temp_dashboard) AS mean_temp_dashboard, 
AVG(unpaved_road.temp_above_suspension) AS mean_temp_above_suspension, AVG(unpaved_road.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(unpaved_road.speed) AS mean_speed,'unpaved_road' AS road_type;

aggregated_dirt_road = FOREACH grouped_dirt_road GENERATE AVG(dirt_road.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(dirt_road.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(dirt_road.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(dirt_road.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(dirt_road.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(dirt_road.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(dirt_road.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(dirt_road.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(dirt_road.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(dirt_road.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(dirt_road.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(dirt_road.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(dirt_road.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(dirt_road.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(dirt_road.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(dirt_road.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(dirt_road.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(dirt_road.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(dirt_road.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(dirt_road.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(dirt_road.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(dirt_road.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(dirt_road.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(dirt_road.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(dirt_road.temp_dashboard) AS mean_temp_dashboard, 
AVG(dirt_road.temp_above_suspension) AS mean_temp_above_suspension, AVG(dirt_road.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(dirt_road.speed) AS mean_speed,'dirt_road' AS road_type;

aggregated_cobblestone_road = FOREACH grouped_cobblestone_road GENERATE AVG(cobblestone_road.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(cobblestone_road.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(cobblestone_road.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(cobblestone_road.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(cobblestone_road.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(cobblestone_road.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(cobblestone_road.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(cobblestone_road.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(cobblestone_road.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(cobblestone_road.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(cobblestone_road.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(cobblestone_road.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(cobblestone_road.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(cobblestone_road.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(cobblestone_road.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(cobblestone_road.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(cobblestone_road.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(cobblestone_road.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(cobblestone_road.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(cobblestone_road.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(cobblestone_road.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(cobblestone_road.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(cobblestone_road.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(cobblestone_road.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(cobblestone_road.temp_dashboard) AS mean_temp_dashboard, 
AVG(cobblestone_road.temp_above_suspension) AS mean_temp_above_suspension, AVG(cobblestone_road.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(cobblestone_road.speed) AS mean_speed,'cobblestone_road' AS road_type;

aggregated_asphalt_road = FOREACH grouped_asphalt_road GENERATE AVG(asphalt_road.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(asphalt_road.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(asphalt_road.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(asphalt_road.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(asphalt_road.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(asphalt_road.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(asphalt_road.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(asphalt_road.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(asphalt_road.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(asphalt_road.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(asphalt_road.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(asphalt_road.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(asphalt_road.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(asphalt_road.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(asphalt_road.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(asphalt_road.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(asphalt_road.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(asphalt_road.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(asphalt_road.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(asphalt_road.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(asphalt_road.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(asphalt_road.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(asphalt_road.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(asphalt_road.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(asphalt_road.temp_dashboard) AS mean_temp_dashboard, 
AVG(asphalt_road.temp_above_suspension) AS mean_temp_above_suspension, AVG(asphalt_road.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(asphalt_road.speed) AS mean_speed,'asphalt_road' AS road_type;

aggregated_no_speed_bump = FOREACH grouped_no_speed_bump GENERATE AVG(no_speed_bump.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(no_speed_bump.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(no_speed_bump.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(no_speed_bump.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(no_speed_bump.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(no_speed_bump.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(no_speed_bump.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(no_speed_bump.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(no_speed_bump.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(no_speed_bump.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(no_speed_bump.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(no_speed_bump.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(no_speed_bump.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(no_speed_bump.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(no_speed_bump.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(no_speed_bump.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(no_speed_bump.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(no_speed_bump.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(no_speed_bump.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(no_speed_bump.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(no_speed_bump.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(no_speed_bump.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(no_speed_bump.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(no_speed_bump.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(no_speed_bump.temp_dashboard) AS mean_temp_dashboard, 
AVG(no_speed_bump.temp_above_suspension) AS mean_temp_above_suspension, AVG(no_speed_bump.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(no_speed_bump.speed) AS mean_speed,'no_speed_bump' AS road_type;

aggregated_speed_bump_asphalt = FOREACH grouped_speed_bump_asphalt GENERATE AVG(speed_bump_asphalt.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(speed_bump_asphalt.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(speed_bump_asphalt.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(speed_bump_asphalt.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(speed_bump_asphalt.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(speed_bump_asphalt.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(speed_bump_asphalt.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(speed_bump_asphalt.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(speed_bump_asphalt.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(speed_bump_asphalt.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(speed_bump_asphalt.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(speed_bump_asphalt.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(speed_bump_asphalt.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(speed_bump_asphalt.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(speed_bump_asphalt.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(speed_bump_asphalt.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(speed_bump_asphalt.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(speed_bump_asphalt.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(speed_bump_asphalt.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(speed_bump_asphalt.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(speed_bump_asphalt.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(speed_bump_asphalt.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(speed_bump_asphalt.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(speed_bump_asphalt.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(speed_bump_asphalt.temp_dashboard) AS mean_temp_dashboard, 
AVG(speed_bump_asphalt.temp_above_suspension) AS mean_temp_above_suspension, AVG(speed_bump_asphalt.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(speed_bump_asphalt.speed) AS mean_speed,'speed_bump_asphalt' AS road_type;

aggregated_speed_bump_cobblestone = FOREACH grouped_speed_bump_cobblestone GENERATE AVG(speed_bump_cobblestone.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(speed_bump_cobblestone.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(speed_bump_cobblestone.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(speed_bump_cobblestone.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(speed_bump_cobblestone.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(speed_bump_cobblestone.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(speed_bump_cobblestone.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(speed_bump_cobblestone.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(speed_bump_cobblestone.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(speed_bump_cobblestone.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(speed_bump_cobblestone.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(speed_bump_cobblestone.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(speed_bump_cobblestone.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(speed_bump_cobblestone.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(speed_bump_cobblestone.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(speed_bump_cobblestone.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(speed_bump_cobblestone.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(speed_bump_cobblestone.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(speed_bump_cobblestone.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(speed_bump_cobblestone.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(speed_bump_cobblestone.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(speed_bump_cobblestone.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(speed_bump_cobblestone.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(speed_bump_cobblestone.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(speed_bump_cobblestone.temp_dashboard) AS mean_temp_dashboard, 
AVG(speed_bump_cobblestone.temp_above_suspension) AS mean_temp_above_suspension, AVG(speed_bump_cobblestone.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(speed_bump_cobblestone.speed) AS mean_speed,'speed_bump_cobblestone' AS road_type;

aggregated_good_road_left = FOREACH grouped_good_road_left GENERATE AVG(good_road_left.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(good_road_left.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(good_road_left.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(good_road_left.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(good_road_left.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(good_road_left.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(good_road_left.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(good_road_left.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(good_road_left.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(good_road_left.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(good_road_left.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(good_road_left.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(good_road_left.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(good_road_left.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(good_road_left.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(good_road_left.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(good_road_left.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(good_road_left.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(good_road_left.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(good_road_left.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(good_road_left.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(good_road_left.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(good_road_left.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(good_road_left.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(good_road_left.temp_dashboard) AS mean_temp_dashboard, 
AVG(good_road_left.temp_above_suspension) AS mean_temp_above_suspension, AVG(good_road_left.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(good_road_left.speed) AS mean_speed,'good_road_left' AS road_type;

aggregated_regular_road_left = FOREACH grouped_regular_road_left GENERATE AVG(regular_road_left.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(regular_road_left.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(regular_road_left.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(regular_road_left.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(regular_road_left.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(regular_road_left.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(regular_road_left.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(regular_road_left.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(regular_road_left.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(regular_road_left.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(regular_road_left.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(regular_road_left.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(regular_road_left.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(regular_road_left.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(regular_road_left.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(regular_road_left.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(regular_road_left.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(regular_road_left.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(regular_road_left.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(regular_road_left.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(regular_road_left.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(regular_road_left.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(regular_road_left.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(regular_road_left.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(regular_road_left.temp_dashboard) AS mean_temp_dashboard, 
AVG(regular_road_left.temp_above_suspension) AS mean_temp_above_suspension, AVG(regular_road_left.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(regular_road_left.speed) AS mean_speed,'regular_road_left' AS road_type;

aggregated_bad_road_left = FOREACH grouped_bad_road_left GENERATE AVG(bad_road_left.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(bad_road_left.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(bad_road_left.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(bad_road_left.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(bad_road_left.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(bad_road_left.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(bad_road_left.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(bad_road_left.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(bad_road_left.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(bad_road_left.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(bad_road_left.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(bad_road_left.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(bad_road_left.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(bad_road_left.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(bad_road_left.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(bad_road_left.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(bad_road_left.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(bad_road_left.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(bad_road_left.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(bad_road_left.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(bad_road_left.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(bad_road_left.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(bad_road_left.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(bad_road_left.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(bad_road_left.temp_dashboard) AS mean_temp_dashboard, 
AVG(bad_road_left.temp_above_suspension) AS mean_temp_above_suspension, AVG(bad_road_left.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(bad_road_left.speed) AS mean_speed,'bad_road_left' AS road_type;

aggregated_good_road_right = FOREACH grouped_good_road_right GENERATE AVG(good_road_right.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(good_road_right.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(good_road_right.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(good_road_right.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(good_road_right.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(good_road_right.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(good_road_right.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(good_road_right.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(good_road_right.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(good_road_right.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(good_road_right.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(good_road_right.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(good_road_right.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(good_road_right.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(good_road_right.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(good_road_right.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(good_road_right.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(good_road_right.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(good_road_right.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(good_road_right.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(good_road_right.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(good_road_right.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(good_road_right.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(good_road_right.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(good_road_right.temp_dashboard) AS mean_temp_dashboard, 
AVG(good_road_right.temp_above_suspension) AS mean_temp_above_suspension, AVG(good_road_right.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(good_road_right.speed) AS mean_speed,'good_road_right' AS road_type;

aggregated_regular_road_right = FOREACH grouped_regular_road_right GENERATE AVG(regular_road_right.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(regular_road_right.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(regular_road_right.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(regular_road_right.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(regular_road_right.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(regular_road_right.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(regular_road_right.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(regular_road_right.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(regular_road_right.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(regular_road_right.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(regular_road_right.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(regular_road_right.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(regular_road_right.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(regular_road_right.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(regular_road_right.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(regular_road_right.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(regular_road_right.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(regular_road_right.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(regular_road_right.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(regular_road_right.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(regular_road_right.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(regular_road_right.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(regular_road_right.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(regular_road_right.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(regular_road_right.temp_dashboard) AS mean_temp_dashboard, 
AVG(regular_road_right.temp_above_suspension) AS mean_temp_above_suspension, AVG(regular_road_right.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(regular_road_right.speed) AS mean_speed,'regular_road_right' AS road_type;

aggregated_bad_road_right = FOREACH grouped_bad_road_right GENERATE AVG(bad_road_right.acc_x_dashboard) AS mean_acc_x_dashboard, 
AVG(bad_road_right.acc_y_dashboard) AS mean_acc_y_dashboard, AVG(bad_road_right.acc_z_dashboard) AS mean_acc_z_dashboard, 
AVG(bad_road_right.acc_x_above_suspension) AS mean_acc_x_above_suspension, AVG(bad_road_right.acc_y_above_suspension) AS mean_acc_y_above_suspension, 
AVG(bad_road_right.acc_z_above_suspension) AS mean_acc_z_above_suspension, AVG(bad_road_right.acc_x_below_suspension) AS mean_acc_x_below_suspension, 
AVG(bad_road_right.acc_y_below_suspension) AS mean_acc_y_below_suspension, AVG(bad_road_right.acc_z_below_suspension) AS mean_acc_z_below_suspension, 
AVG(bad_road_right.gyro_x_dashboard) AS mean_gyro_x_dashboard, AVG(bad_road_right.gyro_y_dashboard) AS mean_gyro_y_dashboard, 
AVG(bad_road_right.gyro_z_dashboard) AS mean_gyro_z_dashboard, AVG(bad_road_right.gyro_x_above_suspension) AS mean_gyro_x_above_suspension, 
AVG(bad_road_right.gyro_y_above_suspension) AS mean_gyro_y_above_suspension, AVG(bad_road_right.gyro_z_above_suspension) AS mean_gyro_z_above_suspension, 
AVG(bad_road_right.gyro_x_below_suspension) AS mean_gyro_x_below_suspension, AVG(bad_road_right.gyro_y_below_suspension) AS mean_gyro_y_below_suspension, 
AVG(bad_road_right.gyro_z_below_suspension) AS mean_gyro_z_below_suspension, AVG(bad_road_right.mag_x_dashboard) AS mean_mag_x_dashboard, 
AVG(bad_road_right.mag_y_dashboard) AS mean_mag_y_dashboard, AVG(bad_road_right.mag_z_dashboard) AS mean_mag_z_dashboard, 
AVG(bad_road_right.mag_x_above_suspension) AS mean_mag_x_above_suspension, AVG(bad_road_right.mag_y_above_suspension) AS mean_mag_y_above_suspension, 
AVG(bad_road_right.mag_z_above_suspension) AS mean_mag_z_above_suspension, AVG(bad_road_right.temp_dashboard) AS mean_temp_dashboard, 
AVG(bad_road_right.temp_above_suspension) AS mean_temp_above_suspension, AVG(bad_road_right.temp_below_suspension) AS mean_temp_below_suspension, 
AVG(bad_road_right.speed) AS mean_speed,'bad_road_right' AS road_type;

right_final_pvs1 = UNION aggregated_paved_road, aggregated_unpaved_road, aggregated_dirt_road, aggregated_cobblestone_road, aggregated_asphalt_road,
aggregated_no_speed_bump, aggregated_speed_bump_asphalt, aggregated_speed_bump_cobblestone, aggregated_good_road_left,aggregated_regular_road_left,
aggregated_bad_road_left, aggregated_good_road_right, aggregated_regular_road_right, aggregated_bad_road_right;

-- Store the aggregated data into a file
STORE right_final_pvs1 INTO '/user/pig/output_right' USING PigStorage(',');
