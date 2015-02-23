; ModuleID = 'test_sscanf_caps.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"a 1.1 1.1 1.1\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"%X %E %F %G\00", align 1
@.str2 = private unnamed_addr constant [19 x i8] c"%d %.1F %.1F %.1F\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %a = alloca i32, align 4
  %e = alloca float, align 4
  %f = alloca float, align 4
  %g = alloca float, align 4
  %1 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32* %a, float* %e, float* %f, float* %g) #2
  %2 = load i32* %a, align 4, !tbaa !1
  %3 = load float* %e, align 4, !tbaa !5
  %4 = fpext float %3 to double
  %5 = load float* %f, align 4, !tbaa !5
  %6 = fpext float %5 to double
  %7 = load float* %g, align 4, !tbaa !5
  %8 = fpext float %7 to double
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str2, i64 0, i64 0), i32 %2, double %4, double %6, double %8) #2
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
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"float", metadata !3, i64 0}
