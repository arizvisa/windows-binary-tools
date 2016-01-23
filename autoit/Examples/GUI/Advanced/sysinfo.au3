#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

_Main()

Func _Main()
	Local $sVOL, $sSERIAL, $sTOTAL, $sFREE
	Local $idInput_ComputerName, $idInput_CurrentUserName, $idInput_OperatingSystem
	Local $idInput_ServicePack, $idInput_VolumeLabel, $idInput_SerialNumber
	Local $idInput_TotalSpace, $idInput_FreeSpace, $idInput_IpAddress, $idInput_StartupDirectory
	Local $idInput_WindowsDirectory, $idInput_SystemFolderDirectory, $idInput_DesktopDirectory
	Local $idInput_MyDocumentsDirectory, $idInput_ProgramFilesDirectory, $idInput_StartMenuDirectory
	Local $idInput_TemporaryFileDirectory, $idInput_DesktopWidth, $idInput_DesktopHeight
	Local $idInput_Date, $idInput_Time, $iMsg

	#forceref $idInput_ComputerName, $idInput_CurrentUserName, $idInput_OperatingSystem
	#forceref $idInput_ServicePack, $idInput_VolumeLabel, $idInput_SerialNumber
	#forceref $idInput_TotalSpace, $idInput_FreeSpace, $idInput_IpAddress, $idInput_StartupDirectory
	#forceref $idInput_WindowsDirectory, $idInput_SystemFolderDirectory, $idInput_DesktopDirectory
	#forceref $idInput_MyDocumentsDirectory, $idInput_ProgramFilesDirectory, $idInput_StartMenuDirectory
	#forceref $idInput_TemporaryFileDirectory, $idInput_DesktopWidth, $idInput_DesktopHeight
	#forceref $idInput_Date, $idInput_Time

	GUICreate("Computer Information - By : Para", 469, 639, (@DesktopWidth - 469) / 2, (@DesktopHeight - 639) / 2, $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS)

	$sVOL = DriveGetLabel("C:\")
	$sSERIAL = DriveGetSerial("C:\")
	$sTOTAL = DriveSpaceTotal("C:\")
	$sFREE = DriveSpaceFree("C:\")

	GUICtrlCreateLabel("Computer Name", 10, 10, 150, 20)
	GUICtrlCreateLabel("Current User Name", 10, 40, 150, 20)
	GUICtrlCreateLabel("Operating System", 10, 70, 150, 20)
	GUICtrlCreateLabel("Service Pack", 10, 100, 150, 20)
	GUICtrlCreateLabel("C: Volume Label", 10, 130, 150, 20)
	GUICtrlCreateLabel("C: Serial Number", 10, 160, 150, 20)
	GUICtrlCreateLabel("C: Total Space", 10, 190, 150, 20)
	GUICtrlCreateLabel("C: Free Space", 10, 220, 150, 20)
	GUICtrlCreateLabel("Ip Address", 10, 250, 150, 20)
	GUICtrlCreateLabel("Startup Directory", 10, 280, 150, 20)
	GUICtrlCreateLabel("Windows Directory", 10, 310, 150, 20)
	GUICtrlCreateLabel("System Folder Directory", 10, 340, 150, 20)
	GUICtrlCreateLabel("Desktop Directory", 10, 370, 150, 20)
	GUICtrlCreateLabel("My Documents Directory", 10, 400, 150, 20)
	GUICtrlCreateLabel("Program File Directory", 10, 430, 150, 20)
	GUICtrlCreateLabel("Start Menu Directory", 10, 460, 150, 20)
	GUICtrlCreateLabel("Desktop Width (Pixels)", 10, 520, 150, 20)
	GUICtrlCreateLabel("Temporary File Directory", 10, 490, 150, 20)
	GUICtrlCreateLabel("Desktop Height (Pixels)", 10, 550, 150, 20)
	GUICtrlCreateLabel("Date", 10, 580, 150, 20)
	GUICtrlCreateLabel("Time", 10, 610, 150, 20)
	$idInput_ComputerName = GUICtrlCreateInput("" & @ComputerName, 180, 10, 280, 20)
	$idInput_CurrentUserName = GUICtrlCreateInput("" & @UserName, 180, 40, 280, 20)
	$idInput_OperatingSystem = GUICtrlCreateInput("" & @OSType, 180, 70, 280, 20)
	$idInput_ServicePack = GUICtrlCreateInput("" & @OSServicePack, 180, 100, 280, 20)
	$idInput_VolumeLabel = GUICtrlCreateInput("" & $sVOL, 180, 130, 280, 20)
	$idInput_SerialNumber = GUICtrlCreateInput("" & $sSERIAL, 180, 160, 280, 20)
	$idInput_TotalSpace = GUICtrlCreateInput("" & $sTOTAL, 180, 190, 280, 20)
	$idInput_FreeSpace = GUICtrlCreateInput("" & $sFREE, 180, 220, 280, 20)
	$idInput_IpAddress = GUICtrlCreateInput("" & @IPAddress1, 180, 250, 280, 20)
	$idInput_StartupDirectory = GUICtrlCreateInput("" & @StartupDir, 180, 280, 280, 20)
	$idInput_WindowsDirectory = GUICtrlCreateInput("" & @WindowsDir, 180, 310, 280, 20)
	$idInput_SystemFolderDirectory = GUICtrlCreateInput("" & @SystemDir, 180, 340, 280, 20)
	$idInput_DesktopDirectory = GUICtrlCreateInput("" & @DesktopDir, 180, 370, 280, 20)
	$idInput_MyDocumentsDirectory = GUICtrlCreateInput("" & @MyDocumentsDir, 180, 400, 280, 20)
	$idInput_ProgramFilesDirectory = GUICtrlCreateInput("" & @ProgramFilesDir, 180, 430, 280, 20)
	$idInput_StartMenuDirectory = GUICtrlCreateInput("" & @StartMenuDir, 180, 460, 280, 20)
	$idInput_TemporaryFileDirectory = GUICtrlCreateInput("" & @TempDir, 180, 490, 280, 20)
	$idInput_DesktopWidth = GUICtrlCreateInput("" & @DesktopWidth, 180, 520, 280, 20)
	$idInput_DesktopHeight = GUICtrlCreateInput("" & @DesktopHeight, 180, 550, 280, 20)
	$idInput_Date = GUICtrlCreateInput("(MONTH)(DAY)(YEAR) " & @MON & "-" & @MDAY & "-" & @YEAR, 180, 580, 280, 20)
	$idInput_Time = GUICtrlCreateInput("(HOUR)(MIN)(SEC) " & @HOUR & ":" & @MIN & ":" & @SEC, 180, 610, 280, 20)

	GUISetState()
	While 1
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				ExitLoop
			Case Else
				;;;
		EndSelect
	WEnd
	Exit
EndFunc   ;==>_Main
