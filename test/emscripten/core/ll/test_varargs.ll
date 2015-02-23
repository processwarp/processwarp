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
define void @vary(i8* nocapture readonly %s, ...) #0 {
  %v = alloca [1 x %struct.__va_list_tag], align 16
  %d = alloca [20 x i8], align 16
  %tempva = alloca [1 x %struct.__va_list_tag], align 16
  %1 = getelementptr inbounds [1 x %struct.__va_list_tag]* %v, i64 0, i64 0
  %2 = bitcast [1 x %struct.__va_list_tag]* %v to i8*
  call void @llvm.va_start(i8* %2)
  %3 = getelementptr inbounds [20 x i8]* %d, i64 0, i64 0
  %4 = call i32 @vsnprintf(i8* %3, i64 20, i8* %s, %struct.__va_list_tag* %1) #1
  %5 = call i32 @puts(i8* %3) #1
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag]* %tempva, i64 0, i64 0
  %7 = bitcast [1 x %struct.__va_list_tag]* %tempva to i8*
  call void @llvm.va_copy(i8* %7, i8* %2)
  %8 = call i32 @vsnprintf(i8* %3, i64 20, i8* %s, %struct.__va_list_tag* %6) #1
  %9 = call i32 @puts(i8* %3) #1
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
define void @vary2(i8 signext %color, i8* nocapture readonly %s, ...) #0 {
  %v = alloca [1 x %struct.__va_list_tag], align 16
  %d = alloca [21 x i8], align 16
  %1 = getelementptr inbounds [1 x %struct.__va_list_tag]* %v, i64 0, i64 0
  %2 = bitcast [1 x %struct.__va_list_tag]* %v to i8*
  call void @llvm.va_start(i8* %2)
  %3 = getelementptr inbounds [21 x i8]* %d, i64 0, i64 0
  store i8 %color, i8* %3, align 16, !tbaa !1
  %4 = getelementptr inbounds [21 x i8]* %d, i64 0, i64 1
  %5 = call i32 @vsnprintf(i8* %4, i64 20, i8* %s, %struct.__va_list_tag* %1) #1
  %6 = call i32 @puts(i8* %3) #1
  call void @llvm.va_end(i8* %2)
  ret void
}

; Function Attrs: nounwind uwtable
define void @varargs_listoffsets_list_evaluate(i32 %count, %struct.__va_list_tag* %ap, i32 %vaIteration) #0 {
  %1 = alloca %struct.__va_list_tag*, align 8
  store %struct.__va_list_tag* %ap, %struct.__va_list_tag** %1, align 8, !tbaa !4
  %2 = icmp sgt i32 %count, 0
  br i1 %2, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %3 = bitcast %struct.__va_list_tag** %1 to [1 x %struct.__va_list_tag]*
  br label %4

; <label>:4                                       ; preds = %4, %.lr.ph
  %.01 = phi i32 [ %count, %.lr.ph ], [ %9, %4 ]
  %5 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %3, i64 8) #1
  %6 = bitcast i8* %5 to i8**
  %7 = load i8** %6, align 8, !tbaa !4
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %7) #1
  %9 = add nsw i32 %.01, -1
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %4, label %._crit_edge

._crit_edge:                                      ; preds = %4, %0
  %putchar = call i32 @putchar(i32 10) #1
  ret void
}

declare i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]*, i64) #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind uwtable
define void @varags_listoffsets_list_copy(i32 %count, %struct.__va_list_tag* %ap, i32 %iteration) #0 {
  %1 = alloca %struct.__va_list_tag*, align 8
  %ap_copy = alloca [1 x %struct.__va_list_tag], align 16
  %2 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy, i64 0, i64 0
  %3 = bitcast [1 x %struct.__va_list_tag]* %ap_copy to i8*
  %4 = bitcast %struct.__va_list_tag* %ap to i8*
  call void @llvm.va_copy(i8* %3, i8* %4)
  %5 = bitcast %struct.__va_list_tag** %1 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %5) #1
  store %struct.__va_list_tag* %2, %struct.__va_list_tag** %1, align 8, !tbaa !4
  %6 = icmp sgt i32 %count, 0
  br i1 %6, label %.lr.ph.i, label %varargs_listoffsets_list_evaluate.exit

