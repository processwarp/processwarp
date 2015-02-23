; ModuleID = 'test_stack_void.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@s = internal global [100 x i8] c"aaaaa\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 16
@.str1 = private unnamed_addr constant [13 x i8] c"iso open %s\0A\00", align 1
@str = private unnamed_addr constant [5 x i8] c".ok.\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  br label %1

; <label>:1                                       ; preds = %func.exit, %0
  %i.01 = phi i32 [ 0, %0 ], [ %6, %func.exit ]
  %2 = load i8* getelementptr inbounds ([100 x i8]* @s, i64 0, i64 0), align 16, !tbaa !1
  %3 = icmp eq i8 %2, 97
  br i1 %3, label %4, label %func.exit

; <label>:4                                       ; preds = %1
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([100 x i8]* @s, i64 0, i64 0), double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00, double 1.001000e+00) #2
  br label %func.exit

func.exit:                                        ; preds = %4, %1
  %6 = add nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %6, 5000
  br i1 %exitcond, label %7, label %1

; <label>:7                                       ; preds = %func.exit
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0))
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
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
