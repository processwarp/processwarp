; ModuleID = 'test_simd3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str1 = private unnamed_addr constant [19 x i8] c"tmp/test_simd3.cpp\00", align 1
@.str9 = private unnamed_addr constant [11 x i8] c"ar[0] == 0\00", align 1
@.str10 = private unnamed_addr constant [11 x i8] c"ar[1] == 0\00", align 1
@.str11 = private unnamed_addr constant [11 x i8] c"ar[2] == 0\00", align 1
@.str12 = private unnamed_addr constant [11 x i8] c"ar[3] == 0\00", align 1
@.str18 = private unnamed_addr constant [20 x i8] c"ar[1] == 0xffffffff\00", align 1
@.str41 = private unnamed_addr constant [16 x i8] c"ar2[0] == 256.0\00", align 1
@__PRETTY_FUNCTION__._Z15testConversionsv = private unnamed_addr constant [23 x i8] c"void testConversions()\00", align 1
@.str42 = private unnamed_addr constant [17 x i8] c"ar2[1] == -517.0\00", align 1
@.str43 = private unnamed_addr constant [15 x i8] c"ar2[2] == -3.0\00", align 1
@.str44 = private unnamed_addr constant [12 x i8] c"ar2[3] == 0\00", align 1
@.str45 = private unnamed_addr constant [13 x i8] c"ar1[0] == -8\00", align 1
@.str46 = private unnamed_addr constant [12 x i8] c"ar1[1] == 7\00", align 1
@.str47 = private unnamed_addr constant [12 x i8] c"ar1[2] == 6\00", align 1
@.str48 = private unnamed_addr constant [12 x i8] c"ar1[3] == 5\00", align 1
@.str49 = private unnamed_addr constant [11 x i8] c"mask == 13\00", align 1
@__PRETTY_FUNCTION__._Z14testMoveMaskPsv = private unnamed_addr constant [22 x i8] c"void testMoveMaskPs()\00", align 1
@.str64 = private unnamed_addr constant [13 x i8] c"ar[2] == 3.0\00", align 1
@.str66 = private unnamed_addr constant [13 x i8] c"ar[0] == 0.0\00", align 1
@__PRETTY_FUNCTION__._Z9testMinPsv = private unnamed_addr constant [17 x i8] c"void testMinPs()\00", align 1
@.str67 = private unnamed_addr constant [14 x i8] c"ar[1] == 30.0\00", align 1
@.str68 = private unnamed_addr constant [13 x i8] c"ar[2] == 1.0\00", align 1
@.str69 = private unnamed_addr constant [15 x i8] c"ar[3] == -20.0\00", align 1
@.str70 = private unnamed_addr constant [13 x i8] c"ar[0] == 1.0\00", align 1
@__PRETTY_FUNCTION__._Z9testMaxPsv = private unnamed_addr constant [17 x i8] c"void testMaxPs()\00", align 1
@.str71 = private unnamed_addr constant [14 x i8] c"ar[1] == 55.0\00", align 1
@.str72 = private unnamed_addr constant [14 x i8] c"ar[2] == 10.0\00", align 1
@.str73 = private unnamed_addr constant [13 x i8] c"ar[3] == 2.5\00", align 1
@__PRETTY_FUNCTION__._Z10testSqrtPsv = private unnamed_addr constant [18 x i8] c"void testSqrtPs()\00", align 1
@.str74 = private unnamed_addr constant [13 x i8] c"ar[1] == 2.0\00", align 1
@.str75 = private unnamed_addr constant [13 x i8] c"ar[3] == 4.0\00", align 1
@.str76 = private unnamed_addr constant [20 x i8] c"ar[0] == 0xffffffff\00", align 1
@__PRETTY_FUNCTION__._Z11testCmpLtPsv = private unnamed_addr constant [19 x i8] c"void testCmpLtPs()\00", align 1
@.str77 = private unnamed_addr constant [20 x i8] c"ar[3] == 0xffffffff\00", align 1
@.str78 = private unnamed_addr constant [24 x i8] c"_mm_movemask_ps(v) == 9\00", align 1
@__PRETTY_FUNCTION__._Z11testCmpLePsv = private unnamed_addr constant [19 x i8] c"void testCmpLePs()\00", align 1
@.str79 = private unnamed_addr constant [20 x i8] c"ar[2] == 0xffffffff\00", align 1
@.str80 = private unnamed_addr constant [25 x i8] c"_mm_movemask_ps(v) == 13\00", align 1
@__PRETTY_FUNCTION__._Z11testCmpEqPsv = private unnamed_addr constant [19 x i8] c"void testCmpEqPs()\00", align 1
@.str81 = private unnamed_addr constant [24 x i8] c"_mm_movemask_ps(v) == 4\00", align 1
@__PRETTY_FUNCTION__._Z11testCmpGePsv = private unnamed_addr constant [19 x i8] c"void testCmpGePs()\00", align 1
@.str82 = private unnamed_addr constant [24 x i8] c"_mm_movemask_ps(v) == 6\00", align 1
@__PRETTY_FUNCTION__._Z11testCmpGtPsv = private unnamed_addr constant [19 x i8] c"void testCmpGtPs()\00", align 1
@.str83 = private unnamed_addr constant [24 x i8] c"_mm_movemask_ps(v) == 2\00", align 1
@.str107 = private unnamed_addr constant [5 x i8] c"DONE\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #1

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: nounwind uwtable
define void @_Z9testSetPsv() #3 {
  ret void
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #4

