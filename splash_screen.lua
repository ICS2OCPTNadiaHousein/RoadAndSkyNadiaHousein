-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Nadia Coleman
-- Date: November 28th, 2018
-- Description: This is the splash screen, it displays the company logo animation.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )



-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

-- Creates "woosh" Sound
local woosh = audio.loadSound("Sounds/CompanyLogoSound.mp3")
local wooshChannel

-- Background sound
local backgroundSound = audio.loadSound( "Sounds/background.mp3" )
local backgroundSoundChannel 


-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local companyLogo
local scrollSpeedCompanyLogo = 7

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function gotoMainMenu ()
    composer.gotoScene( "main_menu" )
end

-- This function plays the sound effect
local function PlaySound()
    wooshChannel = audio.play(woosh)
end


-- Function: MoveLogo
-- Input: This function accepts an event listener
-- Output: None
-- Description: This function adds the scroll speed to the y-value of companyLogo
local function MoveLogo(event)
    -- Adds the scroll speed to the x-value of pingu
    companyLogo.y = companyLogo.y + scrollSpeedCompanyLogo

    if (companyLogo.y > display.contentCenterY) then
        scrollSpeedCompanyLogo = 0
        companyLogo.alpha = companyLogo.alpha - 0.019
    end
end
  


-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRUCTIONS SCREEN 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background colour
    display.setDefault ("background", 0/255, 0/255, 0/255)

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------
    
    -- Displays the company logo
    companyLogo = display.newImageRect("Images/CompanyLogoHouseinS@2x.png", 1024, 769)
    companyLogo.x = display.contentCenterX
    companyLogo.y = -display.contentHeight*1.1

    companyLogo = display.newImageRect("Images/CompanyLogoHouseinS@2x.png", 1024, 769)
    -- set the company logo X
    companyLogo.x = display.contentCenterX
    -- set the company logo Y
    companyLogo.y = -display.contentHeight*1.1

    -- Associating button widgets with this scen
    sceneGroup:insert( companyLogo )
    


end -- function scene:create( event )  


----------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------
     

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then      
        backgroundSoundChannel = audio.play(backgroundSound)
        Runtime:addEventListener("enterFrame", MoveLogo) 
        timer.performWithDelay(1996, PlaySound)

        timer.performWithDelay( 5000, gotoMainMenu )
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        -- stop the background sounds channel for this screen
        audio.stop(backgroundSoundChannel)
    end

end 
-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
    
end 

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