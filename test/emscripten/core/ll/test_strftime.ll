; ModuleID = 'test_strftime.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i8* }

@.str = private unnamed_addr constant [8 x i8] c"%s: %d\0A\00", align 1
@.str1 = private unnamed_addr constant [19 x i8] c"\0AERROR: %s (\22%s\22)\0A\00", align 1
@.str2 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str3 = private unnamed_addr constant [17 x i8] c"strftime test #1\00", align 1
@.str4 = private unnamed_addr constant [3 x i8] c"%a\00", align 1
@.str5 = private unnamed_addr constant [4 x i8] c"Thu\00", align 1
@.str6 = private unnamed_addr constant [17 x i8] c"strftime test #2\00", align 1
@.str7 = private unnamed_addr constant [3 x i8] c"%A\00", align 1
@.str8 = private unnamed_addr constant [9 x i8] c"Thursday\00", align 1
@.str9 = private unnamed_addr constant [17 x i8] c"strftime test #3\00", align 1
@.str10 = private unnamed_addr constant [3 x i8] c"%b\00", align 1
@.str11 = private unnamed_addr constant [4 x i8] c"Feb\00", align 1
@.str12 = private unnamed_addr constant [17 x i8] c"strftime test #4\00", align 1
@.str13 = private unnamed_addr constant [3 x i8] c"%B\00", align 1
@.str14 = private unnamed_addr constant [9 x i8] c"February\00", align 1
@.str15 = private unnamed_addr constant [17 x i8] c"strftime test #5\00", align 1
@.str16 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str17 = private unnamed_addr constant [3 x i8] c"21\00", align 1
@.str18 = private unnamed_addr constant [17 x i8] c"strftime test #6\00", align 1
@.str19 = private unnamed_addr constant [3 x i8] c"%H\00", align 1
@.str20 = private unnamed_addr constant [3 x i8] c"20\00", align 1
@.str21 = private unnamed_addr constant [17 x i8] c"strftime test #7\00", align 1
@.str22 = private unnamed_addr constant [3 x i8] c"%I\00", align 1
@.str23 = private unnamed_addr constant [3 x i8] c"08\00", align 1
@.str24 = private unnamed_addr constant [17 x i8] c"strftime test #8\00", align 1
@.str25 = private unnamed_addr constant [3 x i8] c"%j\00", align 1
@.str26 = private unnamed_addr constant [4 x i8] c"052\00", align 1
@.str27 = private unnamed_addr constant [17 x i8] c"strftime test #9\00", align 1
@.str28 = private unnamed_addr constant [3 x i8] c"%m\00", align 1
@.str29 = private unnamed_addr constant [3 x i8] c"02\00", align 1
@.str30 = private unnamed_addr constant [18 x i8] c"strftime test #10\00", align 1
@.str31 = private unnamed_addr constant [3 x i8] c"%M\00", align 1
@.str32 = private unnamed_addr constant [3 x i8] c"23\00", align 1
@.str33 = private unnamed_addr constant [18 x i8] c"strftime test #11\00", align 1
@.str34 = private unnamed_addr constant [3 x i8] c"%p\00", align 1
@.str35 = private unnamed_addr constant [3 x i8] c"PM\00", align 1
@.str36 = private unnamed_addr constant [18 x i8] c"strftime test #12\00", align 1
@.str37 = private unnamed_addr constant [3 x i8] c"%S\00", align 1
@.str38 = private unnamed_addr constant [3 x i8] c"04\00", align 1
@.str39 = private unnamed_addr constant [18 x i8] c"strftime test #13\00", align 1
@.str40 = private unnamed_addr constant [3 x i8] c"%U\00", align 1
@.str41 = private unnamed_addr constant [3 x i8] c"07\00", align 1
@.str42 = private unnamed_addr constant [18 x i8] c"strftime test #14\00", align 1
@.str43 = private unnamed_addr constant [3 x i8] c"%w\00", align 1
@.str44 = private unnamed_addr constant [2 x i8] c"4\00", align 1
@.str45 = private unnamed_addr constant [18 x i8] c"strftime test #15\00", align 1
@.str46 = private unnamed_addr constant [3 x i8] c"%W\00", align 1
@.str47 = private unnamed_addr constant [18 x i8] c"strftime test #16\00", align 1
@.str48 = private unnamed_addr constant [3 x i8] c"%y\00", align 1
@.str49 = private unnamed_addr constant [3 x i8] c"74\00", align 1
@.str50 = private unnamed_addr constant [18 x i8] c"strftime test #17\00", align 1
@.str51 = private unnamed_addr constant [3 x i8] c"%Y\00", align 1
@.str52 = private unnamed_addr constant [5 x i8] c"1974\00", align 1
@.str53 = private unnamed_addr constant [18 x i8] c"strftime test #18\00", align 1
@.str54 = private unnamed_addr constant [3 x i8] c"%%\00", align 1
@.str55 = private unnamed_addr constant [2 x i8] c"%\00", align 1
@.str56 = private unnamed_addr constant [18 x i8] c"strftime test #19\00", align 1
@.str57 = private unnamed_addr constant [18 x i8] c"strftime test #20\00", align 1
@.str58 = private unnamed_addr constant [18 x i8] c"strftime test #21\00", align 1
@.str59 = private unnamed_addr constant [3 x i8] c"00\00", align 1
@.str60 = private unnamed_addr constant [18 x i8] c"strftime test #22\00", align 1
@.str61 = private unnamed_addr constant [18 x i8] c"strftime test #23\00", align 1
@.str62 = private unnamed_addr constant [3 x i8] c"01\00", align 1
@.str63 = private unnamed_addr constant [18 x i8] c"strftime test #24\00", align 1
@.str64 = private unnamed_addr constant [18 x i8] c"strftime test #25\00", align 1
@.str65 = private unnamed_addr constant [8 x i8] c"%G (%V)\00", align 1
@.str66 = private unnamed_addr constant [10 x i8] c"1998 (53)\00", align 1
@.str67 = private unnamed_addr constant [18 x i8] c"strftime test #26\00", align 1
@.str68 = private unnamed_addr constant [3 x i8] c"%g\00", align 1
@.str69 = private unnamed_addr constant [3 x i8] c"98\00", align 1
@.str70 = private unnamed_addr constant [18 x i8] c"strftime test #27\00", align 1
@.str71 = private unnamed_addr constant [10 x i8] c"1998 (01)\00", align 1
@.str72 = private unnamed_addr constant [18 x i8] c"strftime test #28\00", align 1
@.str73 = private unnamed_addr constant [18 x i8] c"strftime test #29\00", align 1
@.str74 = private unnamed_addr constant [3 x i8] c"%z\00", align 1
@.str75 = private unnamed_addr constant [22 x i8] c"strftime zone test #1\00", align 1
@.str76 = private unnamed_addr constant [3 x i8] c"%Z\00", align 1
@tzname = external global [2 x i8*]
@.str77 = private unnamed_addr constant [22 x i8] c"strftime zone test #2\00", align 1
@.str78 = private unnamed_addr constant [22 x i8] c"strftime zone test #3\00", align 1
@.str79 = private unnamed_addr constant [22 x i8] c"strftime zone test #4\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z4testiPKcS0_(i32 %result, i8* %comment, i8* %parsed) #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* %comment, i32 %result) #3
  %2 = icmp eq i32 %result, 0
  br i1 %2, label %3, label %5

; <label>:3                                       ; preds = %0
  %4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* %comment, i8* %parsed) #3
  br label %5

; <label>:5                                       ; preds = %3, %0
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readonly uwtable
define i32 @_Z3cmpPKcS0_(i8* nocapture readonly %s1, i8* nocapture readonly %s2) #2 {
  %1 = load i8* %s1, align 1, !tbaa !1
  %2 = load i8* %s2, align 1, !tbaa !1
  %3 = icmp ne i8 %1, %2
  %4 = icmp eq i8 %1, 0
  %or.cond3 = or i1 %3, %4
  br i1 %or.cond3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %0
  %.05 = phi i8* [ %6, %.lr.ph ], [ %s2, %0 ]
  %.014 = phi i8* [ %5, %.lr.ph ], [ %s1, %0 ]
  %5 = getelementptr inbounds i8* %.014, i64 1
  %6 = getelementptr inbounds i8* %.05, i64 1
  %7 = load i8* %5, align 1, !tbaa !1
  %8 = load i8* %6, align 1, !tbaa !1
  %9 = icmp ne i8 %7, %8
  %10 = icmp eq i8 %7, 0
  %or.cond = or i1 %9, %10
  br i1 %or.cond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  %.lcssa2 = phi i8 [ %2, %0 ], [ %8, %.lr.ph ]
  %.lcssa = phi i8 [ %1, %0 ], [ %7, %.lr.ph ]
  %11 = sext i8 %.lcssa to i32
  %12 = sext i8 %.lcssa2 to i32
  %13 = sub nsw i32 %11, %12
  ret i32 %13
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %tm = alloca %struct.tm, align 8
  %s = alloca [1000 x i8], align 16
  %xmas2002 = alloca i64, align 8
  %summer2002 = alloca i64, align 8
  %1 = bitcast %struct.tm* %tm to i8*
  call void @llvm.lifetime.start(i64 56, i8* %1) #3
  %2 = getelementptr inbounds [1000 x i8]* %s, i64 0, i64 0
  call void @llvm.lifetime.start(i64 1000, i8* %2) #3
  %3 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 0
  store i32 4, i32* %3, align 8, !tbaa !4
  %4 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 1
  store i32 23, i32* %4, align 4, !tbaa !9
  %5 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 2
  store i32 20, i32* %5, align 8, !tbaa !10
  %6 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 3
  store i32 21, i32* %6, align 4, !tbaa !11
  %7 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 4
  store i32 1, i32* %7, align 8, !tbaa !12
  %8 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 5
  store i32 74, i32* %8, align 4, !tbaa !13
  %9 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 6
  store i32 4, i32* %9, align 8, !tbaa !14
  %10 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 7
  store i32 51, i32* %10, align 4, !tbaa !15
  %11 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 8
  store i32 0, i32* %11, align 8, !tbaa !16
  %12 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([1 x i8]* @.str2, i64 0, i64 0), %struct.tm* %tm) #3
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %15, label %.thread

