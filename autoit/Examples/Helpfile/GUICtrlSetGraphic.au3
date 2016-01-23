#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

Global Const $g_MAXGr = 6
Global $g_aidGraphics[$g_MAXGr + 1] ; 0 and $g_MAXGr entries not used to allow GUICtrlDelete result
Global $g_idDel, $g_hChild

Example()

Func Example()
	Local $idMsg, $iInc, $i

	GUICreate("My Main", -1, -1, 100, 100)
	Local $idDel1 = GUICtrlCreateButton("ReCreate", 50, 200, 50)
	GUISetState(@SW_SHOW)
	CreateChild()

	$i = 1
	$iInc = 1
	;$i=5	; uncomment to delete starting from last define Graphic control
	;$iInc=-1

	Do
		$idMsg = GUIGetMsg()
		If $idMsg = $idDel1 Then $i = Create($iInc)

		If $idMsg = $g_idDel Then
			GUICtrlDelete($g_aidGraphics[$i])
			$i = $i + $iInc
			If $i < 0 Or $i > $g_MAXGr Then Exit
		EndIf
	Until $idMsg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

Func Create($iInc)
	GUIDelete($g_hChild)
	CreateChild()
	If $iInc = -1 Then Return 5
	Return 1
EndFunc   ;==>Create

Func CreateChild()
	$g_hChild = GUICreate("My Draw")
	$g_idDel = GUICtrlCreateButton("Delete", 50, 165, 50)

	$g_aidGraphics[1] = GUICtrlCreateGraphic(20, 50, 100, 100)
	GUICtrlSetBkColor(-1, 0xffffff)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0xff0000, 0xff0000)
	GUICtrlSetGraphic(-1, $GUI_GR_PIE, 50, 50, 40, 30, 270)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0x00ff00, 0xffffff)
	GUICtrlSetGraphic(-1, $GUI_GR_PIE, 58, 50, 40, -60, 90)

	GUICtrlSetGraphic(-1, $GUI_GR_ELLIPSE, 100, 100, 50, 80)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0x00ff00, 0xc0c0ff)
	GUICtrlSetGraphic(-1, $GUI_GR_RECT, 350, 200, 50, 80)
	GUICtrlCreateLabel("label", 65, 100, 30)
	GUICtrlSetColor(-1, 0xff)

	$g_aidGraphics[2] = GUICtrlCreateGraphic(220, 10, 100, 100)

	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0, 0xff)
	GUICtrlSetGraphic(-1, $GUI_GR_PIE, 50, 50, 40, 30, 270)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0x00ff00, 0xffffff)
	GUICtrlSetGraphic(-1, $GUI_GR_PIE, 58, 50, 40, -60, 90)

	$g_aidGraphics[3] = GUICtrlCreateGraphic(220, 110, 100, 100)
	GUICtrlSetBkColor(-1, 0xf08080)
	GUICtrlSetColor(-1, 0xff)
	GUICtrlSetGraphic(-1, $GUI_GR_HINT, 1)

	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0xff00)
	GUICtrlSetGraphic(-1, $GUI_GR_RECT, 50, 50, 80, 80)

	$g_aidGraphics[4] = GUICtrlCreateGraphic(20, 200, 80, 80)
	GUICtrlSetBkColor(-1, 0xffffff)
	GUICtrlSetGraphic(-1, $GUI_GR_HINT, 1)

	GUICtrlSetGraphic(-1, $GUI_GR_MOVE, 10, 10)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0xff)
	GUICtrlSetGraphic(-1, $GUI_GR_LINE, 30, 40)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0xff00)
	GUICtrlSetGraphic(-1, $GUI_GR_LINE, 70, 70)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0xff0000)
	GUICtrlSetGraphic(-1, $GUI_GR_LINE, 10, 50)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0xffff00)
	GUICtrlSetGraphic(-1, $GUI_GR_LINE, 10, 10)

	$g_aidGraphics[5] = GUICtrlCreateGraphic(150, 10, 50, 50)
	GUICtrlSetBkColor(-1, 0xa0ffa0)
	GUICtrlSetGraphic(-1, $GUI_GR_MOVE, 20, 20) ; start point
	; it is better to draw line and after point
	; to avoid to switch color at each drawing
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0x0000ff)
	GUICtrlSetGraphic(-1, $GUI_GR_DOT, 30, 30)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0)
	GUICtrlSetGraphic(-1, $GUI_GR_LINE, 20, 40)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0xff0000)
	GUICtrlSetGraphic(-1, $GUI_GR_DOT, 25, 25)
	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0)
	GUICtrlSetGraphic(-1, $GUI_GR_LINE, 40, 40)
	GUICtrlSetGraphic(-1, $GUI_GR_DOT, 30, 40)

	$g_aidGraphics[6] = GUICtrlCreateGraphic(110, 260, 230, 130)
	GUICtrlSetColor(-1, 0) ; to display a black border line
	GUICtrlSetBkColor(-1, 0xc0c0ff)
	GUICtrlSetGraphic(-1, $GUI_GR_HINT, 3) ; to display control lines and end points

	GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0, 0xff); fill in blue
	GUICtrlSetGraphic(-1, $GUI_GR_MOVE, 120, 20) ; start point
	GUICtrlSetGraphic(-1, $GUI_GR_BEZIER, 120, 100, 200, 20, 200, 100)
	GUICtrlSetGraphic(-1, $GUI_GR_BEZIER + $GUI_GR_CLOSE, 100, 40, 40, 100, 40, 20)
	GUICtrlSetGraphic(-1, $GUI_GR_LINE, 60, 30) ; start point

	GUISetState(@SW_SHOW)
EndFunc   ;==>CreateChild
