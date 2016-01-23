#include <GUIConstantsEx.au3>

Example()

Func Example()
	; X64 running support
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"

	; Retrieve the following ico file. This can be found in the include folder which is in the installation path of AutoIt.
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\icons\au3.ico"

	GUICreate("My GUI new icon") ; will create a dialog box that when displayed is centered

	GUISetIcon($sFile) ; will change icon

	GUISetState(@SW_SHOW); will display an empty dialog box

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	GUIDelete()
EndFunc   ;==>Example
