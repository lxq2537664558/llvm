; RUN: opt < %s -basicaa -slp-vectorizer -dce -S -mtriple=i386-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

;CHECK: @foo
;CHECK: load <2 x double>
;CHECK: ret
define double @foo(double* nocapture %D) {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %i.02 = phi i32 [ 0, %0 ], [ %10, %1 ]
  %sum.01 = phi double [ 0.000000e+00, %0 ], [ %9, %1 ]
  %2 = shl nsw i32 %i.02, 1
  %3 = getelementptr inbounds double* %D, i32 %2
  %4 = load double* %3, align 4
  %A4 = fmul double %4, %4
  %5 = or i32 %2, 1
  %6 = getelementptr inbounds double* %D, i32 %5
  %7 = load double* %6, align 4
  %A7 = fmul double %7, %7
  %8 = fadd double %A4, %A7
  %9 = fadd double %sum.01, %8
  %10 = add nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %10, 100
  br i1 %exitcond, label %11, label %1

; <label>:11                                      ; preds = %1
  ret double %9
}

