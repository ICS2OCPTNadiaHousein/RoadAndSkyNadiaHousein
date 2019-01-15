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

local LavaCar 
local LavaDragon
local SkyCar
local SkyDragon

local answerPosition = 1
local bkg
local textObject

local userAnswer

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevelSelect() 
    composer.hideOverlay("crossFade", 400 )

    character.isVisible = false

    composer.gotoScene( "level_select" )
end 

local function BackButtonTransition( )
    composer.gotoScene( "main_menu", {effect = "slideDown", time = 1000})
end  

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLavaCar(touch)
    
    if (touch.phase == "ended") then
    character = display.newImageRect("Images/LavaCar.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"

        BackToLevelSelect( )
    
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLavaDragon(touch)
    
                 
    if (touch.phase == "ended") then
    character = display.newImageRect("Images/LavaDragon.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"

        BackToLevelSelect( )
        
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerSkyCar(touch)
    
    
   
    
    if (touch.phase == "ended") then
    character = display.newImageRect("Images/SkyCar.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"

        BackToLevelSelect( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerSkyDragon(touch)
   
    

    if (touch.phase == "ended") then
    character = display.newImageRect("Images/SkyDragon.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 195
    character.height = 150
    character.myName = "character"

        BackToLevelSelect( )
        
    end 
end



--adding the event listeners 
local function AddTextListeners ( )
    LavaCar:addEventListener("touch", TouchListenerLavaCar)
    LavaDragon:addEventListener("touch", TouchListenerLavaDragon)
    SkyCar:addEventListener("touch", TouchListenerSkyCar)
    SkyDragon:addEventListener("touch", TouchListenerSkyDragon)


end

--removing the event listeners
local function RemoveTextListeners()
    LavaCar:removeEventListener("touch", TouchListenerLavaCar)
    LavaDragon:removeEventListener("touch", TouchListenerLavaDragon)
    SkyCar:removeEventListener("touch", TouchListenerSkyCar)
    SkyDragon:removeEventListener("touch", TouchListenerSkyDragon)
end

local function PositionAnswers()

        LavaCar.x = 200
        LavaCar.y = 300
        
        LavaDragon.x = 200
        LavaDragon.y = 600
        
        SkyCar.x = 500
        SkyCar.y = 300

        SkyDragon.x = 500
        SkyDragon.y = 600
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
    bkg:setFillColor(1,1,0.3,1)

    ----------------------------------------------------------------------------------------
    -- TEXT
    -----------------------------------------------------------------------------------------
    textObject = display.newText( "Character Select", 500, 100, nil, 100)
    -- sets the color of the text
    textObject:setTextColor(75/255, 55/255, 40/255)

    -----------------------------------------------------------------------------------------
    -- create the answer text object & wrong answer text objects
    LavaCar = display.newImageRect("Images/LavaCar.png", 300, 200)
    LavaCar.anchorX = 0
    LavaDragon = display.newImageRect("Images/LavaDragon.png", 300, 200)
    LavaDragon.anchorX = 0
    SkyCar = display.newImageRect("Images/SkyCar.png", 300, 200)
    SkyCar.anchorX = 0
    SkyDragon = display.newImageRect("Images/SkyDragon.png", 300, 200)
    SkyDragon.anchorX = 0

    -----------------------------------------------------------------------------------------

        backButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 75,
            y = 105,
            width = 110,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Back Button Unpressed.png",
            overFile = "Images/Back Button Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = BackButtonTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(LavaCar)
    sceneGroup:insert(LavaDragon)
    sceneGroup:insert(SkyCar)
    sceneGroup:insert(SkyDragon)
    sceneGroup:insert(textObject)
    sceneGroup:insert(backButton)


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