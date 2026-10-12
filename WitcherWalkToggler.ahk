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

#HotIf WinActive("ahk_exe witcher.exe")

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
#HotIf