.lr.ph.i:                                         ; preds = %0
  %7 = bitcast %struct.__va_list_tag** %1 to [1 x %struct.__va_list_tag]*
  br label %8

; <label>:8                                       ; preds = %8, %.lr.ph.i
  %.01.i = phi i32 [ %count, %.lr.ph.i ], [ %13, %8 ]
  %9 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %7, i64 8) #1
  %10 = bitcast i8* %9 to i8**
  %11 = load i8** %10, align 8, !tbaa !4
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %11) #1
  %13 = add nsw i32 %.01.i, -1
  %14 = icmp sgt i32 %13, 0
  br i1 %14, label %8, label %varargs_listoffsets_list_evaluate.exit

varargs_listoffsets_list_evaluate.exit:           ; preds = %8, %0
  %putchar.i = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %5) #1
  call void @llvm.va_end(i8* %3)
  ret void
}

; Function Attrs: nounwind uwtable
define void @varargs_listoffsets_args(i32 %type, i32 %count, ...) #0 {
  %1 = alloca %struct.__va_list_tag*, align 8
  %2 = alloca %struct.__va_list_tag*, align 8
  %3 = alloca %struct.__va_list_tag*, align 8
  %4 = alloca %struct.__va_list_tag*, align 8
  %5 = alloca %struct.__va_list_tag*, align 8
  %6 = alloca %struct.__va_list_tag*, align 8
  %7 = alloca %struct.__va_list_tag*, align 8
  %ap_copy.i = alloca [1 x %struct.__va_list_tag], align 16
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0
  %9 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*
  call void @llvm.va_start(i8* %9)
  %10 = bitcast [1 x %struct.__va_list_tag]* %ap_copy.i to i8*
  call void @llvm.lifetime.start(i64 24, i8* %10) #1
  %11 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap_copy.i, i64 0, i64 0
  call void @llvm.va_copy(i8* %10, i8* %9) #1
  %12 = bitcast %struct.__va_list_tag** %7 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %12) #1
  store %struct.__va_list_tag* %11, %struct.__va_list_tag** %7, align 8, !tbaa !4
  %13 = icmp sgt i32 %count, 0
  br i1 %13, label %.lr.ph.i.i, label %varags_listoffsets_list_copy.exit

.lr.ph.i.i:                                       ; preds = %0
  %14 = bitcast %struct.__va_list_tag** %7 to [1 x %struct.__va_list_tag]*
  br label %15

; <label>:15                                      ; preds = %15, %.lr.ph.i.i
  %.01.i.i = phi i32 [ %count, %.lr.ph.i.i ], [ %20, %15 ]
  %16 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %14, i64 8) #1
  %17 = bitcast i8* %16 to i8**
  %18 = load i8** %17, align 8, !tbaa !4
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %18) #1
  %20 = add nsw i32 %.01.i.i, -1
  %21 = icmp sgt i32 %20, 0
  br i1 %21, label %15, label %varags_listoffsets_list_copy.exit

varags_listoffsets_list_copy.exit:                ; preds = %15, %0
  %putchar.i.i = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %12) #1
  call void @llvm.va_end(i8* %10) #1
  call void @llvm.lifetime.end(i64 24, i8* %10) #1
  call void @llvm.lifetime.start(i64 24, i8* %10) #1
  call void @llvm.va_copy(i8* %10, i8* %9) #1
  %22 = bitcast %struct.__va_list_tag** %6 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %22) #1
  store %struct.__va_list_tag* %11, %struct.__va_list_tag** %6, align 8, !tbaa !4
  br i1 %13, label %.lr.ph.i.i2, label %varags_listoffsets_list_copy.exit5

.lr.ph.i.i2:                                      ; preds = %varags_listoffsets_list_copy.exit
  %23 = bitcast %struct.__va_list_tag** %6 to [1 x %struct.__va_list_tag]*
  br label %24

