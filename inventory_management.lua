-- calculate positions for pongs in settings page
function load_config_pongs()
  config_pongs = {}
  for pk, pv in pairs(pong.img) do
    local p = {}
    p.img = pv
    p.x, p.y, p.r, p.sx, p.sy = translate_dim(game_area, conf.config_pong_offset.x.start, conf.config_pong_offset.y.start, 0, 1, 1)

    p.plus_button     = {}
    p.plus_button.img = love.graphics.newImage('sprites/static_graphics/plus.png')
    p.plus_button.x, p.plus_button.y, p.plus_button.r, p.plus_button.sx, p.plus_button.sy = translate_dim(game_area, conf.config_pong_offset.x.start + 250, conf.config_pong_offset.y.start + 60, 0, 0.7, 0.7)

    p.minus_button     = {}
    p.minus_button.img = love.graphics.newImage('sprites/static_graphics/minus.png')
    p.minus_button.x, p.minus_button.y, p.minus_button.r, p.minus_button.sx, p.minus_button.sy = translate_dim(game_area, conf.config_pong_offset.x.start - 135, conf.config_pong_offset.y.start + 60, 0, 0.7, 0.7)

    p.text     = {}
    p.text.x, p.text.y, _1, _2, _3 = translate_dim(game_area, conf.config_pong_offset.x.start + 450, conf.config_pong_offset.y.start + 90, 0, 1, 1)
    p.text.font_size = conf.config_pong_font_size * game_area.ratio

    -- add to table
    config_pongs[pk] = p

    -- increment the next y start
    conf.config_pong_offset.y.start = conf.config_pong_offset.y.start + conf.config_pong_offset.y.increment
  end
  return config_pongs
end

config_pongs = load_config_pongs() -- calculate positions for pongs in settings page
state_20_timer        = 0
state_20_click_count  = 0

inv_settings = {}

inv_settings.close              = {}
inv_settings.close.img          = love.graphics.newImage('sprites/static_graphics/close.png')
inv_settings.close              = translate_dim(game_area, 871, 80, 0, 0.3, 0.3, inv_settings.close)

inv_settings.mute_music               = {}
inv_settings.mute_music.on            = {}
inv_settings.mute_music.on.img        = love.graphics.newImage('sprites/interactive_graphics/mute_music_on.png')
inv_settings.mute_music.on            = translate_dim(game_area, 80, 80, 0, 0.3, 0.3, inv_settings.mute_music.on)
inv_settings.mute_music.off           = {}
inv_settings.mute_music.off.img       = love.graphics.newImage('sprites/interactive_graphics/mute_music_off.png')
inv_settings.mute_music.off           = translate_dim(game_area, 80, 80, 0, 0.3, 0.3, inv_settings.mute_music.off)

inv_settings.mute               = {}
inv_settings.mute.on            = {}
inv_settings.mute.on.img        = love.graphics.newImage('sprites/interactive_graphics/mute_on.png')
inv_settings.mute.on            = translate_dim(game_area, 289, 80, 0, 0.3, 0.3, inv_settings.mute.on)
inv_settings.mute.off           = {}
inv_settings.mute.off.img       = love.graphics.newImage('sprites/interactive_graphics/mute_off.png')
inv_settings.mute.off           = translate_dim(game_area, 289, 80, 0, 0.3, 0.3, inv_settings.mute.off)

inv_settings.reload             = {}
inv_settings.reload.img         = love.graphics.newImage('sprites/static_graphics/reload.png')
inv_settings.reload             = translate_dim(game_area, 498, 80, 0, 0.3, 0.3, inv_settings.reload)

function reload_default_prize_qty()
  for k, v in pairs(conf.prize_inventory_default) do
    prizes[k].qty = v
  end
end

function save_current_inventory(conf)
  local data = ""
  for k, v in pairs(prizes) do
    data = data..k..":"..v.qty.."\n"
  end
  local success, message = love.filesystem.write( conf.prize_inventory_file, data )
end

function adjust_current_inventory(k, adj)
  if (prizes[k].qty + adj) >= 0 then
    prizes[k].qty = prizes[k].qty + adj
  end
end

function load_inventory_from_saved_file(conf)
  -- read prize inventory from file
  if love.filesystem.getInfo( conf.prize_inventory_file, nil ) then
    for line in love.filesystem.lines( conf.prize_inventory_file ) do
      for k, v in line:gmatch("(.-):(.*)") do
        prizes[k].qty = tonumber(v)
      end
    end
  else
    reload_default_prize_qty()
  end
end

