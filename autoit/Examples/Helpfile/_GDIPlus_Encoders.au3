#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>

Global $g_idMemo, $g_aCodex, $g_hImage

Example()

Func Example()
	Local $hBitmap

	; Create GUI
	GUICreate("GDI+", 600, 400)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Initialize GDI+ library
	_GDIPlus_Startup()

	; Create an image to use for paramater lists
	$hBitmap = _ScreenCapture_Capture("", 0, 0, 1, 1)
	$g_hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)

	; Show encoder parameters
	$g_aCodex = _GDIPlus_Encoders()
	ShowCodex("Encoder")

	; Show decoder parameters
	$g_aCodex = _GDIPlus_Decoders()
	ShowCodex("Decoder")

	; Clean up resources
	_GDIPlus_ImageDispose($g_hImage)
	_WinAPI_DeleteObject($hBitmap)

	; Shut down GDI+ library
	_GDIPlus_Shutdown()

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage = '')
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

; Show codex information
Func ShowCodex($sTitle)
	Local $iI, $iJ, $iK, $sCLSID, $tData, $tParam, $tParams, $iParamSize = _GDIPlus_ParamSize()

	For $iI = 1 To $g_aCodex[0][0]
		$sCLSID = _GDIPlus_EncodersGetCLSID($g_aCodex[$iI][5])
		MemoWrite("Image " & $sTitle & " " & $iI)
		MemoWrite("  Codec GUID ............: " & $g_aCodex[$iI][1])
		MemoWrite("  File format GUID ......: " & $g_aCodex[$iI][2])
		MemoWrite("  Codec name ............: " & $g_aCodex[$iI][3])
		MemoWrite("  Codec Dll file name ...: " & $g_aCodex[$iI][4])
		MemoWrite("  Codec file format .....: " & $g_aCodex[$iI][5])
		MemoWrite("  File name extensions ..: " & $g_aCodex[$iI][6])
		MemoWrite("  Mime type .............: " & $g_aCodex[$iI][7])
		MemoWrite("  Flags .................: 0x" & Hex($g_aCodex[$iI][8]))
		MemoWrite("  Version ...............: " & $g_aCodex[$iI][9])
		MemoWrite("  Signature count .......: " & $g_aCodex[$iI][10])
		MemoWrite("  Signature size ........: " & $g_aCodex[$iI][11])
		MemoWrite("  Signature pattern ptr .: 0x" & Hex($g_aCodex[$iI][12]))
		MemoWrite("  Signature mask ptr ....: 0x" & Hex($g_aCodex[$iI][13]))

;~ 		If $sTitle = "Decoder" Then ContinueLoop

		MemoWrite("  Parameter list size ...: " & _GDIPlus_EncodersGetParamListSize($g_hImage, $sCLSID))

		$tParams = _GDIPlus_EncodersGetParamList($g_hImage, $sCLSID)
		If @error Then
			MemoWrite()
			ContinueLoop
		EndIf

		MemoWrite("  Parameters Count ......: " & DllStructGetData($tParams, "Count"))
		MemoWrite()
		For $iJ = 0 To DllStructGetData($tParams, "Count") - 1
			MemoWrite("  Image " & $sTitle & " " & $iI & " Parameter " & $iJ)
			$tParam = DllStructCreate($tagGDIPENCODERPARAM, DllStructGetPtr($tParams, "GUID") + ($iJ * $iParamSize))
			MemoWrite("    Parameter GUID ......: " & _WinAPI_StringFromGUID(DllStructGetPtr($tParam, "GUID")))
			MemoWrite("    Number of values ....: " & DllStructGetData($tParam, "NumberOfValues"))
			MemoWrite("    Parameter type.......: " & DllStructGetData($tParam, "Type"))
			MemoWrite("    Parameter pointer ...: 0x" & Hex(DllStructGetData($tParam, "Values")))
			Switch DllStructGetData($tParam, "Type")
				Case 4
					$tData = DllStructCreate("int Data[" & DllStructGetData($tParam, "NumberOfValues") & "]", DllStructGetData($tParam, "Values"))
					For $iK = 1 To DllStructGetData($tParam, "NumberOfValues")
						MemoWrite("      Value .............: " & DllStructGetData($tData, 1, $iK))
					Next
				Case 6
					$tData = DllStructCreate("int Low;int High", DllStructGetData($tParam, "Values"))
					MemoWrite("      Low range .........: " & DllStructGetData($tData, "Low"))
					MemoWrite("      High range ........: " & DllStructGetData($tData, "High"))
			EndSwitch
			MemoWrite()
		Next
	Next
EndFunc   ;==>ShowCodex
