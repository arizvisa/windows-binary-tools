#include <GuiAVI.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_hAVI

Example()

Func Example()
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $hGUI, $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\SampleAVI.avi"

	; Create GUI
	$hGUI = GUICreate("(External 1) AVI Create", 300, 100)
	$g_hAVI = _GUICtrlAVI_Create($hGUI, $sFile, -1, 10, 10)
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

	; Play the sample AutoIt AVI
	_GUICtrlAVI_Play($g_hAVI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Close AVI clip
	_GUICtrlAVI_Close($g_hAVI)

	GUIDelete()
EndFunc   ;==>Example

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode
	$hWndFrom = $lParam
	$iIDFrom = BitAND($wParam, 0xFFFF) ; Low Word
	$iCode = BitShift($wParam, 16) ; Hi Word
	Switch $hWndFrom
		Case $g_hAVI
			Switch $iCode
				Case $ACN_START ; Notifies an animation control's parent window that the associated AVI clip has started playing
					_DebugPrint("$ACN_START" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $ACN_STOP ; Notifies the parent window of an animation control that the associated AVI clip has stopped playing
					_DebugPrint("$ACN_STOP" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @CRLF & _
			"+======================================================" & @CRLF & _
			"-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
			"+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
