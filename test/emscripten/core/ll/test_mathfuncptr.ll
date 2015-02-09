; ModuleID = 'test_mathfuncptr.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [45 x i8] c"fn2(-5) = %d, fn(10) = %.2f, erf(10) = %.2f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = icmp ne i32 %argc, 12
  %2 = select i1 %1, float (float)* @sqrtf, float (float)* @fabsf
  %3 = icmp ne i32 %argc, 13
  %4 = select i1 %3, float (float)* @fabsf, float (float)* @sqrtf
  %5 = icmp ne i32 %argc, 14
  %6 = select i1 %5, float (float)* @erff, float (float)* @fabsf
  %7 = tail call float %4(float -5.000000e+00) #3
  %8 = fptosi float %7 to i32
  %9 = tail call float %2(float 1.000000e+01) #3
  %10 = fpext float %9 to double
  %11 = tail call float %6(float 1.000000e+01) #3
  %12 = fpext float %11 to double
  %13 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([45 x i8]* @.str, i64 0, i64 0), i32 %8, double %10, double %12) #3
  ret i32 0
}

; Function Attrs: nounwind
declare float @sqrtf(float) #1

; Function Attrs: nounwind readnone
declare float @fabsf(float) #2

; Function Attrs: nounwind
declare float @erff(float) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
