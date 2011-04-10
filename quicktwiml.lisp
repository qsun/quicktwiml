;;;; quicktwiml.lisp

(in-package #:quicktwiml)

;;; "quicktwiml" goes here. Hacks and glory await!

(defmacro with-response ((stream) &body body)
  (let ((expanded-actions (mapcar #'expand-action-list body)))
    `(xml-emitter:with-xml-output (,stream)
       (xml-emitter:with-tag ("Response")
         ,@expanded-actions))))

;; (expand-action-list '(gather '(("action"  "/process_gather.php")
;;                                 ("method" "GET"))
;;                        (say "first")
;;                        (say "second")))

;; (expand-action-list '(say "123"))

;; (expand-action-list '(record '(("action"  "http://ec2-175-41-199-117.ap-northeast-1.compute.amazonaws.com/asf123x/receive-call")
;;                                ("method"  "POST")
;;                                ("maxLength"  "20")
;;                                ("finishOnKey"  "#"))))

(defun expand-action-list (action-list)
  (multiple-value-bind (action parameters nested-actions)
      (let ((action (string-capitalize (string-downcase (symbol-name (car action-list)))))
            (remainings (cdr action-list)))
        (cond ((>= (length remainings) 2)
               (values action (car remainings) (mapcar #'expand-action-list (cdr remainings))))
              ((listp (car remainings))
               (values action (car remainings) nil))
              (t
               (values action nil `((xml-emitter:xml-out ,(car remainings)))))))
    `(xml-emitter:with-tag (,action ,parameters)
       ,@nested-actions)))
    
