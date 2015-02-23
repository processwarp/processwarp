; ModuleID = 'test_math.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"*%.2f,%.2f,%d\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c",%d\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c",%1.1lf\00", align 1
@.str3 = private unnamed_addr constant [7 x i8] c",%1.1f\00", align 1
@str = private unnamed_addr constant [2 x i8] c"*\00"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %y = alloca double, align 8
  %y2 = alloca float, align 4
  %sine = alloca double, align 8
  %cosine = alloca double, align 8
  %fsine = alloca float, align 4
  %fcosine = alloca float, align 4
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), double 0x400921FB54442D18, double 0xC00921FB54442D18, i32 1)
  %2 = call float @fabsf(float 0x7FF8000000000000) #3
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 0)
  %4 = call float @fabsf(float 0x7FF0000000000000) #3
  %5 = fcmp une float %4, 0x7FF0000000000000
  %6 = zext i1 %5 to i32
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %6)
  %8 = call float @fabsf(float 0xFFF0000000000000) #3
  %9 = fcmp une float %8, 0x7FF0000000000000
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %10)
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 1)
  %13 = call float @fabsf(float 0x7FF8000000000000) #3
  %14 = fcmp oeq float %13, 0x7FF0000000000000
  %15 = zext i1 %14 to i32
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %15)
  %17 = call float @fabsf(float 0x7FF0000000000000) #3
  %18 = fcmp oeq float %17, 0x7FF0000000000000
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %19)
  %21 = call float @fabsf(float 0xFFF0000000000000) #3
  %22 = fcmp oeq float %21, 0x7FF0000000000000
  %23 = zext i1 %22 to i32
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %23)
  %25 = call i32 @isinf(double 1.230000e+01) #4
  %26 = icmp ne i32 %25, 0
  %27 = zext i1 %26 to i32
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %27)
  %29 = call i64 @div(i32 23, i32 10) #4
  %30 = trunc i64 %29 to i32
  %31 = lshr i64 %29, 32
  %32 = trunc i64 %31 to i32
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %30)
  %34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %32)
  %35 = call i64 @div(i32 -5, i32 3) #4
  %36 = trunc i64 %35 to i32
  %37 = lshr i64 %35, 32
  %38 = trunc i64 %37 to i32
  %39 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %36)
  %40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %38)
  %41 = call i64 @div(i32 5, i32 -3) #4
  %42 = trunc i64 %41 to i32
  %43 = lshr i64 %41, 32
  %44 = trunc i64 %43 to i32
  %45 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %42)
  %46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %44)
  %47 = call i64 @div(i32 -5, i32 -3) #4
  %48 = trunc i64 %47 to i32
  %49 = lshr i64 %47, 32
  %50 = trunc i64 %49 to i32
  %51 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %48)
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %50)
  %53 = call double @modf(double 3.200000e+00, double* %y) #3
  %54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), double %53)
  %55 = load double* %y, align 8, !tbaa !1
  %56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), double %55)
  %57 = call double @modf(double -3.200000e+00, double* %y) #3
  %58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), double %57)
  %59 = load double* %y, align 8, !tbaa !1
  %60 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), double %59)
  %61 = call float @modff(float 0x40099999A0000000, float* %y2) #3
  %62 = fpext float %61 to double
  %63 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %62)
  %64 = load float* %y2, align 4, !tbaa !5
  %65 = fpext float %64 to double
  %66 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %65)
  %67 = call float @modff(float 0xC0099999A0000000, float* %y2) #3
  %68 = fpext float %67 to double
  %69 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %68)
  %70 = load float* %y2, align 4, !tbaa !5
  %71 = fpext float %70 to double
  %72 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %71)
  store double -1.000000e+00, double* %sine, align 8, !tbaa !1
  store double -1.000000e+00, double* %cosine, align 8, !tbaa !1
  call void @sincos(double 0.000000e+00, double* %sine, double* %cosine) #3
  %73 = load double* %sine, align 8, !tbaa !1
  %74 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), double %73)
  %75 = load double* %cosine, align 8, !tbaa !1
  %76 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), double %75)
  store float -1.000000e+00, float* %fsine, align 4, !tbaa !5
  store float -1.000000e+00, float* %fcosine, align 4, !tbaa !5
  call void @sincosf(float 0.000000e+00, float* %fsine, float* %fcosine) #3
  %77 = load float* %fsine, align 4, !tbaa !5
  %78 = fpext float %77 to double
  %79 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %78)
  %80 = load float* %fcosine, align 4, !tbaa !5
  %81 = fpext float %80 to double
  %82 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %81)
  %83 = sitofp i32 %argc to double
  %84 = fadd double %83, 1.100000e+00
  %85 = fadd double %84, -1.000000e+00
  %86 = fptrunc double %85 to float
  %87 = call float @sinf(float %86) #3
  store float %87, float* %fsine, align 4, !tbaa !5
  %88 = call float @cosf(float %86) #3
  store float %88, float* %fcosine, align 4, !tbaa !5
  %89 = load float* %fsine, align 4, !tbaa !5
  %90 = fpext float %89 to double
  %91 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %90)
  %92 = load float* %fcosine, align 4, !tbaa !5
  %93 = fpext float %92 to double
  %94 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), double %93)
  %puts = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readnone
declare i32 @isinf(double) #2

; Function Attrs: nounwind readnone
declare i64 @div(i32, i32) #2

; Function Attrs: nounwind
declare double @modf(double, double* nocapture) #1

; Function Attrs: nounwind
declare float @modff(float, float* nocapture) #1

; Function Attrs: nounwind
declare void @sincos(double, double*, double*) #1

; Function Attrs: nounwind
declare void @sincosf(float, float*, float*) #1

; Function Attrs: nounwind
declare float @sinf(float) #1

; Function Attrs: nounwind
declare float @cosf(float) #1

declare float @fabsf(float)

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"double", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"float", metadata !3, i64 0}
