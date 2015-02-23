; ModuleID = 'test_strptime_days.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { i8*, i8* }
%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i8* }

@day_tests = internal unnamed_addr constant [12 x %struct.anon] [%struct.anon { i8* getelementptr inbounds ([11 x i8]* @.str3, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str4, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([9 x i8]* @.str5, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8]* @.str6, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([7 x i8]* @.str7, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8]* @.str8, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([15 x i8]* @.str9, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8]* @.str10, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([12 x i8]* @.str11, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str12, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([11 x i8]* @.str13, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str12, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([12 x i8]* @.str14, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str15, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([12 x i8]* @.str16, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str15, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([23 x i8]* @.str17, i32 0, i32 0), i8* getelementptr inbounds ([21 x i8]* @.str18, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([23 x i8]* @.str19, i32 0, i32 0), i8* getelementptr inbounds ([21 x i8]* @.str18, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([12 x i8]* @.str20, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str12, i32 0, i32 0) }, %struct.anon { i8* getelementptr inbounds ([16 x i8]* @.str21, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str15, i32 0, i32 0) }], align 16
@.str = private unnamed_addr constant [35 x i8] c"%s: %d/%d/%d (%dth DoW, %dth DoY)\0A\00", align 1
@.str1 = private unnamed_addr constant [3 x i8] c"OK\00", align 1
@.str2 = private unnamed_addr constant [4 x i8] c"ERR\00", align 1
@.str3 = private unnamed_addr constant [11 x i8] c"2000-01-01\00", align 1
@.str4 = private unnamed_addr constant [9 x i8] c"%Y-%m-%d\00", align 1
@.str5 = private unnamed_addr constant [9 x i8] c"03/03/00\00", align 1
@.str6 = private unnamed_addr constant [3 x i8] c"%D\00", align 1
@.str7 = private unnamed_addr constant [7 x i8] c"9/9/99\00", align 1
@.str8 = private unnamed_addr constant [3 x i8] c"%x\00", align 1
@.str9 = private unnamed_addr constant [15 x i8] c"19990502123412\00", align 1
@.str10 = private unnamed_addr constant [13 x i8] c"%Y%m%d%H%M%S\00", align 1
@.str11 = private unnamed_addr constant [12 x i8] c"2001 20 Mon\00", align 1
@.str12 = private unnamed_addr constant [9 x i8] c"%Y %U %a\00", align 1
@.str13 = private unnamed_addr constant [11 x i8] c"2006 4 Fri\00", align 1
@.str14 = private unnamed_addr constant [12 x i8] c"2001 21 Mon\00", align 1
@.str15 = private unnamed_addr constant [9 x i8] c"%Y %W %a\00", align 1
@.str16 = private unnamed_addr constant [12 x i8] c"2013 29 Wed\00", align 1
@.str17 = private unnamed_addr constant [23 x i8] c"2000-01-01 08:12:21 AM\00", align 1
@.str18 = private unnamed_addr constant [21 x i8] c"%Y-%m-%d %I:%M:%S %p\00", align 1
@.str19 = private unnamed_addr constant [23 x i8] c"2000-01-01 08:12:21 PM\00", align 1
@.str20 = private unnamed_addr constant [12 x i8] c"2001 17 Tue\00", align 1
@.str21 = private unnamed_addr constant [16 x i8] c"2001 8 Thursday\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %tm = alloca %struct.tm, align 8
  %1 = bitcast %struct.tm* %tm to i8*
  call void @llvm.lifetime.start(i64 56, i8* %1) #1
  %2 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 4
  %3 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 3
  %4 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 6
  br label %5

; <label>:5                                       ; preds = %17, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %17 ]
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 56, i32 8, i1 false)
  %6 = getelementptr inbounds [12 x %struct.anon]* @day_tests, i64 0, i64 %indvars.iv, i32 0
  %7 = load i8** %6, align 16, !tbaa !1
  %8 = getelementptr inbounds [12 x %struct.anon]* @day_tests, i64 0, i64 %indvars.iv, i32 1
  %9 = load i8** %8, align 8, !tbaa !6
  %10 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* %7, i8* %9, %struct.tm* %tm) #1
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %17, label %12

; <label>:12                                      ; preds = %5
  %13 = sext i32 %10 to i64
  %14 = inttoptr i64 %13 to i8*
  %15 = load i8* %14, align 1, !tbaa !7
  %16 = icmp eq i8 %15, 0
  %phitmp = select i1 %16, i8* getelementptr inbounds ([3 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str2, i64 0, i64 0)
  br label %17

; <label>:17                                      ; preds = %12, %5
  %18 = phi i8* [ getelementptr inbounds ([4 x i8]* @.str2, i64 0, i64 0), %5 ], [ %phitmp, %12 ]
  %19 = bitcast i32* %2 to i64*
  %20 = load i64* %19, align 8
  %21 = trunc i64 %20 to i32
  %22 = add nsw i32 %21, 1
  %23 = load i32* %3, align 4, !tbaa !8
  %24 = lshr i64 %20, 32
  %25 = trunc i64 %24 to i32
  %26 = add nsw i32 %25, 1900
  %27 = bitcast i32* %4 to i64*
  %28 = load i64* %27, align 8
  %29 = trunc i64 %28 to i32
  %30 = lshr i64 %28, 32
  %31 = trunc i64 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str, i64 0, i64 0), i8* %18, i32 %22, i32 %23, i32 %26, i32 %29, i32 %31) #1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 12
  br i1 %exitcond, label %33, label %5

; <label>:33                                      ; preds = %17
  call void @llvm.lifetime.end(i64 56, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

declare i32 @strptime(...) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"", metadata !3, i64 0, metadata !3, i64 8}
!3 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !2, metadata !3, i64 8}
!7 = metadata !{metadata !4, metadata !4, i64 0}
!8 = metadata !{metadata !9, metadata !10, i64 12}
!9 = metadata !{metadata !"tm", metadata !10, i64 0, metadata !10, i64 4, metadata !10, i64 8, metadata !10, i64 12, metadata !10, i64 16, metadata !10, i64 20, metadata !10, i64 24, metadata !10, i64 28, metadata !10, i64 32, metadata !11, i64 40, metadata !3, i64 48}
!10 = metadata !{metadata !"int", metadata !4, i64 0}
!11 = metadata !{metadata !"long", metadata !4, i64 0}
