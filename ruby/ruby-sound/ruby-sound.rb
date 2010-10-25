require 'win32/sound'
include Win32

40.times do |i|
    puts  i
    sleep(115);
    Sound.play('C:\WINDOWS\Media\chord.wav')
    sleep(5);
    #Sound.play('c:\sounds\hal9000.wav')
end
