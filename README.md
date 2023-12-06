# MakeMKV-AHK-Automation
An AutoHotKey script for automating all the clicking for mass ripping DVDs using MakeMKV

# Installation
Clone this repo or download and extract the ZIP. Make sure you have AutoHotKey v1.x installed. Execute the `RunAutoRipper.ahk` script to start auto ripping.

# The overall idea
This script checks to see what visual elements are being displayed in order to determine what state the disc ripping process is in. Based on the current state, the script will click certain buttons in order to progress the ripping process. Ultimately, once the disc is ripped, the system will eject the disc and wait for the next one.

# Errors
If errors occur during the ripping process because the disc is dirty/bad, alert messages might pop up. The script will not progress further until these errors are aknowledged.

# Possible states this MakeMKV script is in
State | Description
-|-
EJECTED | Waiting for a disc
SPINNING | Waiting for inserted disc to become available
READY_TO_LOAD | Disc is ready, script clicks button to load the disc
LOADING | Waiting for disc to load
READY | Disc is ready for ripping, add number to disc name, start ripping
RIPPING | Waiting for ripping to complete
COMPLETE | Ripping complete, eject disc
NONE | Script can't determine the current state

# Script Notes
The script assumes MakeMKV is installed at `"C:\Program Files (x86)\MakeMKV\makemkv.exe"`. Adjust this if needed.

In `MakeMKVManager.ahk`, in the `EJECTED` function, I have it set to beep at me every second once the disc is ejected. Edit that if you don't want the beeping.

I'm using a drive with a disc tray that pops out and stays out until I push in a new disc. I haven't tested this script using a drive without a tray. I'm not sure if the ejection state will act differently with those types of drives.

## MakeMKV Settings
In MakeMKV, go to View > Preferences > Video to set the "Default destination" to use "SemiAuto" and select the folder you'd like your rips to go to. Also set the "Minimum title length" so you don't get all the little 1-5 minute video transitions, ads, and misc behind-the-scenes stuff (unless you want all that). I usually have it set to 900 seconds (15 mins) unless I'm ripping a kids show that has episodes with a duration less than that.

## Converting for Plex Server
I use Handbrake to convert the `.mkv` files to a usable `.mp4` file format that works nicely with Plex Server.

# The Process
If MakeMKV isn't open, the script will try to open it. Once the MakeMKV window is available, the script will activate it and be ready further actions.

MakeMKV displays an image of a disc drive with it's tray popped out when the tray is ejected. This image triggers the EJECTED state and the script waits for a disc.

MakeMKV displays an image of a disc spinning in a drive when a disc gets inserted. This image triggers the SPINNING state and the script waits for the disc to become available.

MakeMKV displays an image of a drive with a green light when a disc is ready for loading. This image triggers the READY_TO_LOAD state and the script will click the image in order to start loading up the disc.

MakeMKV displays the text "Opening DVD disc" while it's loading a disc. This image triggers the LOADING state and the script waits for the loading to complete.

MakeMKV displays the text "Operation successfully completed" once a disc is fully loaded. This image triggers the READY state and the script adds an autoincremented index to the disc name (e.g. "_1", "_2"..etc) in case you're ripping a season of something and their discs are all named the same thing. Then, it clicks the "Rip" button to start the process.

MakeMKV displays the text "Saving all titles to MKV files" while it rips a disc. This image triggers the RIPPING state and the script waits for it to complete.

MakeMKV displays the text "Copy complete." once ripping is done. This image triggers the COMPLETE state and the script ejects the disc. Once the disc is ejected, the cycle loops back up to the EJECTED state and starts over.
