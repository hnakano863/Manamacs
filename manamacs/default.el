;;; default.el --- Manamacs' default.el -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Hiroshi Nakano

;; Author: Hiroshi Nakano <notchi863@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Manamacs' default.el.

;;; Code:

;; initialize package
(require 'package)
(package-initialize 'noactivate)
(eval-when-compile
  (require 'use-package))

;; evil
(use-package evil
  :custom
  (evil-want-C-u-scroll . t)
  :config
  (evil-mode t))

;; doom-themes
