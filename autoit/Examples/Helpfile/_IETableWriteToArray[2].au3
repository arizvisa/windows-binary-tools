; Same as Example 1, except transpose the output array and display
; the results with _ArrayDisplay()

#include <Array.au3>
#include <IE.au3>

Local $oIE = _IE_Example("table")
Local $oTable = _IETableGetCollection($oIE, 1)
Local $aTableData = _IETableWriteToArray($oTable, True)
_ArrayDisplay($aTableData)

_IEQuit($oIE)
