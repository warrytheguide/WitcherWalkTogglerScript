#Requires AutoHotkey v2.0
#SingleInstance Force

gameDir := "C:\Program Files (x86)\Steam\steamapps\common\The Witcher Enhanced Edition\System"
steamExePath := gameDir "\witcher.exe"

if FileExist(steamExePath) {
    Run '"' steamExePath '"', gameDir
} else if FileExist("System\witcher.exe") {
    Run "System\witcher.exe"
} else if FileExist("witcher.exe") {
    Run "witcher.exe"
} else {
    MsgBox "Could not find witcher.exe at:`n" steamExePath "`n`nPlease ensure the path is correct or place this script in your Witcher directory."
    ExitApp()
}

WinWait("ahk_exe witcher.exe")
SetTimer(CheckGameClosed, 2000)

CheckGameClosed() {
    if !ProcessExist("witcher.exe")
        ExitApp()
}

global walkMode := false
global hudHidden := false

#HotIf WinActive("ahk_exe witcher.exe")

; CapsLock = Walk / Run toggle
*CapsLock::
{
    global walkMode
    walkMode := !walkMode

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

*$w::
{
    if walkMode
        Send "{Blind}{F11 DownR}"
    else
        Send "{Blind}{w DownR}"
}

*$w up::
{
    Send "{Blind}{F11 Up}"
    Send "{Blind}{w Up}"
}

~*Alt::
~*Tab::
{
    Send "{Blind}{F11 Up}"
    Send "{Blind}{w Up}"
}

; V = HUD toggle (g_bDisableGui via console)
*v::
{
    global hudHidden, walkMode

    if GetKeyState("w", "P") {
        Send "{Blind}{F11 Up}"
        Send "{Blind}{w Up}"
    }

    hudHidden := !hudHidden
    value := hudHidden ? 0 : 1

    Send "{sc029}"
    Sleep 30
    Send "g_bDisableGui " value
    Sleep 10
    Send "{Enter}"
    Sleep 10

    if GetKeyState("w", "P") {
        if walkMode
            Send "{Blind}{F11 DownR}"
        else
            Send "{Blind}{w DownR}"
    }

    KeyWait "v"
}
#HotIf