#include <Security.au3>
#include <SecurityConstants.au3>

ConsoleWrite("SID type for $SIDTYPEDOMAIN is: " & _Security__SidTypeStr($SIDTYPEDOMAIN) & @CRLF)