.thread:                                          ; preds = %0
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str3, i64 0, i64 0), i32 0) #3
  br label %20

; <label>:15                                      ; preds = %0
  %16 = load i8* %2, align 16, !tbaa !1
  %17 = icmp eq i8 %16, 0
  %18 = zext i1 %17 to i32
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str3, i64 0, i64 0), i32 %18) #3
  br i1 %17, label %_Z4testiPKcS0_.exit, label %20

; <label>:20                                      ; preds = %15, %.thread
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str3, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit

_Z4testiPKcS0_.exit:                              ; preds = %20, %15
  %22 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str4, i64 0, i64 0), %struct.tm* %tm) #3
  %23 = icmp eq i64 %22, 3
  br i1 %23, label %25, label %.thread347

.thread347:                                       ; preds = %_Z4testiPKcS0_.exit
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str6, i64 0, i64 0), i32 0) #3
  br label %39

; <label>:25                                      ; preds = %_Z4testiPKcS0_.exit
  %26 = load i8* %2, align 16, !tbaa !1
  %27 = icmp eq i8 %26, 84
  br i1 %27, label %.lr.ph.i, label %.thread348

.thread348:                                       ; preds = %25
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str6, i64 0, i64 0), i32 0) #3
  br label %39

.lr.ph.i:                                         ; preds = %.lr.ph.i, %25
  %.05.i = phi i8* [ %30, %.lr.ph.i ], [ getelementptr inbounds ([4 x i8]* @.str5, i64 0, i64 0), %25 ]
  %.014.i = phi i8* [ %29, %.lr.ph.i ], [ %2, %25 ]
  %29 = getelementptr inbounds i8* %.014.i, i64 1
  %30 = getelementptr inbounds i8* %.05.i, i64 1
  %31 = load i8* %29, align 1, !tbaa !1
  %32 = load i8* %30, align 1, !tbaa !1
  %33 = icmp ne i8 %31, %32
  %34 = icmp eq i8 %31, 0
  %or.cond.i = or i1 %33, %34
  br i1 %or.cond.i, label %35, label %.lr.ph.i

; <label>:35                                      ; preds = %.lr.ph.i
  %36 = icmp eq i8 %31, %32
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str6, i64 0, i64 0), i32 %37) #3
  br i1 %36, label %_Z4testiPKcS0_.exit1, label %39

; <label>:39                                      ; preds = %35, %.thread348, %.thread347
  %40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str6, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit1

_Z4testiPKcS0_.exit1:                             ; preds = %39, %35
  %41 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str7, i64 0, i64 0), %struct.tm* %tm) #3
  %42 = icmp eq i64 %41, 8
  br i1 %42, label %44, label %.thread349

.thread349:                                       ; preds = %_Z4testiPKcS0_.exit1
  %43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str9, i64 0, i64 0), i32 0) #3
  br label %58

; <label>:44                                      ; preds = %_Z4testiPKcS0_.exit1
  %45 = load i8* %2, align 16, !tbaa !1
  %46 = icmp eq i8 %45, 84
  br i1 %46, label %.lr.ph.i6, label %.thread350

.thread350:                                       ; preds = %44
  %47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str9, i64 0, i64 0), i32 0) #3
  br label %58

.lr.ph.i6:                                        ; preds = %.lr.ph.i6, %44
  %.05.i3 = phi i8* [ %49, %.lr.ph.i6 ], [ getelementptr inbounds ([9 x i8]* @.str8, i64 0, i64 0), %44 ]
  %.014.i4 = phi i8* [ %48, %.lr.ph.i6 ], [ %2, %44 ]
  %48 = getelementptr inbounds i8* %.014.i4, i64 1
  %49 = getelementptr inbounds i8* %.05.i3, i64 1
  %50 = load i8* %48, align 1, !tbaa !1
  %51 = load i8* %49, align 1, !tbaa !1
  %52 = icmp ne i8 %50, %51
  %53 = icmp eq i8 %50, 0
  %or.cond.i5 = or i1 %52, %53
  br i1 %or.cond.i5, label %54, label %.lr.ph.i6

; <label>:54                                      ; preds = %.lr.ph.i6
  %55 = icmp eq i8 %50, %51
  %56 = zext i1 %55 to i32
  %57 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str9, i64 0, i64 0), i32 %56) #3
  br i1 %55, label %_Z4testiPKcS0_.exit10, label %58

; <label>:58                                      ; preds = %54, %.thread350, %.thread349
  %59 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str9, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit10

_Z4testiPKcS0_.exit10:                            ; preds = %58, %54
  %60 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str10, i64 0, i64 0), %struct.tm* %tm) #3
  %61 = icmp eq i64 %60, 3
  br i1 %61, label %63, label %.thread351

.thread351:                                       ; preds = %_Z4testiPKcS0_.exit10
  %62 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str12, i64 0, i64 0), i32 0) #3
  br label %77

; <label>:63                                      ; preds = %_Z4testiPKcS0_.exit10
  %64 = load i8* %2, align 16, !tbaa !1
  %65 = icmp eq i8 %64, 70
  br i1 %65, label %.lr.ph.i15, label %.thread352

.thread352:                                       ; preds = %63
  %66 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str12, i64 0, i64 0), i32 0) #3
  br label %77

.lr.ph.i15:                                       ; preds = %.lr.ph.i15, %63
  %.05.i12 = phi i8* [ %68, %.lr.ph.i15 ], [ getelementptr inbounds ([4 x i8]* @.str11, i64 0, i64 0), %63 ]
  %.014.i13 = phi i8* [ %67, %.lr.ph.i15 ], [ %2, %63 ]
  %67 = getelementptr inbounds i8* %.014.i13, i64 1
  %68 = getelementptr inbounds i8* %.05.i12, i64 1
  %69 = load i8* %67, align 1, !tbaa !1
  %70 = load i8* %68, align 1, !tbaa !1
  %71 = icmp ne i8 %69, %70
  %72 = icmp eq i8 %69, 0
  %or.cond.i14 = or i1 %71, %72
  br i1 %or.cond.i14, label %73, label %.lr.ph.i15

; <label>:73                                      ; preds = %.lr.ph.i15
  %74 = icmp eq i8 %69, %70
  %75 = zext i1 %74 to i32
  %76 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str12, i64 0, i64 0), i32 %75) #3
  br i1 %74, label %_Z4testiPKcS0_.exit19, label %77

; <label>:77                                      ; preds = %73, %.thread352, %.thread351
  %78 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str12, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit19

_Z4testiPKcS0_.exit19:                            ; preds = %77, %73
  %79 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str13, i64 0, i64 0), %struct.tm* %tm) #3
  %80 = icmp eq i64 %79, 8
  br i1 %80, label %82, label %.thread353

.thread353:                                       ; preds = %_Z4testiPKcS0_.exit19
  %81 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str15, i64 0, i64 0), i32 0) #3
  br label %96

; <label>:82                                      ; preds = %_Z4testiPKcS0_.exit19
  %83 = load i8* %2, align 16, !tbaa !1
  %84 = icmp eq i8 %83, 70
  br i1 %84, label %.lr.ph.i24, label %.thread354

.thread354:                                       ; preds = %82
  %85 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str15, i64 0, i64 0), i32 0) #3
  br label %96

.lr.ph.i24:                                       ; preds = %.lr.ph.i24, %82
  %.05.i21 = phi i8* [ %87, %.lr.ph.i24 ], [ getelementptr inbounds ([9 x i8]* @.str14, i64 0, i64 0), %82 ]
  %.014.i22 = phi i8* [ %86, %.lr.ph.i24 ], [ %2, %82 ]
  %86 = getelementptr inbounds i8* %.014.i22, i64 1
  %87 = getelementptr inbounds i8* %.05.i21, i64 1
  %88 = load i8* %86, align 1, !tbaa !1
  %89 = load i8* %87, align 1, !tbaa !1
  %90 = icmp ne i8 %88, %89
  %91 = icmp eq i8 %88, 0
  %or.cond.i23 = or i1 %90, %91
  br i1 %or.cond.i23, label %92, label %.lr.ph.i24

