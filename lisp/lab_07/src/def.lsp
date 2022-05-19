(defun z-list (n)
  (cond ((zerop n) nil)
        (t (cons 0 (z-list (1- n))))))

(defun e-matrix (n &optional (l nil) (r (z-list (1- n))))
  (cond ((zerop n) nil)
        (t (cons (append l (cons 1 r)) (e-matrix (1- n) (cons 0 l) (cdr r))))))

(defun plus-rows (left right)
  (mapcar '+ left right))

(defun map-matrix (func matrix)
  (mapcar
   (lambda (row i)
     (mapcar
      (lambda (x j)
        (funcall func x i j))
      row (range (length row))))
   matrix (range (length matrix))))
   
(defun replace-el-row (row pos v &optional (i (- (length row) 1)) (acc ()))
  (cond
   ((< i 0)
    acc)
   ((= i pos)
    (replace-el-row
     row pos v (- i 1)
     (cons v acc)))
   (T
    (replace-el-row
     row pos v (- i 1)
     (cons (nth i row) acc)))))

(defun get-el-matrix (matrix row col)
  (nth col (nth row matrix)))

(defun find_opor (matrix col)
  (let ((column (mapcar (lambda (row) (abs (nth col row))) matrix)))
    (position (reduce #'max (nthcdr col column)) column)))

(defun __wrapper-lu (matrix
                      &optional
                      (i 0) (end (length matrix)))
  (if (>= i end)
      (matrix)
        (__wrapper-lu
           (__row_process_rec_lu matrix i end)
            (+ i 1) end)))

(defun range (to &optional (from 0) (i (- to 1)) (acc nil))
  (if (< i from)
      acc
      (range to from (- i 1) (cons i acc))))

(defun __row_process_other_row_lu (matrix i j end)
  (let ((external-val (/ (get-el-matrix matrix j i)
                         (get-el-matrix matrix i i))))
    (replace-el-row
     matrix j
     (mapcar
      (lambda (x k)
        (cond
         ((< k i) x)
         ((= k i) external-val)
         ((> k i) (- x (*
                        external-val
                        (get-el-matrix matrix i k))))))
      (nth j matrix)
      (range end)))))

(defun __row_process_rec_lu (matrix i end &optional (j (+ i 1)))
  (if (>= j end)
      matrix
      (__row_process_rec_lu
       (__row_process_other_row_lu matrix i j end)
       i end
       (+ j 1))))

(defun plus-matrix (left right &optional (acc nil))
  (if (null left)
      (reverse acc)
      (plus-matrix
       (cdr left) (cdr right)
       (cons
        (plus-rows (car left) (car right)) acc))))


(defun lu-decompose (matrix)
  (let ((size (length matrix))
        (LUE (__wrapper-lu matrix)))
      (let ((LU (plus-matrix LUE (e-matrix size))))
        (let ((L (map-matrix
                  (lambda (x i j)
                    (cond
                     ((= i j) 1)
                     ((> i j) (float x))
                     (T 0)))
                  LU))
              (U (map-matrix
                  (lambda (x i j)
                    (cond
                     ((= i j) (float (- x 1)))
                     ((< i j) (float x))
                     (T 0)))
                  LU)))
          (list L U)))))