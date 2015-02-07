; ModuleID = 'test_varargs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str2 = private unnamed_addr constant [4 x i8] c"abc\00", align 1
@.str3 = private unnamed_addr constant [4 x i8] c"def\00", align 1
@.str4 = private unnamed_addr constant [4 x i8] c"ghi\00", align 1
@.str5 = private unnamed_addr constant [4 x i8] c"jkl\00", align 1
@.str6 = private unnamed_addr constant [4 x i8] c"mno\00", align 1
@.str7 = private unnamed_addr constant [8 x i8] c"<BAD+0>\00", align 1
@.str8 = private unnamed_addr constant [8 x i8] c"<BAD+1>\00", align 1
@.str9 = private unnamed_addr constant [8 x i8] c"<BAD+2>\00", align 1
@.str10 = private unnamed_addr constant [8 x i8] c"<BAD+3>\00", align 1
@.str11 = private unnamed_addr constant [8 x i8] c"<BAD+4>\00", align 1
@.str12 = private unnamed_addr constant [8 x i8] c"<BAD+5>\00", align 1
@.str13 = private unnamed_addr constant [8 x i8] c"<BAD+6>\00", align 1
@.str14 = private unnamed_addr constant [8 x i8] c"<BAD+7>\00", align 1
@.str15 = private unnamed_addr constant [8 x i8] c"<BAD+8>\00", align 1
@.str16 = private unnamed_addr constant [8 x i8] c"<BAD+9>\00", align 1
@.str17 = private unnamed_addr constant [9 x i8] c"<BAD+10>\00", align 1
@.str18 = private unnamed_addr constant [9 x i8] c"<BAD+11>\00", align 1
@.str19 = private unnamed_addr constant [9 x i8] c"<BAD+12>\00", align 1
@.str20 = private unnamed_addr constant [9 x i8] c"<BAD+13>\00", align 1
@.str21 = private unnamed_addr constant [9 x i8] c"<BAD+14>\00", align 1
@.str22 = private unnamed_addr constant [9 x i8] c"<BAD+15>\00", align 1
@.str23 = private unnamed_addr constant [9 x i8] c"<BAD+16>\00", align 1
@.str24 = private unnamed_addr constant [15 x i8] c"*cheez: %d+%d*\00", align 1
@.str25 = private unnamed_addr constant [9 x i8] c"*albeit*\00", align 1
@.str26 = private unnamed_addr constant [4 x i8] c"%d*\00", align 1
@.str27 = private unnamed_addr constant [11 x i8] c"maxxi:%d*\0A\00", align 1
@.str28 = private unnamed_addr constant [13 x i8] c"maxxD:%.2f*\0A\00", align 1
@.str29 = private unnamed_addr constant [12 x i8] c"*vfp:%d,%d*\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z4varyPKcz(i8* nocapture readonly %s, ...) #0 {
  %v = alloca [1 x %struct.__va_list_tag], align 16
  %d = alloca [20 x i8], align 16
  %tempva = alloca [1 x %struct.__va_list_tag], align 16
  %1 = getelementptr inbounds [1 x %struct.__va_list_tag]* %v, i64 0, i64 0
  %2 = bitcast [1 x %struct.__va_list_tag]* %v to i8*
  call void @llvm.va_start(i8* %2)
  %3 = getelementptr inbounds [20 x i8]* %d, i64 0, i64 0
  %4 = call i32 @vsnprintf(i8* %3, i64 20, i8* %s, %struct.__va_list_tag* %1) #1
  %5 = call i32 @puts(i8* %3)
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag]* %tempva, i64 0, i64 0
  %7 = bitcast [1 x %struct.__va_list_tag]* %tempva to i8*
  call void @llvm.va_copy(i8* %7, i8* %2)
  %8 = call i32 @vsnprintf(i8* %3, i64 20, i8* %s, %struct.__va_list_tag* %6) #1
  %9 = call i32 @puts(i8* %3)
  call void @llvm.va_end(i8* %2)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

; Function Attrs: nounwind
declare i32 @vsnprintf(i8* nocapture, i64, i8* nocapture readonly, %struct.__va_list_tag*) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

