#include <APIDiagConstants.au3>
#include <WinAPIDiag.au3>

ConsoleWrite('Hardware1: ' & _WinAPI_UniqueHardwareID() & @CRLF)
ConsoleWrite('Hardware2: ' & _WinAPI_UniqueHardwareID(BitOR($UHID_MB, $UHID_BIOS)) & @CRLF)
ConsoleWrite('Hardware3: ' & _WinAPI_UniqueHardwareID(BitOR($UHID_MB, $UHID_BIOS, $UHID_CPU)) & @CRLF)
ConsoleWrite('Hardware4: ' & _WinAPI_UniqueHardwareID($UHID_All) & @CRLF)