function update_state_20(dt)
  if state_20_timer > 0 then
    state_20_timer = state_20_timer - dt
  elseif state_20_timer < 0 then
    state_20_timer = 0
  end
  if state_20_timer == 0 then
    state_20_click_count = 0
  end
end

function check_opening_inventory_settings(mx, my, game_area, game_state, conf)
  local open_settings = false
  if game_state == 1 then
    if calc_distance(mx, my, (game_area.pos.x.start + (840 * game_area.ratio)), (game_area.pos.y.start + (142 * game_area.ratio))) <= ((175 / 2) * game_area.ratio) then
      if state_20_click_count == 0 then
        state_20_timer = conf.state_20_click_detection_duration
      end
      state_20_click_count = state_20_click_count + 1
      if state_20_click_count >= conf.state_20_click_activation then
        open_settings = true
      end
    end
  end
  return open_settings
end

function check_closing_inventory_settings(mx, my, game_area, game_state)
  return false
end

function enter_state_20()
  play_pressing_sound()
  state_20_timer        = 0
  state_20_click_count  = 0
  game_state            = 20
end

function check_clicking_on_settings(mx, my, game_area, game_state)
  if game_state == 20 then
    if check_mouse_within_graphic(mx, my, game_area, inv_settings.close) then
      play_pressing_sound()
      save_current_inventory(conf)
      enter_state_1()
    elseif check_mouse_within_graphic(mx, my, game_area, inv_settings.mute_music.on) then
      play_pressing_sound()
      conf.bg_music_on = not conf.bg_music_on
      if conf.bg_music_on then
        start_bg_music()
      else
        stop_bg_music()
      end
    elseif check_mouse_within_graphic(mx, my, game_area, inv_settings.mute.on) then
      conf.sound_on = not conf.sound_on
      if conf.sound_on then
        play_pressing_sound()
        start_bg_music()
      else
        stop_bg_music()
      end
    elseif check_mouse_within_graphic(mx, my, game_area, inv_settings.reload) then
      play_pressing_sound()
      reload_default_prize_qty()
    else
      local match_found = false
      for k, v in pairs(config_pongs) do
        for button_type, button_key in pairs({ plus='plus_button', minus='minus_button' }) do
          if check_mouse_within_graphic(mx, my, game_area, v[button_key]) then
            play_pressing_sound()
            local adj = 1
            if button_type == 'minus' then adj = -1 end
            adjust_current_inventory(k, adj)
            match_found = true
            break
          end
        end
        if match_found then break end
      end
    end
  end
end

function draw_inventory_settings(game_area, game_state, conf)
  if game_state == 20 then

    -- fade
    love.graphics.setColor(0, 0, 0, conf.show_price_fade_percentage)
    love.graphics.rectangle('fill', game_area.pos.x.start, game_area.pos.y.start, game_area.dim.w, game_area.dim.h)
    set_default_alpha()

    -- close button
    love.graphics.draw(inv_settings.close.img, inv_settings.close.x, inv_settings.close.y, inv_settings.close.r, inv_settings.close.sx, inv_settings.close.sy)

    -- mute music button
    local mute_music_obj = inv_settings.mute_music.off
    if not conf.bg_music_on then mute_music_obj = inv_settings.mute_music.on end
    love.graphics.draw(mute_music_obj.img, mute_music_obj.x, mute_music_obj.y, mute_music_obj.r, mute_music_obj.sx, mute_music_obj.sy)

    -- mute button
    local mute_obj = inv_settings.mute.off
    if not conf.sound_on then mute_obj = inv_settings.mute.on end
    love.graphics.draw(mute_obj.img, mute_obj.x, mute_obj.y, mute_obj.r, mute_obj.sx, mute_obj.sy)

    -- reload button
    love.graphics.draw(inv_settings.reload.img, inv_settings.reload.x, inv_settings.reload.y, inv_settings.reload.r, inv_settings.reload.sx, inv_settings.reload.sy)

    -- confic pongs
    for k, v in pairs(config_pongs) do
      love.graphics.draw(v.img, v.x, v.y, v.r, v.sx, v.sy) -- draw pong
      love.graphics.draw(v.plus_button.img, v.plus_button.x, v.plus_button.y, v.plus_button.r, v.plus_button.sx, v.plus_button.sy) -- draw plus button
      love.graphics.draw(v.minus_button.img, v.minus_button.x, v.minus_button.y, v.minus_button.r, v.minus_button.sx, v.minus_button.sy) -- draw minus button

      love.graphics.setNewFont(v.text.font_size)
      love.graphics.print(prizes[k].qty, v.text.x, v.text.y)
    end
  end
end