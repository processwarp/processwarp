; ModuleID = 'test_erf.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [42 x i8] c"%1.6f, %1.6f, %1.6f, %1.6f, %1.6f, %1.6f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = tail call double @erf(double 1.000000e+00) #2
  %2 = tail call double @erf(double 3.000000e+00) #2
  %3 = tail call double @erf(double -1.000000e+00) #2
  %4 = tail call double @erfc(double 1.000000e+00) #2
  %5 = tail call double @erfc(double 3.000000e+00) #2
  %6 = tail call double @erfc(double -1.500000e+00) #2
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str, i64 0, i64 0), double %1, double %2, double %3, double %4, double %5, double %6)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare double @erf(double) #1

; Function Attrs: nounwind
declare double @erfc(double) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