; <label>:92                                      ; preds = %.lr.ph.i24
  %93 = icmp eq i8 %88, %89
  %94 = zext i1 %93 to i32
  %95 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str15, i64 0, i64 0), i32 %94) #3
  br i1 %93, label %_Z4testiPKcS0_.exit28, label %96

; <label>:96                                      ; preds = %92, %.thread354, %.thread353
  %97 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str15, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit28

_Z4testiPKcS0_.exit28:                            ; preds = %96, %92
  %98 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str16, i64 0, i64 0), %struct.tm* %tm) #3
  %99 = icmp eq i64 %98, 2
  br i1 %99, label %101, label %.thread355

.thread355:                                       ; preds = %_Z4testiPKcS0_.exit28
  %100 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str18, i64 0, i64 0), i32 0) #3
  br label %115

; <label>:101                                     ; preds = %_Z4testiPKcS0_.exit28
  %102 = load i8* %2, align 16, !tbaa !1
  %103 = icmp eq i8 %102, 50
  br i1 %103, label %.lr.ph.i33, label %.thread356

.thread356:                                       ; preds = %101
  %104 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str18, i64 0, i64 0), i32 0) #3
  br label %115

.lr.ph.i33:                                       ; preds = %.lr.ph.i33, %101
  %.05.i30 = phi i8* [ %106, %.lr.ph.i33 ], [ getelementptr inbounds ([3 x i8]* @.str17, i64 0, i64 0), %101 ]
  %.014.i31 = phi i8* [ %105, %.lr.ph.i33 ], [ %2, %101 ]
  %105 = getelementptr inbounds i8* %.014.i31, i64 1
  %106 = getelementptr inbounds i8* %.05.i30, i64 1
  %107 = load i8* %105, align 1, !tbaa !1
  %108 = load i8* %106, align 1, !tbaa !1
  %109 = icmp ne i8 %107, %108
  %110 = icmp eq i8 %107, 0
  %or.cond.i32 = or i1 %109, %110
  br i1 %or.cond.i32, label %111, label %.lr.ph.i33

; <label>:111                                     ; preds = %.lr.ph.i33
  %112 = icmp eq i8 %107, %108
  %113 = zext i1 %112 to i32
  %114 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str18, i64 0, i64 0), i32 %113) #3
  br i1 %112, label %_Z4testiPKcS0_.exit37, label %115

; <label>:115                                     ; preds = %111, %.thread356, %.thread355
  %116 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str18, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit37

_Z4testiPKcS0_.exit37:                            ; preds = %115, %111
  %117 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str19, i64 0, i64 0), %struct.tm* %tm) #3
  %118 = icmp eq i64 %117, 2
  br i1 %118, label %120, label %.thread357

.thread357:                                       ; preds = %_Z4testiPKcS0_.exit37
  %119 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str21, i64 0, i64 0), i32 0) #3
  br label %134

; <label>:120                                     ; preds = %_Z4testiPKcS0_.exit37
  %121 = load i8* %2, align 16, !tbaa !1
  %122 = icmp eq i8 %121, 50
  br i1 %122, label %.lr.ph.i42, label %.thread358

.thread358:                                       ; preds = %120
  %123 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str21, i64 0, i64 0), i32 0) #3
  br label %134

.lr.ph.i42:                                       ; preds = %.lr.ph.i42, %120
  %.05.i39 = phi i8* [ %125, %.lr.ph.i42 ], [ getelementptr inbounds ([3 x i8]* @.str20, i64 0, i64 0), %120 ]
  %.014.i40 = phi i8* [ %124, %.lr.ph.i42 ], [ %2, %120 ]
  %124 = getelementptr inbounds i8* %.014.i40, i64 1
  %125 = getelementptr inbounds i8* %.05.i39, i64 1
  %126 = load i8* %124, align 1, !tbaa !1
  %127 = load i8* %125, align 1, !tbaa !1
  %128 = icmp ne i8 %126, %127
  %129 = icmp eq i8 %126, 0
  %or.cond.i41 = or i1 %128, %129
  br i1 %or.cond.i41, label %130, label %.lr.ph.i42

; <label>:130                                     ; preds = %.lr.ph.i42
  %131 = icmp eq i8 %126, %127
  %132 = zext i1 %131 to i32
  %133 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str21, i64 0, i64 0), i32 %132) #3
  br i1 %131, label %_Z4testiPKcS0_.exit46, label %134

; <label>:134                                     ; preds = %130, %.thread358, %.thread357
  %135 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str21, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit46

_Z4testiPKcS0_.exit46:                            ; preds = %134, %130
  %136 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str22, i64 0, i64 0), %struct.tm* %tm) #3
  %137 = icmp eq i64 %136, 2
  br i1 %137, label %139, label %.thread359

.thread359:                                       ; preds = %_Z4testiPKcS0_.exit46
  %138 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str24, i64 0, i64 0), i32 0) #3
  br label %153

; <label>:139                                     ; preds = %_Z4testiPKcS0_.exit46
  %140 = load i8* %2, align 16, !tbaa !1
  %141 = icmp eq i8 %140, 48
  br i1 %141, label %.lr.ph.i51, label %.thread360

.thread360:                                       ; preds = %139
  %142 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str24, i64 0, i64 0), i32 0) #3
  br label %153

.lr.ph.i51:                                       ; preds = %.lr.ph.i51, %139
  %.05.i48 = phi i8* [ %144, %.lr.ph.i51 ], [ getelementptr inbounds ([3 x i8]* @.str23, i64 0, i64 0), %139 ]
  %.014.i49 = phi i8* [ %143, %.lr.ph.i51 ], [ %2, %139 ]
  %143 = getelementptr inbounds i8* %.014.i49, i64 1
  %144 = getelementptr inbounds i8* %.05.i48, i64 1
  %145 = load i8* %143, align 1, !tbaa !1
  %146 = load i8* %144, align 1, !tbaa !1
  %147 = icmp ne i8 %145, %146
  %148 = icmp eq i8 %145, 0
  %or.cond.i50 = or i1 %147, %148
  br i1 %or.cond.i50, label %149, label %.lr.ph.i51

; <label>:149                                     ; preds = %.lr.ph.i51
  %150 = icmp eq i8 %145, %146
  %151 = zext i1 %150 to i32
  %152 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str24, i64 0, i64 0), i32 %151) #3
  br i1 %150, label %_Z4testiPKcS0_.exit55, label %153

; <label>:153                                     ; preds = %149, %.thread360, %.thread359
  %154 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str24, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit55

_Z4testiPKcS0_.exit55:                            ; preds = %153, %149
  %155 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str25, i64 0, i64 0), %struct.tm* %tm) #3
  %156 = icmp eq i64 %155, 3
  br i1 %156, label %158, label %.thread361

.thread361:                                       ; preds = %_Z4testiPKcS0_.exit55
  %157 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str27, i64 0, i64 0), i32 0) #3
  br label %172

; <label>:158                                     ; preds = %_Z4testiPKcS0_.exit55
  %159 = load i8* %2, align 16, !tbaa !1
  %160 = icmp eq i8 %159, 48
  br i1 %160, label %.lr.ph.i60, label %.thread362

.thread362:                                       ; preds = %158
  %161 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str27, i64 0, i64 0), i32 0) #3
  br label %172

.lr.ph.i60:                                       ; preds = %.lr.ph.i60, %158
  %.05.i57 = phi i8* [ %163, %.lr.ph.i60 ], [ getelementptr inbounds ([4 x i8]* @.str26, i64 0, i64 0), %158 ]
  %.014.i58 = phi i8* [ %162, %.lr.ph.i60 ], [ %2, %158 ]
  %162 = getelementptr inbounds i8* %.014.i58, i64 1
  %163 = getelementptr inbounds i8* %.05.i57, i64 1
  %164 = load i8* %162, align 1, !tbaa !1
  %165 = load i8* %163, align 1, !tbaa !1
  %166 = icmp ne i8 %164, %165
  %167 = icmp eq i8 %164, 0
  %or.cond.i59 = or i1 %166, %167
  br i1 %or.cond.i59, label %168, label %.lr.ph.i60

; <label>:168                                     ; preds = %.lr.ph.i60
  %169 = icmp eq i8 %164, %165
  %170 = zext i1 %169 to i32
  %171 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str27, i64 0, i64 0), i32 %170) #3
  br i1 %169, label %_Z4testiPKcS0_.exit64, label %172

; <label>:172                                     ; preds = %168, %.thread362, %.thread361
  %173 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str27, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit64

_Z4testiPKcS0_.exit64:                            ; preds = %172, %168
  %174 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str28, i64 0, i64 0), %struct.tm* %tm) #3
  %175 = icmp eq i64 %174, 2
  br i1 %175, label %177, label %.thread363

.thread363:                                       ; preds = %_Z4testiPKcS0_.exit64
  %176 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str30, i64 0, i64 0), i32 0) #3
  br label %191

; <label>:177                                     ; preds = %_Z4testiPKcS0_.exit64
  %178 = load i8* %2, align 16, !tbaa !1
  %179 = icmp eq i8 %178, 48
  br i1 %179, label %.lr.ph.i69, label %.thread364

.thread364:                                       ; preds = %177
  %180 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str30, i64 0, i64 0), i32 0) #3
  br label %191

