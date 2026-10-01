#Requires AutoHotkey v2.0
#SingleInstance Force

; 1. Launch the Witcher executable automatically
if FileExist("System\witcher.exe") {
    Run "System\witcher.exe"
} else if FileExist("witcher.exe") {
    Run "witcher.exe"
} else {
    MsgBox "Could not find witcher.exe! Please place this file in your Witcher root directory."
    ExitApp()
}

; 2. Wait for the game process to launch
WinWait("ahk_exe witcher.exe")

; 3. Periodically check if the game has closed, then exit automatically
SetTimer(CheckGameClosed, 2000)

CheckGameClosed() {
    if !ProcessExist("witcher.exe") {
        ExitApp()
    }
}

; -------------------------------------------------------------
; Walk Toggle Logic (Active only while The Witcher is focused)
; -------------------------------------------------------------
#HotIf WinActive("ahk_exe witcher.exe")

; Prevent CapsLock from actually toggling capital letters in-game
SetCapsLockState "AlwaysOff"

global walkMode := false

; Press CapsLock to toggle Walk / Run
*CapsLock::
{
    global walkMode := !walkMode

    ; If W is currently being held, seamlessly switch mid-stride
    if GetKeyState("w", "P") {
        if walkMode {
            Send "{Blind}{w Up}"
            Sleep 25
            Send "{Blind}{F11 DownR}"
        } else {
            Send "{Blind}{F11 Up}"
            Sleep 25
            Send "{Blind}{w DownR}"
        }
    }
}

; Intercept W key down
*$w::
{
    if walkMode {
        Send "{Blind}{F11 DownR}"
    } else {
        Send "{Blind}{w DownR}"
    }
}

; Intercept W key up
*$w up::
{
    Send "{Blind}{F11 Up}"
    Send "{Blind}{w Up}"
}

; Failsafe: release movement keys if Alt-Tabbing or switching windows
~*Alt::
~*Tab::
{
    Send "{Blind}{F11 Up}"
    Send "{Blind}{w Up}"
}

#HotIf
