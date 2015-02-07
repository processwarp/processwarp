; ModuleID = 'test_globals.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@cache = global [256 x i8] zeroinitializer, align 16
@next = global i8* getelementptr inbounds ([256 x i8]* @cache, i64 0, i64 0), align 8
@.str = private unnamed_addr constant [9 x i8] c"*%d,%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store i8 25, i8* getelementptr inbounds ([256 x i8]* @cache, i64 0, i64 10), align 2, !tbaa !1
  %1 = load i8** @next, align 8, !tbaa !4
  %2 = getelementptr inbounds i8* %1, i64 20
  store i8 51, i8* %2, align 1, !tbaa !1
  %3 = load i8** @next, align 8, !tbaa !4
  %4 = getelementptr inbounds i8* %3, i64 10
  %5 = load i8* %4, align 1, !tbaa !1
  %6 = sext i8 %5 to i32
  %7 = load i8* getelementptr inbounds ([256 x i8]* @cache, i64 0, i64 20), align 4, !tbaa !1
  %8 = sext i8 %7 to i32
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %6, i32 %8)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"any pointer", metadata !2, i64 0}
