; ModuleID = 'test_llvmswitch.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"*%d,%d,%d,%d,%d,%d*\0A\00", align 1

; Function Attrs: nounwind readnone uwtable
define i32 @switcher(i32 %p) #0 {
  switch i32 %p, label %4 [
    i32 97, label %1
    i32 98, label %1
    i32 99, label %1
    i32 -15, label %3
  ]

; <label>:1                                       ; preds = %0, %0, %0
  %2 = add nsw i32 %p, -1
  br label %4

; <label>:3                                       ; preds = %0
  br label %4

; <label>:4                                       ; preds = %3, %1, %0
  %.0 = phi i32 [ -14, %3 ], [ %2, %1 ], [ %p, %0 ]
  ret i32 %.0
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #1 {
  %1 = add nsw i32 %argc, -1
  %2 = lshr i32 -15, %1
  switch i32 %2, label %switcher.exit [
    i32 97, label %3
    i32 98, label %3
    i32 99, label %3
    i32 -15, label %5
  ]

; <label>:3                                       ; preds = %0, %0, %0
  %4 = add nsw i32 %2, -1
  br label %switcher.exit

; <label>:5                                       ; preds = %0
  br label %switcher.exit

switcher.exit:                                    ; preds = %5, %3, %0
  %.0.i = phi i32 [ -14, %5 ], [ %4, %3 ], [ %2, %0 ]
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), i32 96, i32 97, i32 98, i32 %.0.i, i32 -14, i32 101) #3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