; Function Attrs: nounwind
declare void @llvm.va_copy(i8*, i8*) #1

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind uwtable
define void @_Z5vary2cPKcz(i8 signext %color, i8* nocapture readonly %s, ...) #0 {
  %v = alloca [1 x %struct.__va_list_tag], align 16
  %d = alloca [21 x i8], align 16
  %1 = getelementptr inbounds [1 x %struct.__va_list_tag]* %v, i64 0, i64 0
  %2 = bitcast [1 x %struct.__va_list_tag]* %v to i8*
  call void @llvm.va_start(i8* %2)
  %3 = getelementptr inbounds [21 x i8]* %d, i64 0, i64 0
  store i8 %color, i8* %3, align 16, !tbaa !1
  %4 = getelementptr inbounds [21 x i8]* %d, i64 0, i64 1
  %5 = call i32 @vsnprintf(i8* %4, i64 20, i8* %s, %struct.__va_list_tag* %1) #1
  %6 = call i32 @puts(i8* %3)
  call void @llvm.va_end(i8* %2)
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi(i32 %count, %struct.__va_list_tag* nocapture %ap, i32 %vaIteration) #0 {
  %1 = icmp sgt i32 %count, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %2 = getelementptr inbounds %struct.__va_list_tag* %ap, i64 0, i32 0
  %3 = getelementptr inbounds %struct.__va_list_tag* %ap, i64 0, i32 3
  %4 = getelementptr inbounds %struct.__va_list_tag* %ap, i64 0, i32 2
  br label %5

; <label>:5                                       ; preds = %16, %.lr.ph
  %.01 = phi i32 [ %count, %.lr.ph ], [ %20, %16 ]
  %6 = load i32* %2, align 4
  %7 = icmp ult i32 %6, 41
  br i1 %7, label %8, label %13

; <label>:8                                       ; preds = %5
  %9 = load i8** %3, align 8
  %10 = sext i32 %6 to i64
  %11 = getelementptr i8* %9, i64 %10
  %12 = add i32 %6, 8
  store i32 %12, i32* %2, align 4
  br label %16

; <label>:13                                      ; preds = %5
  %14 = load i8** %4, align 8
  %15 = getelementptr i8* %14, i64 8
  store i8* %15, i8** %4, align 8
  br label %16

; <label>:16                                      ; preds = %13, %8
  %.in = phi i8* [ %11, %8 ], [ %14, %13 ]
  %17 = bitcast i8* %.in to i8**
  %18 = load i8** %17, align 8
  %19 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %18)
  %20 = add nsw i32 %.01, -1
  %21 = icmp sgt i32 %20, 0
  br i1 %21, label %5, label %._crit_edge

._crit_edge:                                      ; preds = %16, %0
  %putchar = tail call i32 @putchar(i32 10)
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind uwtable
define void @_Z28varags_listoffsets_list_copyiP13__va_list_tagi(i32 %count, %struct.__va_list_tag* %ap, i32 %iteration) #0 {
  %ap_copy = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %ap_copy to i8*
  %2 = bitcast %struct.__va_list_tag* %ap to i8*
  call void @llvm.va_copy(i8* %1, i8* %2)
  %3 = icmp sgt i32 %count, 0
  br i1 %3, label %.lr.ph.i, label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit

.lr.ph.i:                                         ; preds = %0
  %4 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy, i64 0, i64 0, i32 0
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy, i64 0, i64 0, i32 3
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy, i64 0, i64 0, i32 2
  br label %7

; <label>:7                                       ; preds = %18, %.lr.ph.i
  %.01.i = phi i32 [ %count, %.lr.ph.i ], [ %22, %18 ]
  %8 = load i32* %4, align 16
  %9 = icmp ult i32 %8, 41
  br i1 %9, label %10, label %15

; <label>:10                                      ; preds = %7
  %11 = load i8** %5, align 16
  %12 = sext i32 %8 to i64
  %13 = getelementptr i8* %11, i64 %12
  %14 = add i32 %8, 8
  store i32 %14, i32* %4, align 16
  br label %18

; <label>:15                                      ; preds = %7
  %16 = load i8** %6, align 8
  %17 = getelementptr i8* %16, i64 8
  store i8* %17, i8** %6, align 8
  br label %18

