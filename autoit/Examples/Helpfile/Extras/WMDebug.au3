#Region Header

#cs

    Title:          Window Messages (WM) Debugger UDF Library for AutoIt3
    Filename:       WMDebug.au3
    Description:    Helper debug function that used in some examples from the WinAPIEx UDF library package
    Author:         Yashied
    Version:        3.8
    Requirements:   AutoIt v3.3 +, Developed/Tested on Windows XP Pro Service Pack 2 and Windows Vista/7
    Uses:           None
    Note:           -

    Available functions:

    _WM_Debug

#ce

#include-once

#EndRegion Header

#Region Global Variables and Constants

Global Const $WMD_HWND = 0x0001
Global Const $WMD_ID = 0x0002
Global Const $WMD_WPARAM = 0x0004
Global Const $WMD_LPARAM = 0x0008
Global Const $WMD_MSG = 0x0010
Global Const $WMD_ALL = BitOR($WMD_HWND, $WMD_ID, $WMD_WPARAM, $WMD_LPARAM, $WMD_MSG)
Global Const $WMD_DEFAULT = BitOR($WMD_WPARAM, $WMD_LPARAM, $WMD_MSG)

#EndRegion Global Variables and Constants

#Region Local Variables and Constants

Global Const $g_tInt64 = DllStructCreate('int64')
Global Const $g_tDWord = DllStructCreate('dword;dword', DllStructGetPtr($g_tInt64))
Global Const $__WM = __WMGetArray()

#EndRegion Local Variables and Constants

#Region Public Functions

; #FUNCTION# ====================================================================================================================
; Name...........: _WM_Debug
; Description....: Writes a values of the specified parameters to the STDOUT stream as the pre-formatted string.
; Syntax.........: _WM_Debug ($iVal1, $iVal2, $iVal3, $iVal4, $iFlags [, $aInclude [, $aExclude]] )
; Parameters.....: $iVal1...$iVal4 - This parameters must contain the values of the parameters known as "hWnd", "iMsg", "wParam",
;                                    and "lParam" that are passed to the typical Window Message (WM) procedure. This parameters
;                                    should be of the any integer type or a pointers.
;                  $iFlags         - A set of bit flags that specifies which parameters should be used. This parameter can be
;                                    one or more of the following values.
; ;                                    $WMD_ALL
;                                    $WMD_DEFAULT
;                                    $WMD_HWND
;                                    $WMD_ID
;                                    $WMD_WPARAM
;                                    $WMD_LPARAM
;                                    $WMD_MSG
; ;                  $aInclude       - An array that contains an integer values of the Window Messages ($aWM_*) which to be processed.
;                                    The messages that are not included in this array will be ignored. If this parameter is not
;                                    an array, the all messages will be processed.
;                  $aExclude       - An array that contains an integer values of the Window Messages ($aWM_*) which to be ignored.
;                                    The messages that are not included in this array will be processed. This can be useful to
;                                    exclude frequent messages such as WM_MOUSEMOVE, WM_SETCURSOR, etc.
; Return values..: None
; Author.........: Yashied
; Modified.......:
; Remarks........: The _WM_Debug() function generally need to call directly from the hook or window callback procedure and pass it
;                  parameters of this procedure.
; Related........:
; Link...........: None
; Example........: Yes
; ===============================================================================================================================

