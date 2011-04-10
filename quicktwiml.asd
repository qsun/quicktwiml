;;;; quicktwiml.asd

(asdf:defsystem #:quicktwiml
  :serial t
  :depends-on (#:xml-emitter)
  :components ((:file "package")
               (:file "quicktwiml")))

