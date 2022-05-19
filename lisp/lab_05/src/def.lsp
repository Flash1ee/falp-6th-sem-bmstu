; транспонирование

(defun transpose-matrix-list (matrix)
  (apply #'mapcar #'list matrix))

(defun transpose-matrix-array2d (matrix)
  (let ((size (array-dimensions matrix)))
    (make-array
     (reverse size) :initial-contents
     (__rows_transpose-matrix-array2d
      matrix (- (second size) 1) (first size)))))

(defun __rows_transpose-matrix-array2d (matrix j rows &optional (acc ()))
  (if (< j 0)
      acc
      (__rows_transpose-matrix-array2d
       matrix (- j 1) rows
       (cons (__row_transpose-matrix-array2d matrix (- rows 1) j) acc))))

(defun __row_transpose-matrix-array2d (matrix i j &optional (acc ()))
  (if (< i 0)
      acc
      (__row_transpose-matrix-array2d
       matrix (- i 1) j (cons (aref matrix i j) acc))))



; гаус
(defun __row-minus-k (leftrow rightrow k)
  (mapcar (lambda (x y)
            (let ((v (- x (* k y))))
              (if (< (abs v) 1e-5) 0 v))) leftrow rightrow))

(defun __row-mul (row k)
  (mapcar (lambda (x)
            (let ((m (* x k)))
              (if (< (abs (- m 1)) 1e-5) 1 m)))
          row))

(defun __single_row_process_gaussian-solve (matrix i)
  (let* ((row (nth i matrix))
         (pos (position-if-not #'zerop row)))
    (if (or (null pos) (>= pos (length matrix)))
        Nil
        (cons (__row-mul row (/ 1 (nth pos row))) pos))))

; вычитаем обработанную единичную строку из других чтобы занулился какой-либо столбец
(defun __row_process_gaussian-solve (matrix fixed_row pos_col pos_row i &optional (acc nil))
  (if (< i 0)
      acc
      (let ((leftrow (nth i matrix)))
        (__row_process_gaussian-solve
         matrix fixed_row pos_col pos_row (- i 1)
         (if (= pos_row i)
             (cons fixed_row acc)
             (cons
              (__row-minus-k leftrow fixed_row

                             (nth pos_col leftrow))
              acc))))))

(defun __full_row_process_gaussian-solve (matrix i)
  (let ((rowpos (__single_row_process_gaussian-solve matrix i)))
    (if (null rowpos)
        nil
        (__row_process_gaussian-solve
         matrix (car rowpos) (cdr rowpos) i (- (length matrix) 1)))))

(defun __wrapper_gaussian-solve (matrix &optional (i (- (length matrix) 1)))
  (if (or (null matrix) (< i 0))
      matrix
      (__wrapper_gaussian-solve
       (__full_row_process_gaussian-solve matrix i)
       (- i 1))))

; все столбцы нужного размера
(defun check_size (matrix cols)
  (or
   (null matrix)
   (and
    (= (length (car matrix)) cols)
    (check_size (cdr matrix) cols))))

; обратная матрица
(defun z-list (n)
  (cond ((zerop n) nil)
        (t (cons 0 (z-list (1- n))))))

(defun e-matrix (n &optional (l nil) (r (z-list (1- n))))
  (cond ((zerop n) nil)
        (t (cons (append l (cons 1 r)) (e-matrix (1- n) (cons 0 l) (cdr r))))))

(defun invert (matrix)
  (if (check_size matrix (length matrix))
      (mapcar
       (lambda (row)
         (nthcdr (length matrix) row))
       (sort
        (__wrapper_gaussian-solve
         (mapcar (lambda (row zrow) (append row zrow))
                 matrix (e-matrix (length matrix))))
        #'<
        :key (lambda (row)
               (position-if-not #'zerop row))))
      'incorrect-size))

(defun invert-array2d (array)
  (let ((res (invert (2d-array-to-list array))))
    (if (or (null res) (eq res 'incorrect-size))
        res
        (make-array (array-dimensions array) :initial-contents res))))

(defun 2d-array-to-list (array)
  (loop for i below (array-dimension array 0)
        collect (loop for j below (array-dimension array 1)
                      collect (aref array i j))))

(defun wrap_invert(matrix)
(mapcar (lambda (row) (mapcar (lambda (el) (float el)) row)) (invert matrix))
)

(apply #'format#'mapcar #'invert matrix)

(mapcar (
  lambda (e) (mapcar (
    lambda (x) (
      (format t "~2.f~%" e)
      ))))
