; ModuleID = 'test_i64_qdouble.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@str = private unnamed_addr constant [11 x i8] c"Succeeded!\00"
@str2 = private unnamed_addr constant [8 x i8] c"Failed!\00"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = add nsw i32 %argc, -112
  %2 = sitofp i32 %1 to double
  %3 = fadd double %2, 1.110000e+02
  %4 = fcmp olt double %3, -1.000000e+00
  %5 = fcmp ogt double %3, 1.000000e+00
  %or.cond = or i1 %4, %5
  br i1 %or.cond, label %6, label %7

; <label>:6                                       ; preds = %0
  %puts2 = tail call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @str2, i64 0, i64 0))
  br label %8

; <label>:7                                       ; preds = %0
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([11 x i8]* @str, i64 0, i64 0))
  br label %8

; <label>:8                                       ; preds = %7, %6
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
