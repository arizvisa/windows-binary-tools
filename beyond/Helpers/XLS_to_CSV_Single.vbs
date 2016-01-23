' XLS_to_CSV_Single.vbs
'
' Converts <input file> from an Excel workbook to a comma-separated text file
' and saves the results to <output file>.  Requires Microsoft Excel.
'
' Usage:
'  WScript XLS_to_CSV_Single.vbs <input file> <output file>

' WdSaveFormat constants, taken from the Word type library
Const xlCSV			= 6	' Comma-separated values
Const xlUnicodeText		= 42	' Tab delimited text file

Dim fso, xls
Set fso = CreateObject("Scripting.FileSystemObject")
fso.DeleteFile WScript.Arguments(1)
Set xls = CreateObject("Excel.Application")
xls.DisplayAlerts = False

On Error Resume Next

xls.Workbooks.Open WScript.Arguments(0), , True
If Err = 0 Then
	With xls.ActiveWorkbook
		.SaveAs WScript.Arguments(1), xlCSV
		.Close False
	End With
End If

xls.Quit