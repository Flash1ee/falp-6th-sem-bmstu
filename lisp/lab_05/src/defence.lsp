; Вычитает first_row из m, чтобы обнулить col_j колонку матрицы p 
(defun zerofy-column (m p first_row col_j)
  (mapcar
    #'(lambda (mi li)
      (let
        ((lz (nth col_j li)))
        (mapcar
          #'(lambda (mij fj)
            (-
              mij
              (* fj lz)))
          mi
          first_row)))
    m
    p))

; Находит первую строчку в матрице a, в которой элемент в col_i колнке не нулевой 
(defun first-nonzero (a col_i &optional (i 0))
  (cond
    ((null a) (throw 'nonzero-not-found T))
    ((zerop (nth col_i (car a))) (first-nonzero (cdr a) col_i (1+ i)))
    (i)))

; Поместить i строку матрицы a на первую позицию
(defun bubble-row (a i)
  (cond
    ((null a) nil)
    ((zerop i) a)
    ((let
      ((r (bubble-row (cdr a) (1- i))))
      (cons
        (car r)
        (cons 
          (car a)
          (cdr r)))))))

(defun triangular (a b &optional (col_j 0) (ra nil) (rb nil))
  (cond 
    ((null a) (cons ra (cons rb nil)))
    ((let*
      (
        (row_i (first-nonzero a col_j))
        (sa (bubble-row a row_i))
        (sb (bubble-row b row_i))
        (fz (nth col_j (car sa))))
      (triangular
        (zerofy-column
          (cdr sa)
          (cdr sa)
          (mapcar #'(lambda (x) (/ x fz)) (car sa))
          col_j)
        (zerofy-column
          (cdr sb)
          (cdr sa)
          (mapcar #'(lambda (x) (/ x fz)) (car sb))
          col_j)
        (1+ col_j)
        (cons (reverse (car sa)) ra)
        (cons (reverse (car sb)) rb))))))

(defun identity-mat (n)
  (cond
    ((= n 1) (cons (cons 1 nil) nil))
    ((let
      ((r (identity-mat (1- n))))
      (cons
        (cons
          1
          (cons 0 (cdar r)))
        (mapcar
          #'(lambda (x) (cons 0 x))
          r))))))

(defun get-inv (m)
  (let
    ((r
      (apply
        #'triangular
        (triangular
          m
          (identity-mat (length m))))))
    (mapcar
      #'(lambda (ar br)
        (let
          ((nz (find-if-not #'zerop ar)))
          (mapcar
            #'(lambda (bi) (/ bi nz))
            br)))
      (car r)
      (cadr r))))