; Function Attrs: nounwind uwtable
define void @_Z10testSet1Psv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z13testSetZeroPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z12testSetEpi32v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z13testSet1Epi32v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z16testSetZeroSi128v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z12testBitCastsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z15testConversionsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse2.cvtdq2ps(<4 x i32> <i32 256, i32 -517, i32 -3, i32 0>) #2
  %2 = extractelement <4 x float> %1, i32 0
  %3 = fcmp oeq float %2, 2.560000e+02
  br i1 %3, label %5, label %4

; <label>:4                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8]* @.str41, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 138, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:5                                       ; preds = %0
  %6 = extractelement <4 x float> %1, i32 1
  %7 = fcmp oeq float %6, -5.170000e+02
  br i1 %7, label %9, label %8

; <label>:8                                       ; preds = %5
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str42, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 139, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:9                                       ; preds = %5
  %10 = extractelement <4 x float> %1, i32 2
  %11 = fcmp oeq float %10, -3.000000e+00
  br i1 %11, label %13, label %12

; <label>:12                                      ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([15 x i8]* @.str43, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 140, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:13                                      ; preds = %9
  %14 = extractelement <4 x float> %1, i32 3
  %15 = fcmp oeq float %14, 0.000000e+00
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %13
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str44, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 141, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %13
  %18 = tail call <4 x i32> @llvm.x86.sse2.cvtps2dq(<4 x float> <float -8.000000e+00, float 0x401DCCCCC0000000, float 6.000000e+00, float 5.000000e+00>) #2
  %19 = bitcast <4 x i32> %18 to <2 x i64>
  %20 = bitcast <2 x i64> %19 to i128
  %21 = trunc i128 %20 to i32
  %22 = icmp eq i32 %21, -8
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %17
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str45, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 145, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:24                                      ; preds = %17
  %25 = lshr i128 %20, 32
  %26 = trunc i128 %25 to i32
  %27 = icmp eq i32 %26, 7
  br i1 %27, label %29, label %28

; <label>:28                                      ; preds = %24
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str46, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 146, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:29                                      ; preds = %24
  %30 = lshr i128 %20, 64
  %31 = trunc i128 %30 to i32
  %32 = icmp eq i32 %31, 6
  br i1 %32, label %34, label %33

; <label>:33                                      ; preds = %29
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str47, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 147, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:34                                      ; preds = %29
  %.mask = and i128 %20, -79228162514264337593543950336
  %35 = icmp eq i128 %.mask, 396140812571321687967719751680
  br i1 %35, label %37, label %36

; <label>:36                                      ; preds = %34
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str48, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 148, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__._Z15testConversionsv, i64 0, i64 0)) #6
  unreachable

