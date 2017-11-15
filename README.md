# adafruit-wisdom.el

Pulls a random quote from adafruit.com and displays it. 

[![MELPA](https://melpa.org/packages/adafruit-wisdom-badge.svg)](https://melpa.org/#/adafruit-wisdom)

## Description

I've always enjoyed the engineering quotes found at the footer of
each page on adafruit.com ... now you can too!  This code is
derived from Dave Pearson's dad-joke.el, except adafruit.com
publishes their quotes as rss so we have to deal with that.

## Usage

Display a random quote in the minibuffer

    M-x adafruit-wisdom

Insert a random quote into current buffer

    C-u M-x adafruit-wisdom

If you prefer invoking with a hotkey

    (global-set-key (kbd "C-c aw")  'adafruit-wisdom)

