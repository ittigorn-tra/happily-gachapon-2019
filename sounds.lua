function load_sound_array(path, arr_size)
  arr_size = arr_size or 20
  local sound_arr = {}
  table.insert(sound_arr, love.audio.newSource(path, "static"))
  for i = 1, arr_size, 1 do
    table.insert(sound_arr, sound_arr[1]:clone())
  end
  return sound_arr
end

-- sounds
sounds                = {}

sounds.bg_music       = love.audio.newSource('sounds/soundtrack.mp3', 'stream')
sounds.bg_music:setLooping( true )

sounds.balls_rolling  = love.audio.newSource('sounds/balls_rolling.mp3', 'stream')
sounds.press          = load_sound_array("sounds/press.mp3", 20)
sounds.collide        = load_sound_array("sounds/collide.mp3", 10)

sounds.prize          = {}
sounds.prize.success  = love.audio.newSource("sounds/success.mp3", "stream")
sounds.prize.fail     = love.audio.newSource("sounds/fail.mp3", "stream")

if conf.bg_music_on and conf.sound_on then
  sounds.bg_music:setVolume(conf.default_bg_music_volume)
  sounds.bg_music:play()
end

function play_sound_array(arr)
  if conf.sound_on then
    for i, s in ipairs(arr) do
      if not s:isPlaying() then
        s:play()
        break
      end
    end
  end
end

function play_pressing_sound()
  play_sound_array(sounds.press)
end

function play_colliding_sound()
  play_sound_array(sounds.collide)
end

function play_prize_sound(s)
  if conf.sound_on then
    sounds.prize[s]:play()
  end
end

function stop_prize_sound(s)
  if sounds.prize[s]:isPlaying() then
    sounds.prize[s]:stop()
  end
end

function update_music_volume(conf, dt)
  if conf.bg_music_on and conf.sound_on then
    local current_vol = sounds.bg_music:getVolume()
    if (game_state > 1) and (game_state < 10) then
      if (current_vol > conf.dimmed_bg_music_volume) then
        local new_vol = current_vol - (conf.bg_music_down_increment * dt)
        if new_vol < conf.dimmed_bg_music_volume then
          new_vol = conf.dimmed_bg_music_volume
        end
        sounds.bg_music:setVolume(new_vol)
      end
    else
      if (current_vol < conf.default_bg_music_volume) then
        sounds.bg_music:setVolume(current_vol + (conf.bg_music_up_increment * dt))
      elseif (current_vol > conf.default_bg_music_volume) then
        sounds.bg_music:setVolume(conf.default_bg_music_volume)
      end
    end
  end
end