#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	; Create GUI

	Local $aGui[6]
	Local $aPoints[6][2] = [[5]]
	For $i = 1 To 5
		$aPoints[$i][0] = Cos(6.28 * $i / 5) * @DesktopHeight / 3 + @DesktopWidth / 2
		$aPoints[$i][1] = Sin(6.28 * $i / 5) * @DesktopHeight / 3 + @DesktopHeight / 2
		$aGui[$i] = GUICreate($i, 120, 100, $aPoints[$i][0] - 60, $aPoints[$i][1] - 50)
		GUISetBkColor(0x55)
		GUISetState(@SW_SHOW)
	Next

	_GDIPlus_Startup()
	Local $hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix, -@DesktopWidth / 2, -@DesktopHeight / 2)
	_GDIPlus_MatrixRotate($hMatrix, 1, True)
	_GDIPlus_MatrixTranslate($hMatrix, @DesktopWidth / 2, @DesktopHeight / 2, True)

	; Loop until the user exits.
	Local $iTimer = TimerInit()
	Do
		If TimerDiff($iTimer) > 40 Then
			_GDIPlus_MatrixTransformPoints($hMatrix, $aPoints)
			For $i = 1 To 5
				WinMove($aGui[$i], "", $aPoints[$i][0] - 60, $aPoints[$i][1] - 50)
			Next
			$iTimer = TimerInit()
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
