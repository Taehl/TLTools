-- Tcontent b3, dynamic content pools; as needed, load only one copy of each resource in memory and let Lua GC it
-- by Taehl (SelfMadeSpirit@gmail.com)
-- todo: lots of memory tests, also test collectgarbage"collect"

-- Store serialization table of all generated contents, in form of Tcontent.serial[resource] = key
Tcontent = { serial=setmetatable({},{__mode="k"}) }


-- Make a new pool for given content which loads resources with the given __loader function
function Tcontent.newPool(name, loader)
	assert(name, "Must pass a name for the new content pool.")
	assert(loader, "Must pass a loader function for the new content pool.")
	local t = setmetatable( {}, {
		__mode = "k",	-- to properly work, would require res access to always be direct?
		__index = function(t,k)
			--if not k then return end
			assert(k, "Tcontent was passed a nil key: "..tostring(t).." ["..tostring(k).."]")
			local r = rawget(t,k)
			if r then return r
			else
				r = t.__loader(k)
				rawset(t,k,r)
				Tcontent.serial[r] = "Tcontent."..name.."."..k
				return r
			end
		end,
	} )
	Tcontent[name], t.__loader = t, loader
	return t
end


-- Custom-load a resource into a pool (useful if you want to add a resource which the pool's normal loader can't handle)
function Tcontent.load(pool, name, r)
	rawset(pool,name,r)
	Tcontent.serial[r] = name
	return r
end


-- Default content pools and loaders for Love2D: image, font, sound, music
if love and love.graphics then
	Tcontent.newPool( "image", function(i) return love.graphics.newImage("image/"..i) end )
	Tcontent.newPool( "font", function(i) return love.graphics.newFont("font/"..i) end )
end
if love and love.audio then
	Tcontent.newPool( "sound", function(i) return love.audio.newSource("sound/"..i,"static") end )	-- best for smaller files
	Tcontent.newPool( "music", function(i) return love.audio.newSource("music/"..i) end )
end