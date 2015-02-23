; ModuleID = 'test_sscanf_float.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [64 x i8] c"0.512 0.250x5.129_-9.98 1.12*+54.32E3 +54.32E3^87.5E-3 87.5E-3$\00", align 1
@.str1 = private unnamed_addr constant [28 x i8] c"%f %fx%f_%f %f*%f %f^%f %f$\00", align 1
@.str2 = private unnamed_addr constant [37 x i8] c"\0A%f, %f, %f, %f, %f, %f, %f, %f, %f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %f1 = alloca float, align 4
  %f2 = alloca float, align 4
  %f3 = alloca float, align 4
  %f4 = alloca float, align 4
  %f5 = alloca float, align 4
  %f6 = alloca float, align 4
  %f7 = alloca float, align 4
  %f8 = alloca float, align 4
  %f9 = alloca float, align 4
  %1 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([64 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([28 x i8]* @.str1, i64 0, i64 0), float* %f1, float* %f2, float* %f3, float* %f4, float* %f5, float* %f6, float* %f7, float* %f8, float* %f9) #2
  %2 = load float* %f1, align 4, !tbaa !1
  %3 = fpext float %2 to double
  %4 = load float* %f2, align 4, !tbaa !1
  %5 = fpext float %4 to double
  %6 = load float* %f3, align 4, !tbaa !1
  %7 = fpext float %6 to double
  %8 = load float* %f4, align 4, !tbaa !1
  %9 = fpext float %8 to double
  %10 = load float* %f5, align 4, !tbaa !1
  %11 = fpext float %10 to double
  %12 = load float* %f6, align 4, !tbaa !1
  %13 = fpext float %12 to double
  %14 = load float* %f7, align 4, !tbaa !1
  %15 = fpext float %14 to double
  %16 = load float* %f8, align 4, !tbaa !1
  %17 = fpext float %16 to double
  %18 = load float* %f9, align 4, !tbaa !1
  %19 = fpext float %18 to double
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str2, i64 0, i64 0), double %3, double %5, double %7, double %9, double %11, double %13, double %15, double %17, double %19) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"float", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
