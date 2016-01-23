#include <WinAPIGdi.au3>

Local $iHue, $iLuminance, $iSaturation
_WinAPI_ColorRGBToHLS(0xFF8000, $iHue, $iLuminance, $iSaturation)

ConsoleWrite('Hue: ' & $iHue & @CRLF)
ConsoleWrite('Sat: ' & $iSaturation & @CRLF)
ConsoleWrite('Lum: ' & $iLuminance & @CRLF)
