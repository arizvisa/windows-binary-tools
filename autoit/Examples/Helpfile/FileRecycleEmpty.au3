#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Open the recycle bin by using the following CLSID.
	ShellExecute("::{645FF040-5081-101B-9F08-00AA002F954E}")

	; Display a message box asking whether or not you would like to delete files in the recycle bin.
	If MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "", "Would you like to empty the recycle bin on the " & @HomeDrive & "\ drive?") = $IDNO Then Return False

	; Delete files in the recycle bin. This is for the @HomeDrive only, which is generally the C:\ drive.
	Local $iRecycle = FileRecycleEmpty(@HomeDrive)

	; Display a message of whether the recycle bin was emptied successfuly.
	If $iRecycle Then
		MsgBox($MB_SYSTEMMODAL, "", "The recycle bin was emptied successfuly.")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The recycle bin wasn't emptied successfuly.")
	EndIf
EndFunc   ;==>Example