.lr.ph.i69:                                       ; preds = %.lr.ph.i69, %177
  %.05.i66 = phi i8* [ %182, %.lr.ph.i69 ], [ getelementptr inbounds ([3 x i8]* @.str29, i64 0, i64 0), %177 ]
  %.014.i67 = phi i8* [ %181, %.lr.ph.i69 ], [ %2, %177 ]
  %181 = getelementptr inbounds i8* %.014.i67, i64 1
  %182 = getelementptr inbounds i8* %.05.i66, i64 1
  %183 = load i8* %181, align 1, !tbaa !1
  %184 = load i8* %182, align 1, !tbaa !1
  %185 = icmp ne i8 %183, %184
  %186 = icmp eq i8 %183, 0
  %or.cond.i68 = or i1 %185, %186
  br i1 %or.cond.i68, label %187, label %.lr.ph.i69

; <label>:187                                     ; preds = %.lr.ph.i69
  %188 = icmp eq i8 %183, %184
  %189 = zext i1 %188 to i32
  %190 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str30, i64 0, i64 0), i32 %189) #3
  br i1 %188, label %_Z4testiPKcS0_.exit73, label %191

; <label>:191                                     ; preds = %187, %.thread364, %.thread363
  %192 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str30, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit73

_Z4testiPKcS0_.exit73:                            ; preds = %191, %187
  %193 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str31, i64 0, i64 0), %struct.tm* %tm) #3
  %194 = icmp eq i64 %193, 2
  br i1 %194, label %196, label %.thread365

.thread365:                                       ; preds = %_Z4testiPKcS0_.exit73
  %195 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str33, i64 0, i64 0), i32 0) #3
  br label %210

; <label>:196                                     ; preds = %_Z4testiPKcS0_.exit73
  %197 = load i8* %2, align 16, !tbaa !1
  %198 = icmp eq i8 %197, 50
  br i1 %198, label %.lr.ph.i78, label %.thread366

.thread366:                                       ; preds = %196
  %199 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str33, i64 0, i64 0), i32 0) #3
  br label %210

.lr.ph.i78:                                       ; preds = %.lr.ph.i78, %196
  %.05.i75 = phi i8* [ %201, %.lr.ph.i78 ], [ getelementptr inbounds ([3 x i8]* @.str32, i64 0, i64 0), %196 ]
  %.014.i76 = phi i8* [ %200, %.lr.ph.i78 ], [ %2, %196 ]
  %200 = getelementptr inbounds i8* %.014.i76, i64 1
  %201 = getelementptr inbounds i8* %.05.i75, i64 1
  %202 = load i8* %200, align 1, !tbaa !1
  %203 = load i8* %201, align 1, !tbaa !1
  %204 = icmp ne i8 %202, %203
  %205 = icmp eq i8 %202, 0
  %or.cond.i77 = or i1 %204, %205
  br i1 %or.cond.i77, label %206, label %.lr.ph.i78

; <label>:206                                     ; preds = %.lr.ph.i78
  %207 = icmp eq i8 %202, %203
  %208 = zext i1 %207 to i32
  %209 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str33, i64 0, i64 0), i32 %208) #3
  br i1 %207, label %_Z4testiPKcS0_.exit82, label %210

; <label>:210                                     ; preds = %206, %.thread366, %.thread365
  %211 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str33, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit82

_Z4testiPKcS0_.exit82:                            ; preds = %210, %206
  %212 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str34, i64 0, i64 0), %struct.tm* %tm) #3
  %213 = icmp eq i64 %212, 2
  br i1 %213, label %215, label %.thread367

.thread367:                                       ; preds = %_Z4testiPKcS0_.exit82
  %214 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str36, i64 0, i64 0), i32 0) #3
  br label %229

; <label>:215                                     ; preds = %_Z4testiPKcS0_.exit82
  %216 = load i8* %2, align 16, !tbaa !1
  %217 = icmp eq i8 %216, 80
  br i1 %217, label %.lr.ph.i87, label %.thread368

.thread368:                                       ; preds = %215
  %218 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str36, i64 0, i64 0), i32 0) #3
  br label %229

.lr.ph.i87:                                       ; preds = %.lr.ph.i87, %215
  %.05.i84 = phi i8* [ %220, %.lr.ph.i87 ], [ getelementptr inbounds ([3 x i8]* @.str35, i64 0, i64 0), %215 ]
  %.014.i85 = phi i8* [ %219, %.lr.ph.i87 ], [ %2, %215 ]
  %219 = getelementptr inbounds i8* %.014.i85, i64 1
  %220 = getelementptr inbounds i8* %.05.i84, i64 1
  %221 = load i8* %219, align 1, !tbaa !1
  %222 = load i8* %220, align 1, !tbaa !1
  %223 = icmp ne i8 %221, %222
  %224 = icmp eq i8 %221, 0
  %or.cond.i86 = or i1 %223, %224
  br i1 %or.cond.i86, label %225, label %.lr.ph.i87

; <label>:225                                     ; preds = %.lr.ph.i87
  %226 = icmp eq i8 %221, %222
  %227 = zext i1 %226 to i32
  %228 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str36, i64 0, i64 0), i32 %227) #3
  br i1 %226, label %_Z4testiPKcS0_.exit91, label %229

; <label>:229                                     ; preds = %225, %.thread368, %.thread367
  %230 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str36, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit91

_Z4testiPKcS0_.exit91:                            ; preds = %229, %225
  %231 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str37, i64 0, i64 0), %struct.tm* %tm) #3
  %232 = icmp eq i64 %231, 2
  br i1 %232, label %234, label %.thread369

.thread369:                                       ; preds = %_Z4testiPKcS0_.exit91
  %233 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str39, i64 0, i64 0), i32 0) #3
  br label %248

; <label>:234                                     ; preds = %_Z4testiPKcS0_.exit91
  %235 = load i8* %2, align 16, !tbaa !1
  %236 = icmp eq i8 %235, 48
  br i1 %236, label %.lr.ph.i96, label %.thread370

.thread370:                                       ; preds = %234
  %237 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str39, i64 0, i64 0), i32 0) #3
  br label %248

.lr.ph.i96:                                       ; preds = %.lr.ph.i96, %234
  %.05.i93 = phi i8* [ %239, %.lr.ph.i96 ], [ getelementptr inbounds ([3 x i8]* @.str38, i64 0, i64 0), %234 ]
  %.014.i94 = phi i8* [ %238, %.lr.ph.i96 ], [ %2, %234 ]
  %238 = getelementptr inbounds i8* %.014.i94, i64 1
  %239 = getelementptr inbounds i8* %.05.i93, i64 1
  %240 = load i8* %238, align 1, !tbaa !1
  %241 = load i8* %239, align 1, !tbaa !1
  %242 = icmp ne i8 %240, %241
  %243 = icmp eq i8 %240, 0
  %or.cond.i95 = or i1 %242, %243
  br i1 %or.cond.i95, label %244, label %.lr.ph.i96

; <label>:244                                     ; preds = %.lr.ph.i96
  %245 = icmp eq i8 %240, %241
  %246 = zext i1 %245 to i32
  %247 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str39, i64 0, i64 0), i32 %246) #3
  br i1 %245, label %_Z4testiPKcS0_.exit100, label %248

; <label>:248                                     ; preds = %244, %.thread370, %.thread369
  %249 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str39, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit100

_Z4testiPKcS0_.exit100:                           ; preds = %248, %244
  %250 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str40, i64 0, i64 0), %struct.tm* %tm) #3
  %251 = icmp eq i64 %250, 2
  br i1 %251, label %253, label %.thread371

.thread371:                                       ; preds = %_Z4testiPKcS0_.exit100
  %252 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str42, i64 0, i64 0), i32 0) #3
  br label %267

; <label>:253                                     ; preds = %_Z4testiPKcS0_.exit100
  %254 = load i8* %2, align 16, !tbaa !1
  %255 = icmp eq i8 %254, 48
  br i1 %255, label %.lr.ph.i105, label %.thread372

.thread372:                                       ; preds = %253
  %256 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str42, i64 0, i64 0), i32 0) #3
  br label %267

.lr.ph.i105:                                      ; preds = %.lr.ph.i105, %253
  %.05.i102 = phi i8* [ %258, %.lr.ph.i105 ], [ getelementptr inbounds ([3 x i8]* @.str41, i64 0, i64 0), %253 ]
  %.014.i103 = phi i8* [ %257, %.lr.ph.i105 ], [ %2, %253 ]
  %257 = getelementptr inbounds i8* %.014.i103, i64 1
  %258 = getelementptr inbounds i8* %.05.i102, i64 1
  %259 = load i8* %257, align 1, !tbaa !1
  %260 = load i8* %258, align 1, !tbaa !1
  %261 = icmp ne i8 %259, %260
  %262 = icmp eq i8 %259, 0
  %or.cond.i104 = or i1 %261, %262
  br i1 %or.cond.i104, label %263, label %.lr.ph.i105

; <label>:263                                     ; preds = %.lr.ph.i105
  %264 = icmp eq i8 %259, %260
  %265 = zext i1 %264 to i32
  %266 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str42, i64 0, i64 0), i32 %265) #3
  br i1 %264, label %_Z4testiPKcS0_.exit109, label %267

