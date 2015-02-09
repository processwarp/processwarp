; ModuleID = 'test_negative_zero.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"%.2f, %.2f ==> %.2f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = tail call double @copysign(double 5.000000e+00, double 5.000000e+00) #3
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 5.000000e+00, double 5.000000e+00, double %1) #4
  %3 = tail call double @copysign(double 5.000000e+00, double -5.000000e+00) #3
  %4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 5.000000e+00, double -5.000000e+00, double %3) #4
  %5 = tail call double @copysign(double -5.000000e+00, double 5.000000e+00) #3
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -5.000000e+00, double 5.000000e+00, double %5) #4
  %7 = tail call double @copysign(double -5.000000e+00, double -5.000000e+00) #3
  %8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -5.000000e+00, double -5.000000e+00, double %7) #4
  %9 = tail call double @copysign(double 5.000000e+00, double 4.000000e+00) #3
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 5.000000e+00, double 4.000000e+00, double %9) #4
  %11 = tail call double @copysign(double 5.000000e+00, double -4.000000e+00) #3
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 5.000000e+00, double -4.000000e+00, double %11) #4
  %13 = tail call double @copysign(double -5.000000e+00, double 4.000000e+00) #3
  %14 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -5.000000e+00, double 4.000000e+00, double %13) #4
  %15 = tail call double @copysign(double -5.000000e+00, double -4.000000e+00) #3
  %16 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -5.000000e+00, double -4.000000e+00, double %15) #4
  %17 = tail call double @copysign(double 0.000000e+00, double 5.000000e+00) #3
  %18 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 0.000000e+00, double 5.000000e+00, double %17) #4
  %19 = tail call double @copysign(double 0.000000e+00, double -5.000000e+00) #3
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 0.000000e+00, double -5.000000e+00, double %19) #4
  %21 = tail call double @copysign(double -0.000000e+00, double 5.000000e+00) #3
  %22 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -0.000000e+00, double 5.000000e+00, double %21) #4
  %23 = tail call double @copysign(double -0.000000e+00, double -5.000000e+00) #3
  %24 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -0.000000e+00, double -5.000000e+00, double %23) #4
  %25 = tail call double @copysign(double 5.000000e+00, double 0.000000e+00) #3
  %26 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 5.000000e+00, double 0.000000e+00, double %25) #4
  %27 = tail call double @copysign(double 5.000000e+00, double -0.000000e+00) #3
  %28 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 5.000000e+00, double -0.000000e+00, double %27) #4
  %29 = tail call double @copysign(double -5.000000e+00, double 0.000000e+00) #3
  %30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -5.000000e+00, double 0.000000e+00, double %29) #4
  %31 = tail call double @copysign(double -5.000000e+00, double -0.000000e+00) #3
  %32 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -5.000000e+00, double -0.000000e+00, double %31) #4
  %33 = tail call double @copysign(double 0.000000e+00, double 0.000000e+00) #3
  %34 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 0.000000e+00, double 0.000000e+00, double %33) #4
  %35 = tail call double @copysign(double 0.000000e+00, double -0.000000e+00) #3
  %36 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double 0.000000e+00, double -0.000000e+00, double %35) #4
  %37 = tail call double @copysign(double -0.000000e+00, double 0.000000e+00) #3
  %38 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -0.000000e+00, double 0.000000e+00, double %37) #4
  %39 = tail call double @copysign(double -0.000000e+00, double -0.000000e+00) #3
  %40 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), double -0.000000e+00, double -0.000000e+00, double %39) #4
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readnone
declare double @copysign(double, double) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
