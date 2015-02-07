; ModuleID = 'test_struct_varargs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z3fooiz(i32 %unused, ...) #0 {
  %vl = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vl to i8*
  call void @llvm.va_start(i8* %1)
  %2 = bitcast [1 x %struct.__va_list_tag]* %vl to i64*
  %3 = load i64* %2, align 16
  %4 = trunc i64 %3 to i32
  %5 = icmp ult i32 %4, 41
  %6 = lshr i64 %3, 32
  %7 = trunc i64 %6 to i32
  br i1 %5, label %8, label %15

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vl, i64 0, i64 0, i32 0
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vl, i64 0, i64 0, i32 3
  %11 = load i8** %10, align 16
  %sext = shl i64 %3, 32
  %12 = ashr exact i64 %sext, 32
  %13 = getelementptr i8* %11, i64 %12
  %14 = add i32 %4, 8
  store i32 %14, i32* %9, align 16
  br label %19

; <label>:15                                      ; preds = %0
  %16 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vl, i64 0, i64 0, i32 2
  %17 = load i8** %16, align 8
  %18 = getelementptr i8* %17, i64 8
  store i8* %18, i8** %16, align 8
  br label %19

; <label>:19                                      ; preds = %15, %8
  %.in = phi i8* [ %13, %8 ], [ %17, %15 ]
  %20 = bitcast i8* %.in to i32*
  %21 = load i32* %20, align 4
  %22 = icmp ult i32 %7, 161
  br i1 %22, label %23, label %30

; <label>:23                                      ; preds = %19
  %24 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vl, i64 0, i64 0, i32 1
  %25 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vl, i64 0, i64 0, i32 3
  %26 = load i8** %25, align 16
  %27 = ashr i64 %3, 32
  %28 = getelementptr i8* %26, i64 %27
  %29 = add i32 %7, 16
  store i32 %29, i32* %24, align 4
  br label %34

; <label>:30                                      ; preds = %19
  %31 = getelementptr inbounds [1 x %struct.__va_list_tag]* %vl, i64 0, i64 0, i32 2
  %32 = load i8** %31, align 8
  %33 = getelementptr i8* %32, i64 8
  store i8* %33, i8** %31, align 8
  br label %34

; <label>:34                                      ; preds = %30, %23
  %.in1 = phi i8* [ %28, %23 ], [ %32, %30 ]
  %35 = bitcast i8* %.in1 to double*
  %36 = load double* %35, align 8
  call void @llvm.va_end(i8* %1)
  %37 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %21)
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), double %36)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  tail call void (i32, ...)* @_Z3fooiz(i32 undef, i32 42, double 4.231400e+01)
  ret i32 0
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
