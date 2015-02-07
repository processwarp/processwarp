; ModuleID = 'test_sscanf_whitespace.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"173,16\00", align 1
@.str1 = private unnamed_addr constant [11 x i8] c"    16,173\00", align 1
@.str2 = private unnamed_addr constant [11 x i8] c"183,   173\00", align 1
@.str3 = private unnamed_addr constant [12 x i8] c"  17,   287\00", align 1
@.str4 = private unnamed_addr constant [14 x i8] c" 98,  123,   \00", align 1
@.str5 = private unnamed_addr constant [8 x i8] c"%hd,%hd\00", align 1
@.str6 = private unnamed_addr constant [10 x i8] c"%d:%d,%d \00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %x = alloca i16, align 2
  %y = alloca i16, align 2
  %1 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i16* %x, i16* %y) #2
  %2 = load i16* %x, align 2, !tbaa !1
  %3 = sext i16 %2 to i32
  %4 = load i16* %y, align 2, !tbaa !1
  %5 = sext i16 %4 to i32
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), i32 0, i32 %3, i32 %5)
  %7 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([11 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i16* %x, i16* %y) #2
  %8 = load i16* %x, align 2, !tbaa !1
  %9 = sext i16 %8 to i32
  %10 = load i16* %y, align 2, !tbaa !1
  %11 = sext i16 %10 to i32
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), i32 1, i32 %9, i32 %11)
  %13 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([11 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i16* %x, i16* %y) #2
  %14 = load i16* %x, align 2, !tbaa !1
  %15 = sext i16 %14 to i32
  %16 = load i16* %y, align 2, !tbaa !1
  %17 = sext i16 %16 to i32
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), i32 2, i32 %15, i32 %17)
  %19 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i16* %x, i16* %y) #2
  %20 = load i16* %x, align 2, !tbaa !1
  %21 = sext i16 %20 to i32
  %22 = load i16* %y, align 2, !tbaa !1
  %23 = sext i16 %22 to i32
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), i32 3, i32 %21, i32 %23)
  %25 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([14 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i16* %x, i16* %y) #2
  %26 = load i16* %x, align 2, !tbaa !1
  %27 = sext i16 %26 to i32
  %28 = load i16* %y, align 2, !tbaa !1
  %29 = sext i16 %28 to i32
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), i32 4, i32 %27, i32 %29)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"short", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
