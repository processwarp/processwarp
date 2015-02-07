; ModuleID = 'test_constglobalstructs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@iub = global [4 x { i32, double, i32, [4 x i8] }] [{ i32, double, i32, [4 x i8] } { i32 97, double 2.700000e-01, i32 5, [4 x i8] undef }, { i32, double, i32, [4 x i8] } { i32 99, double 1.500000e-01, i32 4, [4 x i8] undef }, { i32, double, i32, [4 x i8] } { i32 103, double 1.200000e-01, i32 3, [4 x i8] undef }, { i32, double, i32, [4 x i8] } { i32 116, double 2.700000e-01, i32 2, [4 x i8] undef }], align 16
@.str = private unnamed_addr constant [15 x i8] c"*%d,%d,%d,%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = load i32* getelementptr inbounds ([4 x { i32, double, i32, [4 x i8] }]* @iub, i64 0, i64 0, i32 0), align 16, !tbaa !1
  %2 = load double* getelementptr inbounds ([4 x { i32, double, i32, [4 x i8] }]* @iub, i64 0, i64 1, i32 1), align 8, !tbaa !7
  %3 = fmul double %2, 1.000000e+02
  %4 = fptosi double %3 to i32
  %5 = load i32* getelementptr inbounds ([4 x { i32, double, i32, [4 x i8] }]* @iub, i64 0, i64 2, i32 2), align 16, !tbaa !8
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0), i32 %1, i32 %4, i32 %5, i32 10)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS3IUB", metadata !3, i64 0, metadata !6, i64 8, metadata !3, i64 16}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"double", metadata !4, i64 0}
!7 = metadata !{metadata !2, metadata !6, i64 8}
!8 = metadata !{metadata !2, metadata !3, i64 16}
