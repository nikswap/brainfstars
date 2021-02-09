bfprogram = '++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.'

ip = 0
dp = 0
mem=[0]*100

def incip():
    global ip
    ip += 1

def incdp():
    global dp
    dp += 1
    incip()

def decdp():
    global dp
    dp -= 1
    incip()

def incmem():
    mem[dp] += 1
    incip()

def decmem():
    mem[dp] -= 1
    incip()

def printmem():
    print(chr(mem[dp]),end='')
    incip()

def readtomem():
    a = input()[0]
    mem[dp] = ord(a)
    incip()

def loopbegin():
    global ip
    ip += 1
    if mem[dp] == 0:
        ip += 1
        k = 1
        for i in range(ip,len(bfprogram)):
            if k == 0:
                break
            if bfprogram[i] == '[':
                k += 1
            elif bfprogram[i] == ']':
                k -= 1
        ip = i

def loopend():
    global ip
    if not mem[dp] == 0:
        k = 1
        for i in range(len(bfprogram)-1,ip,-1):
            if k == 0:
                break
            if bfprogram[i] == '[':
                k -= 1
            elif bfprogram[i] == ']':
                k += 1
        ip = i+1
    else:
        ip += 1

chars = '><+-.,[]'
funcs = [incdp,decdp,incmem,decmem,printmem,readtomem,loopbegin,loopend]

counter = 30000

while counter > 0 and ip < len(bfprogram):
    counter -= 1

    c = bfprogram[ip]
    print(funcs[chars.find(c)],mem)
    funcs[chars.find(c)]()

