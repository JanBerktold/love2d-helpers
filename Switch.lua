--[[

	Switch.lua
		Documentation

	Examples:

		Switch 'Hello World' {
		
			['Hello World'] = function(object)
				print('I was called')
			end,

			['Other random string'] = function(object)
				print('I won\'t be called')
			end,

			['default'] = function(object)
				print('Nor will I')
			end

		}

		==> I was called

		Switch (3) {
	
			['World'] = function()
				print('Nope')
			end,

			[5] = function()
				print('I\'m not right')
			end,

			default = function()
				print('I\'ll be called yay!')
			end
		}

		==> I'll be called yay!
]]

local function empty() end

function Switch(object)
	return function(dictionary)
		return (dictionary[object] or dictionary[tostring(object)] or dictionary.default or empty)(object)
	end
end