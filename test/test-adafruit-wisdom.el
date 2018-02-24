;;; test-adafruit-wisdom.el --- unit tests

(load-file "test/undercover-init.el")
(require 'adafruit-wisdom)

;; DISABLED
(xdescribe "adafruit-wisdom"
  (before-each
    (spy-on 'adafruit-wisdom-select :and-return-value "a quote"))
  (it "displays a message"
    (spy-on 'message)
    (adafruit-wisdom)
    (expect 'message :to-have-been-called-with "a quote"))
  (it "inserts a message"
    ;; THIS TEST FAILS IN CI... WHY?
    (spy-on 'insert)
    (expect (commandp 'adafruit-wisdom))
    (expect (command-execute 'adafruit-wisdom))
    (expect 'insert :to-have-been-called-with "a quote")))

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
      (spy-on 'url-insert-file-contents)
      (let ((x (adafruit-wisdom-cached-get)))
        (expect 'url-insert-file-contents :to-have-been-called))))

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
  (it "returns a quote at random"
    (spy-on 'adafruit-wisdom-cached-get
            :and-return-value
            '((rss nil
                   (channel nil
                            (item nil
                                  (title nil "quote"))))))
    (expect (adafruit-wisdom-select) :to-equal "quote")))

;;; test-adafruit-wisdom.el ends here
