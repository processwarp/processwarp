; ModuleID = 'test_sscanf_5.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"%c c %s\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"%i, %c, %s\0A\00", align 1
@.str2 = private unnamed_addr constant [10 x i8] c"  c black\00", align 1
@.str3 = private unnamed_addr constant [12 x i8] c". c #001100\00", align 1
@.str4 = private unnamed_addr constant [12 x i8] c"X c #111100\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %code = alloca i8, align 1
  %color = alloca [32 x i8], align 16
  %1 = getelementptr inbounds [32 x i8]* %color, i64 0, i64 0
  %2 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* %code, i8* %1) #2
  %3 = load i8* %code, align 1, !tbaa !1
  %4 = zext i8 %3 to i32
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 %2, i32 %4, i8* %1) #2
  %6 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* %code, i8* %1) #2
  %7 = load i8* %code, align 1, !tbaa !1
  %8 = zext i8 %7 to i32
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 %6, i32 %8, i8* %1) #2
  %10 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([12 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* %code, i8* %1) #2
  %11 = load i8* %code, align 1, !tbaa !1
  %12 = zext i8 %11 to i32
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 %10, i32 %12, i8* %1) #2
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
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
