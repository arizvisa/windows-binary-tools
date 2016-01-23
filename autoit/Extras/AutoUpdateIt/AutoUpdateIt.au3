#NoTrayIcon
; =======================================================================
; AutoUpdateIt
; Original by Rob Saunders
; Modifications by JPM/strik3r0475/erebus
;
; Command Line Options:
;  - AutoUpdateIt.au3 [/release | /beta | /prebeta] [/silent] [/noproxy]
;    - /release   Download latest release
;    - /beta      Download latest beta
;    - /prebeta   Download latest prebeta
;    - /silent    Silently auto-install (resets all settings)
;    - /noproxy   Use direct internet access (no IE proxy)
;
; History:
;  - 1.50 - Rewrote the code to new Inet... functions (InetClose, InetGetInfo) (by Prog@ndy)
;  - 1.41 - Added error message when dowload is not working (by JPM)
;  - 1.40 - Fixed a bug where the updater crashed if AU3 was not already installed (by erebus)
;         - Fixed some display bugs, occured if AU3 was not already installed (by erebus)
;         - Re-added the installation paths on the GUI; tiny but useful (by erebus)
;         - Added the /noproxy command line switch to allow direct internet access (by erebus)
;         - Added a menu option to disable/enable the use of IE's proxy (by erebus)
;  - 1.37 - Change Alpha to Pre-Beta (by JPM)
;  - 1.36 - Display current Beta (by strik3r0475)
;  - 1.35 - Fixed some display bugs
;  - 1.34 - Display Alpha release if available
;         - Command line parameters added /alpha to check for latest alpha
;  - 1.33 - Added Retry/Cancel MsgBox when cannot connect to receive update file
;         - Added Progress bar for non-WinXP users
;  - 1.32 - Changed _CompareVersions again (integer comparison now)
;  - 1.31 - Rewrote _ClipPath again
;  - 1.30 - Rewrote a few UDFs (_CompareVersions, _ClipPath)
;         - Underscored all UDF names
;         - Removed a misplaced 'Then' screwing up command line options
;  - 1.21 - Stupid bug fixed (ignored version check for /beta command)
;         - CompareVersions function works properly now (was seeing 3.0.103.173 as newer than 3.1.0.1)
;  - 1.20 - Command line parameters added
;           - /release to check for latest public release
;           - /beta to check for latest beta
;           - /silent to install silently (you will lose your compiler and file settings)
;  - 1.11 - Starts the download when you press one of the download
;           buttons, resulting in pre-downloading while you choose
;           where to save the file
;         - Default name for Beta download includes full version string
;         - Deletes "au3_update.dat" from temp files after loading data
;  - 1.10 - Displays release date
;         - Changed layout of buttons / groups
;         - Slightly modified error message when server inaccessible
;  - 1.00 - "Release" / given a version number
;
; Forum Threads:
;  - http://www.autoitscript.com/forum/index.ph...view=getnewpost
;  - http://www.autoitscript.com/forum/index.ph...view=getnewpost
;
; =======================================================================
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

; ========================================
; Predefine variables
; ========================================
Global Const $g_sTitle = 'AutoUpdateIt'
Local Const $s_Version = '1.41'
Local Const $s_DatFile = 'https://www.autoitscript.com/autoit3/files/beta/update.dat'
Local Const $b_Download_UpdateDat = 1
Global Const $g_sDatFile_Local = @TempDir & '\au3_update.dat'
Global Const $g_sAu3UpReg = 'HKCU\Software\AutoIt v3\AutoUpdateIt'
Global $g_sDownPath, $g_sDownTemp
Global $g_iDnInitiated
Global $g_sReleaseVer, $g_sReleaseFile, $g_iReleaseSize, $g_iReleaseDate, $g_sReleasePage
Global $g_sLatestBetaVer, $g_sBetaFile, $g_iBetaSize, $g_iBetaDate, $g_sBetaPage
Global $g_sPreBetaVer, $g_sPreBetaFile, $g_iPreBetaSize, $g_iPreBetaDate, $g_sPreBetaPage

Global $g_iReleaseSizeKB, $g_iBetaSizeKB, $g_iPreBetaSizeKB
Global $g_iProgOn, $g_iStatusPercent

Global $g_hInetGet, $g_aDownDisplay, $g_aDownButtons

Local $i_Response, $s_Tmp, $s_DnBytes, $s_DnSize, $s_DefFileName, $i_DnPercent
Local $i_Res, $a_Pos, $s_CurrBetaVer, $s_CurrBetaDate, $s_CurrVer, $s_DownSize, $i_DownSize
Local $i_DatFileLoaded, $s_AutoUpdate, $s_CurrDate, $a_Msg
; ========================================
; Read registry settings
; ========================================
Global $g_sDefDownDir = RegRead($g_sAu3UpReg, 'DownloadDir')
If @error Then
	$g_sDefDownDir = @DesktopDir
