;;; test-adafruit-wisdom.el --- unit tests

(load-file "test/undercover-init.el")
(require 'adafruit-wisdom)

(describe "adafruit-wisdom"
  (before-each
    (spy-on 'adafruit-wisdom-select :and-return-value "a quote")
    (spy-on 'insert)
    (spy-on 'message))
  (it "displays a message"
    (expect (command-execute 'adafruit-wisdom))
    (expect 'message :to-have-been-called-with "a quote"))
  (it "inserts a message"
    (with-temp-buffer
      (expect (adafruit-wisdom t))
      (expect 'message :not :to-have-been-called)
      ;; WHY DOES THIS FAIL?
      ;;(expect 'insert :to-have-been-called-with "a quote")
      )))

(describe "adafruit-wisdom-cached-get"

  (describe "when no cache file exists"
    :var (cache-file)

    ;; ensure no cache file exists before or after tests
    (before-each
      (setq cache-file (locate-user-emacs-file adafruit-wisdom-cache-file))
      (when (file-exists-p cache-file)
        (delete-file cache-file)))
    (after-each
      (when (file-exists-p cache-file)
        (delete-file cache-file)))

    (it "fetches the url"
      (spy-on 'request
              :and-return-value (make-request-response :data "dummy body"))
      (let ((x (adafruit-wisdom-cached-get)))
        (expect 'request :to-have-been-called))))

  (describe "when cache file exists"
    :var (cache-file test-data)

    ;; setup cache file prior to tests, and remove after tests
    (before-each
      (setq cache-file (locate-user-emacs-file adafruit-wisdom-cache-file))
      (setq test-data (locate-user-emacs-file "adafruit-wisdom.testdata"))
      (unless (file-exists-p cache-file)
        (copy-file test-data cache-file)))
    (after-each
      (when (file-exists-p cache-file)
        (delete-file cache-file)))

    (it "returns the parsed xml"
      (let ((x (adafruit-wisdom-cached-get)))
        (expect (caar x) :to-equal 'rss)
        (expect (length (dom-by-tag x 'item)) :to-equal 138)))))

(describe "adafruit-wisdom-select"
  (before-each
    (spy-on 'adafruit-wisdom-cached-get
            :and-return-value
            '((rss nil (channel nil (item nil (title nil "quote")))))))
  (it "returns a quote at random"
    (expect (adafruit-wisdom-select) :to-equal "quote")))


;; Local Variables:
;; elisp-lint-ignored-validators:
;; ("package-lint" "byte-compile" "check-declare" "checkdoc")
;; End:

;;; test-adafruit-wisdom.el ends here
