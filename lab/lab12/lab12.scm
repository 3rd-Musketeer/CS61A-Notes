
(define-macro (def func args body)
    (list 'define (cons func args) body)
)

(define (square x) (* x x))
(define (add-one x) (+ x 1))
(define (double x) (* x 2))


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
    (cons-stream 3 (map-stream (lambda (x) (+ x 3)) all-three-multiples))
)


(define (compose-all funcs)
    (define (helper f res)
        (if (null? f)
            res
            (helper (cdr f) 
                (lambda (x) ((car f) (res x)))
            )
        )
    )
    (helper funcs (lambda (x) x))
)
(define composed (compose-all (list double square add-one)))

(define (partial-sums stream)
    (define (helper res lst)
        (if (null? lst)
            nil
            (cons-stream (+ res (car lst)) (map-stream (lambda (x) (+ x (car lst)))(helper res (cdr-stream lst))))
        )
            )
    (helper 0 stream)
)

(define (filter-stream f s)
    (if (null? s)
        nil
        (if (f (car s))
            (cons-stream (car s) (filter-stream f (cdr-stream s)))
            (filter-stream f (cdr-stream s))
        )
    )
)

(define ones (cons-stream 1 ones))

(define (show-n n s) 
    (if (or (= n 0) (null? s))
        nil
        (cons (car s) (show-n (- n 1) (cdr-stream s)))
    )
)

(define (add-stream a b) 
    (cond
        ((and (null? a) (null? b)) nil)
        ((null? a) (cons-stream (car a) (add-stream (cdr-stream a)(cdr-stream b))))
        ((null? b) (cons-stream (car b) (add-stream (cdr-stream a)(cdr-stream b))))
        (else (cons-stream (+ (car a) (car b)) (add-stream (cdr-stream a)(cdr-stream b))))
    )
)

(define naturals (cons-stream 1 (add-stream ones naturals)))

(define (naturals-from n) (cons-stream n (add-stream ones (naturals-from n))))

(define odd (filter-stream (lambda (x) (= (remainder x 2) 1)) naturals))

(define (primes n)
    (define (helper s)
        (if (or (null? s) (> (car s) n))
            nil
            (cons-stream 
                (car s)
                (helper
                    (filter-stream
                        (lambda (x) (< 0 (remainder x (car s))))
                        s
                    )
                )
            )
        )
    )
    (helper (naturals-from 2))
)
