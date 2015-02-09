; ModuleID = 'test_strptime_tm.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i8* }

@.str = private unnamed_addr constant [3 x i8] c"%b\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"%s: %d\0A\00", align 1
@.str2 = private unnamed_addr constant [15 x i8] c"17410105012000\00", align 1
@.str3 = private unnamed_addr constant [13 x i8] c"%H%M%S%d%m%Y\00", align 1
@.str4 = private unnamed_addr constant [26 x i8] c"%s: %s, %d/%d/%d %d:%d:%d\00", align 1
@.str5 = private unnamed_addr constant [3 x i8] c"OK\00", align 1
@.str6 = private unnamed_addr constant [4 x i8] c"ERR\00", align 1
@.str7 = private unnamed_addr constant [4 x i8] c"Sun\00", align 1
@.str8 = private unnamed_addr constant [4 x i8] c"Mon\00", align 1
@.str9 = private unnamed_addr constant [4 x i8] c"Tue\00", align 1
@.str10 = private unnamed_addr constant [4 x i8] c"Wed\00", align 1
@.str11 = private unnamed_addr constant [4 x i8] c"Thu\00", align 1
@.str12 = private unnamed_addr constant [4 x i8] c"Fri\00", align 1
@.str13 = private unnamed_addr constant [4 x i8] c"Sat\00", align 1
@.str15 = private unnamed_addr constant [4 x i8] c"jan\00", align 1
@.str16 = private unnamed_addr constant [8 x i8] c"january\00", align 1
@.str17 = private unnamed_addr constant [4 x i8] c"feb\00", align 1
@.str18 = private unnamed_addr constant [9 x i8] c"february\00", align 1
@.str19 = private unnamed_addr constant [6 x i8] c"march\00", align 1
@.str20 = private unnamed_addr constant [4 x i8] c"mar\00", align 1
@.str21 = private unnamed_addr constant [6 x i8] c"april\00", align 1
@.str22 = private unnamed_addr constant [4 x i8] c"may\00", align 1
@.str23 = private unnamed_addr constant [5 x i8] c"june\00", align 1
@.str24 = private unnamed_addr constant [4 x i8] c"jul\00", align 1
@.str25 = private unnamed_addr constant [7 x i8] c"august\00", align 1
@.str26 = private unnamed_addr constant [10 x i8] c"september\00", align 1
@.str27 = private unnamed_addr constant [4 x i8] c"oct\00", align 1
@.str28 = private unnamed_addr constant [4 x i8] c"nov\00", align 1
@.str29 = private unnamed_addr constant [9 x i8] c"november\00", align 1
@.str30 = private unnamed_addr constant [9 x i8] c"december\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z9ReadMonthPKc(i8* %month) #0 {
  %value = alloca %struct.tm, align 8
  %1 = bitcast %struct.tm* %value to i8*
  call void @llvm.lifetime.start(i64 56, i8* %1) #1
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 56, i32 8, i1 false)
  %2 = call i8* @strptime(i8* %month, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value) #1
  %3 = icmp eq i8* %2, null
  br i1 %3, label %8, label %4

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.tm* %value, i64 0, i32 4
  %6 = load i32* %5, align 8, !tbaa !1
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* %month, i32 %6) #1
  br label %8

; <label>:8                                       ; preds = %4, %0
  call void @llvm.lifetime.end(i64 56, i8* %1) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare i8* @strptime(i8*, i8*, %struct.tm*) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %value.i31 = alloca %struct.tm, align 8
  %value.i29 = alloca %struct.tm, align 8
  %value.i27 = alloca %struct.tm, align 8
  %value.i25 = alloca %struct.tm, align 8
  %value.i23 = alloca %struct.tm, align 8
  %value.i21 = alloca %struct.tm, align 8
  %value.i19 = alloca %struct.tm, align 8
  %value.i17 = alloca %struct.tm, align 8
  %value.i15 = alloca %struct.tm, align 8
  %value.i13 = alloca %struct.tm, align 8
  %value.i11 = alloca %struct.tm, align 8
  %value.i9 = alloca %struct.tm, align 8
  %value.i7 = alloca %struct.tm, align 8
  %value.i5 = alloca %struct.tm, align 8
  %value.i3 = alloca %struct.tm, align 8
  %value.i1 = alloca %struct.tm, align 8
  %value.i = alloca %struct.tm, align 8
  %tm = alloca %struct.tm, align 8
  %1 = bitcast %struct.tm* %tm to i8*
  call void @llvm.lifetime.start(i64 56, i8* %1) #1
  %2 = call i8* @strptime(i8* getelementptr inbounds ([15 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8]* @.str3, i64 0, i64 0), %struct.tm* %tm) #1
  %3 = icmp eq i8* %2, null
  br i1 %3, label %7, label %4

