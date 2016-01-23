#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPISys.au3>
#include <WinAPITheme.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 332, 400)

Local $idListview = GUICtrlCreateListView('Column 1|Column 2|Column 3|Column 4', 10, 10, 312, 380)
For $i = 1 To 9
	GUICtrlCreateListViewItem('Item ' & $i & '|' & 'Sub ' & $i & '|' & 'Sub ' & $i & '|' & 'Sub ' & $i, $idListview)
Next

_WinAPI_SetWindowTheme(GUICtrlGetHandle($idListview), 'Explorer')

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
