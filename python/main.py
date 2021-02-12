program = '++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.'

mem = [0]
ip = 0
dp = 0
ci = program[ip]

max_ip = 10000000

def grow_mem(dp):
    while len(mem) <= dp:        
        mem.append(0)

def inc_ip():
    global ip
    ip += 1

def inc_dp():
    global dp
    dp += 1
    grow_mem(dp)
    inc_ip()

def dec_dp():
    global dp
    dp -= 1
    inc_ip()

def inc_mem():
    mem[dp] += 1
    inc_ip()

def dec_mem():
    mem[dp] -= 1
    inc_ip()

def print_mem():
    print(chr(mem[dp]),end='')
    inc_ip()

def input_mem():
    data = input()
    mem[dp] = data[0]
    inc_ip()

def forward_jmp():
    global ip
    if mem[dp] == 0:
        k = 0
        for j in range(ip+1,len(program)):
            i = program[j]
            if i == '[':
                k+=1
            elif i == ']':
                k-=1
            if k == 0:
                ip = j+1
                break
    else:
        inc_ip()

def backwards_jmp():
    global ip
    if not mem[dp] == 0:
        k = 0
        for j in range(ip,0,-1):
            i = program[j]
            if i == ']':
                k+=1
            elif i == '[':
                k-=1
            if k == 0:
                ip = j+1
                break
    else:
        inc_ip()


instrc = '><+-.,[]'
funcs = [inc_dp,dec_dp,inc_mem,dec_mem,print_mem,input_mem,forward_jmp,backwards_jmp]

while max_ip > 0 and ip < len(program):
    u = program[ip]
    p = instrc.find(u)
    funcs[p]()
    max_ip -= 1
print(ip, max_ip)