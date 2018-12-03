-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Nadia Coleman
-- Date: November 11, 2018
-- Description: This is the splash screen of the game. It displays the 
-- company logo that grows and spins
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"


----------------------------------------------------------------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

-- display app logo
local companyLogo = display.newImageRect("Images/CompanyLogoNadiaC@2x.png", 150, 150)
-- set the company logo X
companyLogo.x = 500
-- set the company logo Y
companyLogo.y = 500

-- create text object
local textObject
-- set company logo to be transparent
companyLogo.alpha = 0

----------------------------------------------------------------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------------------------------------------------------------
-- set scroll speed
scrollSpeed = 3


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------
-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-- Function: ScaleCompanyLogo
-- Input: this function also accepts an event listener
local function ScaleCompanyLogo(event)

    -- scale the image by 101% (X) and 101% (Y)
    companyLogo:scale( 1.01, 1.01 )
    -- change the transparency of the ship every time it moves so that it fades in
    companyLogo.alpha = companyLogo.alpha + 0.01

    transition.to(companyLogo, {rotation=360, time=3000, onComplete=spinImage})
    transition.to(companyLogo, {x=500, y=500, time=3000})
end

-- Function: ScaleTextObject
-- Input: this function also accepts an event listener
local function ScaleTextObject(event)

    -- scale the image by 102.5% (X) and 102% (Y)
    textObject:scale( 1.025, 1.02 )
    -- change the transparency of the text every time it moves so that it fades in
    textObject.alpha = textObject.alpha + 0.01
    -- make the text grow
    transition.to(textObject, {x=500, y=500, time=3000})
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view



x

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

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

    elseif ( phase == "did" ) then
        -- start the splash screen music
        backgroundSoundsChannel = audio.play( backgroundSound )

        -- Call the scaleCompanyLogo function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", scaleCompanyLogo)

        -- Call the scaleTextObject function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", scaleTextObject)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(backgroundSoundChannel)
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



return scene



