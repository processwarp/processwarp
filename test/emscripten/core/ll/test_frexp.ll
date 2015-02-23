; ModuleID = 'test_frexp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"%f=%f*2^%d\0A\00", align 1
@.str1 = private unnamed_addr constant [29 x i8] c"fabs(expected - value) < tol\00", align 1
@.str2 = private unnamed_addr constant [13 x i8] c"test_frexp.c\00", align 1
@__PRETTY_FUNCTION__.test_value = private unnamed_addr constant [24 x i8] c"void test_value(double)\00", align 1
@.str3 = private unnamed_addr constant [43 x i8] c"x == 0 || (fabs(x) >= 5e-1 && fabs(x) < 1)\00", align 1

; Function Attrs: nounwind uwtable
define void @test_value(double %value) #0 {
  %exponent = alloca i32, align 4
  %1 = call double @frexp(double %value, i32* %exponent) #4
  %2 = load i32* %exponent, align 4, !tbaa !1
  %3 = tail call double @ldexp(double 1.000000e+00, i32 %2) #4
  %4 = fmul double %1, %3
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), double %value, double %1, i32 %2) #4
  %6 = fsub double %4, %value
  %7 = tail call double @fabs(double %6) #5
  %8 = fcmp olt double %7, 1.000000e-16
  br i1 %8, label %10, label %9

; <label>:9                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([29 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8]* @.str2, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([24 x i8]* @__PRETTY_FUNCTION__.test_value, i64 0, i64 0)) #6
  unreachable

; <label>:10                                      ; preds = %0
  %11 = fcmp oeq double %1, 0.000000e+00
  br i1 %11, label %17, label %12

; <label>:12                                      ; preds = %10
  %13 = tail call double @fabs(double %1) #5
  %14 = fcmp oge double %13, 5.000000e-01
  %15 = fcmp olt double %13, 1.000000e+00
  %or.cond = and i1 %14, %15
  br i1 %or.cond, label %17, label %16

; <label>:16                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([43 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8]* @.str2, i64 0, i64 0), i32 15, i8* getelementptr inbounds ([24 x i8]* @__PRETTY_FUNCTION__.test_value, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %12, %10
  ret void
}

; Function Attrs: nounwind
declare double @frexp(double, i32* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readnone
declare double @fabs(double) #2

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  tail call void @test_value(double 0.000000e+00)
  tail call void @test_value(double 1.001000e+02)
  tail call void @test_value(double -1.001000e+02)
  tail call void @test_value(double 5.000000e-01)
  tail call void @test_value(double -5.000000e-01)
  tail call void @test_value(double 0x3FEFFFFFFFFFFFFF)
  tail call void @test_value(double 0xBFEFFFFFFFFFFFFF)
  ret i32 0
}

declare double @ldexp(double, i32)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readnone }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
