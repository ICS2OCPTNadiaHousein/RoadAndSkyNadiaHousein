-----------------------------------------------------------------------------------------
--
-- Character.lua
-- Created by: Housein SHiab
-- Date: January. 8, 2019
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "CharacterSelect"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAl VARIABLES
-----------------------------------------------------------------------------------------
character = nil

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local questionText

local firstNumber
local secondNumber

local answer
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3

local LavaCar 
local SkyDragon
local SkyDragon2
local SkyDragon3

local answerPosition = 1
local bkg
--local cover

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

answered = 0

local userAnswer

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 400 )

    composer.gotoScene( "level1_screen" )
end 

-----------------------------------------------------------------------------------------
--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLavaCar(touch)
    
    if (touch.phase == "ended") then
    character = display.newImageRect("Images/LavaCar.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"
        BackToLevel1( )
    
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLavaCar2(touch)
    
                 
    if (touch.phase == "ended") then
    character = display.newImageRect("Images/LavaCar.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"
        BackToLevel1( )
        
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerSkyDragon2(touch)
    
    
   
    
    if (touch.phase == "ended") then
    character = display.newImageRect("Images/SkyDragon.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"

        BackToLevel1( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerSkyDragon3(touch)
   
    

    if (touch.phase == "ended") then
    character = display.newImageRect("Images/SkyDragon.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"

        BackToLevel1( )
        
    end 
end



--adding the event listeners 
local function AddTextListeners ( )
    LavaCar:addEventListener("touch", TouchListenerLavaCar)
    LavaCar2:addEventListener("touch", TouchListenerLavaCar2)
    SkyDragon2:addEventListener("touch", TouchListenerSkyDragon2)
    SkyDragon3:addEventListener("touch", TouchListenerSkyDragon3)


end

--removing the event listeners
local function RemoveTextListeners()
    LavaCar:removeEventListener("touch", TouchListenerLavaCar)
    LavaCar2:removeEventListener("touch", TouchListenerLavaCar2)
    SkyDragon2:removeEventListener("touch", TouchListenerSkyDragon2)
    SkyDragon3:removeEventListener("touch", TouchListenerSkyDragon3)
end

local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1, 4)

    if (answerPosition == 1) then

        LavaCar.x = X1
        LavaCar.y = Y1
        
        LavaCar2.x = X1
        LavaCar2.y = Y2
        
        SkyDragon2.x = X2
        SkyDragon2.y = Y1

        SkyDragon3.x = X2
        SkyDragon3.y = Y2

        
    elseif (answerPosition == 2) then

        LavaCar.x = X1
        LavaCar.y = Y1
            
        LavaCar2.x = X1
        LavaCar2.y = Y2
            
        SkyDragon2.x = X2
        SkyDragon2.y = Y1

        SkyDragon3.x = X2
        SkyDragon3.y = Y2


    elseif (answerPosition == 3) then

        LavaCar.x = X1
        LavaCar.y = Y1
            
        LavaCar2.x = X1
        LavaCar2.y = Y2
            
        SkyDragon2.x = X2
        SkyDragon2.y = Y1

        SkyDragon3.x = X2
        SkyDragon3.y = Y2

    elseif (answerPosition == 4) then

        LavaCar.x = X1
        LavaCar.y = Y1
            
        LavaCar2.x = X1
        LavaCar2.y = Y2
            
        SkyDragon2.x = X2
        SkyDragon2.y = Y1

        SkyDragon3.x = X2
        SkyDragon3.y = Y2
            
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,1,0,1)

    -----------------------------------------------------------------------------------------
    -- create the answer text object & wrong answer text objects
    LavaCar = display.newImageRect("Images/LavaCar.png", 300, 200)
    LavaCar.anchorX = 0
    LavaCar2 = display.newImageRect("Images/LavaCar.png", 300, 200)
    LavaCar2.anchorX = 0
    SkyDragon2 = display.newImageRect("Images/SkyDragon.png", 300, 200)
    SkyDragon2.anchorX = 0
    SkyDragon3 = display.newImageRect("Images/SkyDragon.png", 300, 200)
    SkyDragon3.anchorX = 0

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(LavaCar)
    sceneGroup:insert(LavaCar2)
    sceneGroup:insert(SkyDragon2)
    sceneGroup:insert(SkyDragon3)


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

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        --DisplayQuestion()
        PositionAnswers()
        AddTextListeners()
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
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTextListeners()
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