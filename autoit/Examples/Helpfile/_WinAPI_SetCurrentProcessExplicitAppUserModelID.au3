#NoTrayIcon

#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.1' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later.')
	Exit
EndIf

Local $sAppID = 'Yashied.WinAPIEx.UDF'

Local $sParam
If Not $CmdLine[0] Then
	For $i = 1 To 5
		Switch $i
			Case 1 To 2
				$sParam = $sAppID & '.' & $i
			Case Else
				$sParam = $sAppID & '.3'
		EndSwitch
		If Not @Compiled Then
			Run(@AutoItExe & ' "' & @ScriptFullPath & '" ' & $sParam)
		Else
			Run(@AutoItExe & ' ' & $sParam)
		EndIf
		Sleep(100)
	Next
	Exit
EndIf

_WinAPI_SetCurrentProcessExplicitAppUserModelID($CmdLine[1])

GUICreate($CmdLine[1], 400, 400)
GUISetState(@SW_SHOWMINIMIZED)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
