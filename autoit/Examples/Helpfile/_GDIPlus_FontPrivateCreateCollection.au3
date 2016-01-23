#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hFormat, $hFamily, $hFont, $tLayout, $sFontInternalName, $hCollection, $sFontFile = @WindowsDir & "\Fonts\Times.ttf"

	If _WinAPI_DwmIsCompositionEnabled() Then
		If Not @Compiled Then
			$sFontFile = StringRegExpReplace(@AutoItExe, "(.*)\\.*", "$1")
		Else
			$sFontFile = StringRegExpReplace(RegRead("HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\AutoItv3", "DisplayIcon"), "(.*)\\.*", "$1")
		EndIf
		If $sFontFile = "" Then Exit MsgBox(BitOR($MB_ICONERROR, $MB_TOPMOST), "Error", "Unable to locate SF Square Head Bold.ttf in AutoIt sub dir!")
		$sFontFile &= "\Examples\Helpfile\Extras\SF Square Head Bold.ttf"
	EndIf

	$sFontInternalName = _WinAPI_GetFontResourceInfo($sFontFile, Default, 1)

	$hGUI = GUICreate("GDI+", 720, 235)
	GUISetState()

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (anti aliasing)
	_GDIPlus_GraphicsSetTextRenderingHint($hGraphic, $GDIP_TEXTRENDERINGHINT_ANTIALIASGRIDFIT) ;set the anti aliasing for fonts

	$hCollection = _GDIPlus_FontPrivateCreateCollection() ;create a PrivateFontCollection object to add fonts later
	_GDIPlus_FontPrivateAddFont($hCollection, $sFontFile) ;add the font to the font collection
	$hFormat = _GDIPlus_StringFormatCreate() ;create a string format object
	$hFamily = _GDIPlus_FontFamilyCreateFromCollection($sFontInternalName, $hCollection) ;create a font family object
	$hFont = _GDIPlus_FontCreate($hFamily, 72) ;create a font object
	$tLayout = _GDIPlus_RectFCreate(0, 0, 720, 235) ;create a $tagGDIPRECTF structure to save x, y position of the text
	_GDIPlus_StringFormatSetAlign($hFormat, 1) ;center text
	_GDIPlus_StringFormatSetLineAlign($hFormat, 1) ;center text
	$hBrush = _GDIPlus_BrushCreateSolid(0xFF00007F) ;create a brush with a defined color for the text
	_GDIPlus_GraphicsDrawStringEx($hGraphic, "AutoIt" & @LF & "forever", $hFont, $tLayout, $hFormat, $hBrush) ;draw the string

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_FontPrivateCollectionDispose($hCollection)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
