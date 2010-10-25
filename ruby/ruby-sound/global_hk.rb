#NOTE - you'd have to register the DLL using regsvr32.exe (or you could
#use the DLL directly w/o the COM interface) regsvr32 <path to dll>

#> ... does registering it mean that it actually copies it to some windows
#> directory. (Is there a specific windows directory for dlls?
#
#Registering does not create a copy. Registering will make it so you can
#create a COM object (WIN32OLE.new), but the DLL will remain wherever it
#was when you registered it. Personally, I keep it in the same directory
#as my AHK installation. However, many DLL files are located in the
#Windows Directory.
#
#On a side note, the maintainer of the DLL has been updating it regularly
#recently. He provided a direct link for the Windows (32 bit) Unicode
#version: http://www.autohotkey.net/~HotKeyIt/AutoHotkey.dll



require "WIN32OLE"

code =  "#notrayicon\n" +
        "^m:: msgbox, hotkey created with ahk in ruby"

ahk = WIN32OLE.new("autohotkey.script")
ahk.ahktextdll(code)

puts "press ctrl+m to display a message box with embedded ahk\n\n" +
     "hit enter to close the console & destroy the hotkey ..."
gets

