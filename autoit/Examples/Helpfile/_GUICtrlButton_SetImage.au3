#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $idBtn, $idChk, $idRdo, $iMsg
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\Advanced\Images"

	GUICreate("Buttons", 300, 300)
	$g_idMemo = GUICtrlCreateEdit("", 2, 60, 296, 236, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	$idBtn = GUICtrlCreateButton("Button1", 10, 10, 40, 40, $BS_BITMAP)
	_GUICtrlButton_SetImage($idBtn, $sPath & "\blue.bmp")

	$idChk = GUICtrlCreateCheckbox("Check1", 60, 10, 50, 32, $BS_ICON)
	_GUICtrlButton_SetImage($idChk, "shell32.dll", 14, True)

	$idRdo = GUICtrlCreateRadio("Radio1", 120, 10, 50, 32, $BS_ICON)
	_GUICtrlButton_SetImage($idRdo, "shell32.dll", 21, True)

	MemoWrite("Button1 Image Handle: " & _GUICtrlButton_GetImage($idBtn))
	MemoWrite("Check1 Image Handle: " & _GUICtrlButton_GetImage($idChk))
	MemoWrite("Radio1 Image Handle: " & _GUICtrlButton_GetImage($idRdo))

	While 1
		$iMsg = GUIGetMsg()
		If $iMsg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd

	Exit
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
