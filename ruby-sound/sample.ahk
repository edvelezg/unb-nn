MyVar1 = 123
MyVar2 = my string

^!s::
MouseGetPos, iMousePosX, iMousePosY
if MyVar2 = my string
{
    MsgBox MyVar2 contains the string "my string".
}
if MyVar1 >= 100
{
    MsgBox screen positions are %iMousePosX%, %iMousePosY%
}

$F1::  ; Make the F1 key into a hotkey (the $ symbol facilitates the "P" mode of GetKeyState below).
Loop  ; Since no number is specified with it, this is an infinite loop unless "break" or "return" is encountered inside.
{
    if not GetKeyState("F1", "P")  ; If this statement is true, the user has physically released the F1 key.
        break  ; Break out of the loop.
    ; Otherwise (since the above didn't "break"), keep clicking the mouse.
    Click  ; Click the left mouse button at the cursor's current position.
}
return