; <label>:18                                      ; preds = %15, %10
  %.in.i = phi i8* [ %13, %10 ], [ %16, %15 ]
  %19 = bitcast i8* %.in.i to i8**
  %20 = load i8** %19, align 8
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %20) #1
  %22 = add nsw i32 %.01.i, -1
  %23 = icmp sgt i32 %22, 0
  br i1 %23, label %7, label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit

_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit: ; preds = %18, %0
  %putchar.i = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %1)
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z24varargs_listoffsets_argsiiz(i32 %type, i32 %count, ...) #0 {
  %ap_copy.i = alloca [1 x %struct.__va_list_tag], align 16
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*
  call void @llvm.va_start(i8* %1)
  %2 = bitcast [1 x %struct.__va_list_tag]* %ap_copy.i to i8*
  call void @llvm.lifetime.start(i64 24, i8* %2) #1
  call void @llvm.va_copy(i8* %2, i8* %1) #1
  %3 = icmp sgt i32 %count, 0
  br i1 %3, label %.lr.ph.i.i, label %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6.critedge

.lr.ph.i.i:                                       ; preds = %0
  %4 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 0
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 3
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 2
  br label %7

; <label>:7                                       ; preds = %18, %.lr.ph.i.i
  %.01.i.i = phi i32 [ %count, %.lr.ph.i.i ], [ %22, %18 ]
  %8 = load i32* %4, align 16
  %9 = icmp ult i32 %8, 41
  br i1 %9, label %10, label %15

; <label>:10                                      ; preds = %7
  %11 = load i8** %5, align 16
  %12 = sext i32 %8 to i64
  %13 = getelementptr i8* %11, i64 %12
  %14 = add i32 %8, 8
  store i32 %14, i32* %4, align 16
  br label %18

; <label>:15                                      ; preds = %7
  %16 = load i8** %6, align 8
  %17 = getelementptr i8* %16, i64 8
  store i8* %17, i8** %6, align 8
  br label %18

; <label>:18                                      ; preds = %15, %10
  %.in.i.i = phi i8* [ %13, %10 ], [ %16, %15 ]
  %19 = bitcast i8* %.in.i.i to i8**
  %20 = load i8** %19, align 8
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %20) #1
  %22 = add nsw i32 %.01.i.i, -1
  %23 = icmp sgt i32 %22, 0
  br i1 %23, label %7, label %.lr.ph.i.i2

.lr.ph.i.i2:                                      ; preds = %18
  %putchar.i.i = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %2) #1
  call void @llvm.lifetime.end(i64 24, i8* %2) #1
  call void @llvm.lifetime.start(i64 24, i8* %2) #1
  call void @llvm.va_copy(i8* %2, i8* %1) #1
  br label %24

; <label>:24                                      ; preds = %35, %.lr.ph.i.i2
  %.01.i.i3 = phi i32 [ %count, %.lr.ph.i.i2 ], [ %39, %35 ]
  %25 = load i32* %4, align 16
  %26 = icmp ult i32 %25, 41
  br i1 %26, label %27, label %32

; <label>:27                                      ; preds = %24
  %28 = load i8** %5, align 16
  %29 = sext i32 %25 to i64
  %30 = getelementptr i8* %28, i64 %29
  %31 = add i32 %25, 8
  store i32 %31, i32* %4, align 16
  br label %35

; <label>:32                                      ; preds = %24
  %33 = load i8** %6, align 8
  %34 = getelementptr i8* %33, i64 8
  store i8* %34, i8** %6, align 8
  br label %35

; <label>:35                                      ; preds = %32, %27
  %.in.i.i4 = phi i8* [ %30, %27 ], [ %33, %32 ]
  %36 = bitcast i8* %.in.i.i4 to i8**
  %37 = load i8** %36, align 8
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %37) #1
  %39 = add nsw i32 %.01.i.i3, -1
  %40 = icmp sgt i32 %39, 0
  br i1 %40, label %24, label %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6

_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6.critedge: ; preds = %0
  %putchar.i.i.c = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %2) #1
  call void @llvm.lifetime.end(i64 24, i8* %2) #1
  call void @llvm.lifetime.start(i64 24, i8* %2) #1
  call void @llvm.va_copy(i8* %2, i8* %1) #1
  br label %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6

