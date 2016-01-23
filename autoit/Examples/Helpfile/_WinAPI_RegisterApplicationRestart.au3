#include <APIDiagConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Global $g_iCount = 10

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 300, 100)
Local $idLabel = GUICtrlCreateLabel('The application will be crashes after ' & $g_iCount & ' seconds.', 10, 43, 280, 14, $SS_CENTER)
GUISetState(@SW_SHOW)

If $CmdLine[0] And ($CmdLine[1] = '/crash') Then
	MsgBox(BitOR($MB_ICONWARNING, $MB_SYSTEMMODAL), 'Attention', 'The application has been restarted after an abnormal exit.', 0, $hForm)
EndIf

If Not @Compiled Then
	_WinAPI_RegisterApplicationRestart(BitOR($RESTART_NO_PATCH, $RESTART_NO_REBOOT), '"' & @ScriptFullPath & '" /crash')
Else
	_WinAPI_RegisterApplicationRestart(BitOR($RESTART_NO_PATCH, $RESTART_NO_REBOOT), '/crash')
EndIf

AdlibRegister('_Countdown', 1000)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _Countdown()
	Local $iData
	#forceref $iData

	$g_iCount -= 1
	If $g_iCount Then
		GUICtrlSetData($idLabel, 'The application will be crashes after ' & $g_iCount & ' seconds.')
	Else
		Local $tData
		; Forced script crash due to a memory access violation
		$tData = DllStructCreate('int', 0x12345678)
		$iData = DllStructGetData($tData, 1)
	EndIf
EndFunc   ;==>_Countdown