; <label>:267                                     ; preds = %263, %.thread372, %.thread371
  %268 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str42, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit109

_Z4testiPKcS0_.exit109:                           ; preds = %267, %263
  %269 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str43, i64 0, i64 0), %struct.tm* %tm) #3
  %270 = icmp eq i64 %269, 1
  br i1 %270, label %272, label %.thread373

.thread373:                                       ; preds = %_Z4testiPKcS0_.exit109
  %271 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str45, i64 0, i64 0), i32 0) #3
  br label %286

; <label>:272                                     ; preds = %_Z4testiPKcS0_.exit109
  %273 = load i8* %2, align 16, !tbaa !1
  %274 = icmp eq i8 %273, 52
  br i1 %274, label %.lr.ph.i114, label %.thread374

.thread374:                                       ; preds = %272
  %275 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str45, i64 0, i64 0), i32 0) #3
  br label %286

.lr.ph.i114:                                      ; preds = %.lr.ph.i114, %272
  %.05.i111 = phi i8* [ %277, %.lr.ph.i114 ], [ getelementptr inbounds ([2 x i8]* @.str44, i64 0, i64 0), %272 ]
  %.014.i112 = phi i8* [ %276, %.lr.ph.i114 ], [ %2, %272 ]
  %276 = getelementptr inbounds i8* %.014.i112, i64 1
  %277 = getelementptr inbounds i8* %.05.i111, i64 1
  %278 = load i8* %276, align 1, !tbaa !1
  %279 = load i8* %277, align 1, !tbaa !1
  %280 = icmp ne i8 %278, %279
  %281 = icmp eq i8 %278, 0
  %or.cond.i113 = or i1 %280, %281
  br i1 %or.cond.i113, label %282, label %.lr.ph.i114

; <label>:282                                     ; preds = %.lr.ph.i114
  %283 = icmp eq i8 %278, %279
  %284 = zext i1 %283 to i32
  %285 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str45, i64 0, i64 0), i32 %284) #3
  br i1 %283, label %_Z4testiPKcS0_.exit118, label %286

; <label>:286                                     ; preds = %282, %.thread374, %.thread373
  %287 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str45, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit118

_Z4testiPKcS0_.exit118:                           ; preds = %286, %282
  %288 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str46, i64 0, i64 0), %struct.tm* %tm) #3
  %289 = icmp eq i64 %288, 2
  br i1 %289, label %291, label %.thread375

.thread375:                                       ; preds = %_Z4testiPKcS0_.exit118
  %290 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str47, i64 0, i64 0), i32 0) #3
  br label %305

; <label>:291                                     ; preds = %_Z4testiPKcS0_.exit118
  %292 = load i8* %2, align 16, !tbaa !1
  %293 = icmp eq i8 %292, 48
  br i1 %293, label %.lr.ph.i123, label %.thread376

.thread376:                                       ; preds = %291
  %294 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str47, i64 0, i64 0), i32 0) #3
  br label %305

.lr.ph.i123:                                      ; preds = %.lr.ph.i123, %291
  %.05.i120 = phi i8* [ %296, %.lr.ph.i123 ], [ getelementptr inbounds ([3 x i8]* @.str41, i64 0, i64 0), %291 ]
  %.014.i121 = phi i8* [ %295, %.lr.ph.i123 ], [ %2, %291 ]
  %295 = getelementptr inbounds i8* %.014.i121, i64 1
  %296 = getelementptr inbounds i8* %.05.i120, i64 1
  %297 = load i8* %295, align 1, !tbaa !1
  %298 = load i8* %296, align 1, !tbaa !1
  %299 = icmp ne i8 %297, %298
  %300 = icmp eq i8 %297, 0
  %or.cond.i122 = or i1 %299, %300
  br i1 %or.cond.i122, label %301, label %.lr.ph.i123

; <label>:301                                     ; preds = %.lr.ph.i123
  %302 = icmp eq i8 %297, %298
  %303 = zext i1 %302 to i32
  %304 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str47, i64 0, i64 0), i32 %303) #3
  br i1 %302, label %_Z4testiPKcS0_.exit127, label %305

; <label>:305                                     ; preds = %301, %.thread376, %.thread375
  %306 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str47, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit127

_Z4testiPKcS0_.exit127:                           ; preds = %305, %301
  %307 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str48, i64 0, i64 0), %struct.tm* %tm) #3
  %308 = icmp eq i64 %307, 2
  br i1 %308, label %310, label %.thread377

.thread377:                                       ; preds = %_Z4testiPKcS0_.exit127
  %309 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str50, i64 0, i64 0), i32 0) #3
  br label %324

; <label>:310                                     ; preds = %_Z4testiPKcS0_.exit127
  %311 = load i8* %2, align 16, !tbaa !1
  %312 = icmp eq i8 %311, 55
  br i1 %312, label %.lr.ph.i132, label %.thread378

.thread378:                                       ; preds = %310
  %313 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str50, i64 0, i64 0), i32 0) #3
  br label %324

.lr.ph.i132:                                      ; preds = %.lr.ph.i132, %310
  %.05.i129 = phi i8* [ %315, %.lr.ph.i132 ], [ getelementptr inbounds ([3 x i8]* @.str49, i64 0, i64 0), %310 ]
  %.014.i130 = phi i8* [ %314, %.lr.ph.i132 ], [ %2, %310 ]
  %314 = getelementptr inbounds i8* %.014.i130, i64 1
  %315 = getelementptr inbounds i8* %.05.i129, i64 1
  %316 = load i8* %314, align 1, !tbaa !1
  %317 = load i8* %315, align 1, !tbaa !1
  %318 = icmp ne i8 %316, %317
  %319 = icmp eq i8 %316, 0
  %or.cond.i131 = or i1 %318, %319
  br i1 %or.cond.i131, label %320, label %.lr.ph.i132

; <label>:320                                     ; preds = %.lr.ph.i132
  %321 = icmp eq i8 %316, %317
  %322 = zext i1 %321 to i32
  %323 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str50, i64 0, i64 0), i32 %322) #3
  br i1 %321, label %_Z4testiPKcS0_.exit136, label %324

; <label>:324                                     ; preds = %320, %.thread378, %.thread377
  %325 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str50, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit136

_Z4testiPKcS0_.exit136:                           ; preds = %324, %320
  %326 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str51, i64 0, i64 0), %struct.tm* %tm) #3
  %327 = icmp eq i64 %326, 4
  br i1 %327, label %329, label %.thread379

.thread379:                                       ; preds = %_Z4testiPKcS0_.exit136
  %328 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str53, i64 0, i64 0), i32 0) #3
  br label %343

; <label>:329                                     ; preds = %_Z4testiPKcS0_.exit136
  %330 = load i8* %2, align 16, !tbaa !1
  %331 = icmp eq i8 %330, 49
  br i1 %331, label %.lr.ph.i141, label %.thread380

.thread380:                                       ; preds = %329
  %332 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str53, i64 0, i64 0), i32 0) #3
  br label %343

.lr.ph.i141:                                      ; preds = %.lr.ph.i141, %329
  %.05.i138 = phi i8* [ %334, %.lr.ph.i141 ], [ getelementptr inbounds ([5 x i8]* @.str52, i64 0, i64 0), %329 ]
  %.014.i139 = phi i8* [ %333, %.lr.ph.i141 ], [ %2, %329 ]
  %333 = getelementptr inbounds i8* %.014.i139, i64 1
  %334 = getelementptr inbounds i8* %.05.i138, i64 1
  %335 = load i8* %333, align 1, !tbaa !1
  %336 = load i8* %334, align 1, !tbaa !1
  %337 = icmp ne i8 %335, %336
  %338 = icmp eq i8 %335, 0
  %or.cond.i140 = or i1 %337, %338
  br i1 %or.cond.i140, label %339, label %.lr.ph.i141

; <label>:339                                     ; preds = %.lr.ph.i141
  %340 = icmp eq i8 %335, %336
  %341 = zext i1 %340 to i32
  %342 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str53, i64 0, i64 0), i32 %341) #3
  br i1 %340, label %_Z4testiPKcS0_.exit145, label %343

; <label>:343                                     ; preds = %339, %.thread380, %.thread379
  %344 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str53, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit145

_Z4testiPKcS0_.exit145:                           ; preds = %343, %339
  %345 = call i64 @strftime(i8* %2, i64 1000, i8* getelementptr inbounds ([3 x i8]* @.str54, i64 0, i64 0), %struct.tm* %tm) #3
  %346 = icmp eq i64 %345, 1
  br i1 %346, label %348, label %.thread381

.thread381:                                       ; preds = %_Z4testiPKcS0_.exit145
  %347 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str56, i64 0, i64 0), i32 0) #3
  br label %362

; <label>:348                                     ; preds = %_Z4testiPKcS0_.exit145
  %349 = load i8* %2, align 16, !tbaa !1
  %350 = icmp eq i8 %349, 37
  br i1 %350, label %.lr.ph.i150, label %.thread382

.thread382:                                       ; preds = %348
  %351 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str56, i64 0, i64 0), i32 0) #3
  br label %362

