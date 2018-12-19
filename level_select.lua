-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Nadia Coleman
-- Date: November 25th, 2018
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

-- Background sound
local backgroundSound = audio.loadSound( "Sounds/vehicle.mp3" )
local backgroundSoundChannel = audio.play(backgroundSound,{channel=1,loops=-1})

local buttonSound = audio.loadSound( "Sounds/buttonPressed.mp3")
local buttonSoundChannel

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
sceneName = "level_select"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    --[[-- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/level_select.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )]]


    -----------------------------------------------------------------------------------------
    -- TEXT
    -----------------------------------------------------------------------------------------   

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    lvl2Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 512,
            y = display.contentHeight/2,
            width = 185,
            height = 185,

            -- Insert the images here
            defaultFile = "Images/Level2Pressed.png",
            overFile = "Images/Level2Pressed.png",
  
            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition  
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    lvl3Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 748,
            y = display.contentHeight/2,
            width = 185,
            height = 185,

            -- Insert the images here
            defaultFile = "Images/Level3Pressed.png",
            overFile = "Images/Level3Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
            
        } ) 
    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button
    lvl1Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 276,
            y = display.contentHeight/2,
            width = 185,
            height = 185,

            -- Insert the images here
            defaultFile = "Images/Level1Pressed.png",
            overFile = "Images/Level1Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = InstructionsScreenTransition          
        } )


    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( lvl1Button )
    sceneGroup:insert( lvl2Button )
    sceneGroup:insert( lvl3Button )
end -- function scene:create( event )   

-----------------------------------------------------------------------------------------

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
    audio.play(baqckgroundSoundChannel)
    elseif ( phase == "did" ) then       
        

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
        --audio.stop(backgroundSoundChannel)


    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
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
