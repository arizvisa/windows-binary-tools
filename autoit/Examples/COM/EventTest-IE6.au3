; COM Test file
;
; Test usage of Events with Internet Explorer
;
; See also: http://msdn.microsoft.com/workshop/browser/webbrowser/reference/objects/internetexplorer.asp

; Create a simple GUI for our output

#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Local $hGUIMain = GUICreate("Event Test", 640, 480)
Global $g_idGUIEdit = GUICtrlCreateEdit("Test Log:" & @CRLF, 10, 10, 600, 400)
GUISetState() ;Show GUI

Global $g_nComError, $g_oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

Local $oIE = ObjCreate("InternetExplorer.Application.1")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "Error opening Internet Explorer: " & @error)
	Exit
EndIf

$oIE.Visible = 1
$oIE.RegisterAsDropTarget = 1
$oIE.RegisterAsBrowser = 1

; The Event interfaces of the Internet Explorer are defined in: SHDOCVW.DLL
;
; HTMLElementEvents2
; DWebBrowserEvents
; DWebBrowserEvents2
; -> NOTE1: If you have installed VC6 (DevStudio8) this one is renamed to: DWebBrowserEvent2Sink !
; -> NOTE2: If you have installed the Adobe Acrobat Reader 6.0 IE plugin then the type library of this
;           interface is modified to "AcroIEHelper 1.0 Type Library"

Local $oSinkObject = ObjEvent($oIE, "IEEvent_", "DWebBrowserEvents")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "AutoIt COM Test", "ObjEvent: Can't use interface 'DWebBrowserEvents'. error code: " & Hex(@error, 8))
	Exit
EndIf

ProgressOn("Internet Explorer Event test", "Loading web page", "", -1, -1, 16)

Local $sURL = "http://www.AutoItScript.com/"
$oIE.Navigate($sURL)

Sleep(5000) ; Give it the time to load the web page

$oSinkObject = 0 ; Stop IE Events
$oIE.Quit ; Quit IE
$oIE = 0

ProgressOff()

GUISwitch($hGUIMain) ; In case IE stealed the focus

GUICtrlSetData($g_idGUIEdit, @CRLF & "End of Internet Explorer Events test." & @CRLF, "append")
GUICtrlSetData($g_idGUIEdit, "You may close this window now !" & @CRLF, "append")

; Waiting for user to close the window
Local $iMsg
While 1
	$iMsg = GUIGetMsg()
	If $iMsg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd

GUIDelete()

Exit

; a few Internet Explorer Event Functions
; ---------------------------------------

Func IEEvent_ProgressChange($iProgress, $iProgressMax)
	If $iProgressMax Then ProgressSet(($iProgress * 100) / $iProgressMax, ($iProgress * 100) / $iProgressMax & " percent to go.", "loading web page")
EndFunc   ;==>IEEvent_ProgressChange

Func IEEvent_StatusTextChange($sText)
	GUICtrlSetData($g_idGUIEdit, "IE Status text changed to: " & $sText & @CRLF, "append")
EndFunc   ;==>IEEvent_StatusTextChange

Func IEEvent_PropertyChange($sProperty)
	GUICtrlSetData($g_idGUIEdit, "IE Changed the value of the property: " & $sProperty & @CRLF, "append")
EndFunc   ;==>IEEvent_PropertyChange

Func IEEvent_DownloadBegin()
	GUICtrlSetData($g_idGUIEdit, "IE has started a navigation operation" & @CRLF, "append")
EndFunc   ;==>IEEvent_DownloadBegin

Func IEEvent_DownloadComplete()
	GUICtrlSetData($g_idGUIEdit, "IE has finished a navigation operation" & @CRLF, "append")
EndFunc   ;==>IEEvent_DownloadComplete

Func IEEvent_NavigateComplete2($oWebBrowser, $sURL)
	#forceref $oWebBrowser

	;    IDispatch *pDisp,
	;    VARIANT *URL

	GUICtrlSetData($g_idGUIEdit, "IE has finished loading URL: " & $sURL & @CRLF, "append")
EndFunc   ;==>IEEvent_NavigateComplete2

; AutoIt Error Event Function
; ---------------------------

Func MyErrFunc()
	Local $sHexNumber = Hex($g_oMyError.number, 8)

	MsgBox($MB_SYSTEMMODAL, "", "We intercepted a COM Error !" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $g_oMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $g_oMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & $sHexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $g_oMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $g_oMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $g_oMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $g_oMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $g_oMyError.helpcontext _
			)

	$g_nComError = $g_oMyError.number ; to check for after this function returns
EndFunc   ;==>MyErrFunc
