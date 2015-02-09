; ModuleID = 'test_wprintf.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [28 x i32] [i32 102, i32 111, i32 114, i32 109, i32 97, i32 116, i32 32, i32 32, i32 32, i32 32, i32 115, i32 116, i32 97, i32 114, i32 116, i32 115, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 48, i32 120, i32 37, i32 120, i32 10, i32 0], align 4
@.str2 = private unnamed_addr constant [28 x i32] [i32 102, i32 109, i32 116, i32 32, i32 32, i32 32, i32 32, i32 99, i32 111, i32 110, i32 116, i32 105, i32 110, i32 117, i32 101, i32 115, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 48, i32 120, i32 37, i32 120, i32 10, i32 0], align 4
@.str3 = private unnamed_addr constant [22 x i32] [i32 118, i32 115, i32 119, i32 112, i32 114, i32 105, i32 110, i32 116, i32 102, i32 32, i32 116, i32 111, i32 108, i32 100, i32 32, i32 117, i32 115, i32 32, i32 37, i32 100, i32 10, i32 0], align 4
@.str4 = private unnamed_addr constant [28 x i32] [i32 118, i32 115, i32 119, i32 111, i32 117, i32 116, i32 112, i32 117, i32 116, i32 32, i32 115, i32 116, i32 45, i32 114, i32 116, i32 115, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 48, i32 120, i32 37, i32 120, i32 10, i32 0], align 4
@.str6 = private unnamed_addr constant [28 x i32] [i32 118, i32 115, i32 119, i32 32, i32 32, i32 32, i32 32, i32 99, i32 111, i32 110, i32 116, i32 105, i32 110, i32 117, i32 101, i32 115, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 48, i32 120, i32 37, i32 120, i32 10, i32 0], align 4
@.str7 = private unnamed_addr constant [9 x i8] c"test.dat\00", align 1
@.str8 = private unnamed_addr constant [3 x i8] c"wb\00", align 1
@.str9 = private unnamed_addr constant [9 x i32] [i32 104, i32 101, i32 108, i32 108, i32 111, i32 32, i32 37, i32 100, i32 0], align 4
@.str10 = private unnamed_addr constant [21 x i32] [i32 102, i32 119, i32 112, i32 114, i32 105, i32 110, i32 116, i32 102, i32 32, i32 116, i32 111, i32 108, i32 100, i32 32, i32 117, i32 115, i32 32, i32 37, i32 100, i32 10, i32 0], align 4
@.str11 = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.str12 = private unnamed_addr constant [17 x i32] [i32 102, i32 105, i32 108, i32 101, i32 32, i32 115, i32 105, i32 122, i32 101, i32 32, i32 105, i32 115, i32 32, i32 37, i32 100, i32 10, i32 0], align 4
@_ZZ4mainE3str = private unnamed_addr constant [37 x i32] [i32 116, i32 101, i32 115, i32 116, i32 32, i32 115, i32 116, i32 114, i32 105, i32 110, i32 103, i32 32, i32 104, i32 97, i32 115, i32 32, i32 37, i32 100, i32 32, i32 119, i32 105, i32 100, i32 101, i32 32, i32 99, i32 104, i32 97, i32 114, i32 97, i32 99, i32 116, i32 101, i32 114, i32 115, i32 46, i32 10, i32 0], align 16
@.str13 = private unnamed_addr constant [22 x i32] [i32 115, i32 116, i32 114, i32 32, i32 115, i32 116, i32 97, i32 114, i32 116, i32 115, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 48, i32 120, i32 37, i32 120, i32 10, i32 0], align 4
@.str15 = private unnamed_addr constant [25 x i32] [i32 115, i32 116, i32 114, i32 32, i32 99, i32 111, i32 110, i32 116, i32 105, i32 110, i32 117, i32 101, i32 115, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 48, i32 120, i32 37, i32 120, i32 10, i32 0], align 4
@.str16 = private unnamed_addr constant [22 x i32] [i32 67, i32 104, i32 97, i32 114, i32 97, i32 99, i32 116, i32 101, i32 114, i32 115, i32 58, i32 32, i32 37, i32 108, i32 99, i32 32, i32 37, i32 108, i32 99, i32 32, i32 10, i32 0], align 4
@.str17 = private unnamed_addr constant [18 x i32] [i32 68, i32 101, i32 99, i32 105, i32 109, i32 97, i32 108, i32 115, i32 58, i32 32, i32 37, i32 100, i32 32, i32 37, i32 108, i32 100, i32 10, i32 0], align 4
@.str18 = private unnamed_addr constant [30 x i32] [i32 80, i32 114, i32 101, i32 99, i32 101, i32 100, i32 105, i32 110, i32 103, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 98, i32 108, i32 97, i32 110, i32 107, i32 115, i32 58, i32 32, i32 37, i32 49, i32 48, i32 100, i32 32, i32 10, i32 0], align 4
@.str19 = private unnamed_addr constant [30 x i32] [i32 80, i32 114, i32 101, i32 99, i32 101, i32 100, i32 105, i32 110, i32 103, i32 32, i32 119, i32 105, i32 116, i32 104, i32 32, i32 122, i32 101, i32 114, i32 111, i32 115, i32 58, i32 32, i32 37, i32 48, i32 49, i32 48, i32 100, i32 32, i32 10, i32 0], align 4
@.str20 = private unnamed_addr constant [43 x i32] [i32 83, i32 111, i32 109, i32 101, i32 32, i32 100, i32 105, i32 102, i32 102, i32 101, i32 114, i32 101, i32 110, i32 116, i32 32, i32 114, i32 97, i32 100, i32 105, i32 120, i32 101, i32 115, i32 58, i32 32, i32 37, i32 100, i32 32, i32 37, i32 120, i32 32, i32 37, i32 111, i32 32, i32 37, i32 35, i32 120, i32 32, i32 37, i32 35, i32 111, i32 32, i32 10, i32 0], align 4
@.str21 = private unnamed_addr constant [25 x i32] [i32 102, i32 108, i32 111, i32 97, i32 116, i32 115, i32 58, i32 32, i32 37, i32 52, i32 46, i32 50, i32 102, i32 32, i32 37, i32 43, i32 46, i32 48, i32 101, i32 32, i32 37, i32 69, i32 32, i32 10, i32 0], align 4
@.str22 = private unnamed_addr constant [19 x i32] [i32 87, i32 105, i32 100, i32 116, i32 104, i32 32, i32 116, i32 114, i32 105, i32 99, i32 107, i32 58, i32 32, i32 37, i32 42, i32 100, i32 32, i32 10, i32 0], align 4
@.str23 = private unnamed_addr constant [6 x i32] [i32 37, i32 108, i32 115, i32 32, i32 10, i32 0], align 4
@.str24 = private unnamed_addr constant [14 x i32] [i32 65, i32 32, i32 119, i32 105, i32 100, i32 101, i32 32, i32 115, i32 116, i32 114, i32 105, i32 110, i32 103, i32 0], align 4
@.str25 = private unnamed_addr constant [21 x i32] [i32 84, i32 104, i32 101, i32 32, i32 104, i32 97, i32 108, i32 102, i32 32, i32 111, i32 102, i32 32, i32 37, i32 100, i32 32, i32 105, i32 115, i32 32, i32 37, i32 100, i32 0], align 4
@.str26 = private unnamed_addr constant [21 x i32] [i32 115, i32 119, i32 112, i32 114, i32 105, i32 110, i32 116, i32 102, i32 32, i32 116, i32 111, i32 108, i32 100, i32 32, i32 117, i32 115, i32 32, i32 37, i32 100, i32 10, i32 0], align 4
@.str27 = private unnamed_addr constant [8 x i32] [i32 112, i32 114, i32 101, i32 32, i32 37, i32 100, i32 10, i32 0], align 4
@.str28 = private unnamed_addr constant [31 x i32] [i32 44, i32 32, i32 97, i32 110, i32 100, i32 32, i32 116, i32 104, i32 101, i32 32, i32 104, i32 97, i32 108, i32 102, i32 32, i32 111, i32 102, i32 32, i32 116, i32 104, i32 97, i32 116, i32 32, i32 105, i32 115, i32 32, i32 37, i32 100, i32 46, i32 10, i32 0], align 4
@.str29 = private unnamed_addr constant [9 x i32] [i32 112, i32 111, i32 115, i32 116, i32 32, i32 37, i32 100, i32 10, i32 0], align 4

