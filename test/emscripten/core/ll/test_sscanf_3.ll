; ModuleID = 'test_sscanf_3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str1 = private unnamed_addr constant [32 x i8] c"123 1073741823 1125899906842620\00", align 1
@.str2 = private unnamed_addr constant [15 x i8] c"%lld %lld %lld\00", align 1
@.str3 = private unnamed_addr constant [16 x i8] c"%lld,%lld,%lld\0A\00", align 1
@.str4 = private unnamed_addr constant [35 x i8] c"-123 -1073741823 -1125899906842620\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %s = alloca i64, align 8
  %m = alloca i64, align 8
  %l = alloca i64, align 8
  %negS = alloca i64, align 8
  %negM = alloca i64, align 8
  %negL = alloca i64, align 8
  %1 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([32 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8]* @.str2, i64 0, i64 0), i64* %s, i64* %m, i64* %l) #2
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %1) #2
  %3 = load i64* %s, align 8, !tbaa !1
  %4 = load i64* %m, align 8, !tbaa !1
  %5 = load i64* %l, align 8, !tbaa !1
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str3, i64 0, i64 0), i64 %3, i64 %4, i64 %5) #2
  %7 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([35 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8]* @.str2, i64 0, i64 0), i64* %negS, i64* %negM, i64* %negL) #2
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %7) #2
  %9 = load i64* %negS, align 8, !tbaa !1
  %10 = load i64* %negM, align 8, !tbaa !1
  %11 = load i64* %negL, align 8, !tbaa !1
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str3, i64 0, i64 0), i64 %9, i64 %10, i64 %11) #2
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
!2 = metadata !{metadata !"long", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
