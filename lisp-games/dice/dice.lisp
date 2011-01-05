(defparameter *random-state* (make-random-state t))

(defun get-times ()
  (if *args*
      (parse-integer (car *args*))
      (progn (princ "how many times to roll? ")
             (read))))


(defun roll ()
  (1+(random 6)))


(defun make-dice ()
  (loop for i below 13 collect 0))


(defun roll-dice (times sums)
  (dotimes (i times)
           (let ((sum (+ (roll) (roll))))
             (incf (nth sum sums) 1))))


(defun output-results (sums)
  (princ "TOTAL SPOTS   NUMBER OF TIMES")
  (fresh-line)
  (loop for sum in sums
        for i below 13
        unless (< i 2)
        do (format t "~11d ~17d" i sum)
           (fresh-line)))


(let ((sums  (make-dice)))
  (roll-dice (get-times) sums)
  (output-results sums))