EndIf
Local $s_Au3Path = RegRead64('HKLM\Software\AutoIt v3\AutoIt', 'InstallDir')
If Not @error And FileExists($s_Au3Path & '\AutoIt3.exe') Then
	$s_CurrVer = FileGetVersion($s_Au3Path & "\AutoIt3.exe")
	$s_CurrDate = _FriendlyDate(FileGetTime($s_Au3Path & "\AutoIt3.exe", 0, 1))
Else
	$s_Au3Path = 'Installation not found'
	$s_CurrVer = 'Unavailable'
	$s_CurrDate = 'Unavailable'
EndIf
Local $s_BetaPath = RegRead64('HKLM\Software\AutoIt v3\AutoIt', 'betaInstallDir')
If Not @error And FileExists($s_BetaPath & '\AutoIt3.exe') Then
	$s_CurrBetaVer = FileGetVersion($s_BetaPath & "\AutoIt3.exe")
	$s_CurrBetaDate = _FriendlyDate(FileGetTime($s_BetaPath & "\AutoIt3.exe", 0, 1))
Else
	$s_BetaPath = 'Installation not found'
	$s_CurrBetaVer = 'Unavailable'
	$s_CurrBetaDate = 'Unavailable'
EndIf
; ========================================
; Check for command line parameters
; ========================================
If _StringInArray($CmdLine, '/noproxy') Then HttpSetProxy(1)
If _StringInArray($CmdLine, '/release') Or _StringInArray($CmdLine, '/beta') Or _StringInArray($CmdLine, '/prebeta') Then
	Opt('TrayIconHide', 0)
	_Status('Checking for updates')
	InetGet($s_DatFile, $g_sDatFile_Local, 1)
	If @error <> 0 Then
		_Status('Could not connect to site', 'Please check your connection and try again')
		Sleep(4000)
		Exit
	EndIf
	_LoadUpdateData()
	If _StringInArray($CmdLine, '/release') And _CompareVersions($g_sReleaseVer, $s_CurrVer) Then
		$s_AutoUpdate = $g_sReleaseFile
		$g_sDownTemp = @TempDir & '\autoit-v3-setup.exe'
		$i_DownSize = $g_iReleaseSize
	ElseIf _StringInArray($CmdLine, '/beta') And _CompareVersions($g_sLatestBetaVer, $s_CurrVer) Then
		$s_AutoUpdate = $g_sBetaFile
		$g_sDownTemp = @TempDir & '\autoit-v' & $g_sLatestBetaVer & '.exe'
		$i_DownSize = $g_iBetaSize
	ElseIf _StringInArray($CmdLine, '/prebeta') And _CompareVersions($g_sPreBetaVer, $s_CurrVer) Then
		$s_AutoUpdate = $g_sPreBetaFile
		$g_sDownTemp = @TempDir & '\autoit-v' & $g_sPreBetaVer & '.exe'
		$i_DownSize = $g_iPreBetaSize
	EndIf
	If $s_AutoUpdate Then
		$g_hInetGet = InetGet($s_AutoUpdate, $g_sDownTemp, 1, 1)
		$s_DownSize = Round($i_DownSize / 1024) & ' KB'
		Do
			_Status('Downloading update', '', InetGetInfo($g_hInetGet, 0), $i_DownSize)
		Until InetGetInfo($g_hInetGet, 2)
		_Status('Download Complete', 'Launching install')
		InetClose($g_hInetGet)
		$g_hInetGet = -1
		Sleep(1000)
		If _StringInArray($CmdLine, '/silent') Then
			_Start('"' & $g_sDownTemp & '" /S')
		Else
			_Start('"' & $g_sDownTemp & '"')
		EndIf
	Else
		_Status('No new versions available')
		Sleep(1000)
	EndIf
	Exit
