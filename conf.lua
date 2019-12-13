conf = {

  -- DEV VARIABLES
  show_debug_messages       = true,
  paint_hidden_structures   = true,
  semi_transparent          = true,
  semi_transparent_val      = 0.3,

  -- DISPLAY CONFIGS
  display                         = 2,
  fullscreen                      = true,
  fullscreentype                  = "desktop",
  default_width                   = 1080,
  default_height                  = 1920,
  default_ratio                   = 1080 / 1920,

  -- CONFIGS
  sound_on                        = true,
  bg_music_on                     = true,
  state_2_duration                = 2.0,
  show_price_fade_percentage      = 0.7,
  default_bg_music_volume         = 0.8,
  dimmed_bg_music_volume          = 0.2,
  state_1_pause_duration          = 0.7, -- pausing time before the button can be clicked again after entering this state
  state_20_click_detection_duration = 1.5, -- must click n time within x seconds to enter state 20
  state_20_click_activation       = 3, -- must click n time to enter state 20
  prize_inventory_file            = "prize_inventory.txt",
  plus_button_offset_x            = -420,
  minus_button_offset_x           = -280,
  plus_minus_button_offset_y      = 150 * 0.4,

  show_stars      = true,
  star = {
    speed         = 1000,
    rotate_speed  = 1.5,
    scale_speed   = 1500, -- the lower the faster they scale UP
    fade_speed    = 1000, -- the lower the faster they fade IN
    max           = 40,
    min_scale     = 0.0
  },

  show_flies          = false,
  fly = {
    speed             = 700,
    rotate_speed      = 10,
    scale_speed       = 1500, -- the lower the faster they scale UP
    fade_speed        = 1000, -- the lower the faster they fade IN
    max               = 10,
    min_scale         = 0.0,
    origin_y_offset   = 300
  },

  prize_chances = {
    blue      = 9.0,   -- S Sketchbook 2018
    red       = 49.0,   -- S Sketchbook 2020
    green     = 4.0,   -- L Sketchbook 2018
    metallic  = 15.0,   -- L Sketchbook 2020
    gold      = 3.0,    -- T-Shirt
    purple    = 'else'  -- Candy
  },

  prize_inventory_default = {
    blue      = 30,    -- S Sketchbook 2018
    red       = 165,    -- S Sketchbook 2020
    green     = 15,    -- L Sketchbook 2018
    metallic  = 50,    -- L Sketchbook 2020
    gold      = 11,    -- T-Shirt
    purple    = 200    -- Candy
  },

}