#include <APILocaleConstants.au3>
#include <WinAPILocale.au3>

Local $iID = _WinAPI_GetUserGeoID()

ConsoleWrite('ID:        0x' & Hex($iID) & @CRLF)
ConsoleWrite('Latitude:  ' & _WinAPI_GetGeoInfo($iID, $GEO_LATITUDE) & @CRLF)
ConsoleWrite('Longitude: ' & _WinAPI_GetGeoInfo($iID, $GEO_LONGITUDE) & @CRLF)
ConsoleWrite('Name:      ' & _WinAPI_GetGeoInfo($iID, $GEO_FRIENDLYNAME) & @CRLF)
ConsoleWrite('ISO code:  ' & _WinAPI_GetGeoInfo($iID, $GEO_ISO3) & @CRLF)