Func _WM_Debug($iVal1, $iVal2, $iVal3, $iVal4, $iFlags = 0x001C, $aInclude = 0, $aExclude = 0)
	#forceref $iVal1, $iVal3, $iVal4

	If IsArray($aInclude) Then
		Do
			For $i = 0 To UBound($aInclude) - 1
				If $aInclude[$i] = $iVal2 Then
					ExitLoop 2
				EndIf
			Next
			Return
		Until 1
	EndIf
	If IsArray($aExclude) Then
		Do
			For $i = 0 To UBound($aExclude) - 1
				If $aExclude[$i] = $iVal2 Then
					Return
				EndIf
			Next
		Until 1
	EndIf
	Local $aParam = StringSplit('HWND = 0x%s|MSG = 0x%04X|WP = 0x%s|LP = 0x%s|', '|', 2)
	Local $iPrev = 0, $sPattern = ''
	For $i = 0 To 3
		If BitAND($iFlags, BitShift(1, -$i)) Then
			If $iPrev Then
				$sPattern &= ' | '
			EndIf
			$sPattern &= $aParam[$i]
			$aParam[$i] = Eval('iVal' & ($i + 1))
			$iPrev = 1
		Else
			$sPattern &= '%s'
			$aParam[$i] = ''
		EndIf
	Next
	If BitAND($iFlags, 0x0010) Then
		If $iPrev Then
			$sPattern &= ' | '
		EndIf
		If ($iVal2 < UBound($__WM)) And ($__WM[$iVal2]) Then
			$aParam[4] = $__WM[$iVal2]
			$sPattern &= '%s'
		Else
			$aParam[4] = $iVal2
			$sPattern &= '0x%04X'
		EndIf
	EndIf
	ConsoleWrite(StringFormat($sPattern, __WMHex64($aParam[0]), $aParam[1], __WMHex64($aParam[2]), __WMHex64($aParam[3]), $aParam[4]) & @CRLF)
EndFunc   ;==>_WM_Debug

#EndRegion Public Functions

#Region Internal Functions

