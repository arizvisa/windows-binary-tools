#include <GUIConstantsEx.au3>
#include <GuiToolbar.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hToolbar

	Run("explorer.exe /root, ,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}")
	WinWaitActive("[CLASS:CabinetWClass]")
	Sleep(1000)
	$hToolbar = _GUICtrlToolbar_FindToolbar("[CLASS:CabinetWClass]", "&File")
	MsgBox($MB_SYSTEMMODAL, "Information", "File Toolbar handle: 0x" & Hex($hToolbar))
EndFunc   ;==>Example
