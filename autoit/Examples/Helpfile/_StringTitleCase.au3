#include <MsgBoxConstants.au3>
#include <String.au3>

Local $sString = "'she's all 'that' I, wAnt (" & '1st "disk" of 2)'
MsgBox($MB_SYSTEMMODAL, '', 'Original string: ' & $sString & @CRLF & _ ; Display the orginal and titlecased string.
		'Titlecased string: ' & _StringTitleCase($sString) & @CRLF)
