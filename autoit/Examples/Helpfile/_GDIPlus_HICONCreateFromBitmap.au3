#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <GUIMenu.au3>
#include <WinAPIShellEx.au3>

#NoTrayIcon
Opt('TrayMenuMode', 3)

; Create Bitmap with transparency
_GDIPlus_Startup()
Local $hBitmap = _GDIPlus_BitmapCreateFromScan0(48, 48)
Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)

Local $hBrush = _GDIPlus_LineBrushCreate(4, 4, 44, 44, 0xFF00FF00, 0, 3)
_GDIPlus_GraphicsFillRect($hContext, 4, 4, 40, 40, $hBrush)
_GDIPlus_BrushDispose($hBrush)

_GDIPlus_GraphicsDispose($hContext)

; create icon from bitmap
Local $hIcon = _GDIPlus_HICONCreateFromBitmap($hBitmap)
_GDIPlus_BitmapDispose($hBitmap)
_GDIPlus_Shutdown()

Local $hMenu = TrayItemGetHandle(0)
Local $idOptions = TrayCreateItem('Options')
TrayCreateItem('')
Local $idExit = TrayCreateItem('Exit')

_GUICtrlMenu_SetItemBmp($hMenu, 0, _WinAPI_Create32BitHBITMAP($hIcon, 1, 1))

TraySetState()

TrayTip("Information", "Check out tray menu", 30)

Do
Until TrayGetMsg() = $idExit
