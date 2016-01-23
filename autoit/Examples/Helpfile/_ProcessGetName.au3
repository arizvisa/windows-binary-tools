#include <MsgBoxConstants.au3>
#include <Process.au3>

Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]", "")
Local $iPid = WinGetProcess("[CLASS:Notepad]", "")
Local $sName = _ProcessGetName($iPid)

MsgBox($MB_SYSTEMMODAL, "Notepad - " & $iPid, $sName)