; Function Attrs: nounwind uwtable
define void @_Z9PrintWidePKwz(i32* %format, ...) #0 {
  %buffer = alloca [256 x i32], align 16
  %args = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [256 x i32]* %buffer to i8*
  call void @llvm.lifetime.start(i64 1024, i8* %1) #1
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 256, i32 16, i1 false)
  %2 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i64 0, i64 0
  %3 = bitcast [1 x %struct.__va_list_tag]* %args to i8*
  call void @llvm.va_start(i8* %3)
  %4 = load i32* %format, align 4, !tbaa !1
  %5 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([28 x i32]* @.str, i64 0, i64 0), i32 %4) #1
  %6 = getelementptr inbounds i32* %format, i64 1
  %7 = load i32* %6, align 4, !tbaa !1
  %8 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([28 x i32]* @.str2, i64 0, i64 0), i32 %7) #1
  %9 = getelementptr inbounds i32* %format, i64 2
  %10 = load i32* %9, align 4, !tbaa !1
  %11 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([28 x i32]* @.str2, i64 0, i64 0), i32 %10) #1
  %12 = getelementptr inbounds [256 x i32]* %buffer, i64 0, i64 0
  %13 = call i32 @vswprintf(i32* %12, i64 256, i32* %format, %struct.__va_list_tag* %2) #1
  %14 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([22 x i32]* @.str3, i64 0, i64 0), i32 %13) #1
  %15 = load i32* %12, align 16, !tbaa !1
  %16 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([28 x i32]* @.str4, i64 0, i64 0), i32 %15) #1
  %17 = getelementptr inbounds [256 x i32]* %buffer, i64 0, i64 1
  %18 = load i32* %17, align 4, !tbaa !1
  %19 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([28 x i32]* @.str6, i64 0, i64 0), i32 %18) #1
  %20 = getelementptr inbounds [256 x i32]* %buffer, i64 0, i64 2
  %21 = load i32* %20, align 8, !tbaa !1
  %22 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([28 x i32]* @.str6, i64 0, i64 0), i32 %21) #1
  %23 = call i32 (i32*, ...)* @wprintf(i32* %12) #1
  call void @llvm.va_end(i8* %3)
  call void @llvm.lifetime.end(i64 1024, i8* %1) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

