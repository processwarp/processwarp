; ModuleID = 'test_globaldoubles.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@testVu = common global double 0.000000e+00, align 8
@testVv = common global double 0.000000e+00, align 8
@testWu = common global double 0.000000e+00, align 8
@testWv = common global double 0.000000e+00, align 8
@.str1 = private unnamed_addr constant [37 x i8] c"Display: Vu=%f  Vv=%f  Wu=%f  Wv=%f\0A\00", align 1
@str = private unnamed_addr constant [5 x i8] c"BUG?\00"

; Function Attrs: nounwind uwtable
define void @Test(double %_testVu, double %_testVv, double %_testWu, double %_testWv) #0 {
  store double %_testVu, double* @testVu, align 8, !tbaa !1
  store double %_testVv, double* @testVv, align 8, !tbaa !1
  store double %_testWu, double* @testWu, align 8, !tbaa !1
  store double %_testWv, double* @testWv, align 8, !tbaa !1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0))
  %1 = load double* @testVu, align 8, !tbaa !1
  %2 = load double* @testVv, align 8, !tbaa !1
  %3 = load double* @testWu, align 8, !tbaa !1
  %4 = load double* @testWv, align 8, !tbaa !1
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str1, i64 0, i64 0), double %1, double %2, double %3, double %4) #2
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store double 4.651000e+02, double* @testVu, align 8, !tbaa !1
  store double 4.652000e+02, double* @testVv, align 8, !tbaa !1
  store double 1.603000e+02, double* @testWu, align 8, !tbaa !1
  store double 1.114000e+02, double* @testWv, align 8, !tbaa !1
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0)) #2
  %1 = load double* @testVu, align 8, !tbaa !1
  %2 = load double* @testVv, align 8, !tbaa !1
  %3 = load double* @testWu, align 8, !tbaa !1
  %4 = load double* @testWv, align 8, !tbaa !1
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str1, i64 0, i64 0), double %1, double %2, double %3, double %4) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"double", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