; <label>:37                                      ; preds = %34
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z14testMoveMaskPsv() #3 {
  %1 = tail call i32 @llvm.x86.sse.movmsk.ps(<4 x float> <float 0xFFFFFFFFE0000000, float 0.000000e+00, float 0xFFFFFFFFE0000000, float 0xFFFFFFFFE0000000>) #2
  %2 = icmp eq i32 %1, 13
  br i1 %2, label %4, label %3

; <label>:3                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str49, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 155, i8* getelementptr inbounds ([22 x i8]* @__PRETTY_FUNCTION__._Z14testMoveMaskPsv, i64 0, i64 0)) #6
  unreachable

; <label>:4                                       ; preds = %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testAddPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testSubPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testMulPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testDivPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testMinPsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> <float 5.000000e-01, float 3.000000e+01, float 1.000000e+01, float -2.000000e+01>, <4 x float> <float 0.000000e+00, float 5.000000e+01, float 1.000000e+00, float 2.000000e+00>) #2
  %2 = extractelement <4 x float> %1, i32 0
  %3 = fcmp oeq float %2, 0.000000e+00
  br i1 %3, label %5, label %4

; <label>:4                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str66, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 212, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

; <label>:5                                       ; preds = %0
  %6 = extractelement <4 x float> %1, i32 1
  %7 = fcmp oeq float %6, 3.000000e+01
  br i1 %7, label %9, label %8

