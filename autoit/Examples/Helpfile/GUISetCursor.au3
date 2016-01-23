#include <GUIConstantsEx.au3>

Global $g_iIDC = -1, $g_iNewIDC = 0
Global $g_aArray = StringSplit("Hand|AppStarting|Arrow|Cross|Help|IBeam|Icon (obsolete)|No|" & _
		"Size (obsolete)|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait|None", "|", 2) ; The flag parameter is set to flag = 2 as we don't require the total count of the array.

Example()

Func Example()
	HotKeySet("{ESC}", "Increment")

	GUICreate("Press ESC to Increment", 400, 400, 0, 0)

	GUISetState(@SW_SHOW)

	While GUIGetMsg() <> $GUI_EVENT_CLOSE
		If $g_iNewIDC <> $g_iIDC Then
			$g_iIDC = $g_iNewIDC
			GUISetCursor($g_iIDC)
		EndIf
		ToolTip("GUI Cursor #" & $g_iIDC & " (" & $g_aArray[$g_iIDC] & ")")
	WEnd

	GUIDelete()
EndFunc   ;==>Example

Func Increment()
	$g_iNewIDC = $g_iIDC + 1
	If $g_iNewIDC > 16 Then $g_iNewIDC = 0
EndFunc   ;==>Increment
