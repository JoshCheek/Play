(defstruct quiz title questions)


(defstruct question question
                    options
                    actual-answer
                    player-answer)


(defun question-correct-p (question)
  (eq (question-actual-answer question) 
      (question-player-answer question)))


(defun quiz-add (quiz question)
  (push question (quiz-questions quiz)))

  
(defun print-instructions (quiz)
  (princ "Test your knowledge of children's literature.")
  (fresh-line)
  (princ "Good luck.")
  (fresh-line))


(defun print-result (question i)
  (print-question question i)
  (fresh-line)
  (princ "Your Answer: ")
  (princ (question-player-answer question))
  (fresh-line)
  (princ "Actual Answer: ")
  (princ (question-actual-answer question))
  (fresh-line))


(defun print-score (correct total)
  (princ "Score: ")
  (princ correct)
  (princ "/")
  (princ total)
  (fresh-line))
  

(defun print-results (quiz)
  (princ "=====  RESULTS  =====")
  (fresh-line)
  (let ((score         0)
        (num-questions 0))
    (loop for question in (quiz-questions quiz)
          for i from 1
          do (print-result question i)
             (when (question-correct-p question)
                   (incf score 1))
             (incf num-questions 1)
             (print-score score num-questions))))


(defun question-valid-answer-p (question answer)
  (some (lambda (val) (eq val answer))
        (mapcar #'car (question-options question))))


(defun print-question (question n)
  (princ n)
  (princ ") ")
  (princ (question-question question))
  (fresh-line)
  (loop for option in (question-options question)
        do (princ (car option))
           (princ " ")
           (princ (cadr option))
           (fresh-line)))


(defun question-get-answer (question)
  (princ "Choice: ")
  (let ((answer (read)))
    (if (question-valid-answer-p question answer)
        (setf (question-player-answer question) answer)
        (progn (princ "That is not a valid answer, try again.")
               (fresh-line)
               (question-get-answer question)))))


(defun question-administer (question n)
  (print-question question n)
  (question-get-answer question))


(defun quiz-administer (quiz)
  (print-instructions quiz)
  (let ((score 0))
    (loop for question in (quiz-questions quiz)
          for i from 1
          do (question-administer question i)
             (when (question-correct-p question) (incf score 1)))
    (print-results quiz)))


(load "data")