; <label>:24                                      ; preds = %24, %.lr.ph.i.i2
  %.01.i.i3 = phi i32 [ %count, %.lr.ph.i.i2 ], [ %29, %24 ]
  %25 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %23, i64 8) #1
  %26 = bitcast i8* %25 to i8**
  %27 = load i8** %26, align 8, !tbaa !4
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %27) #1
  %29 = add nsw i32 %.01.i.i3, -1
  %30 = icmp sgt i32 %29, 0
  br i1 %30, label %24, label %varags_listoffsets_list_copy.exit5

varags_listoffsets_list_copy.exit5:               ; preds = %24, %varags_listoffsets_list_copy.exit
  %putchar.i.i4 = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %22) #1
  call void @llvm.va_end(i8* %10) #1
  call void @llvm.lifetime.end(i64 24, i8* %10) #1
  call void @llvm.lifetime.start(i64 24, i8* %10) #1
  call void @llvm.va_copy(i8* %10, i8* %9) #1
  %31 = bitcast %struct.__va_list_tag** %5 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %31) #1
  store %struct.__va_list_tag* %11, %struct.__va_list_tag** %5, align 8, !tbaa !4
  br i1 %13, label %.lr.ph.i.i7, label %varags_listoffsets_list_copy.exit10

.lr.ph.i.i7:                                      ; preds = %varags_listoffsets_list_copy.exit5
  %32 = bitcast %struct.__va_list_tag** %5 to [1 x %struct.__va_list_tag]*
  br label %33

; <label>:33                                      ; preds = %33, %.lr.ph.i.i7
  %.01.i.i8 = phi i32 [ %count, %.lr.ph.i.i7 ], [ %38, %33 ]
  %34 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %32, i64 8) #1
  %35 = bitcast i8* %34 to i8**
  %36 = load i8** %35, align 8, !tbaa !4
  %37 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %36) #1
  %38 = add nsw i32 %.01.i.i8, -1
  %39 = icmp sgt i32 %38, 0
  br i1 %39, label %33, label %varags_listoffsets_list_copy.exit10

varags_listoffsets_list_copy.exit10:              ; preds = %33, %varags_listoffsets_list_copy.exit5
  %putchar.i.i9 = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %31) #1
  call void @llvm.va_end(i8* %10) #1
  call void @llvm.lifetime.end(i64 24, i8* %10) #1
  call void @llvm.lifetime.start(i64 24, i8* %10) #1
  call void @llvm.va_copy(i8* %10, i8* %9) #1
  %40 = bitcast %struct.__va_list_tag** %4 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %40) #1
  store %struct.__va_list_tag* %11, %struct.__va_list_tag** %4, align 8, !tbaa !4
  br i1 %13, label %.lr.ph.i.i12, label %varags_listoffsets_list_copy.exit15

.lr.ph.i.i12:                                     ; preds = %varags_listoffsets_list_copy.exit10
  %41 = bitcast %struct.__va_list_tag** %4 to [1 x %struct.__va_list_tag]*
  br label %42

; <label>:42                                      ; preds = %42, %.lr.ph.i.i12
  %.01.i.i13 = phi i32 [ %count, %.lr.ph.i.i12 ], [ %47, %42 ]
  %43 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %41, i64 8) #1
  %44 = bitcast i8* %43 to i8**
  %45 = load i8** %44, align 8, !tbaa !4
  %46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %45) #1
  %47 = add nsw i32 %.01.i.i13, -1
  %48 = icmp sgt i32 %47, 0
  br i1 %48, label %42, label %varags_listoffsets_list_copy.exit15

varags_listoffsets_list_copy.exit15:              ; preds = %42, %varags_listoffsets_list_copy.exit10
  %putchar.i.i14 = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %40) #1
  call void @llvm.va_end(i8* %10) #1
  call void @llvm.lifetime.end(i64 24, i8* %10) #1
  %49 = bitcast %struct.__va_list_tag** %3 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %49) #1
  store %struct.__va_list_tag* %8, %struct.__va_list_tag** %3, align 8, !tbaa !4
  br i1 %13, label %.lr.ph.i, label %varargs_listoffsets_list_evaluate.exit

