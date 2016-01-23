#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

If MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "", "Note: This is an example and shouldn't be run under normal circumstances. " & @CRLF & @CRLF & "Do you wish to run the example?") = $IDYES Then
	; Mark all .au3 files in current directory as read-only and system.
	If Not FileSetAttrib(@ScriptDir & "\*.au3", "+RS") Then
		MsgBox($MB_SYSTEMMODAL, "Error", "Problem setting attributes.")
	EndIf

	; Mark all .bmp files in @HomeDrive and sub-directories writable and archived.
	If Not FileSetAttrib(@HomeDrive & "\*.bmp", "-R+A", $FT_RECURSIVE) Then
		MsgBox($MB_SYSTEMMODAL, "Error", "Problem setting attributes.")
	EndIf
EndIf
