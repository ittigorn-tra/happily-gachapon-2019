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
default_bg_music_volume         = 1.0
dimmed_bg_music_volume          = 0.4
state_1_pause_duration          = 0.7 -- pausing time before the button can be clicked again after entering this state
state_20_click_detection_duration = 1.5 -- must click n time within x seconds to enter state 20
state_20_click_activation       = 3 -- must click n time to enter state 20
prize_inventory_file            = "prize_inventory.txt"
plus_button_offset_x            = -420
minus_button_offset_x           = -280
plus_minus_button_offset_y      = 150*0.4

prize_chances = {
  blue      = 15.0,   -- S Sketchbook 2018
  red       = 15.0,   -- S Sketchbook 2020
  green     = 10.0,   -- L Sketchbook 2018
  metallic  = 10.0,   -- L Sketchbook 2020
  gold      = 2.0,    -- T-Shirt
  purple    = 'else'  -- Nothing
}

prize_inventory_default = {
  blue      = 3,    -- S Sketchbook 2018
  red       = 3,    -- S Sketchbook 2020
  green     = 3,    -- L Sketchbook 2018
  metallic  = 3,    -- L Sketchbook 2020
  gold      = 1,    -- T-Shirt
  purple    = 10000 -- Nothing
}