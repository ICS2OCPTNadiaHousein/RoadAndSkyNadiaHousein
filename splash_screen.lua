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

-- Background sound
local backgroundSound = audio.loadStream( "Sounds/background.mp3" )
local backgroundSoundChannel


-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local companyLogo

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function goToSplash_Screen2 ()
    composer.gotoScene( "splash_screen2" )
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
    display.setDefault ("background", 132/255, 119/255, 254/255)

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------
    companyLogo = display.newImageRect("Images/CompanyLogoNadiaC@2x.png", 150, 150)
    -- set the company logo X
    companyLogo.x = 500
    -- set the company logo Y
    companyLogo.y = 500

    -- Associating button widgets with this scen
    sceneGroup:insert( companyLogo )
    


end -- function scene:create( event )   


local function ScaleLogo()
    companyLogo:scale(1.01, 1.01)
   
    -- Call the scaleCompanyLogo function as soon as we enter the frame.
    
end

local function GrowCompanyLogo()
    
    transition.to(companyLogo, {x=500, y=500, time=3000})

end


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
    
    backgroundSoundChannel = audio.play(backgroundSound {channel=3, loops=-1})


    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then      

        Runtime:addEventListener("enterFrame", ScaleLogo) 

        transition.to(companyLogo, {rotation=360, time=3000, onComplete=spinImage})

        timer.performWithDelay( 3000, goToSplash_Screen2 )
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