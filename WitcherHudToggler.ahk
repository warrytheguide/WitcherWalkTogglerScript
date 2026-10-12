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

global hudHidden := false

#HotIf WinActive("ahk_exe witcher.exe")

; V = HUD toggle (g_bDisableGui via console)
*v::
{
    global hudHidden

    ; Release W so it doesn't interfere with the console
    if GetKeyState("w", "P")
        Send "{Blind}{w Up}"

    hudHidden := !hudHidden
    value := hudHidden ? 0 : 1

    Send "{sc029}"
    Sleep 30
    Send "g_bDisableGui " value
    Sleep 10
    Send "{Enter}"
    Sleep 10

    ; Resume walking/running if W is still physically held
    if GetKeyState("w", "P")
        Send "{Blind}{w DownR}"

    KeyWait "v"
}
#HotIf