;;;; quicktwiml.lisp

(in-package #:quicktwiml)

;;; "quicktwiml" goes here. Hacks and glory await!

(defmacro with-response ((stream) &body body)
  (let ((expanded-actions (mapcar #'expand-action-list body)))
    `(xml-emitter:with-xml-output (,stream)
       (xml-emitter:with-tag ("Response")
         ,@expanded-actions))))

(expand-action-list '(gather '(("action"  "/process_gather.php")
                               ("method" "GET"))
                      (say "first")
                      (say "second")))

(expand-action-list '(say "123"))

(defun expand-action-list (action-list)
  (let ((action (string-capitalize (string-downcase (symbol-name (car action-list)))))
        (parameters (cond ((<= (length action-list) 2) nil)
                          (t (cadr action-list))))
        (nested-actions 
         (mapcar (lambda (action)
                   (if (listp action)
                       (expand-action-list action)
                       `(xml-emitter:xml-out ,action)))
                 (cond ((<= (length action-list) 2) (list (cadr action-list)))
                       (t (cddr action-list))))))
    `(xml-emitter:with-tag (,action ,parameters)
       ,@nested-actions)))