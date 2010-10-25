require 'win32/sound'
include Win32

40.times do |i|
    puts  i
    sleep(115);
    Sound.play('C:\WINDOWS\Media\chord.wav')         
    sleep(5);                                        
    #Sound.play('c:\sounds\hal9000.wav')             
end     

# 40.times do
#   count
# end
# 
# def count
#   while count <= 200
#     sleep(1)
#     count += 1
#     if "key is pressed"
#       idle();
#     end
#   end
#   puts "write something"
#   count = 0;
# end
# 
# def idle(args)
#   while "continue is not pressed"
#   end
#   count();
# end
                                                     
#          *-----* count until 100                      *-----* idle
#          |     |                                      |     |
#          |     |                                      |     |
#          |     |                                      |     |
#          V     |                                      V     |
#    |--------------------*                       *-------------------*
#    |                    |                       |                   |
#    |                    |               1       |                   |
#    |                    | --------------------->|                   |
#    |                    |                       |                   |
#    |                    | <---------------------|                   |
#    |                    |              0        |                   |
#    |                    |                       |                   |
#    *--------------------*                       *-------------------*
