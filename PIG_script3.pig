test = LOAD '/user/pig/output' USING PigStorage(',') AS (mean_acc_x_dashboard: double, mean_acc_y_dashboard: double, mean_acc_z_dashboard: double, mean_acc_x_above_suspension: double, mean_acc_y_above_suspension: double, mean_acc_z_above_suspension: double, mean_acc_x_below_suspension: double, mean_acc_y_below_suspension: double, mean_acc_z_below_suspension: double, mean_gyro_x_dashboard: double, mean_gyro_y_dashboard: double, mean_gyro_z_dashboard: double, mean_gyro_x_above_suspension: double, mean_gyro_y_above_suspension: double, mean_gyro_z_above_suspension: double, mean_gyro_x_below_suspension: double, mean_gyro_y_below_suspension: double, mean_gyro_z_below_suspension: double, mean_mag_x_dashboard: double, mean_mag_y_dashboard: double, mean_mag_z_dashboard: double, mean_mag_x_above_suspension: double, 
mean_mag_y_above_suspension: double, mean_mag_z_above_suspension: double, mean_temp_dashboard: double, mean_temp_above_suspension: double, mean_temp_below_suspension: double, mean_speed: double, road_type: chararray);

--ACC

test_paved_road = FILTER test BY road_type == 'paved_road';
test_paved_road_acc = FOREACH test_paved_road GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_unpaved_road = FILTER test BY road_type == 'unpaved_road';
test_unpaved_road_acc = FOREACH test_unpaved_road GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_dirt_road = FILTER test BY road_type == 'dirt_road';
test_dirt_road_acc = FOREACH test_dirt_road GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_cobblestone_road = FILTER test BY road_type == 'cobblestone_road';
test_cobblestone_road_acc = FOREACH test_cobblestone_road GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_asphalt_road = FILTER test BY road_type == 'asphalt_road';
test_asphalt_road_acc = FOREACH test_asphalt_road GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_no_speed_bump = FILTER test BY road_type == 'no_speed_bump';
test_no_speed_bump_acc = FOREACH test_no_speed_bump GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_speed_bump_asphalt = FILTER test BY road_type == 'speed_bump_asphalt';
test_speed_bump_asphalt_acc = FOREACH test_speed_bump_asphalt GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_speed_bump_cobblestone = FILTER test BY road_type == 'speed_bump_cobblestone';
test_speed_bump_cobblestone_acc = FOREACH test_speed_bump_cobblestone GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_good_road_left = FILTER test BY road_type == 'good_road_left';
test_good_road_left_acc = FOREACH test_good_road_left GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_regular_road_left = FILTER test BY road_type == 'regular_road_left';
test_regular_road_left_acc = FOREACH test_regular_road_left GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_bad_road_left = FILTER test BY road_type == 'bad_road_left';
test_bad_road_left_acc = FOREACH test_bad_road_left GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_good_road_right = FILTER test BY road_type == 'good_road_right';
test_good_road_right_acc = FOREACH test_good_road_right GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_regular_road_right = FILTER test BY road_type == 'regular_road_right';
test_regular_road_right_acc = FOREACH test_regular_road_right GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

test_bad_road_right = FILTER test BY road_type == 'bad_road_right';
test_bad_road_right_acc = FOREACH test_bad_road_right GENERATE mean_acc_x_dashboard AS acc_x_dashboard, mean_acc_y_dashboard AS acc_y_dashboard, mean_acc_z_dashboard AS acc_z_dashboard, 
mean_acc_x_above_suspension AS acc_x_above_suspension, mean_acc_y_above_suspension AS acc_y_above_suspension, mean_acc_z_above_suspension AS acc_z_above_suspension, 
mean_acc_x_below_suspension AS acc_x_below_suspension, mean_acc_y_below_suspension AS acc_y_below_suspension, mean_acc_z_below_suspension AS acc_z_below_suspension;

--GYRO

test_paved_road_gyro = FOREACH test_paved_road GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_unpaved_road_gyro = FOREACH test_unpaved_road GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_dirt_road_gyro = FOREACH test_dirt_road GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_cobblestone_road_gyro = FOREACH test_cobblestone_road GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_asphalt_road_gyro = FOREACH test_asphalt_road GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_no_speed_bump_gyro = FOREACH test_no_speed_bump GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_speed_bump_asphalt_gyro = FOREACH test_speed_bump_asphalt GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_speed_bump_cobblestone_gyro = FOREACH test_speed_bump_cobblestone GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_good_road_left_gyro = FOREACH test_good_road_left GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_regular_road_left_gyro = FOREACH test_regular_road_left GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_bad_road_left_gyro = FOREACH test_bad_road_left GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_good_road_right_gyro = FOREACH test_good_road_right GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_regular_road_right_gyro = FOREACH test_regular_road_right GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

