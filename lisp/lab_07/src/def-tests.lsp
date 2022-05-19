(ql:quickload "fiveam")

(in-package :cl-user)
(defpackage my-fiveam-test
  (:use :cl :fiveam))
(in-package :my-fiveam-test)


; T [x] z-list (n)
; T [X] e-matrix (n &optional (l nil) (r (z-list (1- n))))
; T [X] plus-rows (left right)
; T [X] plus-matrix (left right &optional (acc nil))
; T [X] map-matrix (func matrix)
; T [X] swap-rows (matrix row1 row2 &optional (i (- (length matrix) 1)) (acc ()))
; T [X] range (to &optional (from 0) (i (- to 1)) (acc nil))
; T [X] replace-el-row (row pos v &optional (i (- (length row) 1)) (acc ()))
; T [X] get-el-matrix (matrix row col)
; T [X] find_opor (matrix col)
; T [X] __wrapper-lup (matrix
; T [X] lup-decompose (matrix)


(test q-z-list-test
  "z-list test"
  (is (equal (z-list 2) '(0 0)))
  (is (equal (z-list 0) nil))
  (is (equal (z-list 5) '(0 0 0 0 0))))
(run! 'q-z-list-test)

(test q-e-matrix-test
  "e-matrix test"
  (is (equal (e-matrix 1) '((1))))
  (is (equal (e-matrix 2) '((1 0) (0 1))))
  (is (equal (e-matrix 3) '((1 0 0) (0 1 0) (0 0 1)))))
(run! 'q-e-matrix-test)

(test q-plus-rows-test
  "plus-rows test"
  (is (equal (plus-rows '(1) '(5)) '(6)))
  (is (equal (plus-rows '(1 4) '(5 -5)) '(6 -1)))
  (is (equal (plus-rows '(1 4 9) '(5 -5 0.1)) '(6 -1 9.1))))
(run! 'q-plus-rows-test)

(test q-plus-matrix-test
  "plus-matrix test"
  (is (equal (plus-matrix '((1)) '((5))) '((6))))
  (is (equal (plus-matrix '((1 4) (0 -1)) '((5 -5) (5 7))) '((6 -1) (5 6)))))
(run! 'q-plus-matrix-test)

(defun ret-x (x i j)
  x)
(defun ret-i (x i j)
  i)
(defun ret-j (x i j)
  j)

(test q-map-matrix-test
  "map-matrix test"
  (is (equal (map-matrix #'ret-x (e-matrix 3)) (e-matrix 3)))
  (is (equal (map-matrix #'ret-i (e-matrix 3)) '((0 0 0) (1 1 1) (2 2 2))))
  (is (equal (map-matrix #'ret-j (e-matrix 3)) '((0 1 2) (0 1 2) (0 1 2)))))
(run! 'q-map-matrix-test)

(test q-range-test
  "range test"
  (is (equal (range 5) '(0 1 2 3 4)))
  (is (equal (range 5 1) '(1 2 3 4)))
  (is (equal (range 10 5) '(5 6 7 8 9))))
(run! 'q-range-test)

(test q-replace-el-row-test
  "replace-el-row test"
  (is (equal (replace-el-row '(2 2 2) 1 33) '(2 33 2)))
  (is (equal (replace-el-row '(2 2 2) 0 33) '(33 2 2)))
  (is (equal (replace-el-row '(1 2 0 2 2) 2 33) '(1 2 33 2 2))))
(run! 'q-replace-el-row-test)

(test q-get-el-matrix-test
  "get-el-matrix test"
  (is (equal (get-el-matrix '((99)) 0 0) 99))
  (is (equal (get-el-matrix '((99) (33)) 1 0) 33))
  (is (equal (get-el-matrix '((99 15) (33 77)) 1 1) 77)))
(run! 'q-get-el-matrix-test)

(test q-find_opor-test
  "find_opor test"
  (is (equal (find_opor '((99 39) (3 5)) 0) 0))
  (is (equal (find_opor '((99 39) (-100 5)) 0) 1))
  (is (equal (find_opor '((99 39) (-100 5)) 1) 1)))
(run! 'q-find_opor-test)

(test q-__wrapper-lu-test
  "__wrapper-lu test"
  (is (equalp (__wrapper-lu '((4 2) (1 8))) (cons '((4 2) (1/4 15/2)) '((1 0) (0 1)))))
  (is (equalp (__wrapper-lu '((0 2) (4 8))) (cons '((4 8) (0 2)) '((0 1) (1 0))))))
(run! 'q-__wrapper-lu-test)

(test q-lu-decompose-test
  "lu-decompose test"
  (is (equalp (lu-decompose '((4 2) (1 8))) (list '((1 0) (1/4 1)) '((4 2) (0 15/2)) '((1 0) (0 1)))))
  (is (equalp (lu-decompose '((0 2) (4 8))) (list '((1 0) (0 1)) '((4 8) (0 2)) '((0 1) (1 0)))))
  (is (equalp
       (lu-decompose '(
        (1 2 1) (2 1 1) (1 -1 2)
       )) '(
         ((1 0 0) (0.5 1 0) (0.5 -1.0 1))
         ((2.0 1.0 1.0) (0 1.5 0.5) (0 0 2.0))
         ((0 1 0) (1 0 0) (0 0 1)))))
  (is (equalp
       (lu-decompose '(
        (0 2 3) (5 7 3) (3 2 8)
       )) '(
          ((1 0 0) (0.6 1 0) (0.0 -0.90909094 1))
          ((5.0 7.0 3.0) (0 -2.2 6.2) (0 0 8.636364))
          ((0 1 0) (0 0 1) (1 0 0))))))
(run! 'q-lu-decompose-test)


(print (lu-decompose '(
  (2 7 -6)
  (8 2 1)
  (7 4 2)
)))


(print (lu-decompose '(
  (9 2 1 0)
  (2 11 1 5)
  (1 -1 2 7)
)))


; (print (lu-decompose '(
;  (3 9 3 9 4 8 8 5 0 4 8 1 5 9 2 5 3 2 8 6)
;  (0 2 2 9 3 0 1 9 7 8 7 0 7 2 2 2 0 0 9 3)
;  (5 9 4 0 0 8 8 3 0 6 1 0 0 5 0 4 5 3 3 4)
;  (1 2 5 8 4 7 2 7 7 3 0 2 2 6 5 4 4 3 9 6)
;  (1 2 6 2 7 8 6 5 1 1 9 2 4 4 3 0 3 7 7 1)
;  (1 9 5 5 5 2 0 1 5 1 7 9 4 6 1 1 4 9 6 8)
;  (2 6 2 8 2 5 9 6 3 6 9 6 8 4 1 3 7 3 7 4)
;  (5 6 3 9 2 6 2 9 5 9 7 8 7 1 6 9 7 7 7 2)
;  (6 6 8 4 3 1 9 2 5 6 6 0 3 2 9 5 8 1 6 6)
;  (2 3 6 9 5 4 1 4 2 0 8 0 7 8 4 0 9 3 4 4)
;  (0 2 4 5 4 5 2 5 7 9 3 9 2 9 1 9 5 4 5 9)
;  (4 3 9 3 1 3 5 1 9 9 7 1 2 2 6 8 7 8 3 6)
;  (7 8 8 2 7 1 3 5 5 9 4 1 4 6 7 8 1 2 1 0)
;  (4 8 1 6 2 7 6 2 8 2 8 5 0 6 9 0 7 3 5 4)
;  (4 1 6 0 7 5 0 9 7 3 9 3 4 3 1 6 2 8 8 0)
;  (0 9 8 0 5 7 0 5 2 7 9 6 9 7 9 8 2 9 7 2)
;  (3 9 5 9 4 7 5 6 5 6 7 7 5 5 7 2 4 0 7 7)
;  (7 9 5 8 8 4 7 1 6 6 5 1 7 2 0 1 9 7 0 6)
;  (3 7 3 0 4 3 3 8 3 2 5 2 3 1 1 2 7 8 5 5)
;  (6 0 6 4 2 8 7 4 6 7 0 1 6 6 2 0 9 7 9 4)
; )))
; https://matworld.ru/calculator/matrix-calculator-1.php