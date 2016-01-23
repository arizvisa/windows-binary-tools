#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Word.au3>

; Copy \Extras\Test.doc to @TempDir
If FileCopy(@ScriptDir & "\Extras\Test.doc", @TempDir & "\_Word_Test.doc", $FC_OVERWRITE) = 0 Then Exit MsgBox($MB_SYSTEMMODAL, _
		"Word UDF: _Word_DocSave Example", "Couldn't copy '.\Extras\Test.doc' as '_Word_Test.doc' to the @TempDir directory.")
; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocSave Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open the test document
Local $oDoc = _Word_DocOpen($oWord, @TempDir & "\_Word_Test.doc")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocSave Example", _
		"Error opening '_Word_Test.doc'." & @CRLF & "error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Save the document
; *****************************************************************************
; Insert text at the beginning
Local $oRange = _Word_DocRangeSet($oDoc, -1)
$oRange.Text = "Bold text at the beginning. "
$oRange.Bold = True
; Save document
_Word_DocSave($oDoc)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocSave Example", _
		"Error saving the Word document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocSave Example", "Document successfully saved as '" & _
		$oDoc.FullName & "'")