EndIf
; ========================================
; GUI - Main Application
; ========================================
Opt("GuiResizeMode", $GUI_DOCKALL)
Local $hGui_Main = GUICreate($g_sTitle, 350, 310 + 20)
Local $idMn_Help = GUICtrlCreateMenu('&Help')
Local $idMn_Proxy = GUICtrlCreateMenuItem('Disable IE''s &proxy server', $idMn_Help)
Local $idMn_VisitSite = GUICtrlCreateMenuItem('&Visit the AutoIt3 Website', $idMn_Help)
Local $idMn_About = GUICtrlCreateMenuItem('&About', $idMn_Help)
Local $idLb_separator = GUICtrlCreateLabel('', 0, 0, 350, 2, $SS_SUNKEN)
Local $idGr_Instal_Details = GUICtrlCreateGroup('Current Installation Details', 5, 5, 340, 70)
GUICtrlCreateLabel('Production Version: ' & $s_CurrVer, 15, 25, 160, 15)
GUICtrlCreateLabel('Date: ' & $s_CurrDate, 15, 40, 160, 15)
GUICtrlCreateLabel('Path: ' & $s_Au3Path, 15, 55, 160, 15)
GUICtrlSetFont(-1, 6)
GUICtrlCreateLabel('Beta Version: ' & $s_CurrBetaVer, 190, 25, 150, 15)
GUICtrlCreateLabel('Date: ' & $s_CurrBetaDate, 190, 40, 150, 15)
GUICtrlCreateLabel('Path: ' & $s_BetaPath, 190, 55, 150, 15)
GUICtrlSetFont(-1, 6)
Local $idGr_Mn_Release = GUICtrlCreateGroup('Latest Public Release', 5, 85, 165, 60)
Local $idLb_Mn_ReleaseVer = GUICtrlCreateLabel('Version: Loading...', 15, 105, 145, 15)
Local $idLb_Mn_ReleaseDate = GUICtrlCreateLabel('Date: Loading...', 15, 120, 145, 15)
Local $idGr_Mn_Beta = GUICtrlCreateGroup('Latest Beta', 180, 85, 165, 60)
Local $idLb_Mn_BetaVer = GUICtrlCreateLabel('Version: Loading...', 190, 105, 145, 15)
Local $idLb_Mn_BetaDate = GUICtrlCreateLabel('Date: Loading...', 190, 120, 145, 15)
Local $idGr_Mn_PreBeta = GUICtrlCreateGroup('Latest Pre-Beta', 180 + 175, 85, 165, 60)
Local $idLb_Mn_PreBetaVer = GUICtrlCreateLabel('Version: Loading...', 190 + 175, 105, 145, 15)
Local $idLb_Mn_PreBetaDate = GUICtrlCreateLabel('Date: Loading...', 190 + 175, 120, 145, 15)
GUIStartGroup()
Local $idRa_Mn_DoneNotify = GUICtrlCreateRadio('&Notify when download complete', 5, 155, 340, 15)
Local $idRa_Mn_DoneRun = GUICtrlCreateRadio('&Autorun install when download complete', 5, 175, 340, 15)
; Check default done option
If RegRead($g_sAu3UpReg, 'DoneOption') = 'Run' Then
	GUICtrlSetState($idRa_Mn_DoneRun, $GUI_CHECKED)
Else
	GUICtrlSetState($idRa_Mn_DoneNotify, $GUI_CHECKED)
