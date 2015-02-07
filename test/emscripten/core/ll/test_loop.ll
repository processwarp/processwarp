; ModuleID = 'test_loop.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [6 x i8] c"*%d*\0A\00", align 1
@str = private unnamed_addr constant [6 x i8] c"cheez\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  br label %3

; <label>:1                                       ; preds = %3
  %2 = icmp slt i32 %7, 6
  br i1 %2, label %3, label %.loopexit

; <label>:3                                       ; preds = %1, %0
  %i.03 = phi i32 [ 0, %0 ], [ %7, %1 ]
  %x.02 = phi i32 [ 5, %0 ], [ %5, %1 ]
  %4 = mul nsw i32 %i.03, %x.02
  %5 = add nsw i32 %4, %x.02
  %6 = icmp sgt i32 %5, 1000
  %7 = add nsw i32 %i.03, 1
  br i1 %6, label %8, label %1

; <label>:8                                       ; preds = %3
  %9 = srem i32 %5, 7
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

; <label>:11                                      ; preds = %8
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str, i64 0, i64 0))
  br label %12

; <label>:12                                      ; preds = %11, %8
  %13 = sdiv i32 %5, 2
  br label %.loopexit

.loopexit:                                        ; preds = %12, %1
  %x.1 = phi i32 [ %13, %12 ], [ %5, %1 ]
  %14 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 %x.1)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
