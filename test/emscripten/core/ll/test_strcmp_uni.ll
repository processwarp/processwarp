; ModuleID = 'test_strcmp_uni.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"WORD\00", align 1
@.str1 = private unnamed_addr constant [29 x i8] c"Compare value strncmp is %d\0A\00", align 1
@.str3 = private unnamed_addr constant [33 x i8] c"Compare value strncasecmp is %d\0A\00", align 1
@.str5 = private unnamed_addr constant [28 x i8] c"Compare value memcmp is %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %wordEntry = alloca i16, align 2
  %wordEntry2 = alloca i16, align 2
  %wordEntry5 = alloca i16, align 2
  store i16 -32061, i16* %wordEntry, align 2
  %1 = bitcast i16* %wordEntry to i8*
  %2 = call i32 @strncmp(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i8* %1, i64 2) #3
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([29 x i8]* @.str1, i64 0, i64 0), i32 %2) #4
  store i16 -32061, i16* %wordEntry2, align 2
  %4 = bitcast i16* %wordEntry2 to i8*
  %5 = call i32 @strncasecmp(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i8* %4, i64 2) #3
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([33 x i8]* @.str3, i64 0, i64 0), i32 %5) #4
  store i16 -32061, i16* %wordEntry5, align 2
  %7 = bitcast i16* %wordEntry5 to i8*
  %8 = call i32 @memcmp(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i8* %7, i64 2) #3
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([28 x i8]* @.str5, i64 0, i64 0), i32 %8) #4
  ret i32 0
}

; Function Attrs: nounwind readonly
declare i32 @strncmp(i8* nocapture, i8* nocapture, i64) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind readonly
declare i32 @strncasecmp(i8* nocapture, i8* nocapture, i64) #1

; Function Attrs: nounwind readonly
declare i32 @memcmp(i8* nocapture, i8* nocapture, i64) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