; <label>:4                                       ; preds = %0
  %5 = load i8* %2, align 1, !tbaa !8
  %6 = icmp eq i8 %5, 0
  %phitmp = select i1 %6, i8* getelementptr inbounds ([3 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str6, i64 0, i64 0)
  br label %7

; <label>:7                                       ; preds = %4, %0
  %8 = phi i8* [ getelementptr inbounds ([4 x i8]* @.str6, i64 0, i64 0), %0 ], [ %phitmp, %4 ]
  %9 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 6
  %10 = load i32* %9, align 8, !tbaa !9
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %24, label %12

; <label>:12                                      ; preds = %7
  %13 = icmp eq i32 %10, 1
  br i1 %13, label %24, label %14

; <label>:14                                      ; preds = %12
  %15 = icmp eq i32 %10, 2
  br i1 %15, label %24, label %16

; <label>:16                                      ; preds = %14
  %17 = icmp eq i32 %10, 3
  br i1 %17, label %24, label %18

; <label>:18                                      ; preds = %16
  %19 = icmp eq i32 %10, 4
  br i1 %19, label %24, label %20

; <label>:20                                      ; preds = %18
  %21 = icmp eq i32 %10, 5
  br i1 %21, label %24, label %22

; <label>:22                                      ; preds = %20
  %23 = icmp eq i32 %10, 6
  %.str13..str6 = select i1 %23, [4 x i8]* @.str13, [4 x i8]* @.str6
  br label %24

; <label>:24                                      ; preds = %22, %20, %18, %16, %14, %12, %7
  %25 = phi [4 x i8]* [ @.str7, %7 ], [ @.str8, %12 ], [ @.str9, %14 ], [ @.str10, %16 ], [ @.str11, %18 ], [ %.str13..str6, %22 ], [ @.str12, %20 ]
  %26 = getelementptr inbounds [4 x i8]* %25, i64 0, i64 0
  %27 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 4
  %28 = bitcast i32* %27 to i64*
  %29 = load i64* %28, align 8
  %30 = trunc i64 %29 to i32
  %31 = add nsw i32 %30, 1
  %32 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 3
  %33 = load i32* %32, align 4, !tbaa !10
  %34 = lshr i64 %29, 32
  %35 = trunc i64 %34 to i32
  %36 = add nsw i32 %35, 1900
  %37 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 2
  %38 = load i32* %37, align 8, !tbaa !11
  %39 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 1
  %40 = load i32* %39, align 4, !tbaa !12
  %41 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 0
  %42 = load i32* %41, align 8, !tbaa !13
  %43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str4, i64 0, i64 0), i8* %8, i8* %26, i32 %31, i32 %33, i32 %36, i32 %38, i32 %40, i32 %42) #1
  %putchar = call i32 @putchar(i32 10) #1
  %44 = bitcast %struct.tm* %value.i to i8*
  call void @llvm.lifetime.start(i64 56, i8* %44) #1
  call void @llvm.memset.p0i8.i64(i8* %44, i8 0, i64 56, i32 8, i1 false) #1
  %45 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str15, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i) #1
  %46 = icmp eq i8* %45, null
  br i1 %46, label %_Z9ReadMonthPKc.exit, label %47

; <label>:47                                      ; preds = %24
  %48 = getelementptr inbounds %struct.tm* %value.i, i64 0, i32 4
  %49 = load i32* %48, align 8, !tbaa !1
  %50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str15, i64 0, i64 0), i32 %49) #1
  br label %_Z9ReadMonthPKc.exit

