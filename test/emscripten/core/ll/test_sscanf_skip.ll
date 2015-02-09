; ModuleID = 'test_sscanf_skip.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"10 20 30 40\00", align 1
@.str2 = private unnamed_addr constant [13 x i8] c"%*lld %*d %d\00", align 1
@.str3 = private unnamed_addr constant [43 x i8] c"1000000 -1125899906842620 -123 -1073741823\00", align 1
@.str4 = private unnamed_addr constant [19 x i8] c"%lld %*lld %ld %*d\00", align 1
@.str5 = private unnamed_addr constant [9 x i8] c"%lld,%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %val1 = alloca i32, align 4
  %large = alloca i64, align 8
  %val2 = alloca i64, align 8
  %1 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8]* @.str2, i64 0, i64 0), i32* %val1) #2
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %1) #2
  %3 = load i32* %val1, align 4, !tbaa !1
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %3) #2
  %5 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([43 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str4, i64 0, i64 0), i64* %large, i64* %val2) #2
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %5) #2
  %7 = load i64* %large, align 8, !tbaa !5
  %8 = load i64* %val2, align 8, !tbaa !5
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str5, i64 0, i64 0), i64 %7, i64 %8) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"long", metadata !3, i64 0}
