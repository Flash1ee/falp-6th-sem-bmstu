(defvar mb1 (make-monoid-wr-bool t))
(defvar mb2 (make-monoid-wr-bool nil))
(format T "bool: t*nil = ~a~%" (mul mb1 mb2))
(format T "bool: one = ~a~%" (get-one mb2))

(defvar ml1 (make-monoid-wr-list '(1 2 3)))
(defvar ml2 (make-monoid-wr-list '(4 5 6)))
(format T "list: (1 2 3)*(4 5 6)= ~a~%" (mul ml1 ml2))
(format T "list: one = ~a~%" (get-one ml2))
