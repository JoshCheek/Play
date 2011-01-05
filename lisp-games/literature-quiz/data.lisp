(let ((quiz (make-quiz :title     "LITERATURE QUIZ"
                       :questions '())))

  (quiz-add quiz (make-question :question      "In Pinocchio, what was the name of the cat"
                                :options       '((a "Tigger")
                                                 (b "Cicero")
                                                 (c "Figaro")
                                                 (d "Suipetbot"))
                                :actual-answer 'c))

  (quiz-add quiz (make-question :question      "From whose garden did Bugs Bunny steal the carrots?"
                                :options       '((a "Mr. Nixon's")
                                                 (b "Elmer Fudd's")
                                                 (c "Clem Judd's")
                                                 (d "Stromboli's"))
                                :actual-answer 'b))

  (quiz-add quiz (make-question :question      "In the Wizard of Oz, Dorothy's dog was named?"
                                :options       '((a "Cicero")
                                                 (b "Trixie")
                                                 (c "Kino")
                                                 (d "Toto"))
                                :actual-answer 'd))

  (quiz-add quiz (make-question :question      "Who was the fair maiden who ate the poison apple?"
                                :options       '((a "Sleeping Beauty")
                                                 (b "Cinderella")
                                                 (c "Snow White")
                                                 (d "Wendy"))
                                :actual-answer 'c))

  (quiz-administer quiz))
