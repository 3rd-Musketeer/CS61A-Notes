(define (rle s)
	(define (helper s node)
		(if (null? s)
			(cons-stream node nil)
			(begin
				(if (and (not (null? node)) (= (car node) (car s)))
					(helper (cdr-stream s) (list (car node) (+ 1 (car (cdr node)))))
					(cons-stream 
						node 
						(helper (cdr-stream s)
							(list (car s) 1)
						)
					)
				)
			)




		)
	)
	(cdr-stream (helper s nil))
)


(define s (cons-stream 1 (cons-stream 1 (cons-stream 2 nil))))
(define encoding (rle s))


(define (group-by-nondecreasing s)
	(define (helper s node last)
		(begin
			(if (null? s)
				(cons-stream node nil)
				(if (and (not (null? last)) (>= (car s) last))
					(helper
						(cdr-stream s)
						(append node (list (car s)))
						(car s)
					)
					(cons-stream
						node
						(helper
							(cdr-stream s)
							(list (car s))
							(car s)
						)
					)
				)
			)


		)


	)
	(cdr-stream (helper s nil nil))
)


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

