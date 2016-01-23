#include <MsgBoxConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>

Local $hQuery, $aRow, $iSwitch
_SQLite_Startup()
_SQLite_Open()
_SQLite_Exec(-1, "CREATE TABLE tblTest (a,b,c);")
_SQLite_Exec(-1, "INSERT INTO tblTest VALUES ('1','1','1');" & _ ; Row 1
		"INSERT INTO tblTest VALUES ('2','2','2');" & _ ; Row 2
		"INSERT INTO tblTest VALUES ('3','3','3');") ; Row 3
_SQLite_Query(-1, "SELECT RowID,* FROM tblTest;", $hQuery)
While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
	$iSwitch = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "Row: " & $aRow[0], $aRow[1] & "," & $aRow[2] & "," & $aRow[3] & @CRLF & _
			"Continue Looping?")
	If $iSwitch = 6 Then ; Yes
		If $aRow[0] = 3 Then _SQLite_QueryReset($hQuery)
	Else ; No
		_SQLite_QueryFinalize($hQuery)
		ExitLoop
	EndIf
WEnd
_SQLite_Close()
_SQLite_Shutdown()
