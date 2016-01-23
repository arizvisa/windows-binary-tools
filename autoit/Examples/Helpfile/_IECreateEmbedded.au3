; Trap COM errors so that 'Back' and 'Forward'
; outside of history bounds does not abort script
; (expect COM errors to be sent to the console)

#include <GUIConstantsEx.au3>
#include <IE.au3>
#include <WindowsConstants.au3>

Local $oIE = _IECreateEmbedded()
GUICreate("Embedded Web control Test", 640, 580, _
		(@DesktopWidth - 640) / 2, (@DesktopHeight - 580) / 2, _
		$WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 10, 40, 600, 360)
Local $idButton_Back = GUICtrlCreateButton("Back", 10, 420, 100, 30)
Local $idButton_Forward = GUICtrlCreateButton("Forward", 120, 420, 100, 30)
Local $idButton_Home = GUICtrlCreateButton("Home", 230, 420, 100, 30)
Local $idButton_Stop = GUICtrlCreateButton("Stop", 340, 420, 100, 30)

Global $g_idError_Message = GUICtrlCreateLabel("", 100, 500, 500, 30)
GUICtrlSetColor(-1, 0xff0000)

GUISetState(@SW_SHOW) ;Show GUI

_IENavigate($oIE, "http://www.autoitscript.com")
_IEAction($oIE, "stop")

; Waiting for user to close the window
While 1
	Local $iMsg = GUIGetMsg()
	Select
		Case $iMsg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $iMsg = $idButton_Home
			_IENavigate($oIE, "http://www.autoitscript.com")
			_IEAction($oIE, "stop")
			_IEAction($oIE, "back")
			CheckError("Home", @error, @extended)
		Case $iMsg = $idButton_Back
			_IEAction($oIE, "back")
			CheckError("Back", @error, @extended)
		Case $iMsg = $idButton_Forward
			_IEAction($oIE, "forward")
			CheckError("Forward", @error, @extended)
		Case $iMsg = $idButton_Stop
			_IEAction($oIE, "stop")
			CheckError("Stop", @error, @extended)
	EndSelect
WEnd

GUIDelete()

Exit

Func CheckError($sMsg, $iError, $iExtended)
	If $iError Then
		$sMsg = "Error using " & $sMsg & " button (" & $iExtended & ")"
	Else
		$sMsg = ""
	EndIf
	GUICtrlSetData($g_idError_Message, $sMsg)
EndFunc   ;==>CheckError
