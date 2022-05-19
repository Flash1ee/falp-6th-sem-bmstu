; 1
(defun palindromp (lst) (equal lst (reverse lst)))

(palindromp '(1 2))
(palindromp '(1 2 1))

; 2
(defun set-equal (l1 l2)
  (and (subsetp l1 l2) (subsetp l2 l1)))

(set-equal '(1 2 3) '(3 1 2))
(set-equal '(1 2 3) '(1 2 3 4))

; 3
(defun get-capital (country table)
  (cond ((equal (caar table) country) (cdar table))
  ((cdr table) (get-capital country (cdr table)))
  (T ())))

(defun get-country (capital table)
  (cond ((equal (cdar table) capital) (caar table))
  ((cdr table) (get-country capital (cdr table)))
  (T ())))

; 








; 4
(defun swap-first-last (lst)
  (if lst 
      (let ((first (car lst))
      (last (car (last lst))))
  (setf (car lst) last)
  (setf (car (last lst)) first)
  lst)))

(swap-first-last '(1 5 5 5 3))
(swap-first-last '(1))
(swap-first-last ())

; 5
(defun swap-two-element (lst n1 n2)
  (if (and lst (< n1 (length lst)) (< n2 (length lst)))
      (let ((n1th (nth n1 lst))
      (n2th (nth n2 lst)))
  (setf (nth n1 lst) n2th)
  (setf (nth n2 lst) n1th)
  lst)))

(swap-two-element '(0 1 2 3 4 5) 1 3)
(swap-two-element () 0 0 )
(swap-two-element '(0 1 2) 1 3)

; 6
(defun swap-to-left (lst)
  (if lst
      (progn
  (setf (cdr (last lst)) (cons (car lst) ()))
  (cdr lst))))

;
(defun swap-to-left (lst)
  (let ((first (car lst)))
    (reverse (cons first (reverse (cdr lst))))))

(swap-to-left '(0 1 2 3))
(swap-to-left '(1))
(swap-to-left ())

(defun swap-to-right (lst)
  (let ((last (car (last lst))))
    (reverse (cdr (reverse (cons last lst))))))
  

(swap-to-right '(0 1 2 3))
(swap-to-right '(1))
(swap-to-right ())

; 7
(defun add-2list (src lst)
  (cond ((not src) (setf src (cons lst ())))
  ((not (cdr src)) (setf (cdr src) (cons lst ())))
  ((equal (car src) lst))
  (T (add-2list (cdr src) lst)))
  src)

(add-2list '((1 2) (3 4) (5 6)) '(1 2))
(add-2list '() '(1 2))

; 8
(defun mult-first (lst n)
  (cons (* (car lst) n) (cdr lst)))

(mult-first '(3 2 1) 3)

(defun mult-first-all (lst n)
  (cond ((not lst) ())
  ((numberp (car lst)) (setf (car lst) (* (car lst) n)))
  (T (mult-first-all (cdr lst) n)))
  lst)

(mult-first-all '(3 2 1) 3)
(mult-first-all '(a 2 1) 3)
(mult-first-all '(a b) 3)
(mult-first-all () 3)

; 9
(defun select-between (lst n1 n2)
  (cond ((> n1 n2) (select-between lst n2 n1))
  ((or (>= n1 (length lst)) (>= n2 (length lst))) ())
  (T (reverse (nthcdr (- (length lst) n2 1) (reverse (nthcdr n1 lst)))))))

(select-between '(0 1 2 3 4) 0 3)
(select-between '(0 1 2 3 4) 3 0)
(select-between '(0 1 2 3 4) 3 3)
(select-between () 3 3)
(select-between '(0 1 2) 3 4)

(defun select-between-sorted (lst n1 n2)
  (sort (select-between lst n1 n2) #'<))

(select-between-sorted '(0 3 1 2 4) 0 3)