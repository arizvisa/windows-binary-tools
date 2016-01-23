#include <MsgBoxConstants.au3>

; An example how to obtain a running instance of the Internet Explorer
;
; Source: http://dbforums.com/t867088.html
;
; Requires: AutoIt with COM Support

; First we activate an example instance of the internet explorer.

Local $sURL = "http://www.autoitscript.com/site"
Run(@ComSpec & " /c start iexplore.exe " & $sURL)
Sleep(4000) ; Give IE some time to load

; Internet Explorer is partly integrated in shell.application

Local $oShell = ObjCreate("shell.application") ; Get the Windows Shell Object
Local $oShellWindows = $oShell.windows ; Get the collection of open shell Windows

If Not IsObj($oShellWindows) Then
	MsgBox($MB_SYSTEMMODAL, "Error", "Failed to obtain shell windows. Error: " & @error)
	Exit
EndIf

; Now we search through all open Shell Windows and locate our internet page

Local $vMyIExplorer = ""

For $oWindow In $oShellWindows ; Count all existing shell windows

	; Note: Internet Explorer appends a slash to the URL in it's window name
	If $oWindow.LocationURL = $sURL & "/" Then
		$vMyIExplorer = $oWindow
		ExitLoop
	EndIf

Next

If Not IsObj($vMyIExplorer) Then
	MsgBox($MB_SYSTEMMODAL, "Error", "Could not find a running instance of the internet explorer")
	Exit
EndIf

; Now we can do whatever we want, because the found object
; has the same characteristics as "InternetExplorer.Application"

MsgBox($MB_SYSTEMMODAL, "OK", "Found the running instance of the Internet Explorer" & @CRLF & _
		"Press 'OK' to navigate to www.google.com")

Local $sNewURL = "http://www.google.com/"
$vMyIExplorer.Navigate($sNewURL)

Sleep(3000) ; Give it the time to load the web page

MsgBox($MB_SYSTEMMODAL, "Quit", "Press 'OK' to quit IE")

$vMyIExplorer.Quit ; Quit IE
$vMyIExplorer = 0 ; Release from memory
