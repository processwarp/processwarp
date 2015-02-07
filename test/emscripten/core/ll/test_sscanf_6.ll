; ModuleID = 'test_sscanf_6.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"18.07.2013w\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"%d.%d.%4d%c\00", align 1
@.str2 = private unnamed_addr constant [55 x i8] c"date: %s; day %2d, month %2d, year %4d, extra: %c, %d\0A\00", align 1
@.str3 = private unnamed_addr constant [10 x i8] c"%d.%d.%3c\00", align 1
@.str4 = private unnamed_addr constant [55 x i8] c"date: %s; day %2d, month %2d, year %4d, extra: %s, %d\0A\00", align 1
@.str5 = private unnamed_addr constant [11 x i8] c"18.07.2013\00", align 1
@.str6 = private unnamed_addr constant [41 x i8] c"date: %s; day %2d, month %2d, year %4d \0A\00", align 1
@.str7 = private unnamed_addr constant [36 x i8] c"Error in sscanf: actually parsed %d\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %c = alloca [10 x i8], align 1
  %y = alloca i32, align 4
  %m = alloca i32, align 4
  %d = alloca i32, align 4
  %c2 = alloca i8, align 1
  %y3 = alloca i32, align 4
  %m4 = alloca i32, align 4
  %d5 = alloca i32, align 4
  %1 = getelementptr inbounds [10 x i8]* %c, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 10, i32 1, i1 false)
  %2 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32* %d, i32* %m, i32* %y, i8* %1) #1
  %3 = load i32* %d, align 4, !tbaa !1
  %4 = load i32* %m, align 4, !tbaa !1
  %5 = load i32* %y, align 4, !tbaa !1
  %6 = load i8* %1, align 1, !tbaa !5
  %7 = sext i8 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([55 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i32 %3, i32 %4, i32 %5, i32 %7, i32 %2)
  %9 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @.str3, i64 0, i64 0), i32* %d, i32* %m, i8* %1) #1
  %10 = load i32* %d, align 4, !tbaa !1
  %11 = load i32* %m, align 4, !tbaa !1
  %12 = load i32* %y, align 4, !tbaa !1
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([55 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i32 %10, i32 %11, i32 %12, i8* %1, i32 %9)
  %14 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([11 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32* %d5, i32* %m4, i32* %y3, i8* %c2) #1
  %15 = icmp eq i32 %14, 3
  br i1 %15, label %16, label %21

; <label>:16                                      ; preds = %0
  %17 = load i32* %d5, align 4, !tbaa !1
  %18 = load i32* %m4, align 4, !tbaa !1
  %19 = load i32* %y3, align 4, !tbaa !1
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8]* @.str5, i64 0, i64 0), i32 %17, i32 %18, i32 %19)
  br label %23

; <label>:21                                      ; preds = %0
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str7, i64 0, i64 0), i32 %14)
  br label %23

; <label>:23                                      ; preds = %21, %16
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !3, metadata !3, i64 0}