.lr.ph.i:                                         ; preds = %varags_listoffsets_list_copy.exit15
  %50 = bitcast %struct.__va_list_tag** %3 to [1 x %struct.__va_list_tag]*
  br label %51

; <label>:51                                      ; preds = %51, %.lr.ph.i
  %.01.i = phi i32 [ %count, %.lr.ph.i ], [ %56, %51 ]
  %52 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %50, i64 8) #1
  %53 = bitcast i8* %52 to i8**
  %54 = load i8** %53, align 8, !tbaa !4
  %55 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %54) #1
  %56 = add nsw i32 %.01.i, -1
  %57 = icmp sgt i32 %56, 0
  br i1 %57, label %51, label %varargs_listoffsets_list_evaluate.exit

varargs_listoffsets_list_evaluate.exit:           ; preds = %51, %varags_listoffsets_list_copy.exit15
  %putchar.i = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %49) #1
  %58 = bitcast %struct.__va_list_tag** %2 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %58) #1
  store %struct.__va_list_tag* %8, %struct.__va_list_tag** %2, align 8, !tbaa !4
  br i1 %13, label %.lr.ph.i16, label %varargs_listoffsets_list_evaluate.exit19

.lr.ph.i16:                                       ; preds = %varargs_listoffsets_list_evaluate.exit
  %59 = bitcast %struct.__va_list_tag** %2 to [1 x %struct.__va_list_tag]*
  br label %60

; <label>:60                                      ; preds = %60, %.lr.ph.i16
  %.01.i17 = phi i32 [ %count, %.lr.ph.i16 ], [ %65, %60 ]
  %61 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %59, i64 8) #1
  %62 = bitcast i8* %61 to i8**
  %63 = load i8** %62, align 8, !tbaa !4
  %64 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %63) #1
  %65 = add nsw i32 %.01.i17, -1
  %66 = icmp sgt i32 %65, 0
  br i1 %66, label %60, label %varargs_listoffsets_list_evaluate.exit19

varargs_listoffsets_list_evaluate.exit19:         ; preds = %60, %varargs_listoffsets_list_evaluate.exit
  %putchar.i18 = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %58) #1
  call void @llvm.va_end(i8* %9)
  call void @llvm.va_start(i8* %9)
  %67 = bitcast %struct.__va_list_tag** %1 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %67) #1
  store %struct.__va_list_tag* %8, %struct.__va_list_tag** %1, align 8, !tbaa !4
  br i1 %13, label %.lr.ph.i20, label %varargs_listoffsets_list_evaluate.exit23

.lr.ph.i20:                                       ; preds = %varargs_listoffsets_list_evaluate.exit19
  %68 = bitcast %struct.__va_list_tag** %1 to [1 x %struct.__va_list_tag]*
  br label %69

; <label>:69                                      ; preds = %69, %.lr.ph.i20
  %.01.i21 = phi i32 [ %count, %.lr.ph.i20 ], [ %74, %69 ]
  %70 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %68, i64 8) #1
  %71 = bitcast i8* %70 to i8**
  %72 = load i8** %71, align 8, !tbaa !4
  %73 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %72) #1
  %74 = add nsw i32 %.01.i21, -1
  %75 = icmp sgt i32 %74, 0
  br i1 %75, label %69, label %varargs_listoffsets_list_evaluate.exit23

varargs_listoffsets_list_evaluate.exit23:         ; preds = %69, %varargs_listoffsets_list_evaluate.exit19
  %putchar.i22 = call i32 @putchar(i32 10) #1
  call void @llvm.lifetime.end(i64 8, i8* %67) #1
  call void @llvm.va_end(i8* %9)
  ret void
}

