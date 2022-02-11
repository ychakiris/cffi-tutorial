;;;; cffi-tutorial.asd

(asdf:defsystem #:cffi-tutorial
  :description "Describe cffi-tutorial here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "curl-h")
               (:file "cffi-tutorial"))
  :depends-on (:cffi))
