; WMI Example
;
; Kill a process
;
; Derived from a KiXtart script ENDPROC by Conrad Wheeler
; See also: http://www.kixtart.org/ubbthreads/showflat.php?Cat=&Number=82164

; Example usage

EndProc("iexplore.exe") ; Kills all instances of the Internet Explorer :-)

Func EndProc($sProc, $sComputer = ".")
	Local $oWMI = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\" & $sComputer & "\root\cimv2")
	Local $oProcessColl = $oWMI.ExecQuery("Select * from Win32_Process where Name= " & '"' & $sProc & '"')

	For $oProcess In $oProcessColl
		$oProcess = $oProcess.Terminate
	Next
EndFunc   ;==>EndProc
