require "WIN32OLE"

code =  "#notrayicon\n" +
        "^m:: msgbox, hotkey created with ahk in ruby"

ahk = win32ole.new("autohotkey.script")
ahk.ahktextdll("C:\Users\Viper\Desktop\AutoHotkey\")

puts "press ctrl+m to display a message box with embedded ahk\n\n" +
     "hit enter to close the console & destroy the hotkey ..."
gets

