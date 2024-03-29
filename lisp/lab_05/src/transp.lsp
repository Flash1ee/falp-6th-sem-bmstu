

;Не нужно
(defun get-row(a n &optional (j 0) (len (array-dimension a 0)))
	(cond ((= j len) NIL)
		  (T (cons (aref a n j) (get-row a n (+ j 1) len)))))
		  
(setf x (make-array '(3 3) 
   :initial-contents '((2 5 7)(6 3 4)(5 -2 -3))))
   
(setf y (make-array '(6) :initial-contents '(1 2 3 4 5 6)))

(map 'vector #'(lambda (x i) (* x i)) y '(0 1 2))

(defun make-2d-array(lst n)
	(make-array `(,n ,n)  :initial-contents lst))
	
(setf arr1 (make-2d-array '((1)) 1))
(setf arr2 (make-2d-array '((1 2)(3 4)) 2))
(setf arr (make-2d-array '((2 5 7)(6 3 4)(5 -2 -3)) 3))

(defun get-row(a n)
	(map 'list #'(lambda (x) (aref a n x)) (forward (array-dimension a 0))))
		 
(get-row arr 0)
(get-row arr 1)
(get-row arr 2)






;inverse-mtrx with array
(defun make-2d-arr(lst)
	(map 'vector #'(lambda (x) (apply #'vector x)) lst))
	
(setf arr (make-2d-arr lst))
(setf arr1 (make-2d-arr lst1))
(setf arr2 (make-2d-arr lst2))
(setf arr3 (make-2d-arr lst3))
(setf arr5 (make-2d-arr lst5))
	
(defun forward(n &optional (res NIL))
	(cond ((zerop n) res)
		  (T (forward (- n 1) (cons (- n 1) res)))))	 

(defun butn (lst n &optional (cur_n 0))
	(cond ((null lst) NIL)
		  ((= cur_n n) (butn (cdr lst) n (+ cur_n 1)))
		  (T (cons (car lst) (butn (cdr lst) n (+ cur_n 1))))))		  

(defun butn-arr(arr n &optional (len (length arr)))
	(map 'vector #'(lambda (x) (aref arr x)) (butn (forward len) n)))
	
(butn-arr arr 1)

(defun get-min-arr(a i j)
	(map 'vector #'(lambda (x) (butn-arr x j)) (butn-arr a i)))

(get-min-arr arr 0 0)

(defun ref (a i j)
	(aref (aref a i) j))

(defun det-arr-r(a &optional (len (length a)))
	(map 'vector #'(lambda (x y) (* x (det-arr y))) (aref a 0) (map 'vector #'(lambda (z) (get-min-arr a 0 z)) (forward len))))


(defun dop-arr (a &optional (n 0))
	(map 'list #'(lambda (x y) (if (evenp (+ y n)) x (- x))) a (forward (length a))))

(dop-arr (aref arr 0))

(defun det-arr(a)
	(let ((len (length a)))
		 (cond ((zerop len) NIL)
			   ((= len 1) (ref a 0 0))
			   ((= len 2) (- (* (ref a 0 0) (ref a 1 1)) (* (ref a 0 1) (ref a 1 0))))
			   (T (apply #'+ (dop-arr (det-arr-r a)))))))

(det-arr-r arr)

(det-arr arr1) ;1
(det-arr arr2) ;-2
(det-arr arr) ;-1
(det-arr arr3) ;0
(det-arr arr5) ;-80

(defun nels (n el &optional (res NIL))
	(cond ((zerop n) res)
		  (T (nels (- n 1) el (cons el res)))))
		  
(nels 3 24)

(defun get-is(n)
	(mapcar #'(lambda (x) (nels n x)) (forward n)))
	
(defun get-js(n)
	(mapcar #'(lambda (x) (forward n)) (forward n)))

(get-is 3)
(get-js 4)

(defun min-mtrx-arr(a &optional (len (length a)))
	(map 'vector #'(lambda (x y)
		(map 'vector #'(lambda (n)
			(det-arr (get-min-arr a (nth n x) (nth n y))))
			(forward (length a))))
		(get-is len) (get-js len)))
	
	;(map 'vector #'(lambda (x y) (det-arr (get-min-arr a x y))) (get-is len) (get-js len))		   ;v1
	;(apply #'map 'vector #'(lambda (x y) (det-arr (get-min-arr a x y))) (get-is len) (get-js len)) ;v2
	;(map 'vector #'(lambda (x y)(map 'vector #'(lambda (n) (det-arr (get-min-arr a (nth n x) (nth n y)))) (forward (length arr)))) (get-is len) (get-js len)) ;v2
	
(min-mtrx-arr arr)

(defun alg-dop-arr(a)
	(map 'vector #'(lambda (x n) (apply #'vector (dop-arr x n))) a (forward (length a))))
	
(alg-dop-arr (min-mtrx-arr arr))

(defun trans-arr (a &optional (len (length a)))
	(map 'vector #'(lambda (x)
		(map 'vector #'(lambda (i j)
			(ref a i j))
			(forward len) (nels len x)))
		(forward len)))

(trans-arr (alg-dop-arr (min-mtrx-arr arr)))

(defun get-transp-mtrx (mtrx)
	(cond ((null mtrx) Nil)
		  (T (apply #'map 'vector #'vector (map 'list #'(lambda (x) x) mtrx)))))
	
(defun mtrx-mul-arr(k a)
	(map 'vector #'(lambda (x)
		(map 'vector #'(lambda (y)
			(* k y)) x)) a))
		
(mtrx-mul-arr -1 (trans-arr (alg-dop-arr (min-mtrx-arr arr))))

(defun inverse-mtrx-arr (a)
	(cond ((zerop (det-arr a)) NIL)
		  (T (mtrx-mul-arr (/ 1 (det-arr a)) (trans-arr (alg-dop-arr (min-mtrx-arr a)))))))
		  
(inverse-mtrx-arr arr)
(inverse-mtrx-arr arr2)
(inverse-mtrx-arr arr3)

;fiveam
(ql:quickload "fiveam")

(fiveam:test Test-inverse-mtrx-arr
	"Test-inverse-mtrx-arr"
	(fiveam:is (equalp (make-2d-arr '((1 -1 1) (-38 41 -34) (27 -29 24))) (inverse-mtrx-arr (make-2d-arr '((2 5 7) (6 3 4) (5 -2 -3))))))
	(fiveam:is (equalp (make-2d-arr '((-2 1) (3/2 -1/2))) (inverse-mtrx-arr (make-2d-arr '((1 2) (3 4))))))
	(fiveam:is (null (inverse-mtrx-arr (make-2d-arr '((1 2 3) (4 5 6)(7 8 9)))))))

(fiveam:run! 'Test-inverse-mtrx-arr)