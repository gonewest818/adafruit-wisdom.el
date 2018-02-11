;;; test-adafruit-wisdom.el --- unit tests

(require 'undercover-init)
(require 'adafruit-wisdom)

(describe "adafruit-wisdom"
  (spy-on 'adafruit-wisdom-select :and-return-value "a quote")
  (spy-on 'insert)
  (spy-on 'message)
  (it "displays a message"
    (adafruit-wisdom)
    (expect 'message :to-have-been-called-with "a quote"))
  (it "inserts a message"
    (adafruit-wisdom t)
    (expect 'insert :to-have-been-called-with "a quote")))

(describe "adafruit-wisdom-cached-get"

  (describe "checks for cache file"
    ;; ensure no cache file exists
    (before-each
      (let ((cache-file (locate-user-emacs-file adafruit-wisdom-cache-file)))
        (when (file-exists-p cache-file)
          (delete-file cache-file))))

    (spy-on 'url-insert-file-contents :and-call-through)

    (it "and gets url if needed"
      (let ((x (adafruit-wisdom-cached-get)))
        (expect 'url-insert-file-contents :to-have-been-called))))

  (describe "reads from cache if newer than TTL"
    ;; ensure we have a cache file newer than ttl
    (before-each
      (let ((cache-file (locate-user-emacs-file adafruit-wisdom-cache-file)))
        (unless (file-exists-p cache-file)
          (copy-file (locate-user-emacs-file "adafruit-wisdom.testdata")
                     (locate-user-emacs-file adafruit-wisdom-cache-file)))))
    ;; ... and remove afterward
    (after-each
      (let ((cache-file (locate-user-emacs-file adafruit-wisdom-cache-file)))
        (when (file-exists-p cache-file)
          (delete-file cache-file))))

    (it "and returns the parsed xml"
      (let ((x (adafruit-wisdom-cached-get)))
        (expect (caar x) :to-equal 'rss)
        (expect (length (dom-by-tag x 'item)) :to-equal 138)))))

;; DISABLED
;; See https://github.com/jorgenschaefer/emacs-buttercup/issues/122
(xdescribe "adafruit-wisdom-select"
  (spy-on 'adafruit-wisdom-cached-get
          :and-return-value '((rss (channel (item (title "quote"))))))
  (it "returns a quote at random"
    (expect (adafruit-wisdom-select) :to-equal "quote")))

;;; test-adafruit-widsom.el ends here
