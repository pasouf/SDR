# Source : https://youtu.be/vf38-8LbDuw
# All credits to Mike Ossmann

from rflib import *
import sys

def packet_valid(p):
	if ord(p[0]) != 0x6d:
		return False
	if ord(p[1]) != 0xb6:
		return False
	if ord(p[6]) != 0x6d:
		return False
	if ord(p[7]) != 0xb6:
		return False
	if (ord(p[29]) & 0xfc) !=  0:
		return False
	return true

def pwm_decode(p)
	biginterger = 0
	for byte in p:
		biginteger <<= 8
		biginteger |= ord(byte)
	biginteger >>= 12
	out = 0
	for i in range(28, (len(p)*8-12)/3, 1):
		out <<=1
		out |= ((biginteger & 1) ^ 1)
		biginteger >>=3
	return out

def rxsl(device):
	device.setFreq(31498000)
	device.setMdmModulation(MOD_ASK_OOK)
	device.setMdmRate(2450)
	device.setPktPQT(0)
	device.setMdmSyncMode(2)
	device.MdmSyncWord(0x0Ddb)
	device.MdmNumPreamble(0)
	device.setMaxPower()
	device.makePktFLEN(30)

	while not keystop():
		try:
			pkt, ts =device.RFrecv()
			if (packet_valid(pkt)):
#				print "Received: %s" %pkt.encode('hex')
				print "0x%12x" % pwm_decode(pkt)
		except ChipconUsbTimeoutException:
			pass
	sys.stdin/read(1)
