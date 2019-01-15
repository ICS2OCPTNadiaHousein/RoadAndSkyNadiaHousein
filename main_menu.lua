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
local backgroundSound = audio.loadSound( "Sounds/mainMenu.mp3" )
local backgroundSoundChannel

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
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton

local muteButton
local textObject
local soundOn = true


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "slideDown", time = 500})    
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function CharacterSelect( )
    composer.gotoScene( "CharacterSelect", {effect = "slideDown", time = 1000})
end    
 

-----------------------------------------------------------------------------------------

-- Creating Transition to Instructions Screen
local function InstructionsScreenTransition( )
    composer.gotoScene( "instructions_screen", {effect = "slideDown", time = 1000})
end 

local function MuteButton( )
    if (soundOn == true) then
        audio.setVolume(0)
        soundOn = false
    elseif (soundOn == false) then
        audio.setVolume(1)
        soundOn = true
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

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/main_menu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )


    -----------------------------------------------------------------------------------------
    -- TEXT
    -----------------------------------------------------------------------------------------   
    -- displays text on the screen at posistion x = 500 and y = 500 with 
    -- a default font style and font size of 50
    textObject = display.newText( "ROAD & SKY", 500, 300, nil, 100)
    -- sets the color of the text
    textObject:setTextColor(100/255, 55/255, 120/255)

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,
            width = 185,
            height = 185,

            -- Insert the images here
            defaultFile = "Images/PlayButtonUnpressed@2x.png",
            overFile = "Images/PlayButtonPressed@2x.png",
  
            -- When the button is released, call the Level1 screen transition function
            onRelease = CharacterSelect
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*7/8,
            y = display.contentHeight*7/8,
            width = 185,
            height = 185,

            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressed.png",
            overFile = "Images/CreditsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
            
        } ) 
    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button
    instructionsButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/4.5,
            y = display.contentHeight*7/8,
            width = 200,
            height = 150,

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = InstructionsScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button
    muteButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/1/8,
            y = display.contentHeight*2/4,
            width = 80,
            height = 80,

            -- Insert the images here
            defaultFile = "Images/muteUnpressed.png",
            overFile = "Images/mutePressed.png",

            onRelease = MuteButton

        } )

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( textObject )
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
    elseif ( phase == "did" ) then       
        
        backgroundSoundChannel = audio.play(backgroundSound,{channel=1,loops=-1})
       
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
        audio.stop (backgroundSoundChannel)
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
