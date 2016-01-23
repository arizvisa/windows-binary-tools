#pragma compile(Out, myProg.exe)
; Uncomment to use the following icon. Make sure the file path is correct and matches the installation of your AutoIt install path.
; #pragma compile(Icon, C:\Program Files\AutoIt3\Icons\au3.ico)
#pragma compile(ExecLevel, highestavailable)
#pragma compile(Compatibility, win7)
#pragma compile(UPX, False)
#pragma compile(FileDescription, myProg - a description of the application)
#pragma compile(ProductName, myProg)
#pragma compile(ProductVersion, 3.7)
#pragma compile(FileVersion, 3.7.0.0, 3.7.100.201) ; The last parameter is optional.
#pragma compile(LegalCopyright, © Joe Bloggs)
#pragma compile(LegalTrademarks, '"Trademark something, and some text in "quotes" etc...')
#pragma compile(CompanyName, 'Joe Bloggs & Co')

#include <MsgBoxConstants.au3>

If @Compiled Then
	Example()
Else
	MsgBox($MB_SYSTEMMODAL, "", "Please compile before running.")
EndIf

Func Example()
	; Retrieve the file version of the AutoIt executable.
	Local $sFileVersion = FileGetVersion(@AutoItExe)

	; Display the file version. This should be equal to @AutoItVersion.
	MsgBox($MB_SYSTEMMODAL, "", $sFileVersion)
EndFunc   ;==>Example