; <label>:8                                       ; preds = %5
  tail call void @__assert_fail(i8* getelementptr inbounds ([14 x i8]* @.str67, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 213, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

; <label>:9                                       ; preds = %5
  %10 = extractelement <4 x float> %1, i32 2
  %11 = fcmp oeq float %10, 1.000000e+00
  br i1 %11, label %13, label %12

; <label>:12                                      ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str68, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 214, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

; <label>:13                                      ; preds = %9
  %14 = extractelement <4 x float> %1, i32 3
  %15 = fcmp oeq float %14, -2.000000e+01
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %13
  tail call void @__assert_fail(i8* getelementptr inbounds ([15 x i8]* @.str69, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 215, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %13
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testMaxPsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> <float 5.000000e-01, float 3.000000e+01, float 1.000000e+01, float -2.000000e+01>, <4 x float> <float 1.000000e+00, float 5.500000e+01, float 5.000000e+00, float 2.500000e+00>) #2
  %2 = extractelement <4 x float> %1, i32 0
  %3 = fcmp oeq float %2, 1.000000e+00
  br i1 %3, label %5, label %4

; <label>:4                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str70, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 224, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

; <label>:5                                       ; preds = %0
  %6 = extractelement <4 x float> %1, i32 1
  %7 = fcmp oeq float %6, 5.500000e+01
  br i1 %7, label %9, label %8

; <label>:8                                       ; preds = %5
  tail call void @__assert_fail(i8* getelementptr inbounds ([14 x i8]* @.str71, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 225, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

; <label>:9                                       ; preds = %5
  %10 = extractelement <4 x float> %1, i32 2
  %11 = fcmp oeq float %10, 1.000000e+01
  br i1 %11, label %13, label %12

; <label>:12                                      ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([14 x i8]* @.str72, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 226, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

; <label>:13                                      ; preds = %9
  %14 = extractelement <4 x float> %1, i32 3
  %15 = fcmp oeq float %14, 2.500000e+00
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %13
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str73, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 227, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %13
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z10testSqrtPsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.sqrt.ps(<4 x float> <float 1.000000e+00, float 4.000000e+00, float 9.000000e+00, float 1.600000e+01>) #2
  %2 = extractelement <4 x float> %1, i32 0
  %3 = fcmp oeq float %2, 1.000000e+00
  br i1 %3, label %5, label %4

; <label>:4                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str70, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 235, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:5                                       ; preds = %0
  %6 = extractelement <4 x float> %1, i32 1
  %7 = fcmp oeq float %6, 2.000000e+00
  br i1 %7, label %9, label %8

; <label>:8                                       ; preds = %5
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str74, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 236, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:9                                       ; preds = %5
  %10 = extractelement <4 x float> %1, i32 2
  %11 = fcmp oeq float %10, 3.000000e+00
  br i1 %11, label %13, label %12

; <label>:12                                      ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str64, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 237, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:13                                      ; preds = %9
  %14 = extractelement <4 x float> %1, i32 3
  %15 = fcmp oeq float %14, 4.000000e+00
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %13
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str75, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 238, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %13
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z11testCmpLtPsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> <float 0x3F50624DE0000000, float 0x3FB99999A0000000, float 2.000000e+00, float 1.000000e+00>, <4 x float> <float 0x3FB99999A0000000, float 0x3F50624DE0000000, float 2.000000e+00, float 2.000000e+00>, i8 1) #2
  %2 = bitcast <4 x float> %1 to <2 x i64>
  %3 = bitcast <2 x i64> %2 to i128
  %4 = trunc i128 %3 to i32
  %5 = icmp eq i32 %4, -1
  br i1 %5, label %7, label %6

; <label>:6                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str76, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 247, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:7                                       ; preds = %0
  %8 = lshr i128 %3, 32
  %9 = trunc i128 %8 to i32
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 248, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:12                                      ; preds = %7
  %13 = lshr i128 %3, 64
  %14 = trunc i128 %13 to i32
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 249, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %12
  %18 = icmp ugt i128 %3, -79228162514264337593543950337
  br i1 %18, label %20, label %19

; <label>:19                                      ; preds = %17
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str77, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 250, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:20                                      ; preds = %17
  %21 = tail call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %1) #2
  %22 = icmp eq i32 %21, 9
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %20
  tail call void @__assert_fail(i8* getelementptr inbounds ([24 x i8]* @.str78, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 251, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:24                                      ; preds = %20
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z11testCmpLePsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> <float 0x3F50624DE0000000, float 0x3FB99999A0000000, float 2.000000e+00, float 1.000000e+00>, <4 x float> <float 0x3FB99999A0000000, float 0x3F50624DE0000000, float 2.000000e+00, float 2.000000e+00>, i8 2) #2
  %2 = bitcast <4 x float> %1 to <2 x i64>
  %3 = bitcast <2 x i64> %2 to i128
  %4 = trunc i128 %3 to i32
  %5 = icmp eq i32 %4, -1
  br i1 %5, label %7, label %6

; <label>:6                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str76, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 260, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLePsv, i64 0, i64 0)) #6
  unreachable

; <label>:7                                       ; preds = %0
  %8 = lshr i128 %3, 32
  %9 = trunc i128 %8 to i32
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 261, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLePsv, i64 0, i64 0)) #6
  unreachable

; <label>:12                                      ; preds = %7
  %13 = lshr i128 %3, 64
  %14 = trunc i128 %13 to i32
  %15 = icmp eq i32 %14, -1
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str79, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 262, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLePsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %12
  %18 = icmp ugt i128 %3, -79228162514264337593543950337
  br i1 %18, label %20, label %19

; <label>:19                                      ; preds = %17
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str77, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 263, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLePsv, i64 0, i64 0)) #6
  unreachable