_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6: ; preds = %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6.critedge, %35
  %putchar.i.i5 = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %2) #1
  call void @llvm.lifetime.end(i64 24, i8* %2) #1
  call void @llvm.lifetime.start(i64 24, i8* %2) #1
  call void @llvm.va_copy(i8* %2, i8* %1) #1
  br i1 %3, label %.lr.ph.i.i8, label %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18.critedge

.lr.ph.i.i8:                                      ; preds = %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6
  %41 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 0
  %42 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 3
  %43 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 2
  br label %44

; <label>:44                                      ; preds = %55, %.lr.ph.i.i8
  %.01.i.i9 = phi i32 [ %count, %.lr.ph.i.i8 ], [ %59, %55 ]
  %45 = load i32* %41, align 16
  %46 = icmp ult i32 %45, 41
  br i1 %46, label %47, label %52

; <label>:47                                      ; preds = %44
  %48 = load i8** %42, align 16
  %49 = sext i32 %45 to i64
  %50 = getelementptr i8* %48, i64 %49
  %51 = add i32 %45, 8
  store i32 %51, i32* %41, align 16
  br label %55

; <label>:52                                      ; preds = %44
  %53 = load i8** %43, align 8
  %54 = getelementptr i8* %53, i64 8
  store i8* %54, i8** %43, align 8
  br label %55

; <label>:55                                      ; preds = %52, %47
  %.in.i.i10 = phi i8* [ %50, %47 ], [ %53, %52 ]
  %56 = bitcast i8* %.in.i.i10 to i8**
  %57 = load i8** %56, align 8
  %58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %57) #1
  %59 = add nsw i32 %.01.i.i9, -1
  %60 = icmp sgt i32 %59, 0
  br i1 %60, label %44, label %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit12

_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit12: ; preds = %55
  %putchar.i.i11 = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %2) #1
  call void @llvm.lifetime.end(i64 24, i8* %2) #1
  call void @llvm.lifetime.start(i64 24, i8* %2) #1
  call void @llvm.va_copy(i8* %2, i8* %1) #1
  br i1 %3, label %.lr.ph.i.i14, label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit.thread.critedge

.lr.ph.i.i14:                                     ; preds = %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit12
  %61 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 0
  %62 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 3
  %63 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0, i32 2
  br label %64

; <label>:64                                      ; preds = %75, %.lr.ph.i.i14
  %.01.i.i15 = phi i32 [ %count, %.lr.ph.i.i14 ], [ %79, %75 ]
  %65 = load i32* %61, align 16
  %66 = icmp ult i32 %65, 41
  br i1 %66, label %67, label %72

; <label>:67                                      ; preds = %64
  %68 = load i8** %62, align 16
  %69 = sext i32 %65 to i64
  %70 = getelementptr i8* %68, i64 %69
  %71 = add i32 %65, 8
  store i32 %71, i32* %61, align 16
  br label %75

; <label>:72                                      ; preds = %64
  %73 = load i8** %63, align 8
  %74 = getelementptr i8* %73, i64 8
  store i8* %74, i8** %63, align 8
  br label %75

; <label>:75                                      ; preds = %72, %67
  %.in.i.i16 = phi i8* [ %70, %67 ], [ %73, %72 ]
  %76 = bitcast i8* %.in.i.i16 to i8**
  %77 = load i8** %76, align 8
  %78 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %77) #1
  %79 = add nsw i32 %.01.i.i15, -1
  %80 = icmp sgt i32 %79, 0
  br i1 %80, label %64, label %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18

_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18.critedge: ; preds = %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit6
  %putchar.i.i11.c = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %2) #1
  call void @llvm.lifetime.end(i64 24, i8* %2) #1
  call void @llvm.lifetime.start(i64 24, i8* %2) #1
  call void @llvm.va_copy(i8* %2, i8* %1) #1
  br label %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18

_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18: ; preds = %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18.critedge, %75
  %putchar.i.i17 = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %2) #1
  call void @llvm.lifetime.end(i64 24, i8* %2) #1
  br i1 %3, label %.lr.ph.i, label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit.thread

