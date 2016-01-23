#include <GUIConstantsEx.au3>
#include <WinAPIDlg.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $idButton = GUICtrlCreateButton('About', 165, 366, 70, 23)
GUICtrlSetState($idButton, $GUI_DEFBUTTON)
GUISetState(@SW_SHOW)
Send('{Enter}')

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			_WinAPI_ShellAboutDlg('About', 'About Dialog Box Test', 'Simple Text', _WinAPI_ShellExtractIcon(@AutoItExe, 0, 32, 32), $hForm)
	EndSwitch
WEnd
