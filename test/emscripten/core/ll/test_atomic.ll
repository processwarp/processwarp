; ModuleID = 'test_atomic.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"*%d,%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %x = alloca i32, align 4
  store i32 10, i32* %x, align 4, !tbaa !1
  %1 = atomicrmw add i32* %x, i32 5 seq_cst
  %2 = add i32 %1, 5
  %3 = load i32* %x, align 4, !tbaa !1
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %3, i32 %2)
  store i32 10, i32* %x, align 4, !tbaa !1
  %5 = atomicrmw add i32* %x, i32 5 seq_cst
  %6 = load i32* %x, align 4, !tbaa !1
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %6, i32 %5)
  store i32 10, i32* %x, align 4, !tbaa !1
  %8 = atomicrmw xchg i32* %x, i32 6 seq_cst
  %9 = load i32* %x, align 4, !tbaa !1
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %9, i32 %8)
  store i32 10, i32* %x, align 4, !tbaa !1
  %11 = cmpxchg i32* %x, i32 9, i32 7 seq_cst seq_cst
  %12 = extractvalue { i32, i1 } %11, 0
  %13 = icmp eq i32 %12, 9
  %14 = zext i1 %13 to i32
  %15 = load i32* %x, align 4, !tbaa !1
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %15, i32 %14)
  %17 = cmpxchg i32* %x, i32 10, i32 7 seq_cst seq_cst
  %18 = extractvalue { i32, i1 } %17, 0
  %19 = icmp eq i32 %18, 10
  %20 = zext i1 %19 to i32
  %21 = load i32* %x, align 4, !tbaa !1
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %21, i32 %20)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
