#include <MsgBoxConstants.au3>

; Press Esc to terminate script, Pause/Break to "pause"

Global $g_bPaused = False

HotKeySet("{PAUSE}", "HotKeyPressed")
HotKeySet("{ESC}", "HotKeyPressed")
HotKeySet("+!d", "HotKeyPressed") ; Shift-Alt-d

While 1
	Sleep(100)
WEnd

Func HotKeyPressed()
	Switch @HotKeyPressed ; The last hotkey pressed.
		Case "{PAUSE}" ; String is the {PAUSE} hotkey.
			$g_bPaused = Not $g_bPaused
			While $g_bPaused
				Sleep(100)
				ToolTip('Script is "Paused"', 0, 0)
			WEnd
			ToolTip("")

		Case "{ESC}" ; String is the {ESC} hotkey.
			Exit

		Case "+!d" ; String is the Shift-Alt-d hotkey.
			MsgBox($MB_SYSTEMMODAL, "", "This is a message.")

	EndSwitch
EndFunc   ;==>HotKeyPressed
