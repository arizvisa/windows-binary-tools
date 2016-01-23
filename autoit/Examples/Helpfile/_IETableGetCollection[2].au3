; Open a browser with the table example, get a reference to the
; table collection and display the number of tables on the page

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("table")
Local $oTable = _IETableGetCollection($oIE)
Local $iNumTables = @extended
MsgBox($MB_SYSTEMMODAL, "Table Info", "There are " & $iNumTables & " tables on the page")

_IEQuit($oIE)
