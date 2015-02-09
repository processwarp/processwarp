; ModuleID = 'test_atoX.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d*\00", align 1
@.str1 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str2 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str3 = private unnamed_addr constant [3 x i8] c" b\00", align 1
@.str4 = private unnamed_addr constant [4 x i8] c" c \00", align 1
@.str5 = private unnamed_addr constant [2 x i8] c"6\00", align 1
@.str6 = private unnamed_addr constant [3 x i8] c" 5\00", align 1
@.str7 = private unnamed_addr constant [3 x i8] c"4 \00", align 1
@.str8 = private unnamed_addr constant [4 x i8] c"3 6\00", align 1
@.str9 = private unnamed_addr constant [5 x i8] c" 3 7\00", align 1
@.str10 = private unnamed_addr constant [4 x i8] c"9 d\00", align 1
@.str11 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str12 = private unnamed_addr constant [5 x i8] c" 8 e\00", align 1
@.str13 = private unnamed_addr constant [6 x i8] c"%lld*\00", align 1
@.str14 = private unnamed_addr constant [11 x i8] c"6294967296\00", align 1
@.str15 = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([1 x i8]* @.str1, i64 0, i64 0), i8** null, i32 10) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %2) #2
  %4 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([2 x i8]* @.str2, i64 0, i64 0), i8** null, i32 10) #2
  %5 = trunc i64 %4 to i32
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %5) #2
  %7 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8** null, i32 10) #2
  %8 = trunc i64 %7 to i32
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %8) #2
  %10 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8** null, i32 10) #2
  %11 = trunc i64 %10 to i32
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %11) #2
  %13 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8** null, i32 10) #2
  %14 = trunc i64 %13 to i32
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %14) #2
  %16 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([3 x i8]* @.str6, i64 0, i64 0), i8** null, i32 10) #2
  %17 = trunc i64 %16 to i32
  %18 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %17) #2
  %19 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([3 x i8]* @.str7, i64 0, i64 0), i8** null, i32 10) #2
  %20 = trunc i64 %19 to i32
  %21 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %20) #2
  %22 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([4 x i8]* @.str8, i64 0, i64 0), i8** null, i32 10) #2
  %23 = trunc i64 %22 to i32
  %24 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %23) #2
  %25 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([5 x i8]* @.str9, i64 0, i64 0), i8** null, i32 10) #2
  %26 = trunc i64 %25 to i32
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %26) #2
  %28 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([4 x i8]* @.str10, i64 0, i64 0), i8** null, i32 10) #2
  %29 = trunc i64 %28 to i32
  %30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %29) #2
  %31 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([5 x i8]* @.str12, i64 0, i64 0), i8** null, i32 10) #2
  %32 = trunc i64 %31 to i32
  %33 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str11, i64 0, i64 0), i32 %32) #2
  %34 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([1 x i8]* @.str1, i64 0, i64 0), i8** null, i32 10) #2
  %35 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %34) #2
  %36 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([2 x i8]* @.str2, i64 0, i64 0), i8** null, i32 10) #2
  %37 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %36) #2
  %38 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8** null, i32 10) #2
  %39 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %38) #2
  %40 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8** null, i32 10) #2
  %41 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %40) #2
  %42 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8** null, i32 10) #2
  %43 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %42) #2
  %44 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([3 x i8]* @.str6, i64 0, i64 0), i8** null, i32 10) #2
  %45 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %44) #2
  %46 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([3 x i8]* @.str7, i64 0, i64 0), i8** null, i32 10) #2
  %47 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %46) #2
  %48 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([4 x i8]* @.str8, i64 0, i64 0), i8** null, i32 10) #2
  %49 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %48) #2
  %50 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([5 x i8]* @.str9, i64 0, i64 0), i8** null, i32 10) #2
  %51 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %50) #2
  %52 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([4 x i8]* @.str10, i64 0, i64 0), i8** null, i32 10) #2
  %53 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i64 %52) #2
  %54 = tail call i64 @strtol(i8* nocapture getelementptr inbounds ([5 x i8]* @.str12, i64 0, i64 0), i8** null, i32 10) #2
  %55 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str11, i64 0, i64 0), i64 %54) #2
  %56 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([11 x i8]* @.str14, i64 0, i64 0), i8** null, i32 10) #2
  %57 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %56) #2
  %58 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([1 x i8]* @.str1, i64 0, i64 0), i8** null, i32 10) #2
  %59 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %58) #2
  %60 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([2 x i8]* @.str2, i64 0, i64 0), i8** null, i32 10) #2
  %61 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %60) #2
  %62 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8** null, i32 10) #2
  %63 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %62) #2
  %64 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8** null, i32 10) #2
  %65 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %64) #2
  %66 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8** null, i32 10) #2
  %67 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %66) #2
  %68 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([3 x i8]* @.str6, i64 0, i64 0), i8** null, i32 10) #2
  %69 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %68) #2
  %70 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([3 x i8]* @.str7, i64 0, i64 0), i8** null, i32 10) #2
  %71 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %70) #2
  %72 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([4 x i8]* @.str8, i64 0, i64 0), i8** null, i32 10) #2
  %73 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %72) #2
  %74 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([5 x i8]* @.str9, i64 0, i64 0), i8** null, i32 10) #2
  %75 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %74) #2
  %76 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([4 x i8]* @.str10, i64 0, i64 0), i8** null, i32 10) #2
  %77 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i64 %76) #2
  %78 = tail call i64 @strtoll(i8* nocapture getelementptr inbounds ([5 x i8]* @.str12, i64 0, i64 0), i8** null, i32 10) #2
  %79 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str15, i64 0, i64 0), i64 %78) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i64 @strtoll(i8* readonly, i8** nocapture, i32) #1

; Function Attrs: nounwind
declare i64 @strtol(i8* readonly, i8** nocapture, i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