; Function Attrs: nounwind uwtable
define void @varargs_listoffsets_main() #0 {
  tail call void (i32, i32, ...)* @varargs_listoffsets_args(i32 undef, i32 5, i8* getelementptr inbounds ([4 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str13, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str15, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str16, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str19, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str20, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str21, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str23, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @getMaxi(i32 %num, ...) #0 {
  %vv = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vv to i8*
  call void @llvm.va_start(i8* %1)
  %2 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vv, i64 4) #1
  %3 = bitcast i8* %2 to i32*
  %4 = load i32* %3, align 4, !tbaa !6
  %5 = icmp sgt i32 %num, 1
  br i1 %5, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %0
  %maxx.02 = phi i32 [ %10, %.lr.ph ], [ %4, %0 ]
  %i.01 = phi i32 [ %11, %.lr.ph ], [ 1, %0 ]
  %6 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vv, i64 4) #1
  %7 = bitcast i8* %6 to i32*
  %8 = load i32* %7, align 4, !tbaa !6
  %9 = icmp sgt i32 %8, %maxx.02
  %10 = select i1 %9, i32 %8, i32 %maxx.02
  %11 = add nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %11, %num
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  %maxx.0.lcssa = phi i32 [ %4, %0 ], [ %10, %.lr.ph ]
  call void @llvm.va_end(i8* %1)
  ret i32 %maxx.0.lcssa
}

; Function Attrs: nounwind uwtable
define double @getMaxD(i32 %num, ...) #0 {
  %vv = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vv to i8*
  call void @llvm.va_start(i8* %1)
  %2 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vv, i64 8) #1
  %3 = bitcast i8* %2 to double*
  %4 = load double* %3, align 8, !tbaa !8
  %5 = icmp sgt i32 %num, 1
  br i1 %5, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %0
  %maxx.02 = phi double [ %10, %.lr.ph ], [ %4, %0 ]
  %i.01 = phi i32 [ %11, %.lr.ph ], [ 1, %0 ]
  %6 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vv, i64 8) #1
  %7 = bitcast i8* %6 to double*
  %8 = load double* %7, align 8, !tbaa !8
  %9 = fcmp ogt double %8, %maxx.02
  %10 = select i1 %9, double %8, double %maxx.02
  %11 = add nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %11, %num
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  %maxx.0.lcssa = phi double [ %4, %0 ], [ %10, %.lr.ph ]
  call void @llvm.va_end(i8* %1)
  ret double %maxx.0.lcssa
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  tail call void (i8*, ...)* @vary(i8* getelementptr inbounds ([15 x i8]* @.str24, i64 0, i64 0), i32 0, i32 24)
  tail call void (i8*, ...)* @vary(i8* getelementptr inbounds ([9 x i8]* @.str25, i64 0, i64 0))
  tail call void (i8, i8*, ...)* @vary2(i8 signext 81, i8* getelementptr inbounds ([4 x i8]* @.str26, i64 0, i64 0), i32 85)
  %1 = tail call i32 (i32, ...)* @getMaxi(i32 6, i32 2, i32 5, i32 21, i32 4, i32 -10, i32 19)
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str27, i64 0, i64 0), i32 %1) #1
  %3 = tail call double (i32, ...)* @getMaxD(i32 6, double 2.100000e+00, double 5.100000e+00, double 2.210000e+01, double 4.100000e+00, double -1.010000e+01, double 1.910000e+01, double 2.000000e+00)
  %4 = fptrunc double %3 to float
  %5 = fpext float %4 to double
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str28, i64 0, i64 0), double %5) #1
  %7 = icmp eq i32 %argc, 1211
  %8 = select i1 %7, void (i8*, ...)* null, void (i8*, ...)* @vary
  tail call void (i8*, ...)* %8(i8* getelementptr inbounds ([12 x i8]* @.str29, i64 0, i64 0), i32 22, i32 199) #1
  tail call void (i32, i32, ...)* @varargs_listoffsets_args(i32 undef, i32 5, i8* getelementptr inbounds ([4 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str13, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str15, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str16, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str19, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str20, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str21, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str23, i64 0, i64 0)) #1
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
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"any pointer", metadata !2, i64 0}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !2, i64 0}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"double", metadata !2, i64 0}
