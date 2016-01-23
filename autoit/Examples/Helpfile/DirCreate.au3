#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $sFldr1 = "C:\Test1\"
	Local $sFldr2 = "C:\Test1\Folder1\"
	Local $sFldr3 = "C:\Test1\Folder1\Folder2\"

	If DirGetSize($sFldr1) <> -1 Then
		MsgBox($MB_SYSTEMMODAL, "", "Directory already exists!")
		Return False
	EndIf

	DirCreate($sFldr3)

	RunWait("explorer /root, C:\Test1\Folder1")
	Local $hWnd = WinGetHandle("[TITLE:Folder1;CLASS:CabinetWClass]")

	MsgBox($MB_SYSTEMMODAL, "", "Explorer is opened with Folder2 displayed.")

	DirRemove($sFldr3, 1)
	MsgBox($MB_SYSTEMMODAL, "", "The sub folder: Folder2 has been deleted.")

	WinClose($hWnd)

	DirRemove($sFldr2) ;clean up test folders
	DirRemove($sFldr1) ;clean up test folders
EndFunc   ;==>Example
