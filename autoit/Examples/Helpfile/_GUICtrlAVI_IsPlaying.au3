#include <GuiAVI.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $hGUI, $hAVI, $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\SampleAVI.avi"
	Local $id_StartStop

	; Create GUI
	$hGUI = GUICreate("(External) AVI Open", 300, 200)
	$hAVI = _GUICtrlAVI_Create($hGUI, "", -1, 10, 10)
	$id_StartStop = GUICtrlCreateButton("Start", 50, 10, 75, 25)
	$g_idMemo = GUICtrlCreateEdit("", 10, 50, 276, 144, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Play the sample AutoIt AVI
	_GUICtrlAVI_Open($hAVI, $sFile)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $id_StartStop
				If GUICtrlRead($id_StartStop) = "Start" Then
					_GUICtrlAVI_Play($hAVI)
					GUICtrlSetData($id_StartStop, "Stop")
				Else
					_GUICtrlAVI_Stop($hAVI)
					GUICtrlSetData($id_StartStop, "Start")
				EndIf
				MemoWrite("Is Playing: " & _GUICtrlAVI_IsPlaying($hAVI))

			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	; Close AVI clip
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
