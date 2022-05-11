# StormFox 1/2 HUD & ULX Module
This is for Garry's Mod and the StormFox 1/2 Addon. This adds a simple clock to your hud reflecting the StormFox time.

Includes ULX Module to control StormFox - See below for Features

![Current version of clock with server name enabled](https://i.imgur.com/BxslrHr.png)

## Requirements
- Garry's Mod Server
- StormFox 1/2 Installed on Server
- ULX & ULib for the Module
- Access to the server addons folder (Ignore if it's workshop release)

## Installation

Simply install the folder to garrysmod/addons. Ensure the folder is lowercase as it may cause issues on Linux based servers.

If you want just the ULX Module delete the **autorun** folder. 

## ConVars
`StormFoxHudServerNameEnabled 1`
Allows you to disable/enable the Server Name under the clock

`StormFoxHudServerName "My Server Name"`
Sets the Server Name to appear under the clock

The can **only** be changed by the server and they update in real time. You will need to put these into your **autoexec.cfg** or **server.cfg**

## Current Features
- Displays the time from StormFox 1/2
- Displays Server Name set via ConVars which can be disabled
- ULX Module - Set Time, Set Weather and Strength, Set Temp & Set Wind Speed

## Upcoming Features

 - Display the weather with toggleable ConVars - Stretch goal is to have Just Text/Icons/Icons and Text
 - Display the temperature with toggleable ConVars - Stretch goal is to have Just Text/Icons/Icons and Text
 - ~~Add missing StormFox features to the ULX Module (Weather Change, Temp change, etc)~~
 - ~~Garry's Mod Workshop Release~~
 - Format all variables under the clock so that it formats itself when something is disabled.
 - Allow server admins to set the position of the hud via ConVars (Workshop release only - If they don't want to modify the code themselves)

## Usage

Feel free to use and modify at will for your own servers. No need to credit us or anything but always appreciated if you do.

## Contact
Any issues contact me on Discord  - Fate#2191 or join https://discord.gg/SoulNetworks
