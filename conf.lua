-- DEV VARIABLES
paint_hidden_structures   = false
semi_transparent          = false
show_debug_messages       = false

-- CONFIGS
display                         = 2
fullscreen                      = true
forceWidth, forceHeight         = 1080, 1920
sound_on                        = true
bg_music_on                     = true
state_2_duration                = 2.0
show_price_fade_percentage      = 0.7
default_bg_music_volume         = 0.8
dimmed_bg_music_volume          = 0.2
state_1_pause_duration          = 0.7 -- pausing time before the button can be clicked again after entering this state
state_20_click_detection_duration = 1.5 -- must click n time within x seconds to enter state 20
state_20_click_activation       = 3 -- must click n time to enter state 20
prize_inventory_file            = "prize_inventory.txt"
plus_button_offset_x            = -420
minus_button_offset_x           = -280
plus_minus_button_offset_y      = 150*0.4

show_stars      = true
star = {
  speed         = 1000,
  rotate_speed  = 1.5,
  scale_speed   = 1500, -- the lower the faster they scale UP
  fade_speed    = 1000, -- the lower the faster they fade IN
  max           = 40,
  min_scale     = 0.0
}

-- show_flies      = true
-- fly = {
--   speed         = 1000,
--   rotate_speed  = 1.5,
--   scale_speed   = 1500, -- the lower the faster they scale UP
--   fade_speed    = 1000, -- the lower the faster they fade IN
--   max           = 40,
--   min_scale     = 0.0
--   origin_x_offset      = 0,
--   origin_y_offset      = 0,
-- }

prize_chances = {
  blue      = 15.0,   -- S Sketchbook 2018
  red       = 15.0,   -- S Sketchbook 2020
  green     = 10.0,   -- L Sketchbook 2018
  metallic  = 10.0,   -- L Sketchbook 2020
  gold      = 2.0,    -- T-Shirt
  purple    = 'else'  -- Nothing
}

prize_inventory_default = {
  blue      = 30,    -- S Sketchbook 2018
  red       = 165,    -- S Sketchbook 2020
  green     = 15,    -- L Sketchbook 2018
  metallic  = 50,    -- L Sketchbook 2020
  gold      = 11,    -- T-Shirt
  purple    = 10000 -- Nothing
}