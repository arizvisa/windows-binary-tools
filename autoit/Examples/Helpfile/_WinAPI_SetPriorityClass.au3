#include <APIProcConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIProc.au3>

Run(@SystemDir & '\taskmgr.exe')
Sleep(1000)

_WinAPI_SetPriorityClass($HIGH_PRIORITY_CLASS)
MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '', 'Look what priority class has the "' & _WinAPI_PathStripPath(FileGetLongName(@AutoItExe)) & '" (' & @AutoItPID & ') process.' & @CRLF & @CRLF & 'Should be "High".')

_WinAPI_SetPriorityClass($IDLE_PRIORITY_CLASS)
MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '', 'Look what priority class has the "' & _WinAPI_PathStripPath(FileGetLongName(@AutoItExe)) & '" (' & @AutoItPID & ') process.' & @CRLF & @CRLF & 'Should be "Low".')
