(ql:quickload "fiveam")
(use-package :fiveam)

(load "/Users/dvvarin/BMSTU/falp-6th-sem-bmstu/lab_03/src/defend.lisp")

(test test-square-fun
  "Testing function for quadratic equation."
  (is (equal (solve-quad-eq 1 -2 1) '(1 1)) "D=0 I test")
  (is (equal (solve-quad-eq 1 2 1) '(-1 -1)) "D=0 II test")
  (is (equal (solve-quad-eq 2 5 2) '(-0.5 -2.0)) "D>0 I test")
  (is (equal (solve-quad-eq 2 5 2) '(-0.5 -2)) "D>0 II test (equal int float) --- SHOULD BE FAILED")
  (is (equalp (solve-quad-eq 2 5 2) '(-0.5 -2)) "D>0 II test (equalp int float)")
  (is (equal (solve-quad-eq 1 7 -18) '(2.0 -9.0)) "D>0 III test")
  (is (equal (solve-quad-eq 2 4 4) '(#C(-1.0 1.0) #C(-1.0 -1.0))) "D<0 I test")
  (is (equal (solve-quad-eq 0 1 1) '(-1)) "One root")
)
(run! 'test-square-fun)
