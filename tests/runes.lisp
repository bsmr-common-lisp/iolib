;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; indent-tabs-mode: nil -*-
;;;
;;; --- runes test suite.
;;;

(in-package :iolib-tests)

(in-suite :iolib.base.runes)


(test code-rune.1
  (is (= #x1234 (code-rune #x1234))))

(test code-rune.error.1
  (signals type-error
    (code-rune rune-code-limit)))


(test rune-code.1
  (is (= #x1234 (rune-code #x1234))))

(test rune-code.error.1
  (signals type-error
    (rune-code rune-code-limit)))


(test char-rune.1
  (is (= 49 (char-rune #\1))))


(test rune-char.1
  (is (char= #\1 (rune-char 49))))

(test rune-char.error.1
  (signals type-error
    (rune-char rune-code-limit)))


(test name-rune.1
  (is (= (char-rune #\space) (name-rune "Space"))))

(test name-rune.2
  (is (= #xD800 (name-rune "Non-Unicode rune #xD800"))))

(test name-rune.error.1
  (is-false (name-rune "This is not a rune name")))


(test rune-name.1
  (is (string-equal "Space" (rune-name (char-rune #\space)))))

(test rune-name.2
  (is (string-equal "Non-Unicode rune #xD800"
                    (rune-name #xD800))))


(test digit-rune.1
  (is (= 9 (digit-rune 9))))

(test digit-rune.2
  (is (loop :for i :below 16 :always (digit-rune i 16))))

(test digit-rune.error.1
  (is-false (digit-rune 16 16)))


(test rune.1
  (is (= 9 (rune 9))))

(test rune.2
  (is (= 9 (rune (make-array 1 :element-type 'rune :initial-element 9)))))

(test rune.3
  (is (= 65 (rune #\A))))

(test rune.4
  (is (= 65 (rune "A"))))

(test rune.5
  (is (= 65 (rune 'a))))

(test rune.error.1
  (signals type-error
    (rune rune-code-limit)))

(test rune.error.2
  (signals type-error
    (rune -1)))

(test rune.error.3
  (signals type-error
    (rune (make-array 2 :element-type 'rune :initial-element 9))))

(test rune.error.4
  (signals type-error
    (rune "FOO")))

(test rune.error.5
  (signals type-error
    (rune 'nil)))


(test runep.1
  (is-true (runep 0)))

(test runep.2
  (is-true (runep (1- rune-code-limit))))

(test runep.3
  (is-false (runep -1)))

(test runep.4
  (is-false (runep rune-code-limit)))

(test runep.5
  (is-false (runep #\a)))

(test runep.6
  (is-true (runep "string")))