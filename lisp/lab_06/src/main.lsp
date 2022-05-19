

(defun minus-10 (lst)
  (mapcar (lambda (e) (if (numberp e) (- e 10) e)) lst))

(minus-10 '(1 2 3))
(minus-10 '(a b c))


(defun mult-all (lst n)
  (mapcar (lambda (e) (if (numberp e) (* e n) e)) lst))

(mult-all '(1 2 a) 10)

(defun mult-all-deep (lst n)
  (mapcar (lambda (e) (cond ((numberp e) (* e n))
			    ((listp e) (mult-all-deep e n))
			    (T e)))
	  lst))
(mult-all-deep '(1 2 (3 4) (5 (6 (7))) a b) 10)
			    

(defun my-reverse (lst)
  (reduce (lambda (res e) (cons e res)) lst :initial-value ()))

(defun palindromp (lst)
  (equal lst (my-reverse lst)))


(defun in-set (el lst)
  (reduce (lambda (a b) (or a b))
	  (mapcar (lambda (e) (equal el e)) lst)))

(defun my-subsetp (l1 l2)
  (reduce (lambda (a b) (and a b))
	  (mapcar (lambda (e) (in-set e l2)) l1)))

(defun set-equal (l1 l2)
  (and (my-subsetp l1 l2) (my-subsetp l2 l1)))

(set-equal '(1 2 3) '(3 1 2))
(set-equal '(1 2 3) '(1 2 3 4))


(defun sqr-lst (lst)
  (mapcar (lambda (e) (* e e)) lst))

(sqr-lst '(0 1 -2 3))


(defun select-between (lst n1 n2)
  (mapcan (lambda (e) (and (< n1 e n2) (list e)))
	  lst))

(select-between '(0 1 2 3 4) 0 3)

(defun select-between-sorted (lst n1 n2)
  (sort (select-between lst n1 n2) #'<))

(select-between-sorted '(0 3 1 2 4) 0 3)


(defun decart-mult (l1 l2)
  (mapcan (lambda (e1)
	    (mapcar (lambda (e2)
		      (list e1 e2))
		    l2))
	  l1))

(decart-mult '(0 1) '(2 3))

(defun sum-of-len (lst)
  (reduce (lambda (res e) (+ res (length e)))
	  lst
	  :initial-value 0))

(sum-of-len '((1 2) (3 4 5)))
