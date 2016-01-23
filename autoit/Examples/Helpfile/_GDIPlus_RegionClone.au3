#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hRegion, $hRegion1, $hRegion2, $hPath

	; Create GUI
	$hGUI = GUICreate("GDI+", 600, 480)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_BrushCreateSolid(0x7F8800AA)

	$hPath = _GDIPlus_PathCreate() ;Create new path object
	_GDIPlus_PathAddEllipse($hPath, 80, 60, 80, 60)

	$hRegion1 = _GDIPlus_RegionCreateFromRect(30, 80, 80, 60)
	$hRegion2 = _GDIPlus_RegionCreateFromPath($hPath)

	_GDIPlus_GraphicsDrawString($hGraphic, "2 regions", 50, 30)
	_GDIPlus_GraphicsFillRegion($hGraphic, $hRegion1, $hBrush)
	_GDIPlus_GraphicsFillRegion($hGraphic, $hRegion2, $hBrush)

	_GDIPlus_GraphicsDrawString($hGraphic, "intersection", 50, 180)
	_GDIPlus_RegionTranslate($hRegion1, 0, 150)
	_GDIPlus_RegionTranslate($hRegion2, 0, 150)
	$hRegion = _GDIPlus_RegionClone($hRegion1)
	_GDIPlus_RegionCombineRegion($hRegion, $hRegion2, 1) ;intersection
	_GDIPlus_GraphicsFillRegion($hGraphic, $hRegion, $hBrush)
	_GDIPlus_RegionDispose($hRegion)

	_GDIPlus_GraphicsDrawString($hGraphic, "union", 250, 180)
	_GDIPlus_RegionTranslate($hRegion1, 200, 0)
	_GDIPlus_RegionTranslate($hRegion2, 200, 0)
	$hRegion = _GDIPlus_RegionClone($hRegion1)
	_GDIPlus_RegionCombineRegion($hRegion, $hRegion2, 2) ;union
	_GDIPlus_GraphicsFillRegion($hGraphic, $hRegion, $hBrush)
	_GDIPlus_RegionDispose($hRegion)

	_GDIPlus_GraphicsDrawString($hGraphic, "xor", 450, 180)
	_GDIPlus_RegionTranslate($hRegion1, 200, 0)
	_GDIPlus_RegionTranslate($hRegion2, 200, 0)
	$hRegion = _GDIPlus_RegionClone($hRegion1)
	_GDIPlus_RegionCombineRegion($hRegion, $hRegion2, 3) ;xor
	_GDIPlus_GraphicsFillRegion($hGraphic, $hRegion, $hBrush)
	_GDIPlus_RegionDispose($hRegion)

	_GDIPlus_GraphicsDrawString($hGraphic, "region1 sub region2", 50, 330)
	_GDIPlus_RegionTranslate($hRegion1, -400, 150)
	_GDIPlus_RegionTranslate($hRegion2, -400, 150)
	$hRegion = _GDIPlus_RegionClone($hRegion1)
	_GDIPlus_RegionCombineRegion($hRegion, $hRegion2, 4) ;1 sub 2
	_GDIPlus_GraphicsFillRegion($hGraphic, $hRegion, $hBrush)
	_GDIPlus_RegionDispose($hRegion)

	_GDIPlus_GraphicsDrawString($hGraphic, "region2 sub region1", 250, 330)
	_GDIPlus_RegionTranslate($hRegion1, 200, 0)
	_GDIPlus_RegionTranslate($hRegion2, 200, 0)
	$hRegion = _GDIPlus_RegionClone($hRegion1)
	_GDIPlus_RegionCombineRegion($hRegion, $hRegion2, 5) ;2 sub 1
	_GDIPlus_GraphicsFillRegion($hGraphic, $hRegion, $hBrush)
	_GDIPlus_RegionDispose($hRegion)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_RegionDispose($hRegion1)
	_GDIPlus_RegionDispose($hRegion2)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
