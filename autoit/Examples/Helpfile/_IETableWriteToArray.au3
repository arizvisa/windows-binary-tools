; Open a browser with the table example, get a reference to the second table
; on the page (index 1) and read its contents into a 2-D array

#include <Array.au3>
#include <IE.au3>

Local $oIE = _IE_Example("table")
Local $oTable = _IETableGetCollection($oIE, 1)
Local $aTableData = _IETableWriteToArray($oTable)

_ArrayDisplay($aTableData)

_IEQuit($oIE)