.lr.ph.i150:                                      ; preds = %.lr.ph.i150, %348
  %.05.i147 = phi i8* [ %353, %.lr.ph.i150 ], [ getelementptr inbounds ([2 x i8]* @.str55, i64 0, i64 0), %348 ]
  %.014.i148 = phi i8* [ %352, %.lr.ph.i150 ], [ %2, %348 ]
  %352 = getelementptr inbounds i8* %.014.i148, i64 1
  %353 = getelementptr inbounds i8* %.05.i147, i64 1
  %354 = load i8* %352, align 1, !tbaa !1
  %355 = load i8* %353, align 1, !tbaa !1
  %356 = icmp ne i8 %354, %355
  %357 = icmp eq i8 %354, 0
  %or.cond.i149 = or i1 %356, %357
  br i1 %or.cond.i149, label %358, label %.lr.ph.i150

; <label>:358                                     ; preds = %.lr.ph.i150
  %359 = icmp eq i8 %354, %355
  %360 = zext i1 %359 to i32
  %361 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str56, i64 0, i64 0), i32 %360) #3
  br i1 %359, label %_Z4testiPKcS0_.exit154, label %362

; <label>:362                                     ; preds = %358, %.thread382, %.thread381
  %363 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str56, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit154

_Z4testiPKcS0_.exit154:                           ; preds = %362, %358
  %364 = call i64 @strftime(i8* %2, i64 5, i8* getelementptr inbounds ([3 x i8]* @.str51, i64 0, i64 0), %struct.tm* %tm) #3
  %365 = icmp eq i64 %364, 4
  br i1 %365, label %367, label %.thread383

.thread383:                                       ; preds = %_Z4testiPKcS0_.exit154
  %366 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str57, i64 0, i64 0), i32 0) #3
  br label %381

; <label>:367                                     ; preds = %_Z4testiPKcS0_.exit154
  %368 = load i8* %2, align 16, !tbaa !1
  %369 = icmp eq i8 %368, 49
  br i1 %369, label %.lr.ph.i159, label %.thread384

.thread384:                                       ; preds = %367
  %370 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str57, i64 0, i64 0), i32 0) #3
  br label %381

.lr.ph.i159:                                      ; preds = %.lr.ph.i159, %367
  %.05.i156 = phi i8* [ %372, %.lr.ph.i159 ], [ getelementptr inbounds ([5 x i8]* @.str52, i64 0, i64 0), %367 ]
  %.014.i157 = phi i8* [ %371, %.lr.ph.i159 ], [ %2, %367 ]
  %371 = getelementptr inbounds i8* %.014.i157, i64 1
  %372 = getelementptr inbounds i8* %.05.i156, i64 1
  %373 = load i8* %371, align 1, !tbaa !1
  %374 = load i8* %372, align 1, !tbaa !1
  %375 = icmp ne i8 %373, %374
  %376 = icmp eq i8 %373, 0
  %or.cond.i158 = or i1 %375, %376
  br i1 %or.cond.i158, label %377, label %.lr.ph.i159

; <label>:377                                     ; preds = %.lr.ph.i159
  %378 = icmp eq i8 %373, %374
  %379 = zext i1 %378 to i32
  %380 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str57, i64 0, i64 0), i32 %379) #3
  br i1 %378, label %_Z4testiPKcS0_.exit163, label %381

; <label>:381                                     ; preds = %377, %.thread384, %.thread383
  %382 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str57, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit163

_Z4testiPKcS0_.exit163:                           ; preds = %381, %377
  %383 = call i64 @strftime(i8* %2, i64 4, i8* getelementptr inbounds ([3 x i8]* @.str51, i64 0, i64 0), %struct.tm* %tm) #3
  %384 = icmp eq i64 %383, 0
  %385 = zext i1 %384 to i32
  %386 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str58, i64 0, i64 0), i32 %385) #3
  br i1 %384, label %_Z4testiPKcS0_.exit164, label %387

; <label>:387                                     ; preds = %_Z4testiPKcS0_.exit163
  %388 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str58, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit164

_Z4testiPKcS0_.exit164:                           ; preds = %387, %_Z4testiPKcS0_.exit163
  store i32 0, i32* %7, align 8, !tbaa !12
  store i32 1, i32* %6, align 4, !tbaa !11
  %389 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([3 x i8]* @.str40, i64 0, i64 0), %struct.tm* %tm) #3
  %390 = icmp eq i64 %389, 2
  br i1 %390, label %392, label %.thread385

.thread385:                                       ; preds = %_Z4testiPKcS0_.exit164
  %391 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str60, i64 0, i64 0), i32 0) #3
  br label %406

; <label>:392                                     ; preds = %_Z4testiPKcS0_.exit164
  %393 = load i8* %2, align 16, !tbaa !1
  %394 = icmp eq i8 %393, 48
  br i1 %394, label %.lr.ph.i169, label %.thread386

.thread386:                                       ; preds = %392
  %395 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str60, i64 0, i64 0), i32 0) #3
  br label %406

.lr.ph.i169:                                      ; preds = %.lr.ph.i169, %392
  %.05.i166 = phi i8* [ %397, %.lr.ph.i169 ], [ getelementptr inbounds ([3 x i8]* @.str59, i64 0, i64 0), %392 ]
  %.014.i167 = phi i8* [ %396, %.lr.ph.i169 ], [ %2, %392 ]
  %396 = getelementptr inbounds i8* %.014.i167, i64 1
  %397 = getelementptr inbounds i8* %.05.i166, i64 1
  %398 = load i8* %396, align 1, !tbaa !1
  %399 = load i8* %397, align 1, !tbaa !1
  %400 = icmp ne i8 %398, %399
  %401 = icmp eq i8 %398, 0
  %or.cond.i168 = or i1 %400, %401
  br i1 %or.cond.i168, label %402, label %.lr.ph.i169

; <label>:402                                     ; preds = %.lr.ph.i169
  %403 = icmp eq i8 %398, %399
  %404 = zext i1 %403 to i32
  %405 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str60, i64 0, i64 0), i32 %404) #3
  br i1 %403, label %_Z4testiPKcS0_.exit173, label %406

; <label>:406                                     ; preds = %402, %.thread386, %.thread385
  %407 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str60, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit173

_Z4testiPKcS0_.exit173:                           ; preds = %406, %402
  %408 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([3 x i8]* @.str46, i64 0, i64 0), %struct.tm* %tm) #3
  %409 = icmp eq i64 %408, 2
  br i1 %409, label %411, label %.thread387

.thread387:                                       ; preds = %_Z4testiPKcS0_.exit173
  %410 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str61, i64 0, i64 0), i32 0) #3
  br label %425

; <label>:411                                     ; preds = %_Z4testiPKcS0_.exit173
  %412 = load i8* %2, align 16, !tbaa !1
  %413 = icmp eq i8 %412, 48
  br i1 %413, label %.lr.ph.i178, label %.thread388

.thread388:                                       ; preds = %411
  %414 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str61, i64 0, i64 0), i32 0) #3
  br label %425

.lr.ph.i178:                                      ; preds = %.lr.ph.i178, %411
  %.05.i175 = phi i8* [ %416, %.lr.ph.i178 ], [ getelementptr inbounds ([3 x i8]* @.str59, i64 0, i64 0), %411 ]
  %.014.i176 = phi i8* [ %415, %.lr.ph.i178 ], [ %2, %411 ]
  %415 = getelementptr inbounds i8* %.014.i176, i64 1
  %416 = getelementptr inbounds i8* %.05.i175, i64 1
  %417 = load i8* %415, align 1, !tbaa !1
  %418 = load i8* %416, align 1, !tbaa !1
  %419 = icmp ne i8 %417, %418
  %420 = icmp eq i8 %417, 0
  %or.cond.i177 = or i1 %419, %420
  br i1 %or.cond.i177, label %421, label %.lr.ph.i178

; <label>:421                                     ; preds = %.lr.ph.i178
  %422 = icmp eq i8 %417, %418
  %423 = zext i1 %422 to i32
  %424 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str61, i64 0, i64 0), i32 %423) #3
  br i1 %422, label %_Z4testiPKcS0_.exit182, label %425

; <label>:425                                     ; preds = %421, %.thread388, %.thread387
  %426 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str61, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit182

_Z4testiPKcS0_.exit182:                           ; preds = %425, %421
  store i32 73, i32* %8, align 4, !tbaa !13
  %427 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([3 x i8]* @.str46, i64 0, i64 0), %struct.tm* %tm) #3
  %428 = icmp eq i64 %427, 2
  br i1 %428, label %430, label %.thread389

.thread389:                                       ; preds = %_Z4testiPKcS0_.exit182
  %429 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str63, i64 0, i64 0), i32 0) #3
  br label %444

; <label>:430                                     ; preds = %_Z4testiPKcS0_.exit182
  %431 = load i8* %2, align 16, !tbaa !1
  %432 = icmp eq i8 %431, 48
  br i1 %432, label %.lr.ph.i187, label %.thread390

.thread390:                                       ; preds = %430
  %433 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str63, i64 0, i64 0), i32 0) #3
  br label %444

