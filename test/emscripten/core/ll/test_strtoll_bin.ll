; ModuleID = 'test_strtoll_bin.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"1 -101 +1011\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"%d%d%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %end_char = alloca i8*, align 8
  %1 = call i64 @strtoll(i8* getelementptr inbounds ([13 x i8]* @.str, i64 0, i64 0), i8** %end_char, i32 2) #2
  %2 = load i8** %end_char, align 8, !tbaa !1
  %3 = call i64 @strtoll(i8* %2, i8** %end_char, i32 2) #2
  %4 = load i8** %end_char, align 8, !tbaa !1
  %5 = tail call i64 @strtoll(i8* nocapture %4, i8** null, i32 2) #2
  %6 = icmp eq i64 %1, 1
  %7 = zext i1 %6 to i32
  %8 = icmp eq i64 %3, -5
  %9 = zext i1 %8 to i32
  %10 = icmp eq i64 %5, 11
  %11 = zext i1 %10 to i32
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i32 %7, i32 %9, i32 %11)
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
