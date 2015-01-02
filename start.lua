-- requires 
local physics = require "physics"
physics.start()
local mydata = require( "mydata" )

local storyboard = require ("storyboard")
local startScene = storyboard.newScene()

-------------------------------------------------------------------------------------

function startGame(event)
     if event.phase == "ended" then
		storyboard.gotoScene("game")
     end
end

function groundScroller(self,event)
	
	if self.x < (-900 + (self.speed*2)) then
		self.x = 900
	else 
		self.x = self.x - self.speed
	end
	
end

function titleTransitionDown()
	downTransition = transition.to(titleGroup,{time=400, y=titleGroup.y+20,onComplete=titleTransitionUp})
	
end

function titleTransitionUp()
	upTransition = transition.to(titleGroup,{time=400, y=titleGroup.y-20, onComplete=titleTransitionDown})
	
end

function titleAnimation()
	titleTransitionDown()
end

-------------------------------------------------------------------------------------

function startScene:createScene(event)

	local screenGroup = self.view

	background = display.newImageRect("images/bg.png",900,1425)
	background.anchorX = 0.5
	background.anchorY = 1
	background.x = display.contentCenterX
	background.y = display.contentHeight
	screenGroup:insert(background)
	
	title = display.newImageRect("images/title.png",500,100)
	title.anchorX = 0.5
	title.anchorY = 0.5
	title.x = display.contentCenterX - 80
	title.y = display.contentCenterY 
	screenGroup:insert(title)
	
	platform = display.newImageRect('images/platform.png',900,53)
	platform.anchorX = 0
	platform.anchorY = 1
	platform.x = 0
	platform.y = display.viewableContentHeight - 110
	physics.addBody(platform, "static", {density=.1, bounce=0.1, friction=.2})
	platform.speed = 4
	screenGroup:insert(platform)

	platform2 = display.newImageRect('images/platform.png',900,53)
	platform2.anchorX = 0
	platform2.anchorY = 1
	platform2.x = platform2.width
	platform2.y = display.viewableContentHeight - 110
	physics.addBody(platform2, "static", {density=.1, bounce=0.1, friction=.2})
	platform2.speed = 4
	screenGroup:insert(platform2)
	
	ground = display.newImageRect('images/ground.png',900,162)
	ground.anchorX = 0
	ground.anchorY = 1
	ground.x = 0
	ground.y = 162
	print("*****this is ground insert")
	print(display.contentHeight)
	screenGroup:insert(ground)

	start = display.newImageRect("images/start_btn.png",300,65)
	start.anchorX = 0.5
	start.anchorY = 1
	start.x = display.contentCenterX
	start.y = display.contentHeight - 400
	screenGroup:insert(start)
-- top platform	
	top_platform = display.newImageRect('images/top_platform.png',900,53)
	top_platform.anchorX = 0
	top_platform.anchorY = 1
	top_platform.x = 0
	top_platform.y = 162
	physics.addBody(top_platform, "static", {density=.1, bounce=0.1, friction=.2})
	top_platform.speed = 4
	screenGroup:insert(top_platform)

	top_platform2 = display.newImageRect('images/top_platform.png',900,53)
	top_platform2.anchorX = 0
	top_platform2.anchorY = 1
	top_platform2.x = top_platform2.width
	top_platform2.y = 162 --display.viewableContentHeight - 1300
	physics.addBody(top_platform2, "static", {density=.1, bounce=0.1, friction=.2})
	top_platform2.speed = 4
	screenGroup:insert(top_platform2)
	
	start = display.newImageRect("images/start_btn.png",300,65)
	start.anchorX = 0.5
	start.anchorY = 1
	start.x = display.contentCenterX
	start.y = display.contentHeight - 400
	screenGroup:insert(start)

	p_options = 
	{
		-- Required params
		width = 80,
		height = 42,
		numFrames = 2,
		-- content scaling
		sheetContentWidth = 160,
		sheetContentHeight = 42,
	}

	playerSheet = graphics.newImageSheet( "images/car.png", p_options )
	player = display.newSprite( playerSheet, { name="player", start=1, count=2, time=500 } )
	player.anchorX = 0.5
	player.anchorY = 0.5
	player.x = display.contentCenterX + 240
	player.y = display.contentCenterY 
	player:play()
	screenGroup:insert(player)
	
	titleGroup = display.newGroup()
	titleGroup.anchorChildren = true
	titleGroup.anchorX = 0.5
	titleGroup.anchorY = 0.5
	titleGroup.x = display.contentCenterX
	titleGroup.y = display.contentCenterY - 250
	titleGroup:insert(title)
	titleGroup:insert(player)
	screenGroup:insert(titleGroup)
	titleAnimation()

end


function startScene:enterScene(event)

	storyboard.removeScene("restart")
	start:addEventListener("touch", startGame)
	platform.enterFrame = groundScroller
	Runtime:addEventListener("enterFrame", platform)
	platform2.enterFrame = groundScroller
	Runtime:addEventListener("enterFrame", platform2)
    top_platform.enterFrame = groundScroller
	Runtime:addEventListener("enterFrame", top_platform)
	top_platform2.enterFrame = groundScroller
	Runtime:addEventListener("enterFrame", top_platform2)
end

function startScene:exitScene(event)
print("exit startScene happened!")
	start:removeEventListener("touch", startGame)
	Runtime:removeEventListener("enterFrame", platform)
	Runtime:removeEventListener("enterFrame", platform2)
	Runtime:removeEventListener("enterFrame", top_platform)
	Runtime:removeEventListener("enterFrame", top_platform2)
	transition.cancel(downTransition)
	transition.cancel(upTransition)
	
end

function startScene:destroyScene(event)

end


startScene:addEventListener("createScene", startScene)
startScene:addEventListener("enterScene", startScene)
startScene:addEventListener("exitScene", startScene)
startScene:addEventListener("destroyScene", startScene)

return startScene













