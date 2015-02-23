; ModuleID = 'test_simd8.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@buffer = common global [21 x i8] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  tail call void @llvm.x86.sse.storeu.ps(i8* getelementptr inbounds ([21 x i8]* @buffer, i64 0, i64 1), <4 x float> <float 0x3FB99999A0000000, float 0x4002666660000000, float 4.500000e+00, float 0x401ACCCCC0000000>) #2
  %1 = load <4 x float>* bitcast (i8* getelementptr inbounds ([21 x i8]* @buffer, i64 0, i64 5) to <4 x float>*), align 1, !tbaa !1
  %bitcast = extractelement <4 x float> %1, i32 0
  %2 = fpext float %bitcast to double
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %2) #2
  %4 = extractelement <4 x float> %1, i32 1
  %5 = fpext float %4 to double
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %5) #2
  %7 = extractelement <4 x float> %1, i32 2
  %8 = fpext float %7 to double
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %8) #2
  %10 = extractelement <4 x float> %1, i32 3
  %11 = fpext float %10 to double
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %11) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare void @llvm.x86.sse.storeu.ps(i8*, <4 x float>) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
