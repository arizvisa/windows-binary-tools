#include <APILocaleConstants.au3>
#include <WinAPILocale.au3>

_WinAPI_SetLocaleInfo($LOCALE_USER_DEFAULT, $LOCALE_SLONGDATE, 'dddd, MMMM dd, yyyy')
_WinAPI_SetLocaleInfo($LOCALE_USER_DEFAULT, $LOCALE_SSHORTDATE, 'dd-MMM-yy')
