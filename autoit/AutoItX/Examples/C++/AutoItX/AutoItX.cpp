// To use:
// - Copy AutoItX3_DLL.h and AutoItX3_DLL.lib into the project folder.
// - Add AutoItX3_DLL.lib to the linker input files.
//
// AutoItX3.dll / AutoItX3_x64.dll needs to be in the run path during execution

#include <Windows.h>
#include "AutoItX3_DLL.h"

int APIENTRY wWinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPTSTR    lpCmdLine,
                     int       nCmdShow)
{
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);
	
	// You can now call AutoIt commands, e.g. to send the keystrokes "hello"
	AU3_Sleep(1000);
	AU3_Run(L"notepad.exe", L"", 1);
	AU3_WinWaitActive(L"Untitled -", L"", 0);
	AU3_Send(L"Hello{!}", 0);

	// Get the text in the status bar
	//WCHAR szText[1000];
	//AU3_StatusbarGetText("Untitled -", "", 2, szText, 1000);
	//MessageBox(NULL, szText, "Text:", MB_OK);

	return 0;
}