; <label>:20                                      ; preds = %17
  %21 = tail call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %1) #2
  %22 = icmp eq i32 %21, 13
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %20
  tail call void @__assert_fail(i8* getelementptr inbounds ([25 x i8]* @.str80, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 264, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpLePsv, i64 0, i64 0)) #6
  unreachable

; <label>:24                                      ; preds = %20
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z11testCmpEqPsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> <float 0x3F50624DE0000000, float 0x3FB99999A0000000, float 2.000000e+00, float 1.000000e+00>, <4 x float> <float 0x3FB99999A0000000, float 0x3F50624DE0000000, float 2.000000e+00, float 2.000000e+00>, i8 0) #2
  %2 = bitcast <4 x float> %1 to <2 x i64>
  %3 = bitcast <2 x i64> %2 to i128
  %4 = trunc i128 %3 to i32
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %7, label %6

; <label>:6                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 273, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpEqPsv, i64 0, i64 0)) #6
  unreachable

; <label>:7                                       ; preds = %0
  %8 = lshr i128 %3, 32
  %9 = trunc i128 %8 to i32
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 274, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpEqPsv, i64 0, i64 0)) #6
  unreachable

; <label>:12                                      ; preds = %7
  %13 = lshr i128 %3, 64
  %14 = trunc i128 %13 to i32
  %15 = icmp eq i32 %14, -1
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str79, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 275, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpEqPsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %12
  %18 = icmp ult i128 %3, 79228162514264337593543950336
  br i1 %18, label %20, label %19

; <label>:19                                      ; preds = %17
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 276, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpEqPsv, i64 0, i64 0)) #6
  unreachable

; <label>:20                                      ; preds = %17
  %21 = tail call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %1) #2
  %22 = icmp eq i32 %21, 4
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %20
  tail call void @__assert_fail(i8* getelementptr inbounds ([24 x i8]* @.str81, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 277, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpEqPsv, i64 0, i64 0)) #6
  unreachable

; <label>:24                                      ; preds = %20
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z11testCmpGePsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> <float 0x3FB99999A0000000, float 0x3F50624DE0000000, float 2.000000e+00, float 2.000000e+00>, <4 x float> <float 0x3F50624DE0000000, float 0x3FB99999A0000000, float 2.000000e+00, float 1.000000e+00>, i8 2) #2
  %2 = bitcast <4 x float> %1 to <2 x i64>
  %3 = bitcast <2 x i64> %2 to i128
  %4 = trunc i128 %3 to i32
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %7, label %6

; <label>:6                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 286, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGePsv, i64 0, i64 0)) #6
  unreachable

; <label>:7                                       ; preds = %0
  %8 = lshr i128 %3, 32
  %9 = trunc i128 %8 to i32
  %10 = icmp eq i32 %9, -1
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 287, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGePsv, i64 0, i64 0)) #6
  unreachable

; <label>:12                                      ; preds = %7
  %13 = lshr i128 %3, 64
  %14 = trunc i128 %13 to i32
  %15 = icmp eq i32 %14, -1
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str79, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 288, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGePsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %12
  %18 = icmp ult i128 %3, 79228162514264337593543950336
  br i1 %18, label %20, label %19

; <label>:19                                      ; preds = %17
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 289, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGePsv, i64 0, i64 0)) #6
  unreachable

; <label>:20                                      ; preds = %17
  %21 = tail call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %1) #2
  %22 = icmp eq i32 %21, 6
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %20
  tail call void @__assert_fail(i8* getelementptr inbounds ([24 x i8]* @.str82, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 290, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGePsv, i64 0, i64 0)) #6
  unreachable

; <label>:24                                      ; preds = %20
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z11testCmpGtPsv() #3 {
  %1 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> <float 0x3FB99999A0000000, float 0x3F50624DE0000000, float 2.000000e+00, float 2.000000e+00>, <4 x float> <float 0x3F50624DE0000000, float 0x3FB99999A0000000, float 2.000000e+00, float 1.000000e+00>, i8 1) #2
  %2 = bitcast <4 x float> %1 to <2 x i64>
  %3 = bitcast <2 x i64> %2 to i128
  %4 = trunc i128 %3 to i32
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %7, label %6