_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit.thread.critedge: ; preds = %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit12
  %putchar.i.i17.c = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %2) #1
  call void @llvm.lifetime.end(i64 24, i8* %2) #1
  br label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit.thread

_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit.thread: ; preds = %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit.thread.critedge, %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18
  %putchar.i29 = call i32 @putchar(i32 10) #1
  br label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit23

.lr.ph.i:                                         ; preds = %_Z28varags_listoffsets_list_copyiP13__va_list_tagi.exit18
  %81 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0
  %82 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3
  %83 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2
  br label %84

; <label>:84                                      ; preds = %95, %.lr.ph.i
  %.01.i = phi i32 [ %count, %.lr.ph.i ], [ %99, %95 ]
  %85 = load i32* %81, align 16
  %86 = icmp ult i32 %85, 41
  br i1 %86, label %87, label %92

; <label>:87                                      ; preds = %84
  %88 = load i8** %82, align 16
  %89 = sext i32 %85 to i64
  %90 = getelementptr i8* %88, i64 %89
  %91 = add i32 %85, 8
  store i32 %91, i32* %81, align 16
  br label %95

; <label>:92                                      ; preds = %84
  %93 = load i8** %83, align 8
  %94 = getelementptr i8* %93, i64 8
  store i8* %94, i8** %83, align 8
  br label %95

; <label>:95                                      ; preds = %92, %87
  %.in.i = phi i8* [ %90, %87 ], [ %93, %92 ]
  %96 = bitcast i8* %.in.i to i8**
  %97 = load i8** %96, align 8
  %98 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %97) #1
  %99 = add nsw i32 %.01.i, -1
  %100 = icmp sgt i32 %99, 0
  br i1 %100, label %84, label %.lr.ph.i19

.lr.ph.i19:                                       ; preds = %95
  %putchar.i = call i32 @putchar(i32 10) #1
  br label %101

; <label>:101                                     ; preds = %112, %.lr.ph.i19
  %.01.i20 = phi i32 [ %count, %.lr.ph.i19 ], [ %116, %112 ]
  %102 = load i32* %81, align 16
  %103 = icmp ult i32 %102, 41
  br i1 %103, label %104, label %109

; <label>:104                                     ; preds = %101
  %105 = load i8** %82, align 16
  %106 = sext i32 %102 to i64
  %107 = getelementptr i8* %105, i64 %106
  %108 = add i32 %102, 8
  store i32 %108, i32* %81, align 16
  br label %112

; <label>:109                                     ; preds = %101
  %110 = load i8** %83, align 8
  %111 = getelementptr i8* %110, i64 8
  store i8* %111, i8** %83, align 8
  br label %112

; <label>:112                                     ; preds = %109, %104
  %.in.i21 = phi i8* [ %107, %104 ], [ %110, %109 ]
  %113 = bitcast i8* %.in.i21 to i8**
  %114 = load i8** %113, align 8
  %115 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %114) #1
  %116 = add nsw i32 %.01.i20, -1
  %117 = icmp sgt i32 %116, 0
  br i1 %117, label %101, label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit23

_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit23: ; preds = %112, %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit.thread
  %putchar.i22 = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %1)
  call void @llvm.va_start(i8* %1)
  br i1 %3, label %.lr.ph.i24, label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit28

.lr.ph.i24:                                       ; preds = %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit23
  %118 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0
  %119 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3
  %120 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2
  br label %121

; <label>:121                                     ; preds = %132, %.lr.ph.i24
  %.01.i25 = phi i32 [ %count, %.lr.ph.i24 ], [ %136, %132 ]
  %122 = load i32* %118, align 16
  %123 = icmp ult i32 %122, 41
  br i1 %123, label %124, label %129

; <label>:124                                     ; preds = %121
  %125 = load i8** %119, align 16
  %126 = sext i32 %122 to i64
  %127 = getelementptr i8* %125, i64 %126
  %128 = add i32 %122, 8
  store i32 %128, i32* %118, align 16
  br label %132

; <label>:129                                     ; preds = %121
  %130 = load i8** %120, align 8
  %131 = getelementptr i8* %130, i64 8
  store i8* %131, i8** %120, align 8
  br label %132

