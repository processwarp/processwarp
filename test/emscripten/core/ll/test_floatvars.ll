; ModuleID = 'test_floatvars.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [27 x i8] c"*%d,%d,%.1f,%d,%.4f,%.2f*\0A\00", align 1
@.str1 = private unnamed_addr constant [24 x i8] c"%.2f, %.2f, %.2f, %.2f\0A\00", align 1
@.str2 = private unnamed_addr constant [14 x i8] c"small: %.10f\0A\00", align 1
@.str3 = private unnamed_addr constant [12 x i8] c"double: %f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str, i64 0, i64 0), i32 1, i32 10, double 1.050000e+01, i32 1, double 0x3FF3BE76C0000000, double 0x3E45798EE0000000) #3
  %2 = tail call double @fmin(double 5.000000e-01, double 3.300000e+00) #4
  %3 = tail call double @fmin(double 0x7FF8000000000000, double 3.300000e+00) #4
  %4 = tail call double @fmax(double 5.000000e-01, double 3.300000e+00) #4
  %5 = tail call double @fmax(double 0x7FF8000000000000, double 3.300000e+00) #4
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str1, i64 0, i64 0), double %2, double %3, double %4, double %5) #3
  %7 = sitofp i32 %argc to double
  %8 = fmul double %7, 1.000000e-06
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str2, i64 0, i64 0), double %8) #3
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), double 0x444E738C26A386EB) #3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readnone
declare double @fmin(double, double) #2

; Function Attrs: nounwind readnone
declare double @fmax(double, double) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
