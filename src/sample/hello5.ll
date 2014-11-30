; ModuleID = 'hello5.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct.anon = type { i32, i32 }

@ab = common global %struct.anon zeroinitializer, align 4
@.str = private unnamed_addr constant [13 x i8] c"hello %d %p\0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  store i32 0, i32* getelementptr inbounds (%struct.anon* @ab, i64 0, i32 0), align 4, !tbaa !1
  store i32 1, i32* getelementptr inbounds (%struct.anon* @ab, i64 0, i32 1), align 4, !tbaa !6
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str, i64 0, i64 0), i32 0, i32* getelementptr inbounds (%struct.anon* @ab, i64 0, i32 1)) #2
  ret i32 %1
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.54) (based on LLVM 3.5svn)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"", metadata !3, i64 0, metadata !3, i64 4}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !2, metadata !3, i64 4}
