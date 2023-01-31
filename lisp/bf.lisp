(defvar *BFprogram* "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")
;;(defvar *BFprogram* "+[++[]++]+")
(defvar *mem* (make-array '(30) :initial-element 0))
(defvar *pc* 0)
(defvar *dp* 0)

(defun find-matching-parans (c)
	(block outer
		(let ((par 0))
			(loop for idex from c to (- (length *BFprogram*) 1)
				do
					(case (char *BFprogram* idex)
						(#\[ (setf par (1+ par)))
						(#\] (setf par (1- par)))
						(t ())
					)
					(if (= par 0) 
							(return-from outer idex)
					)
			)
		)
	)
)

(defun find-matching-parans-rev (c)
	(block outer
		(let ((par 0))
			(loop for idex from c downto 0
				do
					(case (char *BFprogram* idex)
						(#\[ (setf par (1- par)))
						(#\] (setf par (1+ par)))
						(t ())
					)
					(if (= par 0) 
							(return-from outer idex)
					)
			)
		)
	)
)


(defun handle-char (c)
	(case c
		(#\> 
			;;(format t "inc dp~%")
			(setf *dp* (1+ *dp*))
			(setf *pc* (1+ *pc*))
		)
		(#\< 
			;;(format t "dec dp~%")
			(setf *dp* (1- *dp*))
			(setf *pc* (1+ *pc*))
		)
		(#\- 
			;;(format t "dec dp val~%")
			(setf (aref *mem* *dp*) (1- (aref *mem* *dp*)))
			(setf *pc* (1+ *pc*))
		)
		(#\, 
			;;(format t "input~%")
			(setf *pc* (1+ *pc*))
		)
		(#\. 
			;;(format t "output~%")
			(format t "~A" (code-char (aref *mem* *dp*)))
			(setf *pc* (1+ *pc*))
		)
		(#\[ 
			;;(format t "loop begin~%")
			(if (= 0 (aref *mem* *dp*))
				(setf *pc* (1+ (find-matching-parans *pc*)))
				(setf *pc* (1+ *pc*))
			)
		)
		(#\] 
			;;(format t "loop end~%")
			(if (= 0 (aref *mem* *dp*))
				(setf *pc* (1+ *pc*))
				(setf *pc* (1+ (find-matching-parans-rev *pc*)))
			)
		)
		(#\+ 
			;;(format t "inc dp val~%")
			(setf (aref *mem* *dp*) (1+ (aref *mem* *dp*)))
			(setf *pc* (1+ *pc*))
		)
		(t 
			(format t "ERROR~%")
			(sb-ext:exit)
		)
	)
	;;(format t "PC, DP: ~a~%" (list *pc* *dp*))
)

;;(format t "~A~%" (char *BFprogram* *pc*))
;;(handle-char (char *BFprogram* *pc*))
;;(format t "RES: ~A~%" (find-matching-parans 1))
;;(format t "RES: ~A~%" (find-matching-parans-rev 8))
(loop for i from 0 to 100000 do
	(if (> *pc* (- (length *BFprogram*) 1))
		(sb-ext:exit)
	)
	(handle-char (char *BFprogram* *pc*))
	;;(format t "~a~%" *mem*)
)
;; Character 	Meaning
;; > 	increment the data pointer (to point to the next cell to the right).
;; < 	decrement the data pointer (to point to the next cell to the left).
;; + 	increment (increase by one) the byte at the data pointer.
;; - 	decrement (decrease by one) the byte at the data pointer.
;; . 	output the byte at the data pointer.
;; , 	accept one byte of input, storing its value in the byte at the data pointer.
;; [ 	if the byte at the data pointer is zero, then instead of moving the instruction pointer forward to the next command, jump it forward to the command after the matching ] command.
;; ] 	if the byte at the data pointer is nonzero, then instead of moving the instruction pointer forward to the next command, jump it back to the command after the matching [ command. 