EndIf
Global $g_idMn_Close = GUICtrlCreateButton('&Close', 10, 275, 330, 25)
; ========================================
; Control Set - Download Buttons
; ========================================
Local $idBt_Mn_ReleaseDl = GUICtrlCreateButton('Download Public &Release', 5, 195, 165, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
Local $idLb_Mn_ReleaseSize = GUICtrlCreateLabel('Size: Loading...', 5, 230, 165, 15, $SS_CENTER)
Local $idLb_Mn_ReleasePage = GUICtrlCreateLabel('Visit Download Page', 5, 245, 165, 15, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
Local $idBt_Mn_BetaDl = GUICtrlCreateButton('Download &Beta', 180, 195, 165, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
Local $idLb_Mn_BetaSize = GUICtrlCreateLabel('Size: Loading...', 180, 230, 165, 15, $SS_CENTER)
Local $idLb_Mn_BetaPage = GUICtrlCreateLabel('Visit Download Page', 180, 245, 165, 15, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
Local $idBt_Mn_PreBetaDl = GUICtrlCreateButton('Download &Pre-Beta', 180 + 175, 195, 165, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
Local $idLb_Mn_PreBetaSize = GUICtrlCreateLabel('Size: Loading...', 180 + 175, 230, 165, 15, $SS_CENTER)
Local $idLb_Mn_PreBetaPage = GUICtrlCreateLabel('Visit Download Page', 180 + 175, 245, 165, 15, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
$g_aDownButtons = StringSplit($idBt_Mn_ReleaseDl & '.' & _
		$idLb_Mn_ReleaseSize & '.' & _
		$idLb_Mn_ReleasePage & '.' & _
		$idBt_Mn_BetaDl & '.' & _
		$idLb_Mn_BetaSize & '.' & _
		$idLb_Mn_BetaPage & '.' & _
		$idBt_Mn_PreBetaDl & '.' & _
		$idLb_Mn_PreBetaSize & '.' & _
		$idLb_Mn_PreBetaPage, '.')
; ========================================
; Control Set - Download Display
; ========================================
Local $idLb_Mn_DwnToTtl = GUICtrlCreateLabel('Downloading to:', 5, 195, 290, 15, $SS_LEFTNOWORDWRAP)
Global $g_idLb_Mn_DwnToTxt = GUICtrlCreateLabel('', 5, 210, 290, 15, $SS_LEFTNOWORDWRAP)
Global $g_idPg_Mn_Progress = GUICtrlCreateProgress(5, 225, 340, 20)
Global $g_idLb_Mn_Progress = GUICtrlCreateLabel('', 5, 250, 290, 15)
Local $idBt_Mn_OpenFile = GUICtrlCreateButton('&Open', 105, 275, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
Local $idBt_Mn_OpenFolder = GUICtrlCreateButton('Open &Folder', 185, 275, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$g_aDownDisplay = StringSplit($idLb_Mn_DwnToTtl & '.' & _
		$g_idLb_Mn_DwnToTxt & '.' & _
		$g_idPg_Mn_Progress & '.' & _
		$g_idLb_Mn_Progress & '.' & _
		$idBt_Mn_OpenFile & '.' & _
		$idBt_Mn_OpenFolder, '.')
_GuiCtrlGroupSetState($g_aDownDisplay, $GUI_HIDE)
; ========================================
; GUI - About
; ========================================
Local $hGui_About = GUICreate('About', 300, 120, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU), -1, $hGui_Main)
GUICtrlCreateLabel($g_sTitle & ' v' & $s_Version & ' - The AutoIt3 Update Utility' & @LF & _
		@LF & _
		'This application is a utility for easily receiving the most ' & _
		'recent public release or beta version of AutoIt3 available. ' & _
		'It was written in AutoIt3 script by Rob Saunders.', 5, 5, 290, 75)
Local $idLb_Ab_VisitSite = GUICtrlCreateLabel('Visit the AutoIt Website', 5, 100, 145, 15)
GUICtrlSetFont(-1, 9, 400, 4)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetCursor(-1, 0)
GUICtrlSetTip(-1, 'https://www.autoitscript.com')
; $idLb_Ab_ContactAuthor = GUICtrlCreateLabel('Contact Rob Saunders', 5, 100, 145, 15)
; GUICtrlSetFont(-1, 9, 400, 4)
; GUICtrlSetColor(-1, 0x0000ff)
; GUICtrlSetCursor(-1, 0)
; GUICtrlSetTip(-1, 'rksaunders@gmail.com')
Local $idBt_Ab_Close = GUICtrlCreateButton('&Close', 220, 90, 75, 25)
; ========================================
; Application start
; ========================================
; Show Main Window
If _StringInArray($CmdLine, '/noproxy') Then GUICtrlSetState($idMn_Proxy, $GUI_CHECKED)
GUISetState(@SW_SHOW, $hGui_Main)
; Download update data file
If $b_Download_UpdateDat Then
	$g_hInetGet = InetGet($s_DatFile, $g_sDatFile_Local, 1, 1)
Else
	FileCopy(@ScriptDir & '\update.dat', $g_sDatFile_Local) ; to test locally
EndIf
; Harness GUI Events
While 1
	$a_Msg = GUIGetMsg(1)
	If Not $i_DatFileLoaded And InetGetInfo($g_hInetGet, 2) Then
		If InetGetInfo($g_hInetGet, 3) = False And $b_Download_UpdateDat Then
			$i_Res = MsgBox(5 + 16 + 8192, 'Error', 'Error connecting to server.' & @LF & _
					'Please verify the following:' & @LF & _
					' - You can connect to the internet' & @LF & _
					' - You can access the site https://www.autoitscript.com' & @LF & _
					' - Your firewall is not blocking internet access to this program')
			If $i_Res = 4 Then
				$g_hInetGet = InetGet($s_DatFile, $g_sDatFile_Local, 1, 1)
			Else
				Exit
			EndIf
		Else
			_LoadUpdateData()
			If $g_sPreBetaVer <> '' Then
				If _CompareVersions(StringTrimRight($g_sPreBetaVer, 1), $g_sLatestBetaVer) > 0 Then
					$a_Pos = WinGetPos($g_sTitle)
					WinMove($g_sTitle, "", $a_Pos[0], $a_Pos[1], $a_Pos[2] + 175, $a_Pos[3])
					GUICtrlSetPos($idLb_separator, 0, 0, 350 + 175, 2)
					GUICtrlSetPos($idGr_Instal_Details, 5, 5, 340 + 175, 75)
					GUICtrlSetPos($g_idMn_Close, 10, 275, 330 + 175, 25)
					GUICtrlSetPos($idLb_Mn_DwnToTtl, 5, 195, 290 + 175, 15)
					GUICtrlSetPos($g_idLb_Mn_DwnToTxt, 5, 210, 290 + 175, 15)
					GUICtrlSetPos($g_idPg_Mn_Progress, 5, 225, 340 + 175, 20)
					GUICtrlSetPos($g_idLb_Mn_Progress, 5, 250, 290 + 175, 15)
					GUICtrlSetPos($idBt_Mn_OpenFile, 105 + 175, 275, 75, 25)
					GUICtrlSetPos($idBt_Mn_OpenFolder, 185 + 175, 275, 75, 25)
				Else
					$g_sPreBetaVer = ''
				EndIf
			EndIf
			$g_iReleaseSizeKB = Round($g_iReleaseSize / 1024)
			$g_iBetaSizeKB = Round($g_iBetaSize / 1024)
			$g_iPreBetaSizeKB = Round($g_iPreBetaSize / 1024)
			If _CompareVersions($g_sReleaseVer, $s_CurrVer) Then
				GUICtrlSetData($idGr_Mn_Release, 'Latest Public Release *New*')
				GUICtrlSetColor($idGr_Mn_Release, 0x0000ff)
			EndIf
			GUICtrlSetData($idLb_Mn_ReleaseVer, 'Version: ' & $g_sReleaseVer)
			If _CompareVersions($g_sLatestBetaVer, $s_CurrBetaVer) Then
				GUICtrlSetData($idGr_Mn_Beta, 'Latest Beta *New*')
				GUICtrlSetColor($idGr_Mn_Beta, 0x0000ff)
			EndIf
			GUICtrlSetData($idLb_Mn_BetaVer, 'Version: ' & $g_sLatestBetaVer)
			If _CompareVersions($g_sPreBetaVer, $s_CurrVer) Then
				GUICtrlSetData($idGr_Mn_PreBeta, 'Latest pre-Beta *New*')
				GUICtrlSetColor($idGr_Mn_PreBeta, 0x0000ff)
			EndIf
			GUICtrlSetData($idLb_Mn_PreBetaVer, 'Version: ' & $g_sPreBetaVer)
			GUICtrlSetData($idLb_Mn_ReleaseDate, 'Date: ' & _FriendlyDate($g_iReleaseDate))
			GUICtrlSetData($idLb_Mn_BetaDate, 'Date: ' & _FriendlyDate($g_iBetaDate))
			GUICtrlSetData($idLb_Mn_PreBetaDate, 'Date: ' & _FriendlyDate($g_iPreBetaDate))
			GUICtrlSetData($idLb_Mn_ReleaseSize, 'Size: ' & $g_iReleaseSizeKB & ' KB')
			GUICtrlSetData($idLb_Mn_BetaSize, 'Size: ' & $g_iBetaSizeKB & ' KB')
			GUICtrlSetData($idLb_Mn_PreBetaSize, 'Size: ' & $g_iPreBetaSizeKB & ' KB')
			GUICtrlSetTip($idLb_Mn_ReleasePage, $g_sReleasePage)
			GUICtrlSetTip($idLb_Mn_BetaPage, $g_sBetaPage)
			GUICtrlSetTip($idLb_Mn_PreBetaPage, $g_sPreBetaPage)
			GUICtrlSetState($idBt_Mn_ReleaseDl, $GUI_ENABLE)
			GUICtrlSetState($idBt_Mn_BetaDl, $GUI_ENABLE)
			GUICtrlSetState($idBt_Mn_PreBetaDl, $GUI_ENABLE)
			GUICtrlSetState($idLb_Mn_ReleasePage, $GUI_ENABLE)
			GUICtrlSetState($idLb_Mn_BetaPage, $GUI_ENABLE)
			GUICtrlSetState($idLb_Mn_PreBetaPage, $GUI_ENABLE)
			$i_DatFileLoaded = 1
		EndIf
	EndIf
	If $g_iDnInitiated Then
		If Not InetGetInfo($g_hInetGet, 2) Then
			$i_DnPercent = Int(InetGetInfo($g_hInetGet, 0) / $i_DownSize * 100)
			$s_DnBytes = Round(InetGetInfo($g_hInetGet, 0) / 1024) & ' KB'
			$s_DnSize = Round($i_DownSize / 1024) & ' KB'
			GUICtrlSetData($g_idPg_Mn_Progress, $i_DnPercent)
			GUICtrlSetData($g_idLb_Mn_Progress, 'Download Progress: ' & $i_DnPercent & '% (' & $s_DnBytes & ' of ' & $s_DnSize & ')')
		Else
			GUICtrlSetData($g_idPg_Mn_Progress, 100)
			InetClose($g_hInetGet)
			If Not FileMove($g_sDownTemp, $g_sDownPath, 1) Then
				MsgBox(16 + 8192, 'Error', 'Error moving file.')
				GUICtrlSetData($g_idLb_Mn_Progress, 'Error')
			Else
				If GUICtrlRead($idRa_Mn_DoneRun) = $GUI_CHECKED Then
					_Start('"' & $g_sDownPath & '"')
					Exit
				Else
					GUICtrlSetData($g_idLb_Mn_Progress, 'Download Complete!')
					GUICtrlSetData($g_idMn_Close, '&Close')
					GUICtrlSetState($idBt_Mn_OpenFile, $GUI_ENABLE)
					GUICtrlSetState($idBt_Mn_OpenFolder, $GUI_ENABLE)
					$i_Response = MsgBox(4 + 64 + 256 + 8192, $g_sTitle, 'Download complete!' & @LF & _
							'Would you like to run the installer now?')
					If $i_Response = 6 Then
						_Start('"' & $g_sDownPath & '"')
						Exit
					EndIf
				EndIf
			EndIf
			$g_iDnInitiated = 0
		EndIf
	EndIf
	If $a_Msg[1] = $hGui_Main Then
		Select
			; Radio buttons
			Case $a_Msg[0] = $idRa_Mn_DoneRun
				RegWrite($g_sAu3UpReg, 'DoneOption', 'REG_SZ', 'Run')
			Case $a_Msg[0] = $idRa_Mn_DoneNotify
				RegWrite($g_sAu3UpReg, 'DoneOption', 'REG_SZ', 'Notify')
				; Download buttons
			Case $a_Msg[0] = $idBt_Mn_ReleaseDl
				$s_Tmp = StringInStr($g_sReleaseFile, '/', 0, -1)
				$s_DefFileName = StringTrimLeft($g_sReleaseFile, $s_Tmp)
				$i_DownSize = $g_iReleaseSize
				ShellExecute("https://www.autoitscript.com/autoit3/docs/history.htm")
				_DownloadFile($g_sReleaseFile, 'autoit-v3-setup.exe')
			Case $a_Msg[0] = $idBt_Mn_BetaDl
				$s_Tmp = StringInStr($g_sBetaFile, '/', 0, -1)
				$s_DefFileName = StringTrimLeft($g_sBetaFile, $s_Tmp)
				$i_DownSize = $g_iBetaSize
				_DownloadFile($g_sBetaFile, 'autoit-v' & $g_sLatestBetaVer & '.exe')
			Case $a_Msg[0] = $idBt_Mn_PreBetaDl
				$s_Tmp = StringInStr($g_sPreBetaFile, '/', 0, -1)
				$s_DefFileName = StringTrimLeft($g_sPreBetaFile, $s_Tmp)
				$i_DownSize = $g_iPreBetaSize
				_DownloadFile($g_sPreBetaFile, 'autoit-v' & $g_sPreBetaVer & '.exe')
				; Download page "hyperlinks"
			Case $a_Msg[0] = $idLb_Mn_ReleasePage
				_Start($g_sReleasePage)
			Case $a_Msg[0] = $idLb_Mn_BetaPage
				_Start($g_sBetaPage)
			Case $a_Msg[0] = $idLb_Mn_PreBetaPage
				_Start($g_sPreBetaPage)
				; Open buttons
			Case $a_Msg[0] = $idBt_Mn_OpenFile
				_Start('"' & $g_sDownPath & '"')
				Exit
			Case $a_Msg[0] = $idBt_Mn_OpenFolder
				_Start('"' & EnvGet('windir') & '\explorer.exe" /select,"' & $g_sDownPath & '"')
				Exit
				; Menu items
			Case $a_Msg[0] = $idMn_Proxy
				If BitAND(GUICtrlRead($idMn_Proxy), $GUI_CHECKED) = $GUI_CHECKED Then
					GUICtrlSetState($idMn_Proxy, $GUI_UNCHECKED)
					HttpSetProxy(0)
				Else
					GUICtrlSetState($idMn_Proxy, $GUI_CHECKED)
					HttpSetProxy(1)
				EndIf
			Case $a_Msg[0] = $idMn_VisitSite
				_Start('https://www.autoitscript.com')
			Case $a_Msg[0] = $idMn_About
				GUISetState(@SW_SHOW, $hGui_About)
				; Close buttons
			Case $a_Msg[0] = $g_idMn_Close
				_CancelDownload()
			Case $a_Msg[0] = $GUI_EVENT_CLOSE
				_CancelDownload(1)
		EndSelect
	ElseIf $a_Msg[1] = $hGui_About Then
		Select
			Case $a_Msg[0] = $idLb_Ab_VisitSite
				_Start('https://www.autoitscript.com')
				;         Case $a_Msg[0] = $idLb_Ab_ContactAuthor
				;            _Start('"mailto:rksaunders@gmail.com?Subject=AutoIt3 Update Utility"')
			Case $a_Msg[0] = $GUI_EVENT_CLOSE Or $a_Msg[0] = $idBt_Ab_Close
				GUISetState(@SW_HIDE, $hGui_About)
		EndSelect
	EndIf
WEnd

; ========================================
; Function Declarations
; ========================================
; App. specific functions
Func _DownloadFile($s_DownUrl, $s_DownName)
	$g_sDownTemp = @TempDir & '\' & $s_DownName

	InetGetSize($s_DownUrl)
	If @error Then
		MsgBox(16 + 8192, 'Error', 'Cannot acces when trying to download.' & @CRLF & @CRLF & $s_DownUrl)
		Return
	EndIf

	$g_hInetGet = InetGet($s_DownUrl, $g_sDownTemp, 1, 1)
	$g_sDownPath = FileSaveDialog('Save As', $g_sDefDownDir, 'Executables (*.exe)', 16, $s_DownName)
	If Not @error Then
		If Not (StringRight($g_sDownPath, 4) = '.exe') Then
			$g_sDownPath = $g_sDownPath & '.exe'
		EndIf
		Local $s_Tmp = StringInStr($g_sDownPath, '\', 0, -1)
		Local $s_DownFolder = StringLeft($g_sDownPath, $s_Tmp)
		RegWrite($g_sAu3UpReg, 'DownloadDir', 'REG_SZ', $s_DownFolder)
		GUICtrlSetData($g_idLb_Mn_DwnToTxt, _ClipPath($g_sDownPath, 55))
		GUICtrlSetData($g_idLb_Mn_Progress, 'Download Progress: Calculating...')
		_GuiCtrlGroupSetState($g_aDownButtons, $GUI_HIDE)
		_GuiCtrlGroupSetState($g_aDownButtons, $GUI_DISABLE)
		_GuiCtrlGroupSetState($g_aDownDisplay, $GUI_SHOW)
		If $g_sPreBetaVer <> '' Then
			GUICtrlSetPos($g_idMn_Close, 265 + 175, 275, 75, 25)
		Else
			GUICtrlSetPos($g_idMn_Close, 265, 275, 75, 25)
		EndIf
		GUICtrlSetData($g_idMn_Close, 'Cancel')
		$g_iDnInitiated = 1
	Else
		InetClose($g_hInetGet)
		FileDelete($g_sDownTemp)
	EndIf
EndFunc   ;==>_DownloadFile

Func _CancelDownload($i_Flag = 0)
	If $g_iDnInitiated Then
		Local $i_Response = MsgBox(4 + 64 + 256 + 8192, $g_sTitle, 'Resuming is not possible.' & @LF & _
				'Your download will be lost.' & @LF & _
				'Continue?')
		If $i_Response = 6 Then
			$g_iDnInitiated = 0
			InetClose($g_hInetGet)
			FileDelete($g_sDownTemp)
			If $i_Flag = 1 Then
				Exit
			EndIf
			_GuiCtrlGroupSetState($g_aDownDisplay, $GUI_HIDE)
			GUICtrlSetData($g_idMn_Close, '&Close')
			If $g_sPreBetaVer <> '' Then
				GUICtrlSetPos($g_idMn_Close, 10, 275, 330 + 175, 25)
			Else
				GUICtrlSetPos($g_idMn_Close, 10, 275, 330, 25)
			EndIf
			GUICtrlSetData($g_idPg_Mn_Progress, 0)
			_GuiCtrlGroupSetState($g_aDownButtons, $GUI_SHOW)
			_GuiCtrlGroupSetState($g_aDownButtons, $GUI_ENABLE)
		EndIf
	Else
		Exit
	EndIf
EndFunc   ;==>_CancelDownload

Func _LoadUpdateData()
	$g_sReleaseVer = IniRead($g_sDatFile_Local, 'AutoIt', 'version', 'Error reading file')
	$g_sReleaseFile = IniRead($g_sDatFile_Local, 'AutoIt', 'setup', '')
	$g_sReleasePage = IniRead($g_sDatFile_Local, 'AutoIt', 'index', 'https://www.autoitscript.com')
	$g_iReleaseSize = IniRead($g_sDatFile_Local, 'AutoIt', 'filesize', 0)
	$g_iReleaseDate = IniRead($g_sDatFile_Local, 'AutoIt', 'filetime', 0)
	$g_sLatestBetaVer = IniRead($g_sDatFile_Local, 'AutoItBeta', 'version', 'Error reading file')
	$g_sBetaFile = IniRead($g_sDatFile_Local, 'AutoItBeta', 'setup', '')
	$g_sBetaPage = IniRead($g_sDatFile_Local, 'AutoItBeta', 'index', 'https://www.autoitscript.com')
	$g_iBetaSize = IniRead($g_sDatFile_Local, 'AutoItBeta', 'filesize', 0)
	$g_iBetaDate = IniRead($g_sDatFile_Local, 'AutoItBeta', 'filetime', 0)
	$g_sPreBetaVer = IniRead($g_sDatFile_Local, 'AutoItPreBeta', 'version', '')
	$g_sPreBetaFile = IniRead($g_sDatFile_Local, 'AutoItPreBeta', 'setup', '')
	$g_sPreBetaPage = IniRead($g_sDatFile_Local, 'AutoItPreBeta', 'index', 'https://www.autoitscript.com')
	$g_iPreBetaSize = IniRead($g_sDatFile_Local, 'AutoItPreBeta', 'filesize', 0)
	$g_iPreBetaDate = IniRead($g_sDatFile_Local, 'AutoItPreBeta', 'filetime', 0)
	FileDelete($g_sDatFile_Local)
EndFunc   ;==>_LoadUpdateData

; Utility functions
Func _Start($s_StartPath)
	Local $s_StartStr
	If @OSType = 'WIN32_NT' Then
		$s_StartStr = @ComSpec & ' /c start "" '
	Else
		$s_StartStr = @ComSpec & ' /c start '
	EndIf
	Run($s_StartStr & $s_StartPath, '', @SW_HIDE)
EndFunc   ;==>_Start

Func _GuiCtrlGroupSetState(ByRef $a_GroupArray, $i_State)
	For $i = 1 To $a_GroupArray[0]
		GUICtrlSetState($a_GroupArray[$i], $i_State)
	Next
EndFunc   ;==>_GuiCtrlGroupSetState

Func _ClipPath($s_Path, $i_ClipLen)
	Local $i_Half, $s_Left, $s_Right
	If StringLen($s_Path) > $i_ClipLen Then
		$i_Half = Int($i_ClipLen / 2)
		$s_Left = StringLeft($s_Path, $i_Half)
		$s_Right = StringRight($s_Path, $i_Half)
		$s_Path = $s_Left & '...' & $s_Right
	EndIf
	Return $s_Path
EndFunc   ;==>_ClipPath

Func _NumSuffix($i_Num)
	Local $s_Num
	Switch Int($i_Num)
		Case 1, 21, 31
			$s_Num = Int($i_Num) & 'st'
		Case 2, 22
			$s_Num = Int($i_Num) & 'nd'
		Case 3, 23
			$s_Num = Int($i_Num) & 'rd'
		Case Else
			$s_Num = Int($i_Num) & 'th'
	EndSwitch
	Return $s_Num
EndFunc   ;==>_NumSuffix

Func _FriendlyDate($s_Date)
	Local $a_Months = StringSplit('January,February,March,April,May,June,July,August,September,October,November,December', ',')
	Local $s_Year, $s_Month, $s_Day
	$s_Year = StringLeft($s_Date, 4)
	$s_Month = StringMid($s_Date, 5, 2)
	$s_Month = $a_Months[Int(StringMid($s_Date, 5, 2))]
	$s_Day = StringMid($s_Date, 7, 2)
	$s_Day = _NumSuffix(StringMid($s_Date, 7, 2))
	Return $s_Month & ' ' & $s_Day & ', ' & $s_Year
EndFunc   ;==>_FriendlyDate

Func _StringInArray($a_Array, $s_String)
	Local $i_ArrayLen = UBound($a_Array) - 1
	For $i = 0 To $i_ArrayLen
		If $a_Array[$i] = $s_String Then
			Return $i
		EndIf
	Next
	SetError(1)
	Return 0
EndFunc   ;==>_StringInArray

Func _CompareVersions($s_Vers1, $s_Vers2, $i_ReturnFlag = 0)
	Local $v_Return
	If $s_Vers1 = '' Then Return 0
	Local $i, $i_Vers1, $i_Vers2, $i_Top
	Local $a_Vers1 = StringSplit($s_Vers1, '.')
	Local $a_Vers2 = StringSplit($s_Vers2, '.')
	$i_Top = $a_Vers1[0]
	If $a_Vers1[0] < $a_Vers2[0] Then
		$i_Top = $a_Vers2[0]
	EndIf
	For $i = 1 To $i_Top
		$i_Vers1 = 0
		$i_Vers2 = 0
		If $i <= $a_Vers1[0] Then
			$i_Vers1 = Number($a_Vers1[$i])
		EndIf
		If $i <= $a_Vers2[0] Then
			$i_Vers2 = Number($a_Vers2[$i])
		EndIf
		If $i_Vers1 > $i_Vers2 Then
			$v_Return = 1
			ExitLoop
		ElseIf $i_Vers1 < $i_Vers2 Then
			$v_Return = 0
			ExitLoop
		Else
			$v_Return = -1
		EndIf
	Next
	If $i_ReturnFlag Then
		Select
			Case $v_Return = -1
				SetError(1)
				Return 0
			Case $v_Return = 1
				Return $s_Vers1
			Case $v_Return = 0
				Return $s_Vers2
		EndSelect
	ElseIf $v_Return = -1 Then
		SetError(1)
		Return 0
	Else
		Return $v_Return
	EndIf
EndFunc   ;==>_CompareVersions

Func _Status($s_MainText, $s_SubText = '', $i_BytesRead = -1, $i_DownSize = -1)
	Local $s_DownStatus
	If @OSVersion = "WIN_XP" Or @OSVersion = "WIN_2003" Then
		If $s_SubText <> '' Then
			$s_SubText = @LF & $s_SubText
		EndIf
		If $i_BytesRead = -1 Then
			TrayTip($g_sTitle, $s_MainText & $s_SubText, 10, 16)
		Else
			$s_DownStatus = Round($i_BytesRead / 1024) & ' of ' & Round($i_DownSize / 1024) & ' KB'
			TrayTip($g_sTitle, $s_MainText & $s_SubText & @LF & $s_DownStatus, 10, 16)
		EndIf
	Else
		If Not $g_iProgOn Then
			ProgressOn($g_sTitle, $s_MainText, $s_SubText, -1, -1, 2 + 16)
			$g_iProgOn = 1
		Else
			If $i_BytesRead = -1 Then
				ProgressSet($g_iStatusPercent, $s_SubText, $s_MainText)
			Else
				$s_DownStatus = 'Downloading ' & Round($i_BytesRead / 1024) & ' of ' & Round($i_DownSize / 1024) & ' KB'
				$g_iStatusPercent = Round($i_BytesRead / $i_DownSize * 100)
				ProgressSet($g_iStatusPercent, $s_DownStatus, $s_MainText)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_Status

Func RegRead64($sKeyname, $sValue)
	Local $sRes = RegRead($sKeyname, $sValue)
	If @error And @AutoItX64 Then
		$sKeyname = StringReplace($sKeyname, "HKEY_LOCAL_MACHINE", "HKLM")
		$sKeyname = StringReplace($sKeyname, "HKLM\SOFTWARE\", "HKLM\SOFTWARE\Wow6432Node\")
		$sRes = RegRead($sKeyname, $sValue)
		If @error Then
			SetError(1)
			Return ""
		EndIf
	EndIf

	SetError(0)
	Return $sRes
EndFunc   ;==>RegRead64
