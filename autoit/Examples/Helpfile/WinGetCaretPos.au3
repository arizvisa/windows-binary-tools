Local $aCaretPos = WinGetCaretPos()
If Not @error Then
	ToolTip("First Method", $aCaretPos[0], $aCaretPos[1])
EndIf
Sleep(2000)

$aCaretPos = _WinGetCaretPos()
If Not @error Then
	ToolTip("Second Method", $aCaretPos[0], $aCaretPos[1])
EndIf
Sleep(2000)

; A more reliable method to retrieve the caret coordinates in MDI text editors.
Func _WinGetCaretPos()
	Local $iXAdjust = 5
	Local $iYAdjust = 40

	Local $iOpt = Opt("CaretCoordMode", 0) ; Set "CaretCoordMode" to relative mode and store the previous option.
	Local $aGetCaretPos = WinGetCaretPos() ; Retrieve the relative caret coordinates.
	Local $aGetPos = WinGetPos("[ACTIVE]") ; Retrieve the position as well as height and width of the active window.
	Local $sControl = ControlGetFocus("[ACTIVE]") ; Retrieve the control name that has keyboard focus.
	Local $aControlPos = ControlGetPos("[ACTIVE]", "", $sControl) ; Retrieve the position as well as the size of the control.
	$iOpt = Opt("CaretCoordMode", $iOpt) ; Reset "CaretCoordMode" to the previous option.

	Local $aReturn[2] = [0, 0] ; Create an array to store the x, y position.
	If IsArray($aGetCaretPos) And IsArray($aGetPos) And IsArray($aControlPos) Then
		$aReturn[0] = $aGetCaretPos[0] + $aGetPos[0] + $aControlPos[0] + $iXAdjust
		$aReturn[1] = $aGetCaretPos[1] + $aGetPos[1] + $aControlPos[1] + $iYAdjust
		Return $aReturn ; Return the array.
	Else
		Return SetError(1, 0, $aReturn) ; Return the array and set @error to 1.
	EndIf
EndFunc   ;==>_WinGetCaretPos
