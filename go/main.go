package main

import (
	"fmt"
	"bufio"
	"os"
)

func logMessage(msg string) {
	if false {
		fmt.Println(msg)
	}
}

func main() {
	//bfprogram := "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
	bfprogram := ",."
	mem := make([]int, 300)
	dp := 0
	ip := 0
	for ipc := 0; ipc < 1000000; ipc++ {
		if ip >= len(bfprogram) || ip < 0 {
			break
		}
		switch bfprogram[ip] {
		case '+':
			logMessage("INCREASE MEM")
			mem[dp]++
			ip++
		case '-':
			logMessage("DECREASE MEM")
			mem[dp]--
			ip++
		case '>':
			logMessage("INCREASE MEM POINTER")
			dp++
			ip++
		case '<':
			logMessage("DECREASE MEM POINTER")
			dp--
			ip++
		case '.':
			logMessage("PRINT MEM")
			fmt.Printf("%c",mem[dp])
			ip++
		case ',':
			logMessage("INPUT MEM")
			reader := bufio.NewReader(os.Stdin)
			char, _, err := reader.ReadRune()
			
			if err != nil {
			  fmt.Println(err)
			}
			mem[dp] = int(char)
			ip++
		case '[':
			logMessage("LOOP BEGIN")
			ip++
			if mem[dp] == 0 {
				ip++
				k:=1
				i := ip
				for i= ip; i < len(bfprogram); i++ {
					if k == 0 {
						break
					}
					switch bfprogram[i] {
					case '[': k++
					case ']': k++
					default: k=k
					}
				}
				ip = i+1
			}
		case ']':
			logMessage("LOOP END")
			if mem[dp] != 0 {
				k:=1
				i := ip
				for i= ip-1; i > 0; i-- {
					if k == 0 {
						break
					}
					switch bfprogram[i] {
					case '[': k--
					case ']': k++
					default: k=k
					}
				}
				ip = i+1	
			} else {
				ip++
			}
		default:
			logMessage("INSTRUCTION UNKNOWN")
		}			
	}
}
