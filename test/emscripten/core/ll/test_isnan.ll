; ModuleID = 'test_isnan.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"%d - %f - %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @IsNaN(double %x) #0 {
  %y = alloca double, align 8
  %z = alloca double, align 8
  store volatile double %x, double* %y, align 8
  %1 = load volatile double* %y, align 8
  store volatile double %1, double* %z, align 8
  %2 = load volatile double* %y, align 8
  %3 = load volatile double* %z, align 8
  %4 = fcmp une double %2, %3
  %5 = zext i1 %4 to i32
  ret i32 %5
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %y.i = alloca double, align 8
  %z.i = alloca double, align 8
  %1 = bitcast double* %y.i to i8*
  %2 = bitcast double* %z.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 1.000000e+00, double* %y.i, align 8
  %3 = load volatile double* %y.i, align 8
  store volatile double %3, double* %z.i, align 8
  %4 = load volatile double* %y.i, align 8
  %5 = load volatile double* %z.i, align 8
  %6 = fcmp une double %4, %5
  %7 = zext i1 %6 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 0, double 1.000000e+00, i32 %7) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 3.333000e+00, double* %y.i, align 8
  %9 = load volatile double* %y.i, align 8
  store volatile double %9, double* %z.i, align 8
  %10 = load volatile double* %y.i, align 8
  %11 = load volatile double* %z.i, align 8
  %12 = fcmp une double %10, %11
  %13 = zext i1 %12 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %14 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 1, double 3.333000e+00, i32 %13) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 0x7FF0000000000000, double* %y.i, align 8
  %15 = load volatile double* %y.i, align 8
  store volatile double %15, double* %z.i, align 8
  %16 = load volatile double* %y.i, align 8
  %17 = load volatile double* %z.i, align 8
  %18 = fcmp une double %16, %17
  %19 = zext i1 %18 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 2, double 0x7FF0000000000000, i32 %19) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 0x7FF8000000000000, double* %y.i, align 8
  %21 = load volatile double* %y.i, align 8
  store volatile double %21, double* %z.i, align 8
  %22 = load volatile double* %y.i, align 8
  %23 = load volatile double* %z.i, align 8
  %24 = fcmp une double %22, %23
  %25 = zext i1 %24 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %26 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 3, double 0x7FF8000000000000, i32 %25) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 0xFFF0000000000000, double* %y.i, align 8
  %27 = load volatile double* %y.i, align 8
  store volatile double %27, double* %z.i, align 8
  %28 = load volatile double* %y.i, align 8
  %29 = load volatile double* %z.i, align 8
  %30 = fcmp une double %28, %29
  %31 = zext i1 %30 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %32 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 4, double 0xFFF0000000000000, i32 %31) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 0.000000e+00, double* %y.i, align 8
  %33 = load volatile double* %y.i, align 8
  store volatile double %33, double* %z.i, align 8
  %34 = load volatile double* %y.i, align 8
  %35 = load volatile double* %z.i, align 8
  %36 = fcmp une double %34, %35
  %37 = zext i1 %36 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %38 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 5, double 0.000000e+00, i32 %37) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 0.000000e+00, double* %y.i, align 8
  %39 = load volatile double* %y.i, align 8
  store volatile double %39, double* %z.i, align 8
  %40 = load volatile double* %y.i, align 8
  %41 = load volatile double* %z.i, align 8
  %42 = fcmp une double %40, %41
  %43 = zext i1 %42 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %44 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 6, double 0.000000e+00, i32 %43) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 0xC19D5AD6CC000000, double* %y.i, align 8
  %45 = load volatile double* %y.i, align 8
  store volatile double %45, double* %z.i, align 8
  %46 = load volatile double* %y.i, align 8
  %47 = load volatile double* %z.i, align 8
  %48 = fcmp une double %46, %47
  %49 = zext i1 %48 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %50 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 7, double 0xC19D5AD6CC000000, i32 %49) #1
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store volatile double 1.200000e+201, double* %y.i, align 8
  %51 = load volatile double* %y.i, align 8
  store volatile double %51, double* %z.i, align 8
  %52 = load volatile double* %y.i, align 8
  %53 = load volatile double* %z.i, align 8
  %54 = fcmp une double %52, %53
  %55 = zext i1 %54 to i32
  call void @llvm.lifetime.end(i64 8, i8* %1)
  call void @llvm.lifetime.end(i64 8, i8* %2)
  %56 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 8, double 1.200000e+201, i32 %55) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
