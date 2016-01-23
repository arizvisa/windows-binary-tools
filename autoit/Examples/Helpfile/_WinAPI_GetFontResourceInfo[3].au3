#include <GDIPlus.au3>
#include <WinAPIGdi.au3>
#include <WinAPIMisc.au3>

Example()

Func Example()
	Local $sFile = "Extras\SF Square Head Bold.ttf"

	ConsoleWrite(_WinAPI_GetFontResourceInfo($sFile, True) & @CRLF)
	ConsoleWrite(@CRLF)

	FontGetInfoFromFile($sFile, 0, "Copyright")
	FontGetInfoFromFile($sFile, 1, "Font Family name")
	FontGetInfoFromFile($sFile, 2, "Font SubFamily name")
	FontGetInfoFromFile($sFile, 3, "Unique font identifier")
	FontGetInfoFromFile($sFile, 4, "Font full name")
	FontGetInfoFromFile($sFile, 5, "Version string")
	FontGetInfoFromFile($sFile, 6, "Postscript name")
	FontGetInfoFromFile($sFile, 7, "Trademark")
	FontGetInfoFromFile($sFile, 8, "Manufacturer Name")
	FontGetInfoFromFile($sFile, 9, "Designer")
	FontGetInfoFromFile($sFile, 10, "Description")
	FontGetInfoFromFile($sFile, 11, "URL Vendor")
	FontGetInfoFromFile($sFile, 16, "Preferred Family (Windows only)")
	FontGetInfoFromFile($sFile, 17, "Preferred SubFamily (Windows only)")
	FontGetInfoFromFile($sFile, 18, "Compatible Full (Mac OS only)")
	FontGetInfoFromFile($sFile, 19, "Sample text")
	FontGetInfoFromFile($sFile, 20, "PostScript CID findfont name")

	FontGetInfoFromFile($sFile, 256, "Font-specific names")

EndFunc   ;==>Example

Func FontGetInfoFromFile($sFile, $n, $sElement)
	Local $s = _WinAPI_GetFontResourceInfo($sFile, Default, $n)
	If Not @error And $s Then ConsoleWrite($sElement & " = " & $s & @CRLF)
EndFunc   ;==>FontGetInfoFromFile
