#Make sure to do the following:
#gem install win32-api
#gem install win32-sound
#
#and do what is told in this forum post:
#http://www.ruby-forum.com/topic/264431
#
#The api.so included in the gem package is not a correct version.
#It is not MinGW compiled version but VC++ compiled version.
#
#You can download the correct api.so for 1.9.x installer for the time
#being
#at http://116.122.37.135/api.so
#
#Copy api.so to your gems directory as follows:
#C:/Ruby192/lib/ruby/gems/1.9.1/gems/win32-api-1.4.6-x86-mingw32/lib/win32/
#
#
#Regards,
#Park Heesob
  
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