; <label>:6                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 299, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:7                                       ; preds = %0
  %8 = lshr i128 %3, 32
  %9 = trunc i128 %8 to i32
  %10 = icmp eq i32 %9, -1
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 300, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:12                                      ; preds = %7
  %13 = lshr i128 %3, 64
  %14 = trunc i128 %13 to i32
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 301, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:17                                      ; preds = %12
  %18 = icmp ult i128 %3, 79228162514264337593543950336
  br i1 %18, label %20, label %19

; <label>:19                                      ; preds = %17
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 302, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:20                                      ; preds = %17
  %21 = tail call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %1) #2
  %22 = icmp eq i32 %21, 2
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %20
  tail call void @__assert_fail(i8* getelementptr inbounds ([24 x i8]* @.str83, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 303, i8* getelementptr inbounds ([19 x i8]* @__PRETTY_FUNCTION__._Z11testCmpGtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:24                                      ; preds = %20
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testAndPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z12testAndNotPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z8testOrPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z9testXorPsv() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z12testAndSi128v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z15testAndNotSi128v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z11testOrSi128v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z12testXorSi128v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z12testAddEpi32v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z12testSubEpi32v() #3 {
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #3 {
  tail call void @_Z15testConversionsv()
  %1 = tail call i32 @llvm.x86.sse.movmsk.ps(<4 x float> <float 0xFFFFFFFFE0000000, float 0.000000e+00, float 0xFFFFFFFFE0000000, float 0xFFFFFFFFE0000000>) #2
  %2 = icmp eq i32 %1, 13
  br i1 %2, label %_Z14testMoveMaskPsv.exit, label %3

; <label>:3                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str49, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 155, i8* getelementptr inbounds ([22 x i8]* @__PRETTY_FUNCTION__._Z14testMoveMaskPsv, i64 0, i64 0)) #6
  unreachable

_Z14testMoveMaskPsv.exit:                         ; preds = %0
  %4 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> <float 5.000000e-01, float 3.000000e+01, float 1.000000e+01, float -2.000000e+01>, <4 x float> <float 1.000000e+00, float 5.500000e+01, float 5.000000e+00, float 2.500000e+00>) #2
  %5 = extractelement <4 x float> %4, i32 0
  %6 = fcmp oeq float %5, 1.000000e+00
  br i1 %6, label %8, label %7

; <label>:7                                       ; preds = %_Z14testMoveMaskPsv.exit
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str70, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 224, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

; <label>:8                                       ; preds = %_Z14testMoveMaskPsv.exit
  %9 = extractelement <4 x float> %4, i32 1
  %10 = fcmp oeq float %9, 5.500000e+01
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([14 x i8]* @.str71, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 225, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

; <label>:12                                      ; preds = %8
  %13 = extractelement <4 x float> %4, i32 2
  %14 = fcmp oeq float %13, 1.000000e+01
  br i1 %14, label %16, label %15

; <label>:15                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([14 x i8]* @.str72, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 226, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

; <label>:16                                      ; preds = %12
  %17 = extractelement <4 x float> %4, i32 3
  %18 = fcmp oeq float %17, 2.500000e+00
  br i1 %18, label %_Z9testMaxPsv.exit, label %19

; <label>:19                                      ; preds = %16
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str73, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 227, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMaxPsv, i64 0, i64 0)) #6
  unreachable

_Z9testMaxPsv.exit:                               ; preds = %16
  %20 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> <float 5.000000e-01, float 3.000000e+01, float 1.000000e+01, float -2.000000e+01>, <4 x float> <float 0.000000e+00, float 5.000000e+01, float 1.000000e+00, float 2.000000e+00>) #2
  %21 = extractelement <4 x float> %20, i32 0
  %22 = fcmp oeq float %21, 0.000000e+00
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %_Z9testMaxPsv.exit
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str66, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 212, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

