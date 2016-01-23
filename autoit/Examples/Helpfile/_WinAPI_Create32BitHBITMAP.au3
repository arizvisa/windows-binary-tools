#NoTrayIcon

#include <GUIMenu.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>

Opt('TrayMenuMode', 3)

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $hMenu = TrayItemGetHandle(0)
Local $iOptions = TrayCreateItem('Options')
TrayCreateItem('')
Local $idExit = TrayCreateItem('Exit')

_GUICtrlMenu_SetItemBmp($hMenu, 0, _WinAPI_Create32BitHBITMAP(_WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 207, 16, 16), 1, 1))
_GUICtrlMenu_SetItemBmp($hMenu, 2, _WinAPI_Create32BitHBITMAP(_WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 131, 16, 16), 1, 1))

TraySetState()

Do
Until TrayGetMsg() = $idExit
