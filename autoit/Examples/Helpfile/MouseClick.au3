#include <AutoItConstants.au3>

; Double click at the current mouse position.
MouseClick($MOUSE_CLICK_LEFT)
MouseClick($MOUSE_CLICK_LEFT)

; Double click at the x, y position of 0, 500.
MouseClick($MOUSE_CLICK_LEFT, 0, 500, 2)

; Double click at the x, y position of 0, 500. This is a better approach as it takes into account left/right handed users.
MouseClick($MOUSE_CLICK_PRIMARY, 0, 500, 2)
