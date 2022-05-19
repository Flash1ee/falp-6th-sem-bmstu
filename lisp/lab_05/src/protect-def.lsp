(ql:quickload "fiveam")

(in-package :cl-user)
(defpackage my-fiveam-test
  (:use :cl :fiveam))
(in-package :my-fiveam-test)

(load "def.lsp")

(test q-transpose-list-test
  "Transpose test list"
  (is (equal (transpose-matrix-list '((1))) '((1))))
  (is (equal (transpose-matrix-list '((1 2))) '((1) (2))))
  (is (equal (transpose-matrix-list '((1) (2))) '((1 2))))
  (is (equal (transpose-matrix-list '((1 3) (2 4))) '((1 2) (3 4))))
  (is (equal (transpose-matrix-list '((1 3 5) (2 4 6))) '((1 2) (3 4) (5 6)))))

(run! 'q-transpose-list-test)

(test q-transpose-array2d-test
  "Transpose test array2d"
  (is (equalp (transpose-matrix-array2d '#2A((1))) '#2A((1))))
  (is (equalp (transpose-matrix-array2d '#2A((1 2))) '#2A((1) (2))))
  (is (equalp (transpose-matrix-array2d '#2A((1) (2))) '#2A((1 2))))
  (is (equalp (transpose-matrix-array2d '#2A((1 3) (2 4))) '#2A((1 2) (3 4))))
  (is (equalp (transpose-matrix-array2d '#2A((1 3 5) (2 4 6))) '#2A((1 2) (3 4) (5 6)))))

(run! 'q-transpose-array2d-test)

(test q-invert-list-test
  "invert test list"
  (is (equalp (invert
               '((2)))
              '((1/2))))
  (is (equalp (invert
               '((3 4) (5 7)))
              '((7 -4) (-5 3))))
  (is (equalp (invert
               '((2 5 7) (6 3 4) (5 -2 -3)))
              '((1 -1 1) (-38 41 -34) (27 -29 24))))
  (is (equalp (invert
               '((2 1 0 0) (3 2 0 0) (1 1 3 4) (2 -1 2 3)))
              '((2 -1 0 0) (-3 2 0 0) (31 -19 3 -4) (-23 14 -2 3))))
  (is (null (invert
             '((1 2 3) (2 4 6) (1 1 -1)))))

  (is (eq (invert
           '((1 2 3) (2 4 6))) 'incorrect-size)))

(run! 'q-invert-list-test)

(test q-invert-array2d-test
  "invert test array2d"
  (is (equalp (invert-array2d
               '#2A((2)))
              '#2A((1/2))))
  (is (equalp (invert-array2d
               '#2A((3 4) (5 7)))
              '#2A((7 -4) (-5 3))))
  (is (equalp (invert-array2d
               '#2A((2 5 7) (6 3 4) (5 -2 -3)))
              '#2A((1 -1 1) (-38 41 -34) (27 -29 24))))
  (is (equalp (invert-array2d
               '#2A((2 1 0 0) (3 2 0 0) (1 1 3 4) (2 -1 2 3)))
              '#2A((2 -1 0 0) (-3 2 0 0) (31 -19 3 -4) (-23 14 -2 3))))
  (is (null (invert-array2d
             '#2A((1 2 3) (2 4 6) (1 1 -1)))))

  (is (eq (invert-array2d
           '#2A((1 2 3) (2 4 6))) 'incorrect-size)))

(run! 'q-invert-array2d-test)

(wrap_invert '(
(3 9 3 9 4 8 8 5 0 4 8 1 5 9 2 5 3 2 8 6)
(0 2 2 9 3 0 1 9 7 8 7 0 7 2 2 2 0 0 9 3)
(5 9 4 0 0 8 8 3 0 6 1 0 0 5 0 4 5 3 3 4)
(1 2 5 8 4 7 2 7 7 3 0 2 2 6 5 4 4 3 9 6)
(1 2 6 2 7 8 6 5 1 1 9 2 4 4 3 0 3 7 7 1)
(1 9 5 5 5 2 0 1 5 1 7 9 4 6 1 1 4 9 6 8)
(2 6 2 8 2 5 9 6 3 6 9 6 8 4 1 3 7 3 7 4)
(5 6 3 9 2 6 2 9 5 9 7 8 7 1 6 9 7 7 7 2)
(6 6 8 4 3 1 9 2 5 6 6 0 3 2 9 5 8 1 6 6)
(2 3 6 9 5 4 1 4 2 0 8 0 7 8 4 0 9 3 4 4)
(0 2 4 5 4 5 2 5 7 9 3 9 2 9 1 9 5 4 5 9)
(4 3 9 3 1 3 5 1 9 9 7 1 2 2 6 8 7 8 3 6)
(7 8 8 2 7 1 3 5 5 9 4 1 4 6 7 8 1 2 1 0)
(4 8 1 6 2 7 6 2 8 2 8 5 0 6 9 0 7 3 5 4)
(4 1 6 0 7 5 0 9 7 3 9 3 4 3 1 6 2 8 8 0)
(0 9 8 0 5 7 0 5 2 7 9 6 9 7 9 8 2 9 7 2)
(3 9 5 9 4 7 5 6 5 6 7 7 5 5 7 2 4 0 7 7)
(7 9 5 8 8 4 7 1 6 6 5 1 7 2 0 1 9 7 0 6)
(3 7 3 0 4 3 3 8 3 2 5 2 3 1 1 2 7 8 5 5)
(6 0 6 4 2 8 7 4 6 7 0 1 6 6 2 0 9 7 9 4)
))
