; ModuleID = 'test_strtoll_oct.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"0 -035 +04711\00", align 1
@.str1 = private unnamed_addr constant [14 x i8] c"%d%d%d%d%d%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %end_char = alloca i8*, align 8
  %1 = call i64 @strtoll(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i8** %end_char, i32 0) #2
  %2 = load i8** %end_char, align 8, !tbaa !1
  %3 = call i64 @strtoll(i8* %2, i8** %end_char, i32 0) #2
  %4 = load i8** %end_char, align 8, !tbaa !1
  %5 = tail call i64 @strtoll(i8* nocapture %4, i8** null, i32 0) #2
  %6 = call i64 @strtoll(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i8** %end_char, i32 8) #2
  %7 = load i8** %end_char, align 8, !tbaa !1
  %8 = call i64 @strtoll(i8* %7, i8** %end_char, i32 8) #2
  %9 = load i8** %end_char, align 8, !tbaa !1
  %10 = tail call i64 @strtoll(i8* nocapture %9, i8** null, i32 8) #2
  %11 = icmp eq i64 %1, 0
  %12 = zext i1 %11 to i32
  %13 = icmp eq i64 %3, -29
  %14 = zext i1 %13 to i32
  %15 = icmp eq i64 %5, 2505
  %16 = zext i1 %15 to i32
  %17 = icmp eq i64 %6, 0
  %18 = zext i1 %17 to i32
  %19 = icmp eq i64 %8, -29
  %20 = zext i1 %19 to i32
  %21 = icmp eq i64 %10, 2505
  %22 = zext i1 %21 to i32
  %23 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str1, i64 0, i64 0), i32 %12, i32 %14, i32 %16, i32 %18, i32 %20, i32 %22) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @strtoll(i8* readonly, i8** nocapture, i32) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
