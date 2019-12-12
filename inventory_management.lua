function save_current_inventory()
  local data = ""
  for k, v in pairs(prizes) do
    data = data..k..":"..v.qty.."\n"
  end
  local success, message = love.filesystem.write( prize_inventory_file, data )
end

function adjust_current_inventory(k, adj)
  if (prizes[k].qty + adj) >= 0 then
    prizes[k].qty = prizes[k].qty + adj
  end
end

function load_inventory_from_saved_file()
  -- read prize inventory from file
  if love.filesystem.getInfo( prize_inventory_file, nil ) then
    for line in love.filesystem.lines( prize_inventory_file ) do
      for k, v in line:gmatch("(.-):(.*)") do
        prizes[k].qty = tonumber(v)
      end
    end
  else
    reload_default_prize_qty()
  end
end