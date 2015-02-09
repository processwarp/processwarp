; ModuleID = 'test_getgep.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@commonblock.0 = internal unnamed_addr global [10 x i32] zeroinitializer
@commonblock.1 = internal unnamed_addr global [10 x i32] zeroinitializer
@.str = private unnamed_addr constant [9 x i8] c"*%d %d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 0), align 16, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 0), align 16, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 1), align 4, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 1), align 4, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 2), align 8, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 2), align 8, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 3), align 4, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 3), align 4, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 4), align 16, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 4), align 16, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 5), align 4, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 5), align 4, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 6), align 8, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 6), align 8, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 7), align 4, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 7), align 4, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 8), align 16, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 8), align 16, !tbaa !1
  store i32 1, i32* getelementptr inbounds ([10 x i32]* @commonblock.0, i64 0, i64 9), align 4, !tbaa !1
  store i32 2, i32* getelementptr inbounds ([10 x i32]* @commonblock.1, i64 0, i64 9), align 4, !tbaa !1
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 1, i32 2) #2
  ret i32 0
}

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
