; ModuleID = 'test_double_varargs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: nounwind uwtable
define double @_Z17func_int_double_1iz(i32 %unused1, ...) #0 {
  %vl = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vl to i8*
  call void @llvm.va_start(i8* %1)
  %2 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 4) #1
  %3 = bitcast i8* %2 to i32*
  %4 = load i32* %3, align 4, !tbaa !1
  %5 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 8) #1
  %6 = bitcast i8* %5 to double*
  %7 = load double* %6, align 8, !tbaa !5
  call void @llvm.va_end(i8* %1)
  %8 = sitofp i32 %4 to double
  %9 = fadd double %8, %7
  ret double %9
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

declare i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]*, i64) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind uwtable
define double @_Z17func_int_double_2iiz(i32 %unused1, i32 %unused2, ...) #0 {
  %vl = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vl to i8*
  call void @llvm.va_start(i8* %1)
  %2 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 4) #1
  %3 = bitcast i8* %2 to i32*
  %4 = load i32* %3, align 4, !tbaa !1
  %5 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 8) #1
  %6 = bitcast i8* %5 to double*
  %7 = load double* %6, align 8, !tbaa !5
  call void @llvm.va_end(i8* %1)
  %8 = sitofp i32 %4 to double
  %9 = fadd double %8, %7
  ret double %9
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = tail call double (i32, ...)* @_Z17func_int_double_1iz(i32 undef, i32 5, double 1.000000e+01)
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %1) #1
  %3 = tail call double (i32, i32, ...)* @_Z17func_int_double_2iiz(i32 undef, i32 undef, i32 5, double 1.000000e+01)
  %4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %3) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"double", metadata !3, i64 0}
