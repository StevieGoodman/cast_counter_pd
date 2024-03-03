import "CoreLibs/graphics"

local APPLICATION_TIME <const> = playdate.epochFromTime({
	minute = 00,
	hour = 10,
	day = 9,
	month = 2,
	year = 2024,
})
local REMOVAL_TIME <const> = playdate.epochFromTime({
	minute = 20,
	hour = 9,
	day = 26,
	month = 3,
	year = 2024,
})

local gfx <const> = playdate.graphics

function getTimeBetween(timeA, timeB)
	local currentTime = playdate.getSecondsSinceEpoch()
	local secondsLeft = 0
	if timeA > timeB then
	    secondsLeft = timeA - timeB
	else
		secondsLeft = timeB - timeA
	end
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

function getTimeLeft()
	return getTimeBetween(REMOVAL_TIME, playdate.getSecondsSinceEpoch())
end

function getSecondsSince()
	return playdate.getSecondsSinceEpoch() - APPLICATION_TIME
end

function getDurationInSeconds()
	return REMOVAL_TIME - APPLICATION_TIME
end

function display()
	playdate.graphics.drawTextAligned("*CAST COUNTER*", 200, 16, kTextAlignment.center)
	
	-- Time left
	local timeLeft = getTimeLeft()
	local timeLeftString = "*"..timeLeft.days.."d "..timeLeft.hours.."h "..timeLeft.minutes.."m "..timeLeft.seconds.."s*"
	playdate.graphics.drawTextAligned("You have\n"..timeLeftString.."\nleft until the cast is removed!", 200, 42, kTextAlignment.center)
	
	-- Percentage
	local percentage = math.floor(
		(getSecondsSince() / getDurationInSeconds()) * 100
	)
	local percentageString = "That's *"..percentage.."%* of the way there!"
	playdate.graphics.drawTextAligned(percentageString, 200, 96+32, kTextAlignment.center)
end 

function playdate.update()
	playdate.graphics.clear()
	display()
end