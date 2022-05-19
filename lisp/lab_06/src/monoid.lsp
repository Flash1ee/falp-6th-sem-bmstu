(defclass my-monoid ()
  ((value :initarg :value
          :initform (error "you didn't supply an initial value for slot value")
          :accessor get-value)))
(defgeneric mul (l r)
  (:documentation "monoid multiplication"))

(defgeneric get-one (some-value)
  (:documentation "get one element by any value of the same type"))

(defmethod print-object ((obj my-monoid) stream)
  (print-unreadable-object (obj stream :type t)
                           (with-accessors ((value get-value))
                                           obj
                                           (format stream "value: ~a" value))))

(defclass monoid-wr-bool (my-monoid)
  ())

(defun make-monoid-wr-bool (value)
  (cond ((or (eq value T) (eq value Nil))
         (make-instance 'monoid-wr-bool :value value))
        (T (error "Impossible to create monoid wrapper"))))

(defmethod mul ((l monoid-wr-bool) (r monoid-wr-bool))
  (make-monoid-wr-bool (and (get-value l) (get-value r))))

(defmethod get-one ((some-value monoid-wr-bool))
  (make-monoid-wr-bool T))

(defclass monoid-wr-list (my-monoid)
  ())

(defun make-monoid-wr-list (value)
  (cond ((listp value)
         (make-instance 'monoid-wr-list :value value))
        (T (error "Impossible to create monoid wrapper"))))

(defmethod mul ((l monoid-wr-list) (r monoid-wr-list))
  (make-monoid-wr-list (append (get-value l) (get-value r))))

(defmethod get-one ((some-value monoid-wr-list))
  (make-monoid-wr-list Nil))
