I'll add better stuff here later.

TLibCompress and TSerial work well with eachother:

-- Save a table to a file:
file = love.filesystem.newFile("name.ext") file:open("w")
file:write(TLibCompress.CompressLZW("tablename="..Tserialize(tablename)))
file:close()

-- Load a table from a file:
file = love.filesystem.newFile("name.ext") file:open("r")
loadstring(TLibCompress.DecompressLZW(file:read()))()
file:close()