.lr.ph.i187:                                      ; preds = %.lr.ph.i187, %430
  %.05.i184 = phi i8* [ %435, %.lr.ph.i187 ], [ getelementptr inbounds ([3 x i8]* @.str62, i64 0, i64 0), %430 ]
  %.014.i185 = phi i8* [ %434, %.lr.ph.i187 ], [ %2, %430 ]
  %434 = getelementptr inbounds i8* %.014.i185, i64 1
  %435 = getelementptr inbounds i8* %.05.i184, i64 1
  %436 = load i8* %434, align 1, !tbaa !1
  %437 = load i8* %435, align 1, !tbaa !1
  %438 = icmp ne i8 %436, %437
  %439 = icmp eq i8 %436, 0
  %or.cond.i186 = or i1 %438, %439
  br i1 %or.cond.i186, label %440, label %.lr.ph.i187

; <label>:440                                     ; preds = %.lr.ph.i187
  %441 = icmp eq i8 %436, %437
  %442 = zext i1 %441 to i32
  %443 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str63, i64 0, i64 0), i32 %442) #3
  br i1 %441, label %_Z4testiPKcS0_.exit191, label %444

; <label>:444                                     ; preds = %440, %.thread390, %.thread389
  %445 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str63, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit191

_Z4testiPKcS0_.exit191:                           ; preds = %444, %440
  store i32 78, i32* %8, align 4, !tbaa !13
  %446 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([3 x i8]* @.str40, i64 0, i64 0), %struct.tm* %tm) #3
  %447 = icmp eq i64 %446, 2
  br i1 %447, label %449, label %.thread391

.thread391:                                       ; preds = %_Z4testiPKcS0_.exit191
  %448 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str64, i64 0, i64 0), i32 0) #3
  br label %463

; <label>:449                                     ; preds = %_Z4testiPKcS0_.exit191
  %450 = load i8* %2, align 16, !tbaa !1
  %451 = icmp eq i8 %450, 48
  br i1 %451, label %.lr.ph.i196, label %.thread392

.thread392:                                       ; preds = %449
  %452 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str64, i64 0, i64 0), i32 0) #3
  br label %463

.lr.ph.i196:                                      ; preds = %.lr.ph.i196, %449
  %.05.i193 = phi i8* [ %454, %.lr.ph.i196 ], [ getelementptr inbounds ([3 x i8]* @.str62, i64 0, i64 0), %449 ]
  %.014.i194 = phi i8* [ %453, %.lr.ph.i196 ], [ %2, %449 ]
  %453 = getelementptr inbounds i8* %.014.i194, i64 1
  %454 = getelementptr inbounds i8* %.05.i193, i64 1
  %455 = load i8* %453, align 1, !tbaa !1
  %456 = load i8* %454, align 1, !tbaa !1
  %457 = icmp ne i8 %455, %456
  %458 = icmp eq i8 %455, 0
  %or.cond.i195 = or i1 %457, %458
  br i1 %or.cond.i195, label %459, label %.lr.ph.i196

; <label>:459                                     ; preds = %.lr.ph.i196
  %460 = icmp eq i8 %455, %456
  %461 = zext i1 %460 to i32
  %462 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str64, i64 0, i64 0), i32 %461) #3
  br i1 %460, label %_Z4testiPKcS0_.exit200, label %463

; <label>:463                                     ; preds = %459, %.thread392, %.thread391
  %464 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str64, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit200

_Z4testiPKcS0_.exit200:                           ; preds = %463, %459
  store i32 99, i32* %8, align 4, !tbaa !13
  store i32 1, i32* %10, align 4, !tbaa !15
  %465 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([8 x i8]* @.str65, i64 0, i64 0), %struct.tm* %tm) #3
  %466 = icmp eq i64 %465, 9
  br i1 %466, label %468, label %.thread393

.thread393:                                       ; preds = %_Z4testiPKcS0_.exit200
  %467 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str67, i64 0, i64 0), i32 0) #3
  br label %482

; <label>:468                                     ; preds = %_Z4testiPKcS0_.exit200
  %469 = load i8* %2, align 16, !tbaa !1
  %470 = icmp eq i8 %469, 49
  br i1 %470, label %.lr.ph.i205, label %.thread394

.thread394:                                       ; preds = %468
  %471 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str67, i64 0, i64 0), i32 0) #3
  br label %482

.lr.ph.i205:                                      ; preds = %.lr.ph.i205, %468
  %.05.i202 = phi i8* [ %473, %.lr.ph.i205 ], [ getelementptr inbounds ([10 x i8]* @.str66, i64 0, i64 0), %468 ]
  %.014.i203 = phi i8* [ %472, %.lr.ph.i205 ], [ %2, %468 ]
  %472 = getelementptr inbounds i8* %.014.i203, i64 1
  %473 = getelementptr inbounds i8* %.05.i202, i64 1
  %474 = load i8* %472, align 1, !tbaa !1
  %475 = load i8* %473, align 1, !tbaa !1
  %476 = icmp ne i8 %474, %475
  %477 = icmp eq i8 %474, 0
  %or.cond.i204 = or i1 %476, %477
  br i1 %or.cond.i204, label %478, label %.lr.ph.i205

; <label>:478                                     ; preds = %.lr.ph.i205
  %479 = icmp eq i8 %474, %475
  %480 = zext i1 %479 to i32
  %481 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str67, i64 0, i64 0), i32 %480) #3
  br i1 %479, label %_Z4testiPKcS0_.exit209, label %482

; <label>:482                                     ; preds = %478, %.thread394, %.thread393
  %483 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str67, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit209

_Z4testiPKcS0_.exit209:                           ; preds = %482, %478
  %484 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([3 x i8]* @.str68, i64 0, i64 0), %struct.tm* %tm) #3
  %485 = icmp eq i64 %484, 2
  br i1 %485, label %487, label %.thread395

.thread395:                                       ; preds = %_Z4testiPKcS0_.exit209
  %486 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str70, i64 0, i64 0), i32 0) #3
  br label %501

; <label>:487                                     ; preds = %_Z4testiPKcS0_.exit209
  %488 = load i8* %2, align 16, !tbaa !1
  %489 = icmp eq i8 %488, 57
  br i1 %489, label %.lr.ph.i214, label %.thread396

.thread396:                                       ; preds = %487
  %490 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str70, i64 0, i64 0), i32 0) #3
  br label %501

.lr.ph.i214:                                      ; preds = %.lr.ph.i214, %487
  %.05.i211 = phi i8* [ %492, %.lr.ph.i214 ], [ getelementptr inbounds ([3 x i8]* @.str69, i64 0, i64 0), %487 ]
  %.014.i212 = phi i8* [ %491, %.lr.ph.i214 ], [ %2, %487 ]
  %491 = getelementptr inbounds i8* %.014.i212, i64 1
  %492 = getelementptr inbounds i8* %.05.i211, i64 1
  %493 = load i8* %491, align 1, !tbaa !1
  %494 = load i8* %492, align 1, !tbaa !1
  %495 = icmp ne i8 %493, %494
  %496 = icmp eq i8 %493, 0
  %or.cond.i213 = or i1 %495, %496
  br i1 %or.cond.i213, label %497, label %.lr.ph.i214

; <label>:497                                     ; preds = %.lr.ph.i214
  %498 = icmp eq i8 %493, %494
  %499 = zext i1 %498 to i32
  %500 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str70, i64 0, i64 0), i32 %499) #3
  br i1 %498, label %_Z4testiPKcS0_.exit218, label %501

; <label>:501                                     ; preds = %497, %.thread396, %.thread395
  %502 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str70, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit218

_Z4testiPKcS0_.exit218:                           ; preds = %501, %497
  store i32 97, i32* %8, align 4, !tbaa !13
  store i32 363, i32* %10, align 4, !tbaa !15
  %503 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([8 x i8]* @.str65, i64 0, i64 0), %struct.tm* %tm) #3
  %504 = icmp eq i64 %503, 9
  br i1 %504, label %506, label %.thread397

.thread397:                                       ; preds = %_Z4testiPKcS0_.exit218
  %505 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str72, i64 0, i64 0), i32 0) #3
  br label %520

; <label>:506                                     ; preds = %_Z4testiPKcS0_.exit218
  %507 = load i8* %2, align 16, !tbaa !1
  %508 = icmp eq i8 %507, 49
  br i1 %508, label %.lr.ph.i223, label %.thread398

.thread398:                                       ; preds = %506
  %509 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str72, i64 0, i64 0), i32 0) #3
  br label %520

.lr.ph.i223:                                      ; preds = %.lr.ph.i223, %506
  %.05.i220 = phi i8* [ %511, %.lr.ph.i223 ], [ getelementptr inbounds ([10 x i8]* @.str71, i64 0, i64 0), %506 ]
  %.014.i221 = phi i8* [ %510, %.lr.ph.i223 ], [ %2, %506 ]
  %510 = getelementptr inbounds i8* %.014.i221, i64 1
  %511 = getelementptr inbounds i8* %.05.i220, i64 1
  %512 = load i8* %510, align 1, !tbaa !1
  %513 = load i8* %511, align 1, !tbaa !1
  %514 = icmp ne i8 %512, %513
  %515 = icmp eq i8 %512, 0
  %or.cond.i222 = or i1 %514, %515
  br i1 %or.cond.i222, label %516, label %.lr.ph.i223

