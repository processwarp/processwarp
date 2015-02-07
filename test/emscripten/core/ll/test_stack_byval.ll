; ModuleID = 'test_stack_byval.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"sum:%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  br label %.preheader

.preheader:                                       ; preds = %25, %0
  %indvars.iv13 = phi i64 [ 0, %0 ], [ %indvars.iv.next14, %25 ]
  %total.012 = phi i32 [ 0, %0 ], [ %24, %25 ]
  %1 = trunc i64 %indvars.iv13 to i32
  %2 = srem i32 %1, 10
  %3 = srem i32 %1, 255
  %4 = srem i32 %1, 120
  br label %5

; <label>:5                                       ; preds = %5, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %5 ]
  %total.110 = phi i32 [ %total.012, %.preheader ], [ %24, %5 ]
  %6 = shl nsw i64 %indvars.iv, 1
  %7 = shl i64 %indvars.iv, 33
  %8 = trunc i64 %indvars.iv to i32
  %9 = srem i32 %8, 255
  %10 = zext i32 %9 to i64
  %11 = shl nuw i64 %10, 32
  %12 = or i64 %11, %6
  %13 = add i64 %12, %7
  %14 = lshr i64 %13, 32
  %15 = trunc i64 %14 to i32
  %16 = add i64 %6, %indvars.iv13
  %17 = trunc i64 %16 to i32
  %18 = add i32 %17, %2
  %19 = add i32 %18, %3
  %20 = add i32 %19, %4
  %21 = add i32 %20, %15
  %22 = srem i32 %21, 100
  %23 = add nsw i32 %22, %total.110
  %24 = srem i32 %23, 10240
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %25, label %5

; <label>:25                                      ; preds = %5
  %indvars.iv.next14 = add nuw nsw i64 %indvars.iv13, 1
  %exitcond15 = icmp eq i64 %indvars.iv.next14, 1000
  br i1 %exitcond15, label %26, label %.preheader

; <label>:26                                      ; preds = %25
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %24)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
