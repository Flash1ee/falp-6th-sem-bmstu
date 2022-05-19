;fiveam
(ql:quickload "fiveam")

(fiveam:test Test-inverse-mtrx
	"Test-inverse-mtrx"
	(fiveam:is (equal '((1 -1 1) (-38 41 -34) (27 -29 24)) (inverse-mtrx '((2 5 7) (6 3 4) (5 -2 -3)))))
	(fiveam:is (equal '((-2 1) (3/2 -1/2)) (inverse-mtrx '((1 2) (3 4)))))
	(fiveam:is (null (inverse-mtrx '((1 2 3) (4 5 6)(7 8 9))))))

(fiveam:run! 'Test-inverse-mtrx)

(fiveam:test Test-mul-matrix
	"Test-mul-mtrx"
	(fiveam:is (equal '((138 179) (73 172)) (mtrx-mul '((7 8)(2 9)) `(()())))))
	; (fiveam:is (null (inverse-mtrx '((1 2 3) (4 5 6)(7 8 9))))))
(fiveam:run! 'Test-mul-matrix)




;fiveam
(ql:quickload "fiveam")

(fiveam:test Test-inverse-mtrx-arr
	"Test-inverse-mtrx-arr"
	(fiveam:is (equalp (make-2d-arr '((1 -1 1) (-38 41 -34) (27 -29 24))) (inverse-mtrx-arr (make-2d-arr '((2 5 7) (6 3 4) (5 -2 -3))))))
	(fiveam:is (equalp (make-2d-arr '((-2 1) (3/2 -1/2))) (inverse-mtrx-arr (make-2d-arr '((1 2) (3 4))))))
	(fiveam:is (null (inverse-mtrx-arr (make-2d-arr '((1 2 3) (4 5 6)(7 8 9)))))))

(fiveam:run! 'Test-inverse-mtrx-arr)