import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

function getTimeLeft()
	local currentTime = playdate.getSecondsSinceEpoch()
	local removalTime = playdate.epochFromTime({
		minute = 20,
		hour = 9,
		day = 26,
		month = 3,
		year = 2024,
	})
	local secondsLeft = removalTime - currentTime
	local daysLeft = math.floor(secondsLeft / 60 / 60 / 24)
	secondsLeft -= daysLeft * 60 * 60 * 24
	local hoursLeft = math.floor(secondsLeft / 60 / 60)
	secondsLeft -= hoursLeft * 60 * 60
	local minutesLeft = math.floor(secondsLeft / 60)
	secondsLeft -= minutesLeft * 60
	return {
		days = daysLeft,
		hours = hoursLeft,
		minutes = minutesLeft,
		seconds = secondsLeft,
	}
end

function display()
	playdate.graphics.drawTextAligned("*CAST COUNTER*", 200, 16, kTextAlignment.center)
	playdate.graphics.drawTextAligned("You have", 200, 48, kTextAlignment.center)
	local timeLeft = getTimeLeft()
	local timeLeftString = "*".. timeLeft.days .. "d " .. timeLeft.hours .. "h " .. timeLeft.minutes .. "m " .. timeLeft.seconds .. "s*"
	playdate.graphics.drawTextAligned(timeLeftString, 200, 80, kTextAlignment.center)
	playdate.graphics.drawTextAligned("left until the cast is removed!", 200, 112, kTextAlignment.center)
end 

function playdate.update()
	playdate.graphics.clear()
	display()
end