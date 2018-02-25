# adafruit-wisdom.el

Pulls a random quote from adafruit.com and displays it. 

[![MELPA Stable](https://stable.melpa.org/packages/adafruit-wisdom-badge.svg)](https://stable.melpa.org/#/adafruit-wisdom)
[![MELPA](https://melpa.org/packages/adafruit-wisdom-badge.svg)](https://melpa.org/#/adafruit-wisdom)
[![CircleCI](https://img.shields.io/circleci/project/github/gonewest818/adafruit-wisdom.el.svg)](https://circleci.com/gh/gonewest818/adafruit-wisdom.el)
[![codecov](https://codecov.io/gh/gonewest818/adafruit-wisdom.el/branch/master/graph/badge.svg)](https://codecov.io/gh/gonewest818/adafruit-wisdom.el)

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

