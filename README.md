quicktwiml is a quick common lisp wrapper for twilio ml.

Example:
    (with-output-to-string (stream)
               (quicktwiml:with-response (stream)
                   (gather '(("action" "/process_gather.php")
                           ("method" "GET"))
                         (say "Please enter your account number, followed by the pound sign"))
                 (say "We did not receive any input. Good bye!")))
             
Output:
    "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
    <Response>
        <Gather action=\"/process_gather.php\" method=\"GET\">
            <Say>
                Please enter your account number, followed by the pound sign
            </Say>
        </Gather>
        <Say>
            We did not receive any input. Good bye!
        </Say>
    </Response>"
