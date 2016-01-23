#include <APILocaleConstants.au3>
#include <WinAPILocale.au3>

Local $iID = _WinAPI_GetUserDefaultLCID()

ConsoleWrite('Language => ' & _WinAPI_GetLocaleInfo($iID, $LOCALE_SLANGUAGE) & @CRLF)
ConsoleWrite('Date format => ' & _WinAPI_GetLocaleInfo($iID, $LOCALE_SSHORTDATE) & @CRLF)
ConsoleWrite('Time format => ' & _WinAPI_GetLocaleInfo($iID, $LOCALE_STIMEFORMAT) & @CRLF)
ConsoleWrite('Currency name => ' & _WinAPI_GetLocaleInfo($iID, $LOCALE_SNATIVECURRNAME) & @CRLF)
ConsoleWrite('Monetary symbol => ' & _WinAPI_GetLocaleInfo($iID, $LOCALE_SCURRENCY) & @CRLF)
