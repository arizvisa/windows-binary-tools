#include <APILocaleConstants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <WinAPILocale.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.1' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later.')
	Exit
EndIf

; Create array of strings ("Item*")
Local $aItem[100]
For $i = 0 To UBound($aItem) - 1
	$aItem[$i] = 'Item' & Random(0, 100, 1)
Next

_ArrayDisplay($aItem, 'Initial array')

; Simple array sorting
_ArraySort($aItem)

_ArrayDisplay($aItem, 'Simple sorting')

; Sort array (bubble sort) ignoring case sensitive and according to the digits
Local $sTemp
For $i = 0 To UBound($aItem) - 2
	For $j = $i + 1 To UBound($aItem) - 1
		Switch _WinAPI_CompareString($LOCALE_INVARIANT, $aItem[$i], $aItem[$j], BitOR($NORM_IGNORECASE, $SORT_DIGITSASNUMBERS))
			Case $CSTR_GREATER_THAN
				$sTemp = $aItem[$i]
				$aItem[$i] = $aItem[$j]
				$aItem[$j] = $sTemp
			Case Else

		EndSwitch
	Next
Next

_ArrayDisplay($aItem, 'bubble sort case insensitive')
