; ModuleID = 'test_nl_types.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"none\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"Hello, %s.\0A\00", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"world\00", align 1

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call i8* @catopen(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i32 0)
  %2 = tail call i8* @catgets(i8* %1, i32 0, i32 0, i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #3
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i8* %2)
  %4 = tail call i32 @catclose(i8* %1) #3
  ret i32 %4
}

declare i8* @catopen(i8*, i32) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i8* @catgets(i8*, i32, i32, i8*) #2

; Function Attrs: nounwind
declare i32 @catclose(i8*) #2

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
