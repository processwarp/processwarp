; ModuleID = 'test_alloca_stack.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"ok:%d*\0A\00", align 1

; Function Attrs: nounwind readnone uwtable
define i32 @func(i32 %i) #0 {
  %1 = shl i32 %i, 24
  %sext = add i32 %1, 16777216
  %2 = ashr exact i32 %sext, 24
  %3 = srem i32 %2, 10
  ret i32 %3
}

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %i.02 = phi i32 [ 0, %0 ], [ %6, %1 ]
  %total.01 = phi i32 [ 0, %0 ], [ %5, %1 ]
  %2 = shl i32 %i.02, 24
  %sext.i = add i32 %2, 16777216
  %3 = ashr exact i32 %sext.i, 24
  %4 = srem i32 %3, 10
  %5 = add nsw i32 %4, %total.01
  %6 = add nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %6, 1048576
  br i1 %exitcond, label %7, label %1

; <label>:7                                       ; preds = %1
  %8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 %5) #3
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
