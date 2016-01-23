#include <AutoItConstants.au3>

SplashTextOn("Title", "Message goes here.", -1, -1, -1, -1, $DLG_TEXTLEFT, "", 24)
Sleep(3000)
SplashOff()

; ; FLICKER
Local $sMessage = ""
SplashTextOn("TitleFoo", $sMessage, -1, -1, -1, -1, $DLG_TEXTLEFT, "")
For $i = 1 To 20
	$sMessage = $sMessage & $i & @CRLF
	SplashTextOn("TitleFoo", $sMessage, -1, -1, -1, -1, $DLG_TEXTLEFT, "")
	Sleep(100)
Next

; ; SMOOTH
$sMessage = ""
SplashTextOn("TitleFoo", $sMessage, -1, -1, -1, -1, $DLG_TEXTLEFT, "")
For $i = 1 To 20
	$sMessage = $sMessage & $i & @CRLF
	ControlSetText("TitleFoo", "", "Static1", $sMessage)
	Sleep(100)
Next
