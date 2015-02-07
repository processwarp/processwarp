; ModuleID = 'test_rounding.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%.1f \00", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.str3 = private unnamed_addr constant [15 x i8] c"%f = %f + %f \0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %intpart = alloca double, align 8
  %1 = tail call double @round(double 1.400000e+00) #4
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %1)
  %3 = tail call double @round(double 1.600000e+00) #4
  %4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %3)
  %5 = tail call double @round(double -1.400000e+00) #4
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %5)
  %7 = tail call double @round(double -1.600000e+00) #4
  %8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %7)
  %9 = tail call double @round(double 1.500000e+00) #4
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %9)
  %11 = tail call double @round(double 2.500000e+00) #4
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %11)
  %13 = tail call double @round(double -1.500000e+00) #4
  %14 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %13)
  %15 = tail call double @round(double -2.500000e+00) #4
  %16 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %15)
  %17 = tail call i64 @lrint(double 1.400000e+00) #3
  %18 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %17)
  %19 = tail call i64 @lrint(double 1.600000e+00) #3
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %19)
  %21 = tail call i64 @lrint(double -1.400000e+00) #3
  %22 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %21)
  %23 = tail call i64 @lrint(double -1.600000e+00) #3
  %24 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %23)
  %25 = tail call i64 @lrint(double 1.500000e+00) #3
  %26 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %25)
  %27 = tail call i64 @lrint(double 2.500000e+00) #3
  %28 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %27)
  %29 = tail call i64 @lrint(double -1.500000e+00) #3
  %30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %29)
  %31 = tail call i64 @lrint(double -2.500000e+00) #3
  %32 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i64 %31)
  %putchar = tail call i32 @putchar(i32 10)
  %33 = call double @modf(double 0x400921FB53C8D4F1, double* %intpart) #3
  %34 = load double* %intpart, align 8, !tbaa !1
  %35 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), double 0x400921FB53C8D4F1, double %34, double %33)
  %36 = call double @modf(double 0xC00921FB53C8D4F1, double* %intpart) #3
  %37 = load double* %intpart, align 8, !tbaa !1
  %38 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), double 0xC00921FB53C8D4F1, double %37, double %36)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readnone
declare double @round(double) #2

; Function Attrs: nounwind
declare i64 @lrint(double) #1

; Function Attrs: nounwind
declare double @modf(double, double* nocapture) #1

; Function Attrs: nounwind
declare i32 @putchar(i32) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"double", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
