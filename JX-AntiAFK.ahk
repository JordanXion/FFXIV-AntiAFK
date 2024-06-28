; Anti-AFK v1.0
; By JX - https://github.com/JordanXion/FFXIV-AntiAFK
;
; Ctrl + Shift + F9 to toggle

#Requires AutoHotkey v2.0

; Settings
movementKeys := ["w", "a", "s", "d", "Space"] ; movement keys that will be pressed randomly
menuKeys := ["c", "u", "i", "h", "o", "p", "n", "m"] ; menus that will be toggled randomly
delayMin := 200 ; minimum time (ms) between actions
delayMax := 3000 ; maximum time (ms) between actions
targetExe := "ffxiv_dx11.exe" ; the exe we are sending keypresses to


PressRandomMovementKey() {
    randomKey := movementKeys[Random(1, movementKeys.Length)]
    if WinActive("ahk_exe " targetExe) {
        Send "{" randomKey " down}"
        Sleep Random(500, 3000)
        Send "{" randomKey " up}"
    }
}

ToggleRandomMenu() {
    randomKey := menuKeys[Random(1, menuKeys.Length)]
    if WinActive("ahk_exe " targetExe) {
        Send "{" randomKey "}"
        Sleep Random(500, 3000)
        Send "{" randomKey "}"
    }
}

isActive := true

^+F9:: {
    global isActive
    isActive := !isActive
    if (isActive) {
        ToolTip("Anti-AFK Activated")
    } else {
        ToolTip("Anti-AFK Paused")
    }
    SetTimer () => ToolTip(), -2500
}

; Main loop
Loop {
    if (isActive) {
        if (Random(1, 5) == 1) {
            ToggleRandomMenu()
        } else {
            PressRandomMovementKey()
        }
    }
    Sleep Random(delayMin, delayMax)
}