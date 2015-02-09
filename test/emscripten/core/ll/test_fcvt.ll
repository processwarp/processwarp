; ModuleID = 'test_fcvt.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [56 x i8] c"source: %2.10f   buffer: '%s'   decimal: %d   sign: %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %decimal = alloca i32, align 4
  %sign = alloca i32, align 4
  %1 = call i8* @fcvt(double 0x400921FB54411744, i32 7, i32* %decimal, i32* %sign) #2
  %2 = load i32* %decimal, align 4, !tbaa !1
  %3 = load i32* %sign, align 4, !tbaa !1
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([56 x i8]* @.str, i64 0, i64 0), double 0x400921FB54411744, i8* %1, i32 %2, i32 %3) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i8* @fcvt(double, i32, i32*, i32*) #1

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
