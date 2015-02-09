; ModuleID = 'test_strndup.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [61 x i8] c"strndup - duplicate a specific number of bytes from a string\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"1:%s\0A\00", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"2:%s\0A\00", align 1
@.str3 = private unnamed_addr constant [6 x i8] c"3:%s\0A\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"4:%s\0A\00", align 1
@.str5 = private unnamed_addr constant [6 x i8] c"5:%s\0A\00", align 1
@.str6 = private unnamed_addr constant [6 x i8] c"6:%s\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call noalias i8* @strndup(i8* getelementptr inbounds ([61 x i8]* @.str, i64 0, i64 0), i64 0) #2
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* %1) #2
  tail call void @free(i8* %1) #2
  %3 = tail call noalias i8* @strndup(i8* getelementptr inbounds ([61 x i8]* @.str, i64 0, i64 0), i64 7) #2
  %4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* %3) #2
  tail call void @free(i8* %3) #2
  %5 = tail call noalias i8* @strndup(i8* getelementptr inbounds ([61 x i8]* @.str, i64 0, i64 0), i64 1000) #2
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str3, i64 0, i64 0), i8* %5) #2
  tail call void @free(i8* %5) #2
  %7 = tail call noalias i8* @strndup(i8* getelementptr inbounds ([61 x i8]* @.str, i64 0, i64 0), i64 60) #2
  %8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* %7) #2
  tail call void @free(i8* %7) #2
  %9 = tail call noalias i8* @strndup(i8* getelementptr inbounds ([61 x i8]* @.str, i64 0, i64 0), i64 19) #2
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str5, i64 0, i64 0), i8* %9) #2
  tail call void @free(i8* %9) #2
  %11 = tail call noalias i8* @strndup(i8* getelementptr inbounds ([61 x i8]* @.str, i64 0, i64 0), i64 -1) #2
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* %11) #2
  tail call void @free(i8* %11) #2
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @strndup(i8* nocapture readonly, i64) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare void @free(i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
