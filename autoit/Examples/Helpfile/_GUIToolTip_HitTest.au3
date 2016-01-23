#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Global $g_hToolTip, $g_aPos, $g_hAdd

; Press g to display the current tooltip information.
HotKeySet("g", "GetInfo")

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idAdd = GUICtrlCreateButton("Button ToolTip", 30, 32, 130, 28)
	$g_hAdd = GUICtrlGetHandle($idAdd)

	$g_hToolTip = _GUIToolTip_Create($hGUI, $TTS_CLOSE + $TTS_BALLOON)

	_GUIToolTip_AddTool($g_hToolTip, 0, "X: " & @TAB & " Y: " & @TAB, $g_hAdd)

	Local $hIcon = _WinAPI_LoadShell32Icon(15)

	_GUIToolTip_SetTitle($g_hToolTip, 'Title', $hIcon)
	GUISetState(@SW_SHOW)
	$g_aPos = MouseGetPos()
	_GUIToolTip_TrackPosition($g_hToolTip, $g_aPos[0] + 10, $g_aPos[1] + 20)
	_GUIToolTip_TrackActivate($g_hToolTip, True, 0, $g_hAdd)
	_GUIToolTip_UpdateTipText($g_hToolTip, 0, $g_hAdd, "X: " & $g_aPos[0] & " Y: " & $g_aPos[1])
	While 1
		Sleep(10)
		$g_aPos = MouseGetPos()
		_GUIToolTip_TrackPosition($g_hToolTip, $g_aPos[0] + 10, $g_aPos[1] + 20)
		_GUIToolTip_UpdateTipText($g_hToolTip, 0, $g_hAdd, "X: " & $g_aPos[0] & " Y: " & $g_aPos[1])
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	_GUIToolTip_Destroy($g_hToolTip)
EndFunc   ;==>Example

Func GetInfo()
	Local $aTool = _GUIToolTip_HitTest($g_hToolTip, $g_hAdd, $g_aPos[0], $g_aPos[1])
	MsgBox($MB_SYSTEMMODAL, "Tooltip info", "Flags: " & @TAB & _GUIToolTip_BitsToTTF($aTool[0]) & @CRLF & _
			"HWnd: " & @TAB & $aTool[1] & @CRLF & _
			"ID: " & @TAB & $aTool[2] & @CRLF & _
			"Left X:" & @TAB & $aTool[3] & @CRLF & _
			"Left Y:" & @TAB & $aTool[4] & @CRLF & _
			"Right X:" & @TAB & $aTool[5] & @CRLF & _
			"Right Y:" & @TAB & $aTool[6] & @CRLF & _
			"Instance:" & @TAB & $aTool[7] & @CRLF & _
			"Text:" & @TAB & $aTool[8] & @CRLF & _
			"lParam:" & @TAB & $aTool[9])
EndFunc   ;==>GetInfo
