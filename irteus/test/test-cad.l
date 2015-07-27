;; test code for euscad

(require :unittest "lib/llib/unittest.l")
(init-unit-test)

;; stl
(deftest read-write-stl
  (let* ((b0 (make-cube 100 100 100))
	 (tmpdir (format nil "/tmp/tmp~A" (unix::getpid)))
	 (tmpstl (format nil "~A/cube.stl" tmpdir)))
    (unix::mkdir tmpdir)
    (eus2stl tmpstl (body-to-faces b0) :scale 0.001)
    ;;
    (setq b1 (stl2eus tmpstl :scale 1000.0))
    
    (assert (eps-v= (v- (send (send b1 :box) :maxpoint) (send (send b1 :box) :minpoint)) #f(100 100 100) 3) "check cube size")
    ))

;; wrl
(deftest read-write-wrl
  (let* ((b0 (make-cube 100 100 100))
	 (tmpdir (format nil "/tmp/tmp~A" (unix::getpid)))
	 (tmpwrl (format nil "~A/cube.wrl" tmpdir)))
    (unix::mkdir tmpdir)
    (send b0 :name "cube")
    (with-open-file (f tmpwrl :direction :output)
      (dump-object-to-wrl b0 f))
    ;;
    ))

(run-all-tests)
(exit)
