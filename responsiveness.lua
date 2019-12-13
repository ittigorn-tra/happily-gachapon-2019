function calc_game_area(default_width, default_height, default_ratio, screen_width, screen_height)

  screen_ratio = screen_width / screen_height
  dim = { w=0, h=0 }
  pos = { x={ start=0, mid=0, stop=0 }, y={ start=0, mid=0, stop=0 }}
  ratio = 0

  if screen_ratio == default_ratio then
    dim = { w=screen_width, h=screen_height }
    pos = { 
            x={ start=0, mid=screen_width/2, stop=screen_width }, 
            y={ start=0, mid=( screen_height/2 ), stop=screen_height }
          }
    ratio = (screen_width / default_width)
  elseif screen_ratio < default_ratio then -- the screen is taller than expected
    dim = { w=screen_width, h=( screen_width / default_ratio ) }
    pos = { 
            x={ start=0, mid=screen_width/2, stop=screen_width }, 
            y={ 
                start=( ( screen_height/2 ) - ( dim.h / 2 ) ), 
                mid=( screen_height/2 ), 
                stop=( ( screen_height/2 ) + ( dim.h / 2 ) ) 
              }
          }
    ratio = (screen_width / default_width)
  elseif screen_ratio > default_ratio then -- the screen is wider than expected
    dim = { w=( screen_height * default_ratio ), h=screen_height }
    pos = {
            x={ 
              start=( ( screen_width/2 ) - ( dim.w / 2 ) ), 
              mid=( screen_width/2 ), 
              stop=( ( screen_width/2 ) + ( dim.w / 2 ) ) 
            },
            y={ start=0, mid=screen_height/2, stop=screen_height }
          }
    ratio = (screen_height / default_height)
  end

  return { dim=dim, pos=pos, ratio=ratio }

end -- end calc_game_area()

-- this function translate position 
function translate_dim(game_area, x, y, r, sx, sy, concat_table)
  x = x or 0
  y = y or 0
  sx = sx or 1
  sy = sy or 1

  x = game_area.pos.x.start + ( x * game_area.ratio )
  y = game_area.pos.y.start + ( y * game_area.ratio )
  sx = sx * game_area.ratio
  sy = sy * game_area.ratio

  if concat_table == nil then
    return x, y, r, sx, sy
  else
    local res = { x=x, y=y, r=r, sx=sx, sy=sy }
    for k, v in pairs(res) do 
      concat_table[k] = v
    end
    return concat_table
  end
end