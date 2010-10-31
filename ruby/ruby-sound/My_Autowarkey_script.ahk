#SingleInstance force		;force a single instance
#HotkeyInterval 0		;disable the warning dialog if a key is held down
#InstallKeybdHook		;Forces the unconditional installation of the keyboard hook
#UseHook On			;might increase responsiveness of hotkeys
#MaxThreads 20			;use 20 (the max) instead of 10 threads
SetBatchLines, -1		;makes the script run at max speed
SetKeyDelay , -1, -1		;faster response (might be better with -1, 0)
;Thread, Interrupt , -1, -1	;not sure what this does, could be bad for timers
SetTitleMatchMode, 3 ;title Warcraft III must match exactly
SetDefaultMouseSpeed, 0 ;Move the mouse faster for mouse moving commands

IfExist, Warcraft III.ico
  menu, tray, Icon, Warcraft III.ico, 1, 1

;;;;; Variables ;;;;;
bInChatRoom := False
bHealthBarOn := False
bBirdGotoX := 0
bBirdGotoY := 0

;;;;; Timers ;;;;;
;; this timer checks to see if warcraft is active and turns on the health bars
settimer, timer_Warcraft, 1000 ;check every 1 second
timer_Warcraft:
{
  ifWinActive, Warcraft III ahk_class Warcraft III
  {
    if ( (bHealthBarOn == False) && (A_IsSuspended == false) )
    {
      SendInput, {[ Down}{] Down}
      bHealthBarOn := True
    }
    if (A_IsSuspended == false)
      SetScrollLockState, On
    else
      SetScrollLockState, Off
  }
  else ifWinNotActive, Warcraft III ahk_class Warcraft III
  {
    if (bHealthBarOn == True)
    {
      SendInput, {[ Up}{] Up}
      bHealthBarOn := False
      SetScrollLockState, Off
    }
  }
}

Return ; End Auto-Execute Section


; Drag and Drop Function
DragAndDrop()
{
  SendPlay, 1
  SendPlay, e
  MouseGetPos, iMousePosX, IMousePosY
  iMouseGotoX := A_ScreenWidth*4//6
  iMouseGotoY := A_ScreenHeight*5//6
  Click, Right, %iMouseGotoX%, %iMouseGotoY%
  Click, Left, %iMousePosX%, %iMousePosY%
  BirdGotoX := %iMouseGotoX%
  BirdGotoY := %iMouseGotoY%
; Sleep, 1000
; SendInput, 2
; Click, Right, %BirdGotoX%, %BirdGotoY%
; SendInput, +z
; Sleep, 50
; SendInput, 1
}


MoveMouseToPos()
{
  SendPlay, 1
  SendPlay, e
  MouseGetPos, iMousePosX, iMousePosY
  iMouseGotoX := A_ScreenWidth*1//45
  iMouseGotoY := A_ScreenHeight*68/70
  MouseMove, %iMouseGotoX%, %iMouseGotoY%
  Click, Left, %iMouseGotoX%, %iMouseGotoY%
  MouseMove, %iMousePosX%, %iMousePosY%
; Sleep, 1000
; SendInput, 2
; Click, Right, %BirdGotoX%, %BirdGotoY%
; SendInput, +z
; Sleep, 50
; SendInput, 1
}


BirdPickUp()
{
  SendPlay, 2
  SendPlay, e
  Click, Right, %BirdGotoX%, %BirdGotoY%
  SendPlay, f
  SendPlay, +z
  SendPlay, 1
}

ClickMouseInPosition(iSpellQWERHotkey)
{
  MouseGetPos, iMousePosX, iMousePosY
  if (iSpellQWERHotkey == 1)
  {
    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 2)
  {
    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 3)
  {    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 4)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 5)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 6)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 7)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 8)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 9)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 10)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 11)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 12)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*19//20
  }
  Click, Left, %iMouseGotoX%, %iMouseGotoY%
  MouseMove, %iMousePosX%, %iMousePosY%
}

; AutoCast Function
AutoCast(iSpellQWERHotkey)
{
  MouseGetPos, iMousePosX, IMousePosY
  if (iSpellQWERHotkey == 1)
  {
    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 2)
  {
    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 3)
  {    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 4)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 5)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 6)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 7)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 8)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 9)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 10)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 11)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 12)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*19//20
  }
  Click, Right, %iMouseGotoX%, %iMouseGotoY%
  MouseMove, %iMousePosX%, %iMousePosY%
}

#ifWinActive, Warcraft III ahk_class Warcraft III

;;;;; Enable/disable all hotkeys ;;;;;
~*Enter::
~*NumpadEnter::
Suspend, Permit
if (bInChatRoom == True)
  return
Suspend
if (A_IsSuspended == true)
{
  SoundPlay,*64
  SetScrollLockState, Off
}
else
{
  SoundPlay,*48
  SetScrollLockState, On
}
return

;; Escape will cancel chatting, so turn the hotkeys back on
~*Esc::
Suspend, Permit
if (bInChatRoom == True)
  return
Suspend, Off
SoundPlay,*48
SetScrollLockState, On

;;;;; Toggle health on/off ;;;;;
;; the health bars are automatic now and cannot be turned off
;; however if for some reason they get turned off, pressing this key will turn it on
bHealthBarOn := not bHealthBarOn
if (bHealthBarOn == true)
  SendInput, {[ Down}{] Down}
else
  SendInput, {[ Up}{] Up}
return

*ScrollLock::
Suspend, Permit
bInChatRoom := not bInChatRoom
if (bInChatRoom == True)
{
  Suspend, On
  SetScrollLockState, Off
  SoundPlay,*64
}
else
{
  Suspend, Off
  SetScrollLockState, On
  SoundPlay,*48
}
return

; Disable Left Windows Key
Lwin::return
; Disable Left Alt-Q GG
!q::BirdPickUp()
Mbutton::MoveMouseToPos()

; Inventory Keys:
+f::SendInput, {Numpad7}
!f::SendInput, {Numpad8}
;+!f::SendInput, +{Numpad8}
+d::SendInput, {Numpad4}
!d::SendInput, {Numpad5}
;+!d::SendInput, +{Numpad5}
+s::SendInput, {Numpad1}
!s::SendInput, {Numpad2}
+!s::SendInput, +{Numpad2}
+!r::Run C:\Users\Viper\Documents\UNB-Courses\NN\ruby\ruby-sound\HearThat
;!q::DragAndDrop()
+!q::DragAndDrop()

; Hotkeys Remapper:

; User Specified Hotkeys:

^!n::
IfWinExist Untitled - Notepad
	WinActivate
else
	Run Notepad
return
