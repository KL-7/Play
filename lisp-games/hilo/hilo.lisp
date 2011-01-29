(defparameter *random-state* (make-random-state t))

((lambda (lines)
    (loop for line in lines
          do (princ line)
             (fresh-line)))
 '("====================  HI LO  ===================="
   "You will have 6 tries to guess the amount of money in the"
   "hi lo jackpot, which is between 1 and 100 dollars. If you"
   "guess the amount, you win all the money in the jackpot!"
   "Then you get another chance to win more money. However,"
   "if you do not guess the amount, the game ends."))

(defun play-game (money game-number)
  (let ((target (random 100)))
    (labels ((blank-line ()
               (fresh-line)
               (princ " ")
               (fresh-line))
             (prompt (n) 
               (princ game-number)
               (princ ".")
               (princ n)
               (princ " Your guess: ")
               (read))
             (guess-correct ()
               (incf money target)
               (fresh-line)
               (princ "GOT IT!!!!!!!!!! You win ")
               (princ target)
               (princ " dollars.")
               (fresh-line)
               (princ "Your total winnings are now ")
               (princ money)
               (princ " dollars.")
               (blank-line)
               money)
             (guess-low ()
               (princ "Your guess is too low.")
               (blank-line)
               nil)
             (guess-high ()
               (princ "Your guess is too high.")
               (blank-line)
               nil)
             (hilo (guess)
               (cond ((= guess target) (guess-correct))
                     ((< guess target) (guess-low))
                     (t                (guess-high))))
             (take-turn (n)
               (hilo (prompt n)))
             (new-game-prompt ()
               (princ "Play again? (yes or no) ")
               (let ((choice (read)))
                 (cond ((eq 'yes choice) (play-game money (1+ game-number)))
                       ((eq 'no  choice) (fresh-line)
                                         (princ "So long. Hope you enjoyed yourself!")
                                         nil)
                       (t                (princ "Invalid answer, enter yes or no ")
                                         (new-game-prompt))))))
      (loop for turn from 1 upto 6
            do (let ((result (take-turn turn)))
                 (when result
                   (new-game-prompt)
                   (return-from play-game))))
      (princ "You ran out of turns.")
      (fresh-line)
      (princ "The correct answer was ")
      (princ target)
      (princ ".")
      (blank-line)
      (princ "All your base are belong to us!"))))

(play-game 0 1)