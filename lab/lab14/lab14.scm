(define (split-at lst n)
	(define (helper s n node)
		(if (null? s)
			(cond
			((>= n 0) (list node))
			(else node)
			)
			(cond 
				((= 0 n)
				(helper
					(cdr s)
					(- n 1)
					(list node (car s))
				))
				((> n 0)
				(helper
					(cdr s)
					(- n 1)
					(append node (list (car s)))
				))
				((< n 0)
				(helper
					(cdr s)
					(- n 1)
					(append node (list (car s)))	
				)
				)
			)
		)

	)
	(helper lst n nil)
)


(define-macro (switch expr cases)
	(cons 'cond
		(map (lambda (case) (cons (list 'eq? expr (list 'quote (car case))) (cdr case)))
    			cases))
)

