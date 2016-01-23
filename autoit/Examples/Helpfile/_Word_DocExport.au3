#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPrint Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test document
Local $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPrint Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Export the complete document with default values
; *****************************************************************************
Local $sFileName = @TempDir & "\Test1.pdf"
_Word_DocExport($oDoc, $sFileName)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocExport Example", _
		"Error exporting the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
ShellExecute($sFileName)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocExport Example", _
		"The whole document has successfully been exported to: " & $sFileName)