; <label>:24                                      ; preds = %_Z9testMaxPsv.exit
  %25 = extractelement <4 x float> %20, i32 1
  %26 = fcmp oeq float %25, 3.000000e+01
  br i1 %26, label %28, label %27

; <label>:27                                      ; preds = %24
  tail call void @__assert_fail(i8* getelementptr inbounds ([14 x i8]* @.str67, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 213, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

; <label>:28                                      ; preds = %24
  %29 = extractelement <4 x float> %20, i32 2
  %30 = fcmp oeq float %29, 1.000000e+00
  br i1 %30, label %32, label %31

; <label>:31                                      ; preds = %28
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str68, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 214, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

; <label>:32                                      ; preds = %28
  %33 = extractelement <4 x float> %20, i32 3
  %34 = fcmp oeq float %33, -2.000000e+01
  br i1 %34, label %_Z9testMinPsv.exit, label %35

; <label>:35                                      ; preds = %32
  tail call void @__assert_fail(i8* getelementptr inbounds ([15 x i8]* @.str69, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 215, i8* getelementptr inbounds ([17 x i8]* @__PRETTY_FUNCTION__._Z9testMinPsv, i64 0, i64 0)) #6
  unreachable

_Z9testMinPsv.exit:                               ; preds = %32
  %36 = tail call <4 x float> @llvm.x86.sse.sqrt.ps(<4 x float> <float 1.000000e+00, float 4.000000e+00, float 9.000000e+00, float 1.600000e+01>) #2
  %37 = extractelement <4 x float> %36, i32 0
  %38 = fcmp oeq float %37, 1.000000e+00
  br i1 %38, label %40, label %39

; <label>:39                                      ; preds = %_Z9testMinPsv.exit
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str70, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 235, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:40                                      ; preds = %_Z9testMinPsv.exit
  %41 = extractelement <4 x float> %36, i32 1
  %42 = fcmp oeq float %41, 2.000000e+00
  br i1 %42, label %44, label %43

; <label>:43                                      ; preds = %40
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str74, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 236, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:44                                      ; preds = %40
  %45 = extractelement <4 x float> %36, i32 2
  %46 = fcmp oeq float %45, 3.000000e+00
  br i1 %46, label %48, label %47

; <label>:47                                      ; preds = %44
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str64, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 237, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

; <label>:48                                      ; preds = %44
  %49 = extractelement <4 x float> %36, i32 3
  %50 = fcmp oeq float %49, 4.000000e+00
  br i1 %50, label %_Z10testSqrtPsv.exit, label %51

; <label>:51                                      ; preds = %48
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str75, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 238, i8* getelementptr inbounds ([18 x i8]* @__PRETTY_FUNCTION__._Z10testSqrtPsv, i64 0, i64 0)) #6
  unreachable

_Z10testSqrtPsv.exit:                             ; preds = %48
  tail call void @_Z11testCmpLtPsv()
  tail call void @_Z11testCmpLePsv()
  tail call void @_Z11testCmpEqPsv()
  tail call void @_Z11testCmpGePsv()
  tail call void @_Z11testCmpGtPsv()
  %52 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str107, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.cmp.ps(<4 x float>, <4 x float>, i8) #5

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.sqrt.ps(<4 x float>) #5

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.max.ps(<4 x float>, <4 x float>) #5

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.min.ps(<4 x float>, <4 x float>) #5

; Function Attrs: nounwind readnone
declare i32 @llvm.x86.sse.movmsk.ps(<4 x float>) #5

; Function Attrs: nounwind readnone
declare <4 x i32> @llvm.x86.sse2.cvtps2dq(<4 x float>) #5

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse2.cvtdq2ps(<4 x i32>) #5

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #2
  ret void
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