declare i32 @wprintf(i32*, ...) #2

; Function Attrs: nounwind
declare i32 @vswprintf(i32*, i64, i32*, %struct.__va_list_tag*) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %str = alloca [37 x i32], align 16
  %buffer = alloca [100 x i32], align 16
  %1 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([9 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str8, i64 0, i64 0)) #1
  %2 = call i32 (%struct._IO_FILE*, i32*, ...)* @fwprintf(%struct._IO_FILE* %1, i32* getelementptr inbounds ([9 x i32]* @.str9, i64 0, i64 0), i32 5) #1
  %3 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([21 x i32]* @.str10, i64 0, i64 0), i32 %2) #1
  %4 = call i32 @fclose(%struct._IO_FILE* %1) #1
  %5 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([9 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str11, i64 0, i64 0)) #1
  %6 = call i32 @fseek(%struct._IO_FILE* %5, i64 0, i32 2) #1
  %7 = call i64 @ftell(%struct._IO_FILE* %5) #1
  %8 = trunc i64 %7 to i32
  %9 = call i32 @fclose(%struct._IO_FILE* %5) #1
  %10 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([17 x i32]* @.str12, i64 0, i64 0), i32 %8) #1
  %11 = bitcast [37 x i32]* %str to i8*
  call void @llvm.lifetime.start(i64 148, i8* %11) #1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* bitcast ([37 x i32]* @_ZZ4mainE3str to i8*), i64 148, i32 16, i1 false)
  %12 = getelementptr inbounds [37 x i32]* %str, i64 0, i64 0
  %13 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([22 x i32]* @.str13, i64 0, i64 0), i32 116) #1
  %14 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([25 x i32]* @.str15, i64 0, i64 0), i32 101) #1
  %15 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([25 x i32]* @.str15, i64 0, i64 0), i32 115) #1
  %16 = call i64 @wcslen(i32* %12) #5
  call void (i32*, ...)* @_Z9PrintWidePKwz(i32* %12, i64 %16)
  %17 = call i64 @wcslen(i32* %12) #5
  call void (i32*, ...)* @_Z9PrintWidePKwz(i32* %12, i64 %17)
  %18 = call i64 @wcslen(i32* %12) #5
  call void (i32*, ...)* @_Z9PrintWidePKwz(i32* %12, i64 %18)
  %19 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([22 x i32]* @.str16, i64 0, i64 0), i32 97, i32 65) #1
  %20 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([18 x i32]* @.str17, i64 0, i64 0), i32 1977, i64 650000) #1
  %21 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([30 x i32]* @.str18, i64 0, i64 0), i32 1977) #1
  %22 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([30 x i32]* @.str19, i64 0, i64 0), i32 1977) #1
  %23 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([43 x i32]* @.str20, i64 0, i64 0), i32 100, i32 100, i32 100, i32 100, i32 100) #1
  %24 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([25 x i32]* @.str21, i64 0, i64 0), double 3.141600e+00, double 3.141600e+00, double 3.141600e+00) #1
  %25 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([19 x i32]* @.str22, i64 0, i64 0), i32 5, i32 10) #1
  %26 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([6 x i32]* @.str23, i64 0, i64 0), i32* getelementptr inbounds ([14 x i32]* @.str24, i64 0, i64 0)) #1
  %27 = bitcast [100 x i32]* %buffer to i8*
  call void @llvm.lifetime.start(i64 400, i8* %27) #1
  call void @llvm.memset.p0i8.i64(i8* %27, i8 0, i64 400, i32 16, i1 false)
  %28 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 0
  %29 = call i32 (i32*, i64, i32*, ...)* @swprintf(i32* %28, i64 100, i32* getelementptr inbounds ([21 x i32]* @.str25, i64 0, i64 0), i32 80, i32 40) #1
  %30 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([21 x i32]* @.str26, i64 0, i64 0), i32 %29) #1
  %31 = load i32* %28, align 16, !tbaa !1
  %32 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %31) #1
  %33 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 1
  %34 = load i32* %33, align 4, !tbaa !1
  %35 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %34) #1
  %36 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 2
  %37 = load i32* %36, align 8, !tbaa !1
  %38 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %37) #1
  %39 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 3
  %40 = load i32* %39, align 4, !tbaa !1
  %41 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %40) #1
  %42 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 4
  %43 = load i32* %42, align 16, !tbaa !1
  %44 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %43) #1
  %45 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 5
  %46 = load i32* %45, align 4, !tbaa !1
  %47 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %46) #1
  %48 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 6
  %49 = load i32* %48, align 8, !tbaa !1
  %50 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %49) #1
  %51 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 7
  %52 = load i32* %51, align 4, !tbaa !1
  %53 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %52) #1
  %54 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 8
  %55 = load i32* %54, align 16, !tbaa !1
  %56 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %55) #1
  %57 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 9
  %58 = load i32* %57, align 4, !tbaa !1
  %59 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([8 x i32]* @.str27, i64 0, i64 0), i32 %58) #1
  %60 = sext i32 %29 to i64
  %61 = getelementptr inbounds [100 x i32]* %buffer, i64 0, i64 %60
  %62 = sub i32 99, %29
  %63 = sext i32 %62 to i64
  %64 = call i32 (i32*, i64, i32*, ...)* @swprintf(i32* %61, i64 %63, i32* getelementptr inbounds ([31 x i32]* @.str28, i64 0, i64 0), i32 20) #1
  %65 = load i32* %28, align 16, !tbaa !1
  %66 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %65) #1
  %67 = load i32* %33, align 4, !tbaa !1
  %68 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %67) #1
  %69 = load i32* %36, align 8, !tbaa !1
  %70 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %69) #1
  %71 = load i32* %39, align 4, !tbaa !1
  %72 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %71) #1
  %73 = load i32* %42, align 16, !tbaa !1
  %74 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %73) #1
  %75 = load i32* %45, align 4, !tbaa !1
  %76 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %75) #1
  %77 = load i32* %48, align 8, !tbaa !1
  %78 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %77) #1
  %79 = load i32* %51, align 4, !tbaa !1
  %80 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %79) #1
  %81 = load i32* %54, align 16, !tbaa !1
  %82 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %81) #1
  %83 = load i32* %57, align 4, !tbaa !1
  %84 = call i32 (i32*, ...)* @wprintf(i32* getelementptr inbounds ([9 x i32]* @.str29, i64 0, i64 0), i32 %83) #1
  %85 = call i32 (i32*, ...)* @wprintf(i32* %28) #1
  call void @llvm.lifetime.end(i64 400, i8* %27) #1
  call void @llvm.lifetime.end(i64 148, i8* %11) #1
  ret i32 0
}

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) #3

declare i32 @fwprintf(%struct._IO_FILE*, i32*, ...) #2

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) #3

; Function Attrs: nounwind
declare i32 @fseek(%struct._IO_FILE* nocapture, i64, i32) #3

; Function Attrs: nounwind
declare i64 @ftell(%struct._IO_FILE* nocapture) #3

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind readonly
declare i64 @wcslen(i32*) #4

; Function Attrs: nounwind
declare i32 @swprintf(i32*, i64, i32*, ...) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