_Z9ReadMonthPKc.exit:                             ; preds = %47, %24
  call void @llvm.lifetime.end(i64 56, i8* %44) #1
  %51 = bitcast %struct.tm* %value.i1 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %51) #1
  call void @llvm.memset.p0i8.i64(i8* %51, i8 0, i64 56, i32 8, i1 false) #1
  %52 = call i8* @strptime(i8* getelementptr inbounds ([8 x i8]* @.str16, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i1) #1
  %53 = icmp eq i8* %52, null
  br i1 %53, label %_Z9ReadMonthPKc.exit2, label %54

; <label>:54                                      ; preds = %_Z9ReadMonthPKc.exit
  %55 = getelementptr inbounds %struct.tm* %value.i1, i64 0, i32 4
  %56 = load i32* %55, align 8, !tbaa !1
  %57 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str16, i64 0, i64 0), i32 %56) #1
  br label %_Z9ReadMonthPKc.exit2

_Z9ReadMonthPKc.exit2:                            ; preds = %54, %_Z9ReadMonthPKc.exit
  call void @llvm.lifetime.end(i64 56, i8* %51) #1
  %58 = bitcast %struct.tm* %value.i3 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %58) #1
  call void @llvm.memset.p0i8.i64(i8* %58, i8 0, i64 56, i32 8, i1 false) #1
  %59 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i3) #1
  %60 = icmp eq i8* %59, null
  br i1 %60, label %_Z9ReadMonthPKc.exit4, label %61

; <label>:61                                      ; preds = %_Z9ReadMonthPKc.exit2
  %62 = getelementptr inbounds %struct.tm* %value.i3, i64 0, i32 4
  %63 = load i32* %62, align 8, !tbaa !1
  %64 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str17, i64 0, i64 0), i32 %63) #1
  br label %_Z9ReadMonthPKc.exit4

_Z9ReadMonthPKc.exit4:                            ; preds = %61, %_Z9ReadMonthPKc.exit2
  call void @llvm.lifetime.end(i64 56, i8* %58) #1
  %65 = bitcast %struct.tm* %value.i5 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %65) #1
  call void @llvm.memset.p0i8.i64(i8* %65, i8 0, i64 56, i32 8, i1 false) #1
  %66 = call i8* @strptime(i8* getelementptr inbounds ([9 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i5) #1
  %67 = icmp eq i8* %66, null
  br i1 %67, label %_Z9ReadMonthPKc.exit6, label %68

; <label>:68                                      ; preds = %_Z9ReadMonthPKc.exit4
  %69 = getelementptr inbounds %struct.tm* %value.i5, i64 0, i32 4
  %70 = load i32* %69, align 8, !tbaa !1
  %71 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str18, i64 0, i64 0), i32 %70) #1
  br label %_Z9ReadMonthPKc.exit6

_Z9ReadMonthPKc.exit6:                            ; preds = %68, %_Z9ReadMonthPKc.exit4
  call void @llvm.lifetime.end(i64 56, i8* %65) #1
  %72 = bitcast %struct.tm* %value.i7 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %72) #1
  call void @llvm.memset.p0i8.i64(i8* %72, i8 0, i64 56, i32 8, i1 false) #1
  %73 = call i8* @strptime(i8* getelementptr inbounds ([6 x i8]* @.str19, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i7) #1
  %74 = icmp eq i8* %73, null
  br i1 %74, label %_Z9ReadMonthPKc.exit8, label %75

; <label>:75                                      ; preds = %_Z9ReadMonthPKc.exit6
  %76 = getelementptr inbounds %struct.tm* %value.i7, i64 0, i32 4
  %77 = load i32* %76, align 8, !tbaa !1
  %78 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str19, i64 0, i64 0), i32 %77) #1
  br label %_Z9ReadMonthPKc.exit8

_Z9ReadMonthPKc.exit8:                            ; preds = %75, %_Z9ReadMonthPKc.exit6
  call void @llvm.lifetime.end(i64 56, i8* %72) #1
  %79 = bitcast %struct.tm* %value.i9 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %79) #1
  call void @llvm.memset.p0i8.i64(i8* %79, i8 0, i64 56, i32 8, i1 false) #1
  %80 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str20, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i9) #1
  %81 = icmp eq i8* %80, null
  br i1 %81, label %_Z9ReadMonthPKc.exit10, label %82

