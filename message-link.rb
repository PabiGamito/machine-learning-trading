require 'msgpack'

msg = [1,2,3].to_msgpack  #=> "\x93\x01\x02\x03"
MessagePack.unpack(msg)   #=> [1,2,3]
