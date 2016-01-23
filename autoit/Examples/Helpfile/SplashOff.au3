#include <MsgBoxConstants.au3>

SplashTextOn("Example", "Splash Screen", 500, 400, 100, 100)
MsgBox($MB_SYSTEMMODAL, 'Test 1', 'Splash is visible')
SplashOff()
MsgBox($MB_SYSTEMMODAL, 'Test 2', 'Splash is Off')