Func __WMGetArray()
	Local $aWM[0x0400]

	$aWM[0x0000] = 'WM_NULL'
	$aWM[0x0001] = 'WM_CREATE'
	$aWM[0x0002] = 'WM_DESTROY'
	$aWM[0x0003] = 'WM_MOVE'
	$aWM[0x0004] = 'WM_SIZEWAIT'
	$aWM[0x0005] = 'WM_SIZE'
	$aWM[0x0006] = 'WM_ACTIVATE'
	$aWM[0x0007] = 'WM_SETFOCUS'
	$aWM[0x0008] = 'WM_KILLFOCUS'
	$aWM[0x0009] = 'WM_SETVISIBLE'
	$aWM[0x000A] = 'WM_ENABLE'
	$aWM[0x000B] = 'WM_SETREDRAW'
	$aWM[0x000C] = 'WM_SETTEXT'
	$aWM[0x000D] = 'WM_GETTEXT'
	$aWM[0x000E] = 'WM_GETTEXTLENGTH'
	$aWM[0x000F] = 'WM_PAINT'
	$aWM[0x0010] = 'WM_CLOSE'
	$aWM[0x0011] = 'WM_QUERYENDSESSION'
	$aWM[0x0012] = 'WM_QUIT'
	$aWM[0x0013] = 'WM_QUERYOPEN'
	$aWM[0x0014] = 'WM_ERASEBKGND'
	$aWM[0x0015] = 'WM_SYSCOLORCHANGE'
	$aWM[0x0016] = 'WM_ENDSESSION'
	$aWM[0x0017] = 'WM_SYSTEMERROR'
	$aWM[0x0018] = 'WM_SHOWWINDOW'
	$aWM[0x0019] = 'WM_CTLCOLOR'
	$aWM[0x001A] = 'WM_SETTINGCHANGE'
	$aWM[0x001B] = 'WM_DEVMODECHANGE'
	$aWM[0x001C] = 'WM_ACTIVATEAPP'
	$aWM[0x001D] = 'WM_FONTCHANGE'
	$aWM[0x001E] = 'WM_TIMECHANGE'
	$aWM[0x001F] = 'WM_CANCELMODE'
	$aWM[0x0020] = 'WM_SETCURSOR'
	$aWM[0x0021] = 'WM_MOUSEACTIVATE'
	$aWM[0x0022] = 'WM_CHILDACTIVATE'
	$aWM[0x0023] = 'WM_QUEUESYNC'
	$aWM[0x0024] = 'WM_GETMINMAXINFO'
	$aWM[0x0025] = 'WM_LOGOFF'
	$aWM[0x0026] = 'WM_PAINTICON'
	$aWM[0x0027] = 'WM_ICONERASEBKGND'
	$aWM[0x0028] = 'WM_NEXTDLGCTL'
	$aWM[0x0029] = 'WM_ALTTABACTIVE'
	$aWM[0x002A] = 'WM_SPOOLERSTATUS'
	$aWM[0x002B] = 'WM_DRAWITEM'
	$aWM[0x002C] = 'WM_MEASUREITEM'
	$aWM[0x002D] = 'WM_DELETEITEM'
	$aWM[0x002E] = 'WM_VKEYTOITEM'
	$aWM[0x002F] = 'WM_CHARTOITEM'
	$aWM[0x0030] = 'WM_SETFONT'
	$aWM[0x0031] = 'WM_GETFONT'
	$aWM[0x0032] = 'WM_SETHOTKEY'
	$aWM[0x0033] = 'WM_GETHOTKEY'
	$aWM[0x0034] = 'WM_FILESYSCHANGE'
	$aWM[0x0035] = 'WM_ISACTIVEICON'
	$aWM[0x0036] = 'WM_QUERYPARKICON'
	$aWM[0x0037] = 'WM_QUERYDRAGICON'
	$aWM[0x0038] = 'WM_WINHELP'
	$aWM[0x0039] = 'WM_COMPAREITEM'
	$aWM[0x003A] = 'WM_FULLSCREEN'
	$aWM[0x003B] = 'WM_CLIENTSHUTDOWN'
	$aWM[0x003C] = 'WM_DDEMLEVENT'
	$aWM[0x003D] = 'WM_GETOBJECT'
	$aWM[0x003F] = 'WM_CALCSCROLL'
	$aWM[0x0040] = 'WM_TESTING'
	$aWM[0x0041] = 'WM_COMPACTING'
	$aWM[0x0042] = 'WM_OTHERWINDOWCREATED'
	$aWM[0x0043] = 'WM_OTHERWINDOWDESTROYED'
	$aWM[0x0044] = 'WM_COMMNOTIFY'
	$aWM[0x0045] = 'WM_MEDIASTATUSCHANGE'
	$aWM[0x0046] = 'WM_WINDOWPOSCHANGING'
	$aWM[0x0047] = 'WM_WINDOWPOSCHANGED'
	$aWM[0x0048] = 'WM_POWER'
	$aWM[0x0049] = 'WM_COPYGLOBALDATA'
	$aWM[0x004A] = 'WM_COPYDATA'
	$aWM[0x004B] = 'WM_CANCELJOURNAL'
	$aWM[0x004C] = 'WM_LOGONNOTIFY'
	$aWM[0x004D] = 'WM_KEYF1'
	$aWM[0x004E] = 'WM_NOTIFY'
	$aWM[0x004F] = 'WM_ACCESS_WINDOW'
	$aWM[0x0050] = 'WM_INPUTLANGCHANGEREQUEST'
	$aWM[0x0051] = 'WM_INPUTLANGCHANGE'
	$aWM[0x0052] = 'WM_TCARD'
	$aWM[0x0053] = 'WM_HELP'
	$aWM[0x0054] = 'WM_USERCHANGED'
	$aWM[0x0055] = 'WM_NOTIFYFORMAT'
	$aWM[0x0060] = 'WM_QM_ACTIVATE'
	$aWM[0x0061] = 'WM_HOOK_DO_CALLBACK'
	$aWM[0x0062] = 'WM_SYSCOPYDATA'
	$aWM[0x0070] = 'WM_FINALDESTROY'
	$aWM[0x0071] = 'WM_MEASUREITEM_CLIENTDATA'
	$aWM[0x007B] = 'WM_CONTEXTMENU'
	$aWM[0x007C] = 'WM_STYLECHANGING'
	$aWM[0x007D] = 'WM_STYLECHANGED'
	$aWM[0x007E] = 'WM_DISPLAYCHANGE'
	$aWM[0x007F] = 'WM_GETICON'
	$aWM[0x0080] = 'WM_SETICON'
	$aWM[0x0081] = 'WM_NCCREATE'
	$aWM[0x0082] = 'WM_NCDESTROY'
	$aWM[0x0083] = 'WM_NCCALCSIZE'
	$aWM[0x0084] = 'WM_NCHITTEST'
	$aWM[0x0085] = 'WM_NCPAINT'
	$aWM[0x0086] = 'WM_NCACTIVATE'
	$aWM[0x0087] = 'WM_GETDLGCODE'
	$aWM[0x0088] = 'WM_SYNCPAINT'
	$aWM[0x0089] = 'WM_SYNCTASK'
	$aWM[0x008B] = 'WM_KLUDGEMINRECT'
	$aWM[0x008C] = 'WM_LPKDRAWSWITCHWND'
	$aWM[0x0090] = 'WM_UAHDESTROYWINDOW'
	$aWM[0x0091] = 'WM_UAHDRAWMENU'
	$aWM[0x0092] = 'WM_UAHDRAWMENUITEM'
	$aWM[0x0093] = 'WM_UAHINITMENU'
	$aWM[0x0094] = 'WM_UAHMEASUREMENUITEM'
	$aWM[0x0095] = 'WM_UAHNCPAINTMENUPOPUP'
	$aWM[0x00A0] = 'WM_NCMOUSEMOVE'
	$aWM[0x00A1] = 'WM_NCLBUTTONDOWN'
	$aWM[0x00A2] = 'WM_NCLBUTTONUP'
	$aWM[0x00A3] = 'WM_NCLBUTTONDBLCLK'
	$aWM[0x00A4] = 'WM_NCRBUTTONDOWN'
	$aWM[0x00A5] = 'WM_NCRBUTTONUP'
	$aWM[0x00A6] = 'WM_NCRBUTTONDBLCLK'
	$aWM[0x00A7] = 'WM_NCMBUTTONDOWN'
	$aWM[0x00A8] = 'WM_NCMBUTTONUP'
	$aWM[0x00A9] = 'WM_NCMBUTTONDBLCLK'
	$aWM[0x00AB] = 'WM_NCXBUTTONDOWN'
	$aWM[0x00AC] = 'WM_NCXBUTTONUP'
	$aWM[0x00AD] = 'WM_NCXBUTTONDBLCLK'
	$aWM[0x00AE] = 'WM_NCUAHDRAWCAPTION'
	$aWM[0x00AF] = 'WM_NCUAHDRAWFRAME'
	$aWM[0x00FE] = 'WM_INPUT_DEVICE_CHANGE'
	$aWM[0x00FF] = 'WM_INPUT'
	$aWM[0x0100] = 'WM_KEYDOWN'
	$aWM[0x0101] = 'WM_KEYUP'
	$aWM[0x0102] = 'WM_CHAR'
	$aWM[0x0103] = 'WM_DEADCHAR'
	$aWM[0x0104] = 'WM_SYSKEYDOWN'
	$aWM[0x0105] = 'WM_SYSKEYUP'
	$aWM[0x0106] = 'WM_SYSCHAR'
	$aWM[0x0107] = 'WM_SYSDEADCHAR'
	$aWM[0x0108] = 'WM_YOMICHAR'
	$aWM[0x0109] = 'WM_UNICHAR'
	$aWM[0x010A] = 'WM_CONVERTREQUEST'
	$aWM[0x010B] = 'WM_CONVERTRESULT'
	$aWM[0x010C] = 'WM_IM_INFO'
	$aWM[0x010D] = 'WM_IME_STARTCOMPOSITION'
	$aWM[0x010E] = 'WM_IME_ENDCOMPOSITION'
	$aWM[0x010F] = 'WM_IME_COMPOSITION'
	$aWM[0x0110] = 'WM_INITDIALOG'
	$aWM[0x0111] = 'WM_COMMAND'
	$aWM[0x0112] = 'WM_SYSCOMMAND'
	$aWM[0x0113] = 'WM_TIMER'
	$aWM[0x0114] = 'WM_HSCROLL'
	$aWM[0x0115] = 'WM_VSCROLL'
	$aWM[0x0116] = 'WM_INITMENU'
	$aWM[0x0117] = 'WM_INITMENUPOPUP'
	$aWM[0x0118] = 'WM_SYSTIMER'
	$aWM[0x0119] = 'WM_GESTURE'
	$aWM[0x011A] = 'WM_GESTURENOTIFY'
	$aWM[0x011B] = 'WM_GESTUREINPUT'
	$aWM[0x011C] = 'WM_GESTURENOTIFIED'
	$aWM[0x011F] = 'WM_MENUSELECT'
	$aWM[0x0120] = 'WM_MENUCHAR'
	$aWM[0x0121] = 'WM_ENTERIDLE'
	$aWM[0x0122] = 'WM_MENURBUTTONUP'
	$aWM[0x0123] = 'WM_MENUDRAG'
	$aWM[0x0124] = 'WM_MENUGETOBJECT'
	$aWM[0x0125] = 'WM_UNINITMENUPOPUP'
	$aWM[0x0126] = 'WM_MENUCOMMAND'
	$aWM[0x0127] = 'WM_CHANGEUISTATE'
	$aWM[0x0128] = 'WM_UPDATEUISTATE'
	$aWM[0x0129] = 'WM_QUERYUISTATE'
	$aWM[0x0131] = 'WM_LBTRACKPOINT'
	$aWM[0x0132] = 'WM_CTLCOLORMSGBOX'
	$aWM[0x0133] = 'WM_CTLCOLOREDIT'
	$aWM[0x0134] = 'WM_CTLCOLORLISTBOX'
	$aWM[0x0135] = 'WM_CTLCOLORBTN'
	$aWM[0x0136] = 'WM_CTLCOLORDLG'
	$aWM[0x0137] = 'WM_CTLCOLORSCROLLBAR'
	$aWM[0x0138] = 'WM_CTLCOLORSTATIC'
	$aWM[0x0200] = 'WM_MOUSEMOVE'
	$aWM[0x0201] = 'WM_LBUTTONDOWN'
	$aWM[0x0202] = 'WM_LBUTTONUP'
	$aWM[0x0203] = 'WM_LBUTTONDBLCLK'
	$aWM[0x0204] = 'WM_RBUTTONDOWN'
	$aWM[0x0205] = 'WM_RBUTTONUP'
	$aWM[0x0206] = 'WM_RBUTTONDBLCLK'
	$aWM[0x0207] = 'WM_MBUTTONDOWN'
	$aWM[0x0208] = 'WM_MBUTTONUP'
	$aWM[0x0209] = 'WM_MBUTTONDBLCLK'
	$aWM[0x020A] = 'WM_MOUSEWHEEL'
	$aWM[0x020B] = 'WM_XBUTTONDOWN'
	$aWM[0x020C] = 'WM_XBUTTONUP'
	$aWM[0x020D] = 'WM_XBUTTONDBLCLK'
	$aWM[0x020E] = 'WM_MOUSEHWHEEL'
	$aWM[0x0210] = 'WM_PARENTNOTIFY'
	$aWM[0x0211] = 'WM_ENTERMENULOOP'
	$aWM[0x0212] = 'WM_EXITMENULOOP'
	$aWM[0x0213] = 'WM_NEXTMENU'
	$aWM[0x0214] = 'WM_SIZING'
	$aWM[0x0215] = 'WM_CAPTURECHANGED'
	$aWM[0x0216] = 'WM_MOVING'
	$aWM[0x0218] = 'WM_POWERBROADCAST'
	$aWM[0x0219] = 'WM_DEVICECHANGE'
	$aWM[0x0220] = 'WM_MDICREATE'
	$aWM[0x0221] = 'WM_MDIDESTROY'
	$aWM[0x0222] = 'WM_MDIACTIVATE'
	$aWM[0x0223] = 'WM_MDIRESTORE'
	$aWM[0x0224] = 'WM_MDINEXT'
	$aWM[0x0225] = 'WM_MDIMAXIMIZE'
	$aWM[0x0226] = 'WM_MDITILE'
	$aWM[0x0227] = 'WM_MDICASCADE'
	$aWM[0x0228] = 'WM_MDIICONARRANGE'
	$aWM[0x0229] = 'WM_MDIGETACTIVE'
	$aWM[0x022A] = 'WM_DROPOBJECT'
	$aWM[0x022B] = 'WM_QUERYDROPOBJECT'
	$aWM[0x022C] = 'WM_BEGINDRAG'
	$aWM[0x022D] = 'WM_DRAGLOOP'
	$aWM[0x022E] = 'WM_DRAGSELECT'
	$aWM[0x022F] = 'WM_DRAGMOVE'
	$aWM[0x0230] = 'WM_MDISETMENU'
	$aWM[0x0231] = 'WM_ENTERSIZEMOVE'
	$aWM[0x0232] = 'WM_EXITSIZEMOVE'
	$aWM[0x0233] = 'WM_DROPFILES'
	$aWM[0x0234] = 'WM_MDIREFRESHMENU'
	$aWM[0x0240] = 'WM_TOUCH'
	$aWM[0x0281] = 'WM_IME_SETCONTEXT'
	$aWM[0x0282] = 'WM_IME_NOTIFY'
	$aWM[0x0283] = 'WM_IME_CONTROL'
	$aWM[0x0284] = 'WM_IME_COMPOSITIONFULL'
	$aWM[0x0285] = 'WM_IME_SELECT'
	$aWM[0x0286] = 'WM_IME_CHAR'
	$aWM[0x0287] = 'WM_IME_SYSTEM'
	$aWM[0x0288] = 'WM_IME_REQUEST'
	$aWM[0x0290] = 'WM_IME_KEYDOWN'
	$aWM[0x0291] = 'WM_IME_KEYUP'
	$aWM[0x02A0] = 'WM_NCMOUSEHOVER'
	$aWM[0x02A1] = 'WM_MOUSEHOVER'
	$aWM[0x02A2] = 'WM_NCMOUSELEAVE'
	$aWM[0x02A3] = 'WM_MOUSELEAVE'
	$aWM[0x02B1] = 'WM_WTSSESSION_CHANGE'
	$aWM[0x02C0] = 'WM_TABLET_FIRST'
	$aWM[0x02DF] = 'WM_TABLET_LAST'
	$aWM[0x0300] = 'WM_CUT'
	$aWM[0x0301] = 'WM_COPY'
	$aWM[0x0302] = 'WM_PASTE'
	$aWM[0x0303] = 'WM_CLEAR'
	$aWM[0x0304] = 'WM_UNDO'
	$aWM[0x0305] = 'WM_RENDERFORMAT'
	$aWM[0x0306] = 'WM_RENDERALLFORMATS'
	$aWM[0x0307] = 'WM_DESTROYCLIPBOARD'
	$aWM[0x0308] = 'WM_DRAWCLIPBOARD'
	$aWM[0x0309] = 'WM_PAINTCLIPBOARD'
	$aWM[0x030A] = 'WM_VSCROLLCLIPBOARD'
	$aWM[0x030B] = 'WM_SIZECLIPBOARD'
	$aWM[0x030C] = 'WM_ASKCBFORMATNAME'
	$aWM[0x030D] = 'WM_CHANGECBCHAIN'
	$aWM[0x030E] = 'WM_HSCROLLCLIPBOARD'
	$aWM[0x030F] = 'WM_QUERYNEWPALETTE'
	$aWM[0x0310] = 'WM_PALETTEISCHANGING'
	$aWM[0x0311] = 'WM_PALETTECHANGED'
	$aWM[0x0312] = 'WM_HOTKEY'
	$aWM[0x0313] = 'WM_SYSMENU'
	$aWM[0x0314] = 'WM_HOOKMSG'
	$aWM[0x0315] = 'WM_EXITPROCESS'
	$aWM[0x0316] = 'WM_WAKETHREAD'
	$aWM[0x0317] = 'WM_PRINT'
	$aWM[0x0318] = 'WM_PRINTCLIENT'
	$aWM[0x0319] = 'WM_APPCOMMAND'
	$aWM[0x031A] = 'WM_THEMECHANGED'
	$aWM[0x031B] = 'WM_UAHINIT'
	$aWM[0x031C] = 'WM_DESKTOPNOTIFY'
	$aWM[0x031D] = 'WM_CLIPBOARDUPDATE'
	$aWM[0x031E] = 'WM_DWMCOMPOSITIONCHANGED'
	$aWM[0x031F] = 'WM_DWMNCRENDERINGCHANGED'
	$aWM[0x0320] = 'WM_DWMCOLORIZATIONCOLORCHANGED'
	$aWM[0x0321] = 'WM_DWMWINDOWMAXIMIZEDCHANGE'
	$aWM[0x0322] = 'WM_DWMEXILEFRAME'
	$aWM[0x0323] = 'WM_DWMSENDICONICTHUMBNAIL'
	$aWM[0x0324] = 'WM_MAGNIFICATION_STARTED'
	$aWM[0x0325] = 'WM_MAGNIFICATION_ENDED'
	$aWM[0x0326] = 'WM_DWMSENDICONICLIVEPREVIEWBITMAP'
	$aWM[0x0327] = 'WM_DWMTHUMBNAILSIZECHANGED'
	$aWM[0x0328] = 'WM_MAGNIFICATION_OUTPUT'
	$aWM[0x0330] = 'WM_MEASURECONTROL'
	$aWM[0x0331] = 'WM_GETACTIONTEXT'
	$aWM[0x0333] = 'WM_FORWARDKEYDOWN'
	$aWM[0x0334] = 'WM_FORWARDKEYUP'
	$aWM[0x033F] = 'WM_GETTITLEBARINFOEX'
	$aWM[0x0340] = 'WM_NOTIFYWOW'
	$aWM[0x0358] = 'WM_HANDHELDFIRST'
	$aWM[0x035F] = 'WM_HANDHELDLAST'
	$aWM[0x0360] = 'WM_AFXFIRST'
	$aWM[0x037F] = 'WM_AFXLAST'
	$aWM[0x0380] = 'WM_PENWINFIRST'
	$aWM[0x038F] = 'WM_PENWINLAST'
	$aWM[0x03E0] = 'WM_DDE_INITIATE'
	$aWM[0x03E1] = 'WM_DDE_TERMINATE'
	$aWM[0x03E2] = 'WM_DDE_ADVISE'
	$aWM[0x03E3] = 'WM_DDE_UNADVISE'
	$aWM[0x03E4] = 'WM_DDE_ACK'
	$aWM[0x03E5] = 'WM_DDE_DATA'
	$aWM[0x03E6] = 'WM_DDE_REQUEST'
	$aWM[0x03E7] = 'WM_DDE_POKE'
	$aWM[0x03E8] = 'WM_DDE_EXECUTE'
	$aWM[0x03FD] = 'WM_DBNOTIFICATION'
	$aWM[0x03FE] = 'WM_NETCONNECT'
	$aWM[0x03FF] = 'WM_HIBERNATE'
	Return $aWM
EndFunc   ;==>__WMGetArray

Func __WMHex64(ByRef $iValue)
	If Not StringLen($iValue) Then
		Return ''
	EndIf
	DllStructSetData($g_tInt64, 1, $iValue)
	If @AutoItX64 Then
		Return StringRight(Hex(DllStructGetData($g_tDWord, 2)) & Hex(DllStructGetData($g_tDWord, 1)), 16)
	Else
		Return StringRight(Hex(DllStructGetData($g_tDWord, 2)) & Hex(DllStructGetData($g_tDWord, 1)), 8)
	EndIf
EndFunc   ;==>__WMHex64

#EndRegion Internal Functions
