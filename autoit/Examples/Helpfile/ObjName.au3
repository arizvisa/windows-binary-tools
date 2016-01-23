#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Local $oInternet = ObjCreate("InternetExplorer.Application")
$oInternet.Navigate("http://www.google.com") ; Opening a web page that contains a form
Sleep(4000) ; Give the page time to load

Local $oDoc = $oInternet.Document ; Example object to test
Local $oForm = $oDoc.Forms(0) ; Example object to test

MsgBox($MB_SYSTEMMODAL, "", "Interface name of $oInternet is: " & ObjName($oInternet) & @CRLF & _
		"Object name of $oInternet is:    " & ObjName($oInternet, $OBJ_STRING) & @CRLF & _
		"Interface name of $oDoc is:      " & ObjName($oDoc) & @CRLF & _
		"Object name of $oDoc is:         " & ObjName($oDoc, $OBJ_STRING) & @CRLF & _
		"Interface name of $oForm is:     " & ObjName($oForm) & @CRLF & _
		"Object name of $oForm is:        " & ObjName($oForm, $OBJ_STRING))
$oInternet.Quit()
