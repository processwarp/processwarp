; ModuleID = 'test_sscanf_n.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"version 1.0\00", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"%s%n\00", align 1
@.str2 = private unnamed_addr constant [30 x i8] c"Header format error, line %d\0A\00", align 1
@.str3 = private unnamed_addr constant [27 x i8] c"[DEBUG] word 1: %s, l: %d\0A\00", align 1
@.str4 = private unnamed_addr constant [11 x i8] c"one %n two\00", align 1
@.str5 = private unnamed_addr constant [6 x i8] c"%s %n\00", align 1
@.str6 = private unnamed_addr constant [10 x i8] c"%d,%s,%d\0A\00", align 1
@.str7 = private unnamed_addr constant [11 x i8] c"12345 6789\00", align 1
@.str8 = private unnamed_addr constant [8 x i8] c"%d %n%d\00", align 1
@.str9 = private unnamed_addr constant [13 x i8] c"%i %i %i %i\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %l = alloca i32, align 4
  %word = alloca [80 x i8], align 16
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %1 = getelementptr inbounds [80 x i8]* %word, i64 0, i64 0
  call void @llvm.lifetime.start(i64 80, i8* %1) #1
  %2 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0), i8* %1, i32* %l) #1
  %3 = icmp eq i32 %2, 1
  br i1 %3, label %6, label %4

; <label>:4                                       ; preds = %0
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str2, i64 0, i64 0), i32 undef) #1
  br label %6

; <label>:6                                       ; preds = %4, %0
  %7 = load i32* %l, align 4, !tbaa !1
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str3, i64 0, i64 0), i8* %1, i32 %7) #1
  %9 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([11 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str5, i64 0, i64 0), i8* %1, i32* %l) #1
  %10 = load i32* %l, align 4, !tbaa !1
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), i32 %9, i8* %1, i32 %10) #1
  %12 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([11 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i32* %a, i32* %b, i32* %c) #1
  %13 = load i32* %a, align 4, !tbaa !1
  %14 = load i32* %b, align 4, !tbaa !1
  %15 = load i32* %c, align 4, !tbaa !1
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str9, i64 0, i64 0), i32 %12, i32 %13, i32 %14, i32 %15) #1
  call void @llvm.lifetime.end(i64 80, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
