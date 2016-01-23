#include <MsgBoxConstants.au3>

; COM Test file
;
; Wscript.filesystem Example

Local $sFolder = @TempDir ; Folder to test the size of

Local $oFSO = ObjCreate("Scripting.FileSystemObject")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "Wscript.filesystem Test", "I'm sorry, but creation of object $oFSO failed. Error code: " & @error)
	Exit
EndIf

Local $oFolder = $oFSO.GetFolder($sFolder) ; Get object to the given folder

MsgBox($MB_SYSTEMMODAL, "Wscript.filesystem Test", "Your " & $sFolder & " folder size is: " & Round($oFolder.Size / 1024) & " Kilobytes")

Exit
