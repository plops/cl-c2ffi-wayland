
(eval-when (:compile-toplevel)
  (ql:quickload :cl-autowrap)
  (ql:quickload :rutilsx))
(defpackage :wl
  (:use  :cl #:autowrap #:rutil #:rutilsx
	 #:rutilsx.threading))
(in-package :wl)
(named-readtables:in-readtable rutils-readtable)

(eval-always
 (defpar *spec-path* (merge-pathnames
		      "stage/cl-c2ffi-wayland/"
		      (user-homedir-pathname))))

(autowrap:c-include "/usr/include/wayland-client.h"
		    :spec-path *spec-path*
		    :exclude-arch ("arm-pc-linux-gnu"
				   "i386-unknown-freebsd"
				   "i686-apple-darwin9"
				   "i686-pc-linux-gnu"
				   "i686-pc-windows-msvc"
				   "x86_64-apple-darwin9"
					;"x86_64-pc-linux-gnu"
				   "x86_64-pc-windows-msvc"
				   "x86_64-unknown-freebsd")
		    :exclude-sources ("/usr/include/"
				      "/usr/include/bits/"
				      "/usr/include/sys/")
		    :include-sources ("/usr/include/wayland-client-core.h"
				      "/usr/include/wayland-client-protocol.h"))

(cffi:use-foreign-library "libwayland-client.so")

;; example code from https://github.com/hdante/hello_wayland/helpers.c
#+nil
(defpar *display* (wl-display-connect (cffi:null-pointer)))

;; wl-display-get-registry is an inline function WHY?

#+nil
(defpar *registry*
    (wl-proxy-marshal-constructor *display* 
				  +WL-DISPLAY-GET-REGISTRY+
				  WL-REGISTRY-INTERFACE
				  ))
