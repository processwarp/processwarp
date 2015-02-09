; ModuleID = 'test_libgen.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@_ZZ4mainE3p1x = private unnamed_addr constant [16 x i8] c"/usr/lib\00\00\00\00\00\00\00\00", align 16
@.str = private unnamed_addr constant [7 x i8] c"%s -> \00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"%s : %s\0A\00", align 1
@_ZZ4mainE3p2x = private unnamed_addr constant [16 x i8] c"/usr\00\00\00\00\00\00\00\00\00\00\00\00", align 16
@_ZZ4mainE3p3x = private unnamed_addr constant [16 x i8] c"/usr/\00\00\00\00\00\00\00\00\00\00\00", align 16
@_ZZ4mainE3p4x = private unnamed_addr constant [16 x i8] c"/usr/lib///\00\00\00\00\00", align 16
@_ZZ4mainE3p5x = private unnamed_addr constant [16 x i8] c"/\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 16
@_ZZ4mainE3p6x = private unnamed_addr constant [16 x i8] c"///\00\00\00\00\00\00\00\00\00\00\00\00\00", align 16
@_ZZ4mainE3p7x = private unnamed_addr constant [16 x i8] c"/usr/../lib/..\00\00", align 16
@.str2 = private unnamed_addr constant [20 x i8] c"(empty) -> %s : %s\0A\00", align 1
@.str3 = private unnamed_addr constant [19 x i8] c"(null) -> %s : %s\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %p1 = alloca [16 x i8], align 16
  %p1x = alloca [16 x i8], align 16
  %p2 = alloca [16 x i8], align 16
  %p2x = alloca [16 x i8], align 16
  %p3 = alloca [16 x i8], align 16
  %p3x = alloca [16 x i8], align 16
  %p4 = alloca [16 x i8], align 16
  %p4x = alloca [16 x i8], align 16
  %p5 = alloca [16 x i8], align 16
  %p5x = alloca [16 x i8], align 16
  %p6 = alloca [16 x i8], align 16
  %p6x = alloca [16 x i8], align 16
  %p7 = alloca [16 x i8], align 16
  %p7x = alloca [16 x i8], align 16
  %p8 = alloca [16 x i8], align 16
  %p8x = alloca [16 x i8], align 16
  %1 = getelementptr inbounds [16 x i8]* %p1, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p1x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %2 = getelementptr inbounds [16 x i8]* %p1x, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p1x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* %1) #1
  %4 = call i8* @dirname(i8* %2) #1
  %5 = call i8* @__xpg_basename(i8* %1) #1
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i8* %4, i8* %5) #1
  %7 = getelementptr inbounds [16 x i8]* %p2, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p2x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %8 = getelementptr inbounds [16 x i8]* %p2x, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p2x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* %7) #1
  %10 = call i8* @dirname(i8* %8) #1
  %11 = call i8* @__xpg_basename(i8* %7) #1
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i8* %10, i8* %11) #1
  %13 = getelementptr inbounds [16 x i8]* %p3, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p3x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %14 = getelementptr inbounds [16 x i8]* %p3x, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %14, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p3x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* %13) #1
  %16 = call i8* @dirname(i8* %14) #1
  %17 = call i8* @__xpg_basename(i8* %13) #1
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i8* %16, i8* %17) #1
  %19 = getelementptr inbounds [16 x i8]* %p4, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %19, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p4x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %20 = getelementptr inbounds [16 x i8]* %p4x, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %20, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p4x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* %19) #1
  %22 = call i8* @dirname(i8* %20) #1
  %23 = call i8* @__xpg_basename(i8* %19) #1
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i8* %22, i8* %23) #1
  %25 = getelementptr inbounds [16 x i8]* %p5, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p5x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %26 = getelementptr inbounds [16 x i8]* %p5x, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %26, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p5x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* %25) #1
  %28 = call i8* @dirname(i8* %26) #1
  %29 = call i8* @__xpg_basename(i8* %25) #1
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i8* %28, i8* %29) #1
  %31 = getelementptr inbounds [16 x i8]* %p6, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %31, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p6x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %32 = getelementptr inbounds [16 x i8]* %p6x, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %32, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p6x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* %31) #1
  %34 = call i8* @dirname(i8* %32) #1
  %35 = call i8* @__xpg_basename(i8* %31) #1
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i8* %34, i8* %35) #1
  %37 = getelementptr inbounds [16 x i8]* %p7, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %37, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p7x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %38 = getelementptr inbounds [16 x i8]* %p7x, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %38, i8* getelementptr inbounds ([16 x i8]* @_ZZ4mainE3p7x, i64 0, i64 0), i64 16, i32 16, i1 false)
  %39 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8* %37) #1
  %40 = call i8* @dirname(i8* %38) #1
  %41 = call i8* @__xpg_basename(i8* %37) #1
  %42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i8* %40, i8* %41) #1
  %43 = getelementptr inbounds [16 x i8]* %p8, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* %43, i8 0, i64 16, i32 16, i1 false)
  %44 = getelementptr inbounds [16 x i8]* %p8x, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* %44, i8 0, i64 16, i32 16, i1 false)
  %45 = call i8* @dirname(i8* %44) #1
  %46 = call i8* @__xpg_basename(i8* %43) #1
  %47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str2, i64 0, i64 0), i8* %45, i8* %46) #1
  %48 = call i8* @dirname(i8* null) #1
  %49 = call i8* @__xpg_basename(i8* null) #1
  %50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str3, i64 0, i64 0), i8* %48, i8* %49) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i8* @dirname(i8*) #2

; Function Attrs: nounwind
declare i8* @__xpg_basename(i8*) #2

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
