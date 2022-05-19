(defun wrong-count-stones ()(
	format t "Количество камней в лунке не может быть отрицательным:(~% Пожалуйста, повторите попытку...~%"
	(finish-output)
))

(defun input_stone (ind)
	(format t "Введите количество камней в лунке №~A:~%" ind)
	(finish-output)
	(let ((stones (read)))
	(cond ((< stones 0) (progn (wrong-count-stones) (input_stone ind)))
		  (t stones)))
)

(defun make-circle-lst (ind size lst_begin)
	(cond
	((zerop size) (cons (cons 'H 0) lst_begin))

	((zerop ind)
		(let ((head (cons (cons ind (input_stone (+ ind 1))) nil)))
		(nconc head (make-circle-lst (+ ind 1) (- size 1) head))))
	(t (cons (cons ind (input_stone (+ ind 1))) (make-circle-lst (+ ind 1) (- size 1) lst_begin)))))

(defun find_pos (lst ind)
	(if (zerop ind)
		lst
		(find_pos (cdr lst) (- ind 1))
	)
)

(defun create_empty_stack (len)
	(cons (+ len 1) nil))

(defun is_empty_stack (stack)
	(not (cdr stack)))

(defun push_move (stack)
	(let ((substack (cons nil (cdr stack))))
	(setf (cdr stack) substack)
	stack))

(defun pop_move (stack) 
	(let ((current (cdr stack)))
	(setf (cdr stack) (cdr current))
	(car current)))


(defun push_value (stack index cnt)
	(let ((new (cons (cons index cnt) nil)))
	(setf (cdr new) (cadr stack))
	(setf (cadr stack) new)))

(defun pop_value (substack)
	(cond
	((eql (cdr substack) nil)
		nil)
	(t
		(let ((current (cdr substack)))
		(setf (cdr substack) (cdr current))
		(setf (cdr current) nil)
		current))))

(defun get-prev-lst (lst_begin stack)
	(find_pos lst_begin (caar (last (cadr stack)))))

(defun reverse_substacks (stack)
	(cond
	((null stack) nil)
	(t 
		(progn
			(setf (car stack) (reverse (car stack)))
			(reverse_substacks (cdr stack))
			stack))))

(defun reverse_stack (stack)
	(reverse (reverse_substacks (cdr stack))))


(defun op_next_n_values1 (lst n op)
	(cond 
	((= n 1)
		(progn
		(setf (cdar lst) (apply op `(,(cdar lst) 1)))
		lst))
	(t
		(progn
		(setf (cdar lst) (apply op `(,(cdar lst) 1)))
		(op_next_n_values1 (cdr lst) (- n 1) op)))))

(defun op_next_n_values (lst n op) (op_next_n_values1 (cdr lst) n op))

(defun reset_step1 (lst index count)
		(progn
		(op_next_n_values (find_pos lst index) count '-)
		(setf (cdar (find_pos lst index)) count)
		lst)
)
(defun reset_step (lst ind_cnt) 
	(reset_step1 lst (car ind_cnt) (cdr ind_cnt)))


(defun reset_move (lst_begin stack)
	(reduce #'reset_step (pop_move stack) :initial-value lst_begin)
)

(defun set_step (stack lst)
	(let ((ind (caar lst)) (val (cdar lst)) (tmp_lst nil))
	(setf tmp_lst (find_pos lst val))
	(cond 
	((eql ind 'H) t)
	((or (and (> (car stack) val) (not (eql (caar tmp_lst) 'H)) (zerop (cdar tmp_lst))) (eql val (car stack))) nil)
	(t
		(let ()
		(push_value stack ind val)
		(setf (cdar lst) 0)
		(set_step stack (op_next_n_values lst val '+)))))))


(defun set_move (lst stack)
	(set_step (push_move stack) lst)
)


(defun is_win (lst)
	(cond 
	((eql (caar lst) 'H)
		nil)
	((not (zerop (cdar lst)))
		lst)
	(t
		(is_win (cdr lst)))))


(defun game_logic (lst stack lst_begin)
	(let ((res_lst (is_win lst_begin))(main_lst (is_win lst)))
	(cond 
	((null res_lst) ;Победа?
		stack)
	((null main_lst) ;Проигрыш?
		(cond 
		((is_empty_stack stack)
			nil) ;Проигрыш
		(t (game_logic (cdr (get-prev-lst lst_begin stack)) stack (reset_move lst_begin stack)))))
	(t (let ((move_result (set_move main_lst stack))) 
		(cond
		((null move_result)
			(game_logic (cdr main_lst) stack (reset_move lst_begin stack)))
		(t (game_logic lst_begin stack lst_begin)))))))) 

(defun print-substack (substack ind)(
	cond ((null substack) ind)
		 (t (progn (format t "Ход №~A (обязательный): ~A~%" ind (+ (caar substack) 1)) (print-substack (cdr substack) (+ ind 1)) ))
))


(defun print-stack (stack ind)
	(cond 
		((null stack) t)
		(t (progn (format t "Ход №~A  (выбор лунки): ~A~%" ind (+ (caaar stack) 1)) (print-stack (cdr stack) (print-substack (cdar stack) (+ ind 1)))))
	)
)

(defun nice-print (stack ind)
	(cond ((null stack) (format t "Тактики не было найдено!"))
		(t (progn (format t "Найденная тактика выигрыша:~%") (print-stack stack ind))))
)

(defun rebuilt-desk (lst)(
	cond ((eql (caar lst) 'H) (cons (cons 0 nil) nil))
		 (t (cons (cdar lst) (rebuilt-desk (cdr lst))))
))

(defun start_game (n)
	(cond ((< n 0) (format t "Невозможно создать доску, так как количество лунок не может быть отрицательным!"))
	(t (let ((stack (create_empty_stack n)) (new_lst (make-circle-lst 0 n nil)))
	(format t "Начальное состояние доски: ~%~A~%~%" (rebuilt-desk new_lst))
	(nice-print (reverse_stack (game_logic new_lst stack new_lst)) 1)))))