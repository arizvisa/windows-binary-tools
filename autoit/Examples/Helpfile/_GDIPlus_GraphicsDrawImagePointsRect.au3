#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; X64 running support
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"

	;get AutoIt install dir
	Local $sRegPath = "HKLM\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt"

	Local $sFile = RegRead($sRegPath, "InstallDir") & "\Examples\GUI\logo4.gif"
	If Not FileExists($sFile) Then
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", $sFile & " not found!", 30)
		Return False
	EndIf

	_GDIPlus_Startup()
	Local $hImage = _GDIPlus_ImageLoadFromFile($sFile) ;create an image object based on a file
	If @error Then
		_GDIPlus_Shutdown()
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "An error has occured - unable to load image!", 30)
		Return False
	EndIf

	Local $hGUI, $hGraphic, $iImgW, $iImgH

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 400)
	GUISetState(@SW_SHOW)
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle

	$iImgW = _GDIPlus_ImageGetWidth($hImage)
	$iImgH = _GDIPlus_ImageGetHeight($hImage)

	_GDIPlus_GraphicsDrawImagePointsRect($hGraphic, $hImage, 100, 10, 300, 60, 90, 160, 0, 0, $iImgW * 0.45, $iImgH)
	_GDIPlus_GraphicsDrawImagePointsRect($hGraphic, $hImage, 300, 60, 360, 30, 290, 210, $iImgW * 0.45, 0, $iImgW * 0.2, $iImgH)
	_GDIPlus_GraphicsDrawImagePointsRect($hGraphic, $hImage, 360, 30, 560, 80, 350, 180, $iImgW * 0.65, 0, $iImgW * 0.35, $iImgH)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup resources
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
