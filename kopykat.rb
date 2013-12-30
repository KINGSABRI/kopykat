require 'Win32API'

listener = Win32API.new('user32', 'GetAsyncKeyState', ['i'], 'i')