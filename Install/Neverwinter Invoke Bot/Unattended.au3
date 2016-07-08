#RequireAdmin
AutoItSetOption("TrayAutoPause", 0)
Local $Title = "Neverwinter Invoke Bot: Unattended Launcher"
TraySetToolTip($Title)
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include "Shared.au3"
If _Singleton("Unattended Launcher" & "Jp4g9QRntjYP", 1) = 0 Then
    MsgBox($MB_ICONWARNING, $Title, Localize("UnattendedAlreadyRunning"))
    Exit
EndIf
#include "_GetUTCMinutes.au3"
While 1
    TraySetIcon(@ScriptDir & "\images\teal.ico")
    Local $min = 0
    While 1
        $min = _GetUTCMinutes(10, 1, True, False, True, $Title)
        If $min >= 0 Then
            ExitLoop
        EndIf
        TraySetToolTip($Title & @CRLF & Localize("FailedToGetMinutes"))
        Sleep(600000)
    WEnd
    TraySetToolTip($Title)
    TraySetIcon(@ScriptDir & "\images\blue.ico")
    Sleep($min * 60000)
    TraySetIcon(@ScriptDir & "\images\green.ico")
    If @Compiled Then
        ShellexecuteWait(@ScriptDir & "\Neverwinter Invoke Bot.exe", 1, @ScriptDir)
    Else
        ShellexecuteWait(@AutoItExe, '/AutoIt3ExecuteScript "' & @ScriptDir & '\Neverwinter Invoke Bot.au3" 1', @ScriptDir)
    EndIf
WEnd