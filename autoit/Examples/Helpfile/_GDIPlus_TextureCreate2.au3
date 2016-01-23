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

	Local $hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", 320, 200)
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a Graphics object from a window handle
	_GDIPlus_GraphicsClear($hGraphics, 0xFF404040) ;clear graphic handle with dark grey (background)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)
	Local $hTexture = _GDIPlus_TextureCreate2($hImage, 5, 4, 59, 59) ;create texture brush only from a defined rectangle
	_GDIPlus_GraphicsFillEllipse($hGraphics, 10, 40, 300, 120, $hTexture) ;draw ellipse with texture as a brush

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup resources
	_GDIPlus_BrushDispose($hTexture)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
