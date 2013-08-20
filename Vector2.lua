--[[

	Vector2.lua
		Documentation

	API:

		(number) MyVector.getMagnitude
			Arguments:
				None
			Description:
				Returns the magnitude
				Also accessible as a property: MyVector.magnitude

		(vector2) MyVector.getUnit
			Arguments:
				None
			Description:
				Returns the unit-vector
				Also accessible as a property: MyVector.unit

		(number) MyVector.getDistance
			Arguments:
				(vector2) SecondVector
			Description:
				Returns the distance between MyVector and the given one	

		(vector2) MyVector.inv
			Arguments:
				None
			Description:
				Returns the inversed vector

		(vector2) MyVector.lerp
			Arguments:
				(vector2) b-Vector
				(number/0-1) alpha
			Description:
				Returns the point specified by alpha between MyVector and b-Vector

		(vector2) MyVector + (vector2/number) SecondVector
			Description:
				Allows you to add MyVector with another vector or a number

		(vector2) MyVector - (vector2/number) SecondVector
			Description:
				Allows you to sub another vector or a number from MyVector

		(vector2) MyVector * (vector2/number) SecondVector
			Description:
				Allows you to multiply MyVector and another vector or a number

		(vector2) MyVector / (vector2/number) SecondVector
			Description:
				Allows you to divide MyVector by another vector or a number


	Properties:

		(number) MyVector.x
			Description:
				The x-coordinate of MyVector

		(number) MyVector.y
			Description:
				The x-coordinate of MyVector

		(number) MyVector.X
			Description:
				The x-coordinate of MyVector

		(number) MyVector.Y
			Description:
				The x-coordinate of MyVector

		(vector2) MyVector.magnitude
			Description:
				The magnitude of MyVector

		(vector2) MyVector.unit
			Description:
				The unit-vector of MyVector
]]

Vector2 = {}

function Vector2.new(x, y)
	local this = {}

	this.x = x or 0
	this.y = y or 0

	function this.getMagnitude()
		return math.sqrt(this.x ^ 2 + this.y ^ 2)
	end

	function this.getUnit()
		local magnitude = this.getMagnitude()
		return this / magnitude
	end

	function this.getDistance(secondVector)
		return (this - secondVector).getMagnitude()
	end

	function this.inv()
		return Vector2.new(this.x * -1, this.y * -1)
	end

	function this.lerp(secondVector, alpha)
		local alpha = type(alpha) == 'number' and alpha or 0
		return Vector2.new((secondVector.x - this.x) * alpha + this.x, (secondVector.y - this.y) * alpha + this.x)
	end

	-- just incase someone wants to have the magnitude 'n stuff as a property
	local look_up = {
		magnitude = this.getMagnitude,
		unit = this.getUnit
	}

	setmetatable(this, 
		{

			__metatable = 'Vector2.metatable',

			__index = function(this, index)
				-- so we can do .Y and .y, without having to use two variables
				return look_up[index] and look_up[index]() or this[index:upper()] or this[index:lower()]
			end,

			__add = function(this, secondVector)
				assert(getmetatable(secondVector) == 'Vector2.metatable' or type(secondVector) == 'number', 'You can only add a Vector2 with another Vector2 or a number.')
				local x, y
				if getmetatable(secondVector) == 'Vector2.metatable' then
					x, y = secondVector.x, secondVector.y
				else
					x, y = secondVector, secondVector
				end
				return Vector2.new(this.x + x, this.y + y)
			end,

			__sub = function(this, secondVector)
				assert(getmetatable(secondVector) == 'Vector2.metatable' or type(secondVector) == 'number', 'You can only sub a Vector2 with another Vector2 or a number.')
				local x, y
				if getmetatable(secondVector) == 'Vector2.metatable' then
					x, y = secondVector.x, secondVector.y
				else
					x, y = secondVector, secondVector
				end
				return Vector2.new(this.x - x, this.y - y)
			end,

			__mul = function(this, secondVector)
				assert(getmetatable(secondVector) == 'Vector2.metatable' or type(secondVector) == 'number', 'You can only multiply a Vector2 with another Vector2 or a number.')
				local x, y
				if getmetatable(secondVector) == 'Vector2.metatable' then
					x, y = secondVector.x, secondVector.y
				else
					x, y = secondVector, secondVector
				end
				return Vector2.new(this.x * x, this.y * y)
			end,

			__div = function(this, secondVector)
				assert(getmetatable(secondVector) == 'Vector2.metatable' or type(secondVector) == 'number', 'You can only divide a Vector2 with another Vector2 or a number.')
				local x, y
				if getmetatable(secondVector) == 'Vector2.metatable' then
					x, y = secondVector.x, secondVector.y
				else
					x, y = secondVector, secondVector
				end
				return Vector2.new(this.x / x, this.y / y)
			end,

			__tostring = function(this)
				return ('Vector2 %f, %f'):format(this.x, this.y)
			end

		}
	)

	return this
end

function Vector2.One()
	return Vector2.new(1, 1)
end