local vide = require("../../vide")

local source = vide.source
local create = vide.create
local values = vide.values
local indexes = vide.indexes

local function Text()
	return create("TextLabel")({
		Text = "Hello, world!",
		Size = UDim2.new(0, 200, 0, 50),
		BackgroundColor3 = Color3.new(1, 1, 1),
	})
end

local cardList = source({
	{ name = "Business Tower" },
	{ name = "Residential Tower" },
})

local textLabel = create("TextLabel")({
	Text(),
	Text = "Label",

	indexes(cardList, function(value, index, present)
		return create("TextLabel")({
			Text = "",
		})
	end),
})
