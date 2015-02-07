; ModuleID = 'test_simd6.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@negzero = global <4 x float> zeroinitializer, align 16
@zero = global <4 x float> zeroinitializer, align 16
@nan = global <4 x float> zeroinitializer, align 16
@one = global <4 x float> zeroinitializer, align 16
@.str = private unnamed_addr constant [48 x i8] c"memcmp(&result, &expected, sizeof(__m128)) == 0\00", align 1
@.str1 = private unnamed_addr constant [19 x i8] c"tmp/test_simd6.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str2 = private unnamed_addr constant [5 x i8] c"DONE\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %expected = alloca <4 x float>, align 16
  %result = alloca <4 x float>, align 16
  store volatile <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, <4 x float>* @negzero, align 16, !tbaa !1
  store volatile <4 x float> zeroinitializer, <4 x float>* @zero, align 16, !tbaa !1
  store volatile <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float>* @one, align 16, !tbaa !1
  store volatile <4 x float> <float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000>, <4 x float>* @nan, align 16, !tbaa !1
  %1 = load volatile <4 x float>* @negzero, align 16, !tbaa !1
  %2 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %3 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> %1, <4 x float> %2) #5
  store <4 x float> %3, <4 x float>* %result, align 16, !tbaa !1
  %4 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  store <4 x float> %4, <4 x float>* %expected, align 16, !tbaa !1
  %5 = bitcast <4 x float>* %result to i8*
  %6 = bitcast <4 x float>* %expected to i8*
  %7 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %10, label %9

; <label>:9                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 26, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:10                                      ; preds = %0
  %11 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %12 = load volatile <4 x float>* @negzero, align 16, !tbaa !1
  %13 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> %11, <4 x float> %12) #5
  store <4 x float> %13, <4 x float>* %result, align 16, !tbaa !1
  %14 = load volatile <4 x float>* @negzero, align 16, !tbaa !1
  store <4 x float> %14, <4 x float>* %expected, align 16, !tbaa !1
  %15 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %18, label %17

; <label>:17                                      ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 30, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:18                                      ; preds = %10
  %19 = load volatile <4 x float>* @nan, align 16, !tbaa !1
  %20 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %21 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> %19, <4 x float> %20) #5
  store <4 x float> %21, <4 x float>* %result, align 16, !tbaa !1
  %22 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  store <4 x float> %22, <4 x float>* %expected, align 16, !tbaa !1
  %23 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %24 = icmp eq i32 %23, 0
  br i1 %24, label %26, label %25

; <label>:25                                      ; preds = %18
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 34, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:26                                      ; preds = %18
  %27 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %28 = load volatile <4 x float>* @nan, align 16, !tbaa !1
  %29 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> %27, <4 x float> %28) #5
  store <4 x float> %29, <4 x float>* %result, align 16, !tbaa !1
  %30 = load volatile <4 x float>* @nan, align 16, !tbaa !1
  store <4 x float> %30, <4 x float>* %expected, align 16, !tbaa !1
  %31 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %34, label %33

; <label>:33                                      ; preds = %26
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 38, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:34                                      ; preds = %26
  %35 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %36 = load volatile <4 x float>* @one, align 16, !tbaa !1
  %37 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> %35, <4 x float> %36) #5
  store <4 x float> %37, <4 x float>* %result, align 16, !tbaa !1
  %38 = load volatile <4 x float>* @one, align 16, !tbaa !1
  store <4 x float> %38, <4 x float>* %expected, align 16, !tbaa !1
  %39 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %42, label %41

; <label>:41                                      ; preds = %34
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 42, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:42                                      ; preds = %34
  %43 = load volatile <4 x float>* @negzero, align 16, !tbaa !1
  %44 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %45 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> %43, <4 x float> %44) #5
  store <4 x float> %45, <4 x float>* %result, align 16, !tbaa !1
  %46 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  store <4 x float> %46, <4 x float>* %expected, align 16, !tbaa !1
  %47 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %48 = icmp eq i32 %47, 0
  br i1 %48, label %50, label %49

; <label>:49                                      ; preds = %42
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 46, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:50                                      ; preds = %42
  %51 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %52 = load volatile <4 x float>* @negzero, align 16, !tbaa !1
  %53 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> %51, <4 x float> %52) #5
  store <4 x float> %53, <4 x float>* %result, align 16, !tbaa !1
  %54 = load volatile <4 x float>* @negzero, align 16, !tbaa !1
  store <4 x float> %54, <4 x float>* %expected, align 16, !tbaa !1
  %55 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %56 = icmp eq i32 %55, 0
  br i1 %56, label %58, label %57

; <label>:57                                      ; preds = %50
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 50, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:58                                      ; preds = %50
  %59 = load volatile <4 x float>* @nan, align 16, !tbaa !1
  %60 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %61 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> %59, <4 x float> %60) #5
  store <4 x float> %61, <4 x float>* %result, align 16, !tbaa !1
  %62 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  store <4 x float> %62, <4 x float>* %expected, align 16, !tbaa !1
  %63 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %64 = icmp eq i32 %63, 0
  br i1 %64, label %66, label %65

; <label>:65                                      ; preds = %58
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 54, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:66                                      ; preds = %58
  %67 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %68 = load volatile <4 x float>* @nan, align 16, !tbaa !1
  %69 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> %67, <4 x float> %68) #5
  store <4 x float> %69, <4 x float>* %result, align 16, !tbaa !1
  %70 = load volatile <4 x float>* @nan, align 16, !tbaa !1
  store <4 x float> %70, <4 x float>* %expected, align 16, !tbaa !1
  %71 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %72 = icmp eq i32 %71, 0
  br i1 %72, label %74, label %73

; <label>:73                                      ; preds = %66
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 58, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:74                                      ; preds = %66
  %75 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  %76 = load volatile <4 x float>* @one, align 16, !tbaa !1
  %77 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> %75, <4 x float> %76) #5
  store <4 x float> %77, <4 x float>* %result, align 16, !tbaa !1
  %78 = load volatile <4 x float>* @zero, align 16, !tbaa !1
  store <4 x float> %78, <4 x float>* %expected, align 16, !tbaa !1
  %79 = call i32 @memcmp(i8* %5, i8* %6, i64 16) #6
  %80 = icmp eq i32 %79, 0
  br i1 %80, label %82, label %81

; <label>:81                                      ; preds = %74
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 62, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #7
  unreachable

; <label>:82                                      ; preds = %74
  %83 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str2, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind readonly
declare i32 @memcmp(i8* nocapture, i8* nocapture, i64) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.min.ps(<4 x float>, <4 x float>) #4

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.max.ps(<4 x float>, <4 x float>) #4

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }
attributes #5 = { nounwind }
attributes #6 = { nounwind readonly }
attributes #7 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