; <label>:516                                     ; preds = %.lr.ph.i223
  %517 = icmp eq i8 %512, %513
  %518 = zext i1 %517 to i32
  %519 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str72, i64 0, i64 0), i32 %518) #3
  br i1 %517, label %_Z4testiPKcS0_.exit227, label %520

; <label>:520                                     ; preds = %516, %.thread398, %.thread397
  %521 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str72, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit227

_Z4testiPKcS0_.exit227:                           ; preds = %520, %516
  %522 = call i64 @strftime(i8* %2, i64 10, i8* getelementptr inbounds ([3 x i8]* @.str68, i64 0, i64 0), %struct.tm* %tm) #3
  %523 = icmp eq i64 %522, 2
  br i1 %523, label %525, label %.thread399

.thread399:                                       ; preds = %_Z4testiPKcS0_.exit227
  %524 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str73, i64 0, i64 0), i32 0) #3
  br label %539

; <label>:525                                     ; preds = %_Z4testiPKcS0_.exit227
  %526 = load i8* %2, align 16, !tbaa !1
  %527 = icmp eq i8 %526, 57
  br i1 %527, label %.lr.ph.i232, label %.thread400

.thread400:                                       ; preds = %525
  %528 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str73, i64 0, i64 0), i32 0) #3
  br label %539

.lr.ph.i232:                                      ; preds = %.lr.ph.i232, %525
  %.05.i229 = phi i8* [ %530, %.lr.ph.i232 ], [ getelementptr inbounds ([3 x i8]* @.str69, i64 0, i64 0), %525 ]
  %.014.i230 = phi i8* [ %529, %.lr.ph.i232 ], [ %2, %525 ]
  %529 = getelementptr inbounds i8* %.014.i230, i64 1
  %530 = getelementptr inbounds i8* %.05.i229, i64 1
  %531 = load i8* %529, align 1, !tbaa !1
  %532 = load i8* %530, align 1, !tbaa !1
  %533 = icmp ne i8 %531, %532
  %534 = icmp eq i8 %531, 0
  %or.cond.i231 = or i1 %533, %534
  br i1 %or.cond.i231, label %535, label %.lr.ph.i232

; <label>:535                                     ; preds = %.lr.ph.i232
  %536 = icmp eq i8 %531, %532
  %537 = zext i1 %536 to i32
  %538 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str73, i64 0, i64 0), i32 %537) #3
  br i1 %536, label %_Z4testiPKcS0_.exit236, label %539

; <label>:539                                     ; preds = %535, %.thread400, %.thread399
  %540 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str73, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit236

_Z4testiPKcS0_.exit236:                           ; preds = %539, %535
  store i64 1040786563, i64* %xmas2002, align 8, !tbaa !17
  store i64 1025528525, i64* %summer2002, align 8, !tbaa !17
  %541 = call %struct.tm* @localtime_r(i64* %summer2002, %struct.tm* %tm) #3
  %542 = call i64 @timegm(%struct.tm* %tm) #3
  %543 = load i64* %summer2002, align 8, !tbaa !17
  %544 = call i64 @strftime(i8* %2, i64 50, i8* getelementptr inbounds ([3 x i8]* @.str74, i64 0, i64 0), %struct.tm* %tm) #3
  %545 = icmp eq i64 %544, 5
  br i1 %545, label %547, label %.thread401

.thread401:                                       ; preds = %_Z4testiPKcS0_.exit236
  %546 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str75, i64 0, i64 0), i32 0) #3
  br label %554

; <label>:547                                     ; preds = %_Z4testiPKcS0_.exit236
  %548 = icmp sge i64 %542, %543
  %549 = select i1 %548, i32 43, i32 45
  %550 = call i8* @strchr(i8* %2, i32 %549) #5
  %551 = icmp ne i8* %550, null
  %552 = zext i1 %551 to i32
  %553 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str75, i64 0, i64 0), i32 %552) #3
  br i1 %551, label %_Z4testiPKcS0_.exit237, label %554

; <label>:554                                     ; preds = %547, %.thread401
  %555 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str75, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit237

_Z4testiPKcS0_.exit237:                           ; preds = %554, %547
  %556 = call i64 @strftime(i8* %2, i64 50, i8* getelementptr inbounds ([3 x i8]* @.str76, i64 0, i64 0), %struct.tm* %tm) #3
  %557 = load i32* %11, align 8, !tbaa !16
  %558 = sext i32 %557 to i64
  %559 = getelementptr inbounds [2 x i8*]* @tzname, i64 0, i64 %558
  %560 = load i8** %559, align 8, !tbaa !18
  %561 = call i32 @strcmp(i8* %2, i8* %560) #5
  %562 = icmp eq i32 %561, 0
  %563 = zext i1 %562 to i32
  %564 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str77, i64 0, i64 0), i32 %563) #3
  br i1 %562, label %_Z4testiPKcS0_.exit238, label %565

; <label>:565                                     ; preds = %_Z4testiPKcS0_.exit237
  %566 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str77, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit238

_Z4testiPKcS0_.exit238:                           ; preds = %565, %_Z4testiPKcS0_.exit237
  %567 = call %struct.tm* @localtime_r(i64* %xmas2002, %struct.tm* %tm) #3
  %568 = call i64 @timegm(%struct.tm* %tm) #3
  %569 = load i64* %xmas2002, align 8, !tbaa !17
  %570 = call i64 @strftime(i8* %2, i64 50, i8* getelementptr inbounds ([3 x i8]* @.str74, i64 0, i64 0), %struct.tm* %tm) #3
  %571 = icmp eq i64 %570, 5
  br i1 %571, label %573, label %.thread402

.thread402:                                       ; preds = %_Z4testiPKcS0_.exit238
  %572 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str78, i64 0, i64 0), i32 0) #3
  br label %580

; <label>:573                                     ; preds = %_Z4testiPKcS0_.exit238
  %574 = icmp sge i64 %568, %569
  %575 = select i1 %574, i32 43, i32 45
  %576 = call i8* @strchr(i8* %2, i32 %575) #5
  %577 = icmp ne i8* %576, null
  %578 = zext i1 %577 to i32
  %579 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str78, i64 0, i64 0), i32 %578) #3
  br i1 %577, label %_Z4testiPKcS0_.exit239, label %580

; <label>:580                                     ; preds = %573, %.thread402
  %581 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str78, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit239

_Z4testiPKcS0_.exit239:                           ; preds = %580, %573
  %582 = call i64 @strftime(i8* %2, i64 50, i8* getelementptr inbounds ([3 x i8]* @.str76, i64 0, i64 0), %struct.tm* %tm) #3
  %583 = load i32* %11, align 8, !tbaa !16
  %584 = sext i32 %583 to i64
  %585 = getelementptr inbounds [2 x i8*]* @tzname, i64 0, i64 %584
  %586 = load i8** %585, align 8, !tbaa !18
  %587 = call i32 @strcmp(i8* %2, i8* %586) #5
  %588 = icmp eq i32 %587, 0
  %589 = zext i1 %588 to i32
  %590 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str79, i64 0, i64 0), i32 %589) #3
  br i1 %588, label %_Z4testiPKcS0_.exit240, label %591

; <label>:591                                     ; preds = %_Z4testiPKcS0_.exit239
  %592 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str79, i64 0, i64 0), i8* %2) #3
  br label %_Z4testiPKcS0_.exit240

_Z4testiPKcS0_.exit240:                           ; preds = %591, %_Z4testiPKcS0_.exit239
  call void @llvm.lifetime.end(i64 1000, i8* %2) #3
  call void @llvm.lifetime.end(i64 56, i8* %1) #3
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #3

; Function Attrs: nounwind
declare i64 @strftime(i8*, i64, i8*, %struct.tm*) #1

; Function Attrs: nounwind
declare %struct.tm* @localtime_r(i64*, %struct.tm*) #1

; Function Attrs: nounwind
declare i64 @timegm(%struct.tm*) #1

; Function Attrs: nounwind readonly
declare i8* @strchr(i8*, i32) #4

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !6, i64 0}
!5 = metadata !{metadata !"_ZTS2tm", metadata !6, i64 0, metadata !6, i64 4, metadata !6, i64 8, metadata !6, i64 12, metadata !6, i64 16, metadata !6, i64 20, metadata !6, i64 24, metadata !6, i64 28, metadata !6, i64 32, metadata !7, i64 40, metadata !8, i64 48}
!6 = metadata !{metadata !"int", metadata !2, i64 0}
!7 = metadata !{metadata !"long", metadata !2, i64 0}
!8 = metadata !{metadata !"any pointer", metadata !2, i64 0}
!9 = metadata !{metadata !5, metadata !6, i64 4}
!10 = metadata !{metadata !5, metadata !6, i64 8}
!11 = metadata !{metadata !5, metadata !6, i64 12}
!12 = metadata !{metadata !5, metadata !6, i64 16}
!13 = metadata !{metadata !5, metadata !6, i64 20}
!14 = metadata !{metadata !5, metadata !6, i64 24}
!15 = metadata !{metadata !5, metadata !6, i64 28}
!16 = metadata !{metadata !5, metadata !6, i64 32}
!17 = metadata !{metadata !7, metadata !7, i64 0}
!18 = metadata !{metadata !8, metadata !8, i64 0}
