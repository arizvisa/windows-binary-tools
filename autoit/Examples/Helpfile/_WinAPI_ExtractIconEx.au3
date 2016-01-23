#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

MsgBox($MB_SYSTEMMODAL, "ExtractIconEx", "# of Icons in file shell32.dll: " & _WinAPI_ExtractIconEx("shell32.dll", -1, 0, 0, 0))
