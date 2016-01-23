#include <Constants.au3>
;
; WMI example to enumerate services
;

MsgBox($MB_SYSTEMMODAL, "Enumerated list of services", "Services on this computer: " & @CRLF & ServicesList())

Func ServicesList()
	Local $oWMI = ObjGet("winmgmts://" & @ComputerName)

	Local $sServiceList = ""
	For $oItem In $oWMI.ExecQuery("select * from win32_service")
		$sServiceList &= $oItem.name & @TAB
	Next
	Return $sServiceList
EndFunc   ;==>ServicesList
