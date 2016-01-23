#include <GUIConstantsEx.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

Local Const $sTxt = 'String' & @TAB & 'with' & @TAB & 'tab' & @TAB & 'characters'

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 0, 0, -1, -1, BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU))
GUICtrlCreateLabel($sTxt, 0, 0)
GUICtrlSetFont(-1, 26, 400, 0, 'Comic Sans MS')

; Compute dimensions of a string and resize the window
Local $iSize = _GetTabbedStringSize(-1, $sTxt)
If IsArray($iSize) Then
	GUICtrlSetPos(-1, 0, 0, $iSize[0], $iSize[1])
	Local $aPos = WinGetPos($hForm)
	If Not @error Then
		WinMove($hForm, '', (@DesktopWidth - ($aPos[2] + $iSize[0])) / 2, (@DesktopHeight - ($aPos[3] + $iSize[1])) / 2, $aPos[2] + $iSize[0], $aPos[3] + $iSize[1])
	EndIf
EndIf

; Show GUI
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _GetTabbedStringSize($hWnd, $sText)
	Local $tTM = DllStructCreate($tagTEXTMETRIC)

	If Not IsHWnd($hWnd) Then
		$hWnd = GUICtrlGetHandle($hWnd)
		If Not $hWnd Then Return 0
	EndIf

	Local $hDC = _WinAPI_GetDC($hWnd)
	Local $hFont = _SendMessage($hWnd, $WM_GETFONT)
	Local $hSv = _WinAPI_SelectObject($hDC, $hFont)
	Local $iTab = 0
	Local $aRet = DllCall('gdi32.dll', 'int', 'GetTextMetricsW', 'handle', $hDC, 'struct*', $tTM)
	If Not @error And $aRet[0] Then
		$iTab = 8 * DllStructGetData($tTM, 'tmAveCharWidth')
	EndIf
	Local $iSize = 0
	Local $tSIZE = _WinAPI_GetTabbedTextExtent($hDC, $sText, $iTab)
	If Not @error Then
		Dim $iSize[2]
		For $i = 0 To 1
			$iSize[$i] = DllStructGetData($tSIZE, $i + 1)
		Next
	EndIf
	_WinAPI_SelectObject($hDC, $hSv)
	_WinAPI_ReleaseDC($hWnd, $hDC)
	Return $iSize
EndFunc   ;==>_GetTabbedStringSize