test_bad_road_right_gyro = FOREACH test_bad_road_right GENERATE mean_gyro_x_dashboard AS gyro_x_dashboard, mean_gyro_y_dashboard AS gyro_y_dashboard, mean_gyro_z_dashboard AS gyro_z_dashboard, 
mean_gyro_x_above_suspension AS gyro_x_above_suspension, mean_gyro_y_above_suspension AS gyro_y_above_suspension, mean_gyro_z_above_suspension AS gyro_z_above_suspension, 
mean_gyro_x_below_suspension AS gyro_x_below_suspension, mean_gyro_y_below_suspension AS gyro_y_below_suspension, mean_gyro_z_below_suspension AS gyro_z_below_suspension;

--Mag

test_paved_road_mag = FOREACH test_paved_road GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_unpaved_road_mag = FOREACH test_unpaved_road GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_dirt_road_mag = FOREACH test_dirt_road GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_cobblestone_road_mag = FOREACH test_cobblestone_road GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_asphalt_road_mag = FOREACH test_asphalt_road GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_no_speed_bump_mag = FOREACH test_no_speed_bump GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_speed_bump_asphalt_mag = FOREACH test_speed_bump_asphalt GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_speed_bump_cobblestone_mag = FOREACH test_speed_bump_cobblestone GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_good_road_left_mag = FOREACH test_good_road_left GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_regular_road_left_mag = FOREACH test_regular_road_left GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_bad_road_left_mag = FOREACH test_bad_road_left GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_good_road_right_mag = FOREACH test_good_road_right GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_regular_road_right_mag = FOREACH test_regular_road_right GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

test_bad_road_right_mag = FOREACH test_bad_road_right GENERATE mean_mag_x_dashboard AS mag_x_dashboard, mean_mag_y_dashboard AS mag_y_dashboard, mean_mag_z_dashboard AS mag_z_dashboard, 
mean_mag_x_above_suspension AS mag_x_above_suspension, mean_mag_y_above_suspension AS mag_y_above_suspension, mean_mag_z_above_suspension AS mag_z_above_suspension;

--Temp

test_paved_road_temp = FOREACH test_paved_road GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_unpaved_road_temp = FOREACH test_unpaved_road GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_dirt_road_temp = FOREACH test_dirt_road GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_cobblestone_road_temp = FOREACH test_cobblestone_road GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_asphalt_road_temp = FOREACH test_asphalt_road GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_no_speed_bump_temp = FOREACH test_no_speed_bump GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_speed_bump_asphalt_temp = FOREACH test_speed_bump_asphalt GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_speed_bump_cobblestone_temp = FOREACH test_speed_bump_cobblestone GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_good_road_left_temp = FOREACH test_good_road_left GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_regular_road_left_temp = FOREACH test_regular_road_left GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_bad_road_left_temp = FOREACH test_bad_road_left GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_good_road_right_temp = FOREACH test_good_road_right GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_regular_road_right_temp = FOREACH test_regular_road_right GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

test_bad_road_right_temp = FOREACH test_bad_road_right GENERATE mean_temp_above_suspension AS temp_above_suspension, temp_below_suspension AS mean_temp_below_suspension;

--Speed

test_paved_road_speed = FOREACH test_paved_road GENERATE mean_speed AS mean_speed;

test_unpaved_road_speed = FOREACH test_unpaved_road GENERATE mean_speed AS mean_speed;

test_dirt_road_speed = FOREACH test_dirt_road GENERATE mean_speed AS mean_speed;

test_cobblestone_road_speed = FOREACH test_cobblestone_road GENERATE mean_speed AS mean_speed;

test_asphalt_road_speed = FOREACH test_asphalt_road GENERATE mean_speed AS mean_speed;

test_no_speed_bump_speed = FOREACH test_no_speed_bump GENERATE mean_speed AS mean_speed;

test_speed_bump_asphalt_speed = FOREACH test_speed_bump_asphalt GENERATE mean_speed AS mean_speed;

test_speed_bump_cobblestone_speed = FOREACH test_speed_bump_cobblestone GENERATE mean_speed AS mean_speed;

test_good_road_left_speed = FOREACH test_good_road_left GENERATE mean_speed AS mean_speed;

test_regular_road_left_speed = FOREACH test_regular_road_left GENERATE mean_speed AS mean_speed;

test_bad_road_left_speed = FOREACH test_bad_road_left GENERATE mean_speed AS mean_speed;

test_good_road_right_speed = FOREACH test_good_road_right GENERATE mean_speed AS mean_speed;

test_regular_road_right_speed = FOREACH test_regular_road_right GENERATE mean_speed AS mean_speed;

test_bad_road_right_speed = FOREACH test_bad_road_right GENERATE mean_speed AS mean_speed;