; <label>:82                                      ; preds = %_Z9ReadMonthPKc.exit8
  %83 = getelementptr inbounds %struct.tm* %value.i9, i64 0, i32 4
  %84 = load i32* %83, align 8, !tbaa !1
  %85 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str20, i64 0, i64 0), i32 %84) #1
  br label %_Z9ReadMonthPKc.exit10

_Z9ReadMonthPKc.exit10:                           ; preds = %82, %_Z9ReadMonthPKc.exit8
  call void @llvm.lifetime.end(i64 56, i8* %79) #1
  %86 = bitcast %struct.tm* %value.i11 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %86) #1
  call void @llvm.memset.p0i8.i64(i8* %86, i8 0, i64 56, i32 8, i1 false) #1
  %87 = call i8* @strptime(i8* getelementptr inbounds ([6 x i8]* @.str21, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i11) #1
  %88 = icmp eq i8* %87, null
  br i1 %88, label %_Z9ReadMonthPKc.exit12, label %89

; <label>:89                                      ; preds = %_Z9ReadMonthPKc.exit10
  %90 = getelementptr inbounds %struct.tm* %value.i11, i64 0, i32 4
  %91 = load i32* %90, align 8, !tbaa !1
  %92 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str21, i64 0, i64 0), i32 %91) #1
  br label %_Z9ReadMonthPKc.exit12

_Z9ReadMonthPKc.exit12:                           ; preds = %89, %_Z9ReadMonthPKc.exit10
  call void @llvm.lifetime.end(i64 56, i8* %86) #1
  %93 = bitcast %struct.tm* %value.i13 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %93) #1
  call void @llvm.memset.p0i8.i64(i8* %93, i8 0, i64 56, i32 8, i1 false) #1
  %94 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i13) #1
  %95 = icmp eq i8* %94, null
  br i1 %95, label %_Z9ReadMonthPKc.exit14, label %96

; <label>:96                                      ; preds = %_Z9ReadMonthPKc.exit12
  %97 = getelementptr inbounds %struct.tm* %value.i13, i64 0, i32 4
  %98 = load i32* %97, align 8, !tbaa !1
  %99 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str22, i64 0, i64 0), i32 %98) #1
  br label %_Z9ReadMonthPKc.exit14

_Z9ReadMonthPKc.exit14:                           ; preds = %96, %_Z9ReadMonthPKc.exit12
  call void @llvm.lifetime.end(i64 56, i8* %93) #1
  %100 = bitcast %struct.tm* %value.i15 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %100) #1
  call void @llvm.memset.p0i8.i64(i8* %100, i8 0, i64 56, i32 8, i1 false) #1
  %101 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i15) #1
  %102 = icmp eq i8* %101, null
  br i1 %102, label %_Z9ReadMonthPKc.exit16, label %103

; <label>:103                                     ; preds = %_Z9ReadMonthPKc.exit14
  %104 = getelementptr inbounds %struct.tm* %value.i15, i64 0, i32 4
  %105 = load i32* %104, align 8, !tbaa !1
  %106 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str22, i64 0, i64 0), i32 %105) #1
  br label %_Z9ReadMonthPKc.exit16

_Z9ReadMonthPKc.exit16:                           ; preds = %103, %_Z9ReadMonthPKc.exit14
  call void @llvm.lifetime.end(i64 56, i8* %100) #1
  %107 = bitcast %struct.tm* %value.i17 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %107) #1
  call void @llvm.memset.p0i8.i64(i8* %107, i8 0, i64 56, i32 8, i1 false) #1
  %108 = call i8* @strptime(i8* getelementptr inbounds ([5 x i8]* @.str23, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i17) #1
  %109 = icmp eq i8* %108, null
  br i1 %109, label %_Z9ReadMonthPKc.exit18, label %110

; <label>:110                                     ; preds = %_Z9ReadMonthPKc.exit16
  %111 = getelementptr inbounds %struct.tm* %value.i17, i64 0, i32 4
  %112 = load i32* %111, align 8, !tbaa !1
  %113 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str23, i64 0, i64 0), i32 %112) #1
  br label %_Z9ReadMonthPKc.exit18

_Z9ReadMonthPKc.exit18:                           ; preds = %110, %_Z9ReadMonthPKc.exit16
  call void @llvm.lifetime.end(i64 56, i8* %107) #1
  %114 = bitcast %struct.tm* %value.i19 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %114) #1
  call void @llvm.memset.p0i8.i64(i8* %114, i8 0, i64 56, i32 8, i1 false) #1
  %115 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str24, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i19) #1
  %116 = icmp eq i8* %115, null
  br i1 %116, label %_Z9ReadMonthPKc.exit20, label %117

; <label>:117                                     ; preds = %_Z9ReadMonthPKc.exit18
  %118 = getelementptr inbounds %struct.tm* %value.i19, i64 0, i32 4
  %119 = load i32* %118, align 8, !tbaa !1
  %120 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str24, i64 0, i64 0), i32 %119) #1
  br label %_Z9ReadMonthPKc.exit20

_Z9ReadMonthPKc.exit20:                           ; preds = %117, %_Z9ReadMonthPKc.exit18
  call void @llvm.lifetime.end(i64 56, i8* %114) #1
  %121 = bitcast %struct.tm* %value.i21 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %121) #1
  call void @llvm.memset.p0i8.i64(i8* %121, i8 0, i64 56, i32 8, i1 false) #1
  %122 = call i8* @strptime(i8* getelementptr inbounds ([7 x i8]* @.str25, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i21) #1
  %123 = icmp eq i8* %122, null
  br i1 %123, label %_Z9ReadMonthPKc.exit22, label %124

; <label>:124                                     ; preds = %_Z9ReadMonthPKc.exit20
  %125 = getelementptr inbounds %struct.tm* %value.i21, i64 0, i32 4
  %126 = load i32* %125, align 8, !tbaa !1
  %127 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str25, i64 0, i64 0), i32 %126) #1
  br label %_Z9ReadMonthPKc.exit22

_Z9ReadMonthPKc.exit22:                           ; preds = %124, %_Z9ReadMonthPKc.exit20
  call void @llvm.lifetime.end(i64 56, i8* %121) #1
  %128 = bitcast %struct.tm* %value.i23 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %128) #1
  call void @llvm.memset.p0i8.i64(i8* %128, i8 0, i64 56, i32 8, i1 false) #1
  %129 = call i8* @strptime(i8* getelementptr inbounds ([10 x i8]* @.str26, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i23) #1
  %130 = icmp eq i8* %129, null
  br i1 %130, label %_Z9ReadMonthPKc.exit24, label %131

; <label>:131                                     ; preds = %_Z9ReadMonthPKc.exit22
  %132 = getelementptr inbounds %struct.tm* %value.i23, i64 0, i32 4
  %133 = load i32* %132, align 8, !tbaa !1
  %134 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @.str26, i64 0, i64 0), i32 %133) #1
  br label %_Z9ReadMonthPKc.exit24

_Z9ReadMonthPKc.exit24:                           ; preds = %131, %_Z9ReadMonthPKc.exit22
  call void @llvm.lifetime.end(i64 56, i8* %128) #1
  %135 = bitcast %struct.tm* %value.i25 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %135) #1
  call void @llvm.memset.p0i8.i64(i8* %135, i8 0, i64 56, i32 8, i1 false) #1
  %136 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str27, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i25) #1
  %137 = icmp eq i8* %136, null
  br i1 %137, label %_Z9ReadMonthPKc.exit26, label %138

; <label>:138                                     ; preds = %_Z9ReadMonthPKc.exit24
  %139 = getelementptr inbounds %struct.tm* %value.i25, i64 0, i32 4
  %140 = load i32* %139, align 8, !tbaa !1
  %141 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str27, i64 0, i64 0), i32 %140) #1
  br label %_Z9ReadMonthPKc.exit26

_Z9ReadMonthPKc.exit26:                           ; preds = %138, %_Z9ReadMonthPKc.exit24
  call void @llvm.lifetime.end(i64 56, i8* %135) #1
  %142 = bitcast %struct.tm* %value.i27 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %142) #1
  call void @llvm.memset.p0i8.i64(i8* %142, i8 0, i64 56, i32 8, i1 false) #1
  %143 = call i8* @strptime(i8* getelementptr inbounds ([4 x i8]* @.str28, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i27) #1
  %144 = icmp eq i8* %143, null
  br i1 %144, label %_Z9ReadMonthPKc.exit28, label %145

; <label>:145                                     ; preds = %_Z9ReadMonthPKc.exit26
  %146 = getelementptr inbounds %struct.tm* %value.i27, i64 0, i32 4
  %147 = load i32* %146, align 8, !tbaa !1
  %148 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str28, i64 0, i64 0), i32 %147) #1
  br label %_Z9ReadMonthPKc.exit28

_Z9ReadMonthPKc.exit28:                           ; preds = %145, %_Z9ReadMonthPKc.exit26
  call void @llvm.lifetime.end(i64 56, i8* %142) #1
  %149 = bitcast %struct.tm* %value.i29 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %149) #1
  call void @llvm.memset.p0i8.i64(i8* %149, i8 0, i64 56, i32 8, i1 false) #1
  %150 = call i8* @strptime(i8* getelementptr inbounds ([9 x i8]* @.str29, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i29) #1
  %151 = icmp eq i8* %150, null
  br i1 %151, label %_Z9ReadMonthPKc.exit30, label %152

; <label>:152                                     ; preds = %_Z9ReadMonthPKc.exit28
  %153 = getelementptr inbounds %struct.tm* %value.i29, i64 0, i32 4
  %154 = load i32* %153, align 8, !tbaa !1
  %155 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str29, i64 0, i64 0), i32 %154) #1
  br label %_Z9ReadMonthPKc.exit30

_Z9ReadMonthPKc.exit30:                           ; preds = %152, %_Z9ReadMonthPKc.exit28
  call void @llvm.lifetime.end(i64 56, i8* %149) #1
  %156 = bitcast %struct.tm* %value.i31 to i8*
  call void @llvm.lifetime.start(i64 56, i8* %156) #1
  call void @llvm.memset.p0i8.i64(i8* %156, i8 0, i64 56, i32 8, i1 false) #1
  %157 = call i8* @strptime(i8* getelementptr inbounds ([9 x i8]* @.str30, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), %struct.tm* %value.i31) #1
  %158 = icmp eq i8* %157, null
  br i1 %158, label %_Z9ReadMonthPKc.exit32, label %159

; <label>:159                                     ; preds = %_Z9ReadMonthPKc.exit30
  %160 = getelementptr inbounds %struct.tm* %value.i31, i64 0, i32 4
  %161 = load i32* %160, align 8, !tbaa !1
  %162 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str30, i64 0, i64 0), i32 %161) #1
  br label %_Z9ReadMonthPKc.exit32

_Z9ReadMonthPKc.exit32:                           ; preds = %159, %_Z9ReadMonthPKc.exit30
  call void @llvm.lifetime.end(i64 56, i8* %156) #1
  call void @llvm.lifetime.end(i64 56, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @putchar(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 16}
!2 = metadata !{metadata !"_ZTS2tm", metadata !3, i64 0, metadata !3, i64 4, metadata !3, i64 8, metadata !3, i64 12, metadata !3, i64 16, metadata !3, i64 20, metadata !3, i64 24, metadata !3, i64 28, metadata !3, i64 32, metadata !6, i64 40, metadata !7, i64 48}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"long", metadata !4, i64 0}
!7 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!8 = metadata !{metadata !4, metadata !4, i64 0}
!9 = metadata !{metadata !2, metadata !3, i64 24}
!10 = metadata !{metadata !2, metadata !3, i64 12}
!11 = metadata !{metadata !2, metadata !3, i64 8}
!12 = metadata !{metadata !2, metadata !3, i64 4}
!13 = metadata !{metadata !2, metadata !3, i64 0}