; <label>:132                                     ; preds = %129, %124
  %.in.i26 = phi i8* [ %127, %124 ], [ %130, %129 ]
  %133 = bitcast i8* %.in.i26 to i8**
  %134 = load i8** %133, align 8
  %135 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %134) #1
  %136 = add nsw i32 %.01.i25, -1
  %137 = icmp sgt i32 %136, 0
  br i1 %137, label %121, label %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit28

_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit28: ; preds = %132, %_Z33varargs_listoffsets_list_evaluateiP13__va_list_tagi.exit23
  %putchar.i27 = call i32 @putchar(i32 10) #1
  call void @llvm.va_end(i8* %1)
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z24varargs_listoffsets_mainv() #0 {
  tail call void (i32, i32, ...)* @_Z24varargs_listoffsets_argsiiz(i32 undef, i32 5, i8* getelementptr inbounds ([4 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str13, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str15, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str16, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str19, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str20, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str21, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str23, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @_Z7getMaxiiz(i32 %num, ...) #0 {
  %vv = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vv to i8*
  call void @llvm.va_start(i8* %1)
  %2 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 0
  %3 = load i32* %2, align 16
  %4 = icmp ult i32 %3, 41
  br i1 %4, label %5, label %11

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 3
  %7 = load i8** %6, align 16
  %8 = sext i32 %3 to i64
  %9 = getelementptr i8* %7, i64 %8
  %10 = add i32 %3, 8
  store i32 %10, i32* %2, align 16
  br label %15

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 2
  %13 = load i8** %12, align 8
  %14 = getelementptr i8* %13, i64 8
  store i8* %14, i8** %12, align 8
  br label %15

; <label>:15                                      ; preds = %11, %5
  %16 = phi i32 [ %10, %5 ], [ %3, %11 ]
  %.in = phi i8* [ %9, %5 ], [ %13, %11 ]
  %17 = bitcast i8* %.in to i32*
  %18 = load i32* %17, align 4
  %19 = icmp sgt i32 %num, 1
  br i1 %19, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %15
  %20 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 3
  %21 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 2
  br label %22

; <label>:22                                      ; preds = %33, %.lr.ph
  %23 = phi i32 [ %16, %.lr.ph ], [ %34, %33 ]
  %maxx.03 = phi i32 [ %18, %.lr.ph ], [ %38, %33 ]
  %i.02 = phi i32 [ 1, %.lr.ph ], [ %39, %33 ]
  %24 = icmp ult i32 %23, 41
  br i1 %24, label %25, label %30

; <label>:25                                      ; preds = %22
  %26 = load i8** %20, align 16
  %27 = sext i32 %23 to i64
  %28 = getelementptr i8* %26, i64 %27
  %29 = add i32 %23, 8
  store i32 %29, i32* %2, align 16
  br label %33

; <label>:30                                      ; preds = %22
  %31 = load i8** %21, align 8
  %32 = getelementptr i8* %31, i64 8
  store i8* %32, i8** %21, align 8
  br label %33

; <label>:33                                      ; preds = %30, %25
  %34 = phi i32 [ %29, %25 ], [ %23, %30 ]
  %.in1 = phi i8* [ %28, %25 ], [ %31, %30 ]
  %35 = bitcast i8* %.in1 to i32*
  %36 = load i32* %35, align 4
  %37 = icmp sgt i32 %36, %maxx.03
  %38 = select i1 %37, i32 %36, i32 %maxx.03
  %39 = add nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %39, %num
  br i1 %exitcond, label %._crit_edge, label %22

._crit_edge:                                      ; preds = %33, %15
  %maxx.0.lcssa = phi i32 [ %18, %15 ], [ %38, %33 ]
  call void @llvm.va_end(i8* %1)
  ret i32 %maxx.0.lcssa
}

; Function Attrs: nounwind uwtable
define double @_Z7getMaxDiz(i32 %num, ...) #0 {
  %vv = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vv to i8*
  call void @llvm.va_start(i8* %1)
  %2 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 1
  %3 = load i32* %2, align 4
  %4 = icmp ult i32 %3, 161
  br i1 %4, label %5, label %11

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 3
  %7 = load i8** %6, align 16
  %8 = sext i32 %3 to i64
  %9 = getelementptr i8* %7, i64 %8
  %10 = add i32 %3, 16
  store i32 %10, i32* %2, align 4
  br label %15

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 2
  %13 = load i8** %12, align 8
  %14 = getelementptr i8* %13, i64 8
  store i8* %14, i8** %12, align 8
  br label %15

; <label>:15                                      ; preds = %11, %5
  %16 = phi i32 [ %10, %5 ], [ %3, %11 ]
  %.in = phi i8* [ %9, %5 ], [ %13, %11 ]
  %17 = bitcast i8* %.in to double*
  %18 = load double* %17, align 8
  %19 = icmp sgt i32 %num, 1
  br i1 %19, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %15
  %20 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 3
  %21 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vv, i64 0, i64 0, i32 2
  br label %22

; <label>:22                                      ; preds = %33, %.lr.ph
  %23 = phi i32 [ %16, %.lr.ph ], [ %34, %33 ]
  %maxx.03 = phi double [ %18, %.lr.ph ], [ %38, %33 ]
  %i.02 = phi i32 [ 1, %.lr.ph ], [ %39, %33 ]
  %24 = icmp ult i32 %23, 161
  br i1 %24, label %25, label %30

; <label>:25                                      ; preds = %22
  %26 = load i8** %20, align 16
  %27 = sext i32 %23 to i64
  %28 = getelementptr i8* %26, i64 %27
  %29 = add i32 %23, 16
  store i32 %29, i32* %2, align 4
  br label %33

; <label>:30                                      ; preds = %22
  %31 = load i8** %21, align 8
  %32 = getelementptr i8* %31, i64 8
  store i8* %32, i8** %21, align 8
  br label %33

; <label>:33                                      ; preds = %30, %25
  %34 = phi i32 [ %29, %25 ], [ %23, %30 ]
  %.in1 = phi i8* [ %28, %25 ], [ %31, %30 ]
  %35 = bitcast i8* %.in1 to double*
  %36 = load double* %35, align 8
  %37 = fcmp ogt double %36, %maxx.03
  %38 = select i1 %37, double %36, double %maxx.03
  %39 = add nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %39, %num
  br i1 %exitcond, label %._crit_edge, label %22

._crit_edge:                                      ; preds = %33, %15
  %maxx.0.lcssa = phi double [ %18, %15 ], [ %38, %33 ]
  call void @llvm.va_end(i8* %1)
  ret double %maxx.0.lcssa
}

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #3 {
  tail call void (i8*, ...)* @_Z4varyPKcz(i8* getelementptr inbounds ([15 x i8]* @.str24, i64 0, i64 0), i32 0, i32 24)
  tail call void (i8*, ...)* @_Z4varyPKcz(i8* getelementptr inbounds ([9 x i8]* @.str25, i64 0, i64 0))
  tail call void (i8, i8*, ...)* @_Z5vary2cPKcz(i8 signext 81, i8* getelementptr inbounds ([4 x i8]* @.str26, i64 0, i64 0), i32 85)
  %1 = tail call i32 (i32, ...)* @_Z7getMaxiiz(i32 6, i32 2, i32 5, i32 21, i32 4, i32 -10, i32 19)
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str27, i64 0, i64 0), i32 %1)
  %3 = tail call double (i32, ...)* @_Z7getMaxDiz(i32 6, double 2.100000e+00, double 5.100000e+00, double 2.210000e+01, double 4.100000e+00, double -1.010000e+01, double 1.910000e+01, double 2.000000e+00)
  %4 = fptrunc double %3 to float
  %5 = fpext float %4 to double
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str28, i64 0, i64 0), double %5)
  %7 = icmp eq i32 %argc, 1211
  %8 = select i1 %7, void (i8*, ...)* null, void (i8*, ...)* @_Z4varyPKcz
  tail call void (i8*, ...)* %8(i8* getelementptr inbounds ([12 x i8]* @.str29, i64 0, i64 0), i32 22, i32 199)
  tail call void (i32, i32, ...)* @_Z24varargs_listoffsets_argsiiz(i32 undef, i32 5, i8* getelementptr inbounds ([4 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str13, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str15, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str16, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str19, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str20, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str21, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str23, i64 0, i64 0)) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @putchar(i32) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
