-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Housein
-- Date: 6,12,2018
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
-- Background sound
local backgroundSound = audio.loadSound( "Sounds/background2.mp3" )
local backgroundSoundChannel
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

numLives = 3
answered = 0
motionxBall = 6
character.isVisible = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local heart1
local heart2
local heart3

local rArrow
local lArrow
local uArrow
local dArrow

local motionx = 0
local SPEED = 5
local motiony = 0
local GRAVITY = 0

local motionxBall1 
local motionxBall2
local motionxBall3
local motionxBall = 4

local leftW
local rightW
local topW
local floor

local obstacle1
local obstacle2
local obstacle3
local theBall

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 
 
-- When right arrow is touched, move character right
local function right (touch)
    motionx = SPEED
    character.xScale = -1
end

-- When left arrow is touched, move character left
local function left (touch)
    motionx = -SPEED
    character.xScale = 1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    motiony = -SPEED
end

-- When up arrow is touched, add vertical so it can jump
local function down (touch)
    motiony = SPEED
end

-- Move character horizontally
local function movePlayer (event)
    
        character.x = character.x + motionx
        character.y = character.y + motiony
    
end

local function resetObstacles()
    
    motionxBall1 = math.random(7, 10)
    motionxBall2 = math.random(7, 10)
    motionxBall3 = math.random(7, 10)

    obstacle1.x = display.contentWidth
    obstacle2.x = display.contentWidth
    obstacle3.x = display.contentWidth

    obstacle1.y = math.random(0, 100)
    obstacle2.y = math.random(275, 400)
    obstacle3.y = math.random(560, 770)
end

-- Moves the obsticles
local function moveObstacles()
    obstacle1.x = obstacle1.x - motionxBall1
    obstacle2.x = obstacle2.x - motionxBall2
    obstacle3.x = obstacle3.x - motionxBall3
    if (obstacle1.x < 0) and
       (obstacle2.x < 0) and
       (obstacle3.x < 0) then
       resetObstacles()
   end
end

-- Stop character movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
        motiony = 0
    end
end


local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    lArrow:addEventListener("touch", left)
    uArrow:addEventListener("touch", up)
    dArrow:addEventListener("touch", down)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    lArrow:addEventListener("touch", left)
    uArrow:removeEventListener("touch", up)
    dArrow:addEventListener("touch", down)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    
    Runtime:removeEventListener("touch", stop )
end


local function ReplaceCharacter()
    
    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )
    
    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

local function MakeSoccerBallsVisible()
    obstacle1.isVisible = true
    obstacle2.isVisible = true
    obstacle3.isVisible = true
end

local function MakeHeartsVisible()
    heart1.isVisible = true
    heart2.isVisible = true
    heart3.isVisible = true
end

function YouLoseTransition()
    composer.gotoScene( "you_lose" )
end

function YouWinTransition()
    composer.gotoScene( "you_win" )
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then
        if  (event.target.myName == "obstacle1") and (event.other.myName == "character") or
            (event.target.myName == "obstacle2") and (event.other.myName == "character") or
            (event.target.myName == "obstacle3") and (event.other.myName == "character")then

            -- get the ball that the user hit
            theBall = event.target

            print ("***Collided with obstacle")

            -- stop the character from moving
            motionx = 0
            motiony = 0
            motionxBall1 = 0
            motionxBall2 = 0
            motionxBall3 = 0
            LINEAR_VELOCITY = 0
            LINEAR_VELOCITY2 = 0



            -- make the character invisible
            character.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

            
        end
    end
end


local function AddCollisionListeners()
    -- if character collides with ball, onCollision will be called    
    obstacle1.collision = onCollision
    obstacle1:addEventListener( "collision" )
    obstacle2.collision = onCollision
    obstacle2:addEventListener( "collision" )
    obstacle3.collision = onCollision
    obstacle3:addEventListener( "collision" )
end

local function RemoveCollisionListeners()
    obstacle1:removeEventListener( "collision" )
    obstacle2:removeEventListener( "collision" )
    obstacle3:removeEventListener( "collision" )
end

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(obstacle1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(obstacle2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(obstacle3, "static",  {density=0, friction=0, bounce=0} )
end

local function RemovePhysicsBodies()
    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)
end


local function UpdateHearts()

    print ("***numLives = " .. numLives)
    if (numLives == 3) then
        -- update hearts
        heart1.isVisible = true
        heart2.isVisible = true
        heart3.isVisible = true
    elseif (numLives == 2) then
        heart1.isVisible = false
        heart2.isVisible = true
        heart3.isVisible = true
 
    elseif (numLives == 1) then              
        -- update hearts
        heart1.isVisible = false
        heart2.isVisible = false
        heart3.isVisible = true
    elseif (numLives == 0) then
        heart1.isVisible = false
        heart2.isVisible = false
        heart3.isVisible = false
        timer.performWithDelay(200, YouLoseTransition)
     end
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeLevel1()

    -- make character visible again
    character.isVisible = true

    resetObstacles()
    UpdateHearts()

    if (answered == 3) then
        YouWinTransition()
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level-1BKG.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

    -- Insert the Hearts
    heart1 = display.newImageRect("Images/heart.png", 80, 80)
    heart1.x = 50
    heart1.y = 50
    heart1.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart1 )

    heart2 = display.newImageRect("Images/heart.png", 80, 80)
    heart2.x = 130
    heart2.y = 50
    heart2.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart2 )

    -- Insert the Hearts
    heart3 = display.newImageRect("Images/heart.png", 80, 80)
    heart3.x = 210
    heart3.y = 50
    heart3.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart3 )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = 650

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)

    --Insert the left arrow
    lArrow = display.newImageRect("Images/LeftArrowUnpressed.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = 650

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( lArrow)

    --Insert the left arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = 580

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow)

        --Insert the left arrow
    dArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, -100)
    dArrow.x = display.contentWidth * 8.2 / 10
    dArrow.y = 700

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( dArrow)

    --WALLS--
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leftW )

    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    floor = display.newImageRect("Images/Level-1Floor.png", 1024, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 1.06
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )

    --obstacle1
    obstacle1 = display.newImageRect ("Images/fireball.png", 70, 70)
    obstacle1.x = 2148
    obstacle1.y = 480
    obstacle1.myName = "obstacle1"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( obstacle1 )

    --obstacle2
    obstacle2 = display.newImageRect ("Images/fireball.png", 70, 70)
    obstacle2.x = 2148
    obstacle2.y = 170
    obstacle2.myName = "obstacle2"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( obstacle2 )

    --obstacle3
    obstacle3 = display.newImageRect ("Images/fireball.png", 70, 70)
    obstacle3.x = 2148
    obstacle3.y = 700
    obstacle3.myName = "obstacle3"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( obstacle3 )

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY )

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        backgroundSoundChannel = audio.play(backgroundSound, { channel=1, loops=-1})

        -- set the number of lives
        numLives = 3

        -- make all soccer balls visible
        MakeSoccerBallsVisible()

        -- make all lives visible
        MakeHeartsVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the character, add physics bodies and runtime listeners
        ReplaceCharacter()
        resetObstacles()

        Runtime:addEventListener("enterFrame", moveObstacles)

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        audio.stop(backgroundSoundChannel)

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveCollisionListeners()
        RemovePhysicsBodies()

        physics.stop()
        Runtime:removeEventListener("enterFrame", moveObstacles)
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene