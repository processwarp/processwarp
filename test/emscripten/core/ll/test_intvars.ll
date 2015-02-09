; ModuleID = 'test_intvars.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@global = global i32 20, align 4
@far = global i32* null, align 8
@.str = private unnamed_addr constant [30 x i8] c"*%d,%d,%d,%d,%d,%d,%d,%d,%d*\0A\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"%d:%d\00", align 1
@.str4 = private unnamed_addr constant [13 x i8] c"*%.1d,%.2d*\0A\00", align 1
@.str5 = private unnamed_addr constant [10 x i8] c"fixed:%d\0A\00", align 1
@.str6 = private unnamed_addr constant [9 x i8] c"*%ld*%p\0A\00", align 1
@str = private unnamed_addr constant [2 x i8] c"*\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %k = alloca i32, align 4
  %hash = alloca i64, align 8
  store i32* %k, i32** @far, align 8, !tbaa !1
  %1 = load i32* @global, align 4, !tbaa !5
  %2 = add nsw i32 %1, 101
  store i32 %2, i32* %k, align 4, !tbaa !5
  %3 = icmp sgt i32 %2, 100
  %4 = zext i1 %3 to i32
  %5 = shl nuw nsw i32 %4, 5
  %6 = or i32 %5, 5
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str, i64 0, i64 0), i32 5, i32 23, i32 10, i32 19, i32 %2, i32 %4, i32 %6, i32 1, i32 0) #2
  store i64 -1, i64* %hash, align 8, !tbaa !7
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 0, i64 -1) #2
  %putchar = call i32 @putchar(i32 44) #2
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 1, i64 576460752303423487) #2
  %putchar.1 = call i32 @putchar(i32 44) #2
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 2, i64 18014398509481983) #2
  %putchar.2 = call i32 @putchar(i32 44) #2
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 3, i64 562949953421311) #2
  %putchar.3 = call i32 @putchar(i32 44) #2
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 4, i64 17592186044415) #2
  %putchar.4 = call i32 @putchar(i32 44) #2
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 5, i64 549755813887) #2
  %putchar.5 = call i32 @putchar(i32 44) #2
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 6, i64 17179869183) #2
  %putchar.6 = call i32 @putchar(i32 44) #2
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 7, i64 536870911) #2
  %putchar.7 = call i32 @putchar(i32 44) #2
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 8, i64 16777215) #2
  %puts = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str, i64 0, i64 0))
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str4, i64 0, i64 0), i32 56, i32 9) #2
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str5, i64 0, i64 0), i32 320434) #2
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str6, i64 0, i64 0), i64 21, i64* %hash) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @putchar(i32) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"int", metadata !3, i64 0}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"long", metadata !3, i64 0}
