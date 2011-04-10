(in-package :quicktwiml)

;; <?xml version="1.0" encoding="UTF-8"?>
;; <!-- page located at http://example.com/complex_gather.xml -->
;; <Response>
;;     <Gather action="/process_gather.php" method="GET">
;;         <Say>
;;             Please enter your account number, 
;;             followed by the pound sign
;;         </Say>
;;     </Gather>
;;     <Say>We didn't receive any input. Goodbye!</Say>
;; </Response>

(with-output-to-string (stream)
  (with-response (stream)
    (gather '(("action" "/process_gather.php")
              ("method" "GET"))
            (say "Please enter your account number, followed by the pound sign"))
    (say "We did not receive any input. Good bye!")))



(with-output-to-string (s)
  (quicktwiml:with-response (s)
    (say "Please say your message after beep")
    (record '(("action"  "http://ec2-com//receive-call")
              ("method"  "POST")
              ("maxLength"  "20")
              ("finishOnKey"  "#")))))