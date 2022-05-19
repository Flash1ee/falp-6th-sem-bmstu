(defun automatic (desk stones)(
    cond ((listp (car desk))
                 (and (setf (caar desk) (+ (caar desk) 1)) 
                    (if (= stones 1) 
                        t
                    (automatic (cdr desk) (- stones 1)))
                 )
         )
          ((= stones 1) (if (and (= (car desk) 0) (setf (car desk) 1))
                            nil
                (and (setf stones (+ stones (car desk))) (setf (car desk) 0) (automatic (cdr desk) stones))
                        )
          )
          ((>= stones 0) (and (setf (car desk) (+ (car desk) 1)) (automatic (cdr desk) (- stones 1))))
))

(defun is-win (lst count)(
    if (>= count 0)
        (cond ((/= (car lst) 0) nil)
              (t (is-win (cdr lst) (- count 1))))
        t
))

(defun find-start (lst pos)(
    cond ((zerop pos) lst)
          (t (find-start (cdr lst) (- pos 1)))
))

(defun logic (lst pos holes)
    (let ((head lst)
           (stones (nth pos lst)))
    (cond 
    ((and (> stones 0) (automatic (cdr (find-start lst pos)) stones))
        (cond ((is-win head holes) (progn (print (not-circle-lst head holes)) (victory)))
              (t (progn (print (not-circle-lst head holes)) (terpri) (logic head (ask-hole holes) holes)))))
    ((= stones 0) (progn (wrong-hole) (logic head (ask-hole holes) holes)))
    (t (progn (print (not-circle-lst head holes)) (lose)))))
)


(defun make-lst (holes num)(
    cond ((= 0 holes) (cons (cons 0 nil) nil))
         (t (cons num (make-lst (- holes 1) num)))
))

(defun wrong-count-holes ()(
	format t "Номер лунки не может быть отрицательным:(~% Пожалуйста, повторите попытку...~%"
	(finish-output)
))

(defun ask-hole (holes)
    (cond ((<= holes 0) (format t "Невозможно сыграть! Так как количество маленьких лунок меньше или равно 0!"))
    (t (format t "Введите номер лунки - от 1 до №~A:~%" holes)
	(finish-output)
	(let ((stones (read)))
	(cond ((< stones 0) (progn (wrong-count-holes) (ask-hole holes)))
		  (t stones)))
    ))
)



(defun start-game (holes n)
    (cond ((<= holes 0) (format t "Невозможно сыграть! Так как количество маленьких лунок равно или меньше 0!"))
    (t (let ((lst (make-lst holes n))
           (pos))
    (format t "Начальное состояние доски: ~%~a~%" lst)
    (setq pos (ask-hole (- holes 1)))
    (setf (cdr (last lst)) lst)
    (format t "состояние доски: ~%~a~%" lst)
    (logic lst pos (- holes 1)))))
)
