#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hPath, $hFamily, $tLayout, $aSize, $hRegion, $hRGN

	_GDIPlus_Startup()

	$hGUI = GUICreate("GDI+", 620, 100)
	GUISetBkColor(0x80) ;Set window background color to blue
	GUISetState(@SW_SHOW)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	$hFamily = _GDIPlus_FontFamilyCreate("Arial Black") ;Create font family object
	$tLayout = _GDIPlus_RectFCreate() ;Create string bounding rectangle X=0, Y=0
	_GDIPlus_PathAddString($hPath, "AutoIt rulez!", $tLayout, $hFamily, 0, 85, 0) ;Add the outline of the string to the path

	$aSize = WinGetPos($hGUI) ;Get windowsize

	$hRegion = _GDIPlus_RegionCreateFromRect(0, 0, 110, $aSize[3]) ;Create region from a rectangle
	_GDIPlus_RegionCombineRect($hRegion, $aSize[2] - 110, 0, 110, $aSize[3], 2) ;Combine rectangle_left AND rectangle_right
	_GDIPlus_RegionCombinePath($hRegion, $hPath, 3) ;Combine rectangles XOR string

	$hRGN = _GDIPlus_RegionGetHRgn($hRegion, 0) ;Create GDI region from GDI+ region
	_WinAPI_SetWindowRgn($hGUI, $hRGN) ;Set window region

	;Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;Clean up resources
	_GDIPlus_FontFamilyDispose($hFamily)
	_WinAPI_DeleteObject($hRGN)
	_GDIPlus_RegionDispose($hRegion)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
