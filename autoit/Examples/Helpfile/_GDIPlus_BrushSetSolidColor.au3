#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUI, $idLabel1, $idLabel2, $hGraphic, $hBrush1, $iClr1, $iClr2

	; Create GUI
	$hGUI = GUICreate("GDI+", 345, 150)
	$idLabel1 = GUICtrlCreateLabel("", 2, 2, 150, 30)
	$idLabel2 = GUICtrlCreateLabel("", 202, 2, 150, 30)
	GUISetState(@SW_SHOW)
	Sleep(100)

	; Start GDIPlus
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; Create solid brush
	$hBrush1 = _GDIPlus_BrushCreateSolid()

	; Get solid brush original color
	$iClr1 = _GDIPlus_BrushGetSolidColor($hBrush1)

	; Draw some graphics with the original brush color
	_GDIPlus_GraphicsFillEllipse($hGraphic, 25, 35, 100, 100, $hBrush1)

	; Set new brush color (0xFFFF0000 = Red)
	_GDIPlus_BrushSetSolidColor($hBrush1, 0xFFFF0000)

	; Get solid brush new color
	$iClr2 = _GDIPlus_BrushGetSolidColor($hBrush1)

	; Draw some graphics with the new brush color
	_GDIPlus_GraphicsFillRect($hGraphic, 220, 35, 100, 100, $hBrush1)

	; Write original brush color to Label1
	GUICtrlSetData($idLabel1, "Brush orignal color: " & Hex($iClr1))

	; Write the new brush color to Label2
	GUICtrlSetData($idLabel2, "Brush new color: " & Hex($iClr2))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush1)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
