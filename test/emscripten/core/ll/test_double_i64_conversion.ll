; ModuleID = 'test_double_i64_conversion.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [62 x i8] c"%.20g converted to int64 returns %lld, not %lld as expected!\0A\00", align 1
@.str1 = private unnamed_addr constant [11 x i8] c"eq(0.0, 0)\00", align 1
@.str2 = private unnamed_addr constant [29 x i8] c"test_double_i64_conversion.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str3 = private unnamed_addr constant [12 x i8] c"eq(-0.0, 0)\00", align 1
@.str4 = private unnamed_addr constant [11 x i8] c"eq(0.1, 0)\00", align 1
@.str5 = private unnamed_addr constant [12 x i8] c"eq(-0.1, 0)\00", align 1
@.str6 = private unnamed_addr constant [11 x i8] c"eq(0.6, 0)\00", align 1
@.str7 = private unnamed_addr constant [12 x i8] c"eq(-0.6, 0)\00", align 1
@.str8 = private unnamed_addr constant [11 x i8] c"eq(1.0, 1)\00", align 1
@.str9 = private unnamed_addr constant [13 x i8] c"eq(-1.0, -1)\00", align 1
@.str10 = private unnamed_addr constant [11 x i8] c"eq(1.1, 1)\00", align 1
@.str11 = private unnamed_addr constant [13 x i8] c"eq(-1.1, -1)\00", align 1
@.str12 = private unnamed_addr constant [11 x i8] c"eq(1.6, 1)\00", align 1
@.str13 = private unnamed_addr constant [13 x i8] c"eq(-1.6, -1)\00", align 1
@.str14 = private unnamed_addr constant [31 x i8] c"eq(4294967295.0, 4294967295LL)\00", align 1
@.str15 = private unnamed_addr constant [31 x i8] c"eq(4294967295.5, 4294967295LL)\00", align 1
@.str16 = private unnamed_addr constant [31 x i8] c"eq(4294967296.0, 4294967296LL)\00", align 1
@.str17 = private unnamed_addr constant [31 x i8] c"eq(4294967296.5, 4294967296LL)\00", align 1
@.str18 = private unnamed_addr constant [33 x i8] c"eq(14294967295.0, 14294967295LL)\00", align 1
@.str19 = private unnamed_addr constant [33 x i8] c"eq(14294967295.5, 14294967295LL)\00", align 1
@.str20 = private unnamed_addr constant [33 x i8] c"eq(14294967296.0, 14294967296LL)\00", align 1
@.str21 = private unnamed_addr constant [33 x i8] c"eq(14294967296.5, 14294967296LL)\00", align 1
@.str22 = private unnamed_addr constant [33 x i8] c"eq(-4294967295.0, -4294967295LL)\00", align 1
@.str23 = private unnamed_addr constant [33 x i8] c"eq(-4294967295.5, -4294967295LL)\00", align 1
@.str24 = private unnamed_addr constant [33 x i8] c"eq(-4294967296.0, -4294967296LL)\00", align 1
@.str25 = private unnamed_addr constant [33 x i8] c"eq(-4294967296.5, -4294967296LL)\00", align 1
@.str26 = private unnamed_addr constant [35 x i8] c"eq(-14294967295.0, -14294967295LL)\00", align 1
@.str27 = private unnamed_addr constant [35 x i8] c"eq(-14294967295.5, -14294967295LL)\00", align 1
@.str28 = private unnamed_addr constant [35 x i8] c"eq(-14294967296.0, -14294967296LL)\00", align 1
@.str29 = private unnamed_addr constant [35 x i8] c"eq(-14294967296.5, -14294967296LL)\00", align 1
@.str30 = private unnamed_addr constant [31 x i8] c"eq(4294967295.3, 4294967295LL)\00", align 1
@.str31 = private unnamed_addr constant [31 x i8] c"eq(4294967296.3, 4294967296LL)\00", align 1
@.str32 = private unnamed_addr constant [33 x i8] c"eq(14294967295.3, 14294967295LL)\00", align 1
@.str33 = private unnamed_addr constant [33 x i8] c"eq(14294967296.3, 14294967296LL)\00", align 1
@.str34 = private unnamed_addr constant [33 x i8] c"eq(-4294967295.3, -4294967295LL)\00", align 1
@.str35 = private unnamed_addr constant [33 x i8] c"eq(-4294967296.3, -4294967296LL)\00", align 1
@.str36 = private unnamed_addr constant [35 x i8] c"eq(-14294967295.3, -14294967295LL)\00", align 1
@.str37 = private unnamed_addr constant [35 x i8] c"eq(-14294967296.3, -14294967296LL)\00", align 1
@.str38 = private unnamed_addr constant [31 x i8] c"eq(4294967295.8, 4294967295LL)\00", align 1
@.str39 = private unnamed_addr constant [31 x i8] c"eq(4294967296.8, 4294967296LL)\00", align 1
@.str40 = private unnamed_addr constant [33 x i8] c"eq(14294967295.8, 14294967295LL)\00", align 1
@.str41 = private unnamed_addr constant [33 x i8] c"eq(14294967296.8, 14294967296LL)\00", align 1
@.str42 = private unnamed_addr constant [33 x i8] c"eq(-4294967295.8, -4294967295LL)\00", align 1
@.str43 = private unnamed_addr constant [33 x i8] c"eq(-4294967296.8, -4294967296LL)\00", align 1
@.str44 = private unnamed_addr constant [35 x i8] c"eq(-14294967295.8, -14294967295LL)\00", align 1
@.str45 = private unnamed_addr constant [35 x i8] c"eq(-14294967296.8, -14294967296LL)\00", align 1
@.str46 = private unnamed_addr constant [44 x i8] c"eq(9007199254740992.0, 9007199254740992LL )\00", align 1
@.str47 = private unnamed_addr constant [46 x i8] c"eq(-9007199254740992.0, -9007199254740992LL )\00", align 1
@str = private unnamed_addr constant [4 x i8] c"OK!\00"

; Function Attrs: noinline nounwind uwtable
define zeroext i1 @_Z2eqdl(double %d, i64 %i) #0 {
  %1 = fptosi double %d to i64
  %2 = icmp eq i64 %1, %i
  br i1 %2, label %5, label %3

; <label>:3                                       ; preds = %0
  %4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([62 x i8]* @.str, i64 0, i64 0), double %d, i64 %1, i64 %i)
  br label %5

; <label>:5                                       ; preds = %3, %0
  ret i1 %2
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
  %1 = tail call zeroext i1 @_Z2eqdl(double 0.000000e+00, i64 0)
  br i1 %1, label %3, label %2

; <label>:2                                       ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 15, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:3                                       ; preds = %0
  %4 = tail call zeroext i1 @_Z2eqdl(double -0.000000e+00, i64 0)
  br i1 %4, label %6, label %5

; <label>:5                                       ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 16, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:6                                       ; preds = %3
  %7 = tail call zeroext i1 @_Z2eqdl(double 1.000000e-01, i64 0)
  br i1 %7, label %9, label %8

; <label>:8                                       ; preds = %6
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:9                                       ; preds = %6
  %10 = tail call zeroext i1 @_Z2eqdl(double -1.000000e-01, i64 0)
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 18, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:12                                      ; preds = %9
  %13 = tail call zeroext i1 @_Z2eqdl(double 6.000000e-01, i64 0)
  br i1 %13, label %15, label %14

; <label>:14                                      ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 19, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:15                                      ; preds = %12
  %16 = tail call zeroext i1 @_Z2eqdl(double -6.000000e-01, i64 0)
  br i1 %16, label %18, label %17

; <label>:17                                      ; preds = %15
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 20, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:18                                      ; preds = %15
  %19 = tail call zeroext i1 @_Z2eqdl(double 1.000000e+00, i64 1)
  br i1 %19, label %21, label %20

; <label>:20                                      ; preds = %18
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 21, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:21                                      ; preds = %18
  %22 = tail call zeroext i1 @_Z2eqdl(double -1.000000e+00, i64 -1)
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %21
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 22, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:24                                      ; preds = %21
  %25 = tail call zeroext i1 @_Z2eqdl(double 1.100000e+00, i64 1)
  br i1 %25, label %27, label %26

; <label>:26                                      ; preds = %24
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 23, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:27                                      ; preds = %24
  %28 = tail call zeroext i1 @_Z2eqdl(double -1.100000e+00, i64 -1)
  br i1 %28, label %30, label %29

; <label>:29                                      ; preds = %27
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 24, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:30                                      ; preds = %27
  %31 = tail call zeroext i1 @_Z2eqdl(double 1.600000e+00, i64 1)
  br i1 %31, label %33, label %32

; <label>:32                                      ; preds = %30
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 25, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:33                                      ; preds = %30
  %34 = tail call zeroext i1 @_Z2eqdl(double -1.600000e+00, i64 -1)
  br i1 %34, label %36, label %35

; <label>:35                                      ; preds = %33
  tail call void @__assert_fail(i8* getelementptr inbounds ([13 x i8]* @.str13, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 26, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:36                                      ; preds = %33
  %37 = tail call zeroext i1 @_Z2eqdl(double 0x41EFFFFFFFE00000, i64 4294967295)
  br i1 %37, label %39, label %38

; <label>:38                                      ; preds = %36
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 27, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:39                                      ; preds = %36
  %40 = tail call zeroext i1 @_Z2eqdl(double 0x41EFFFFFFFF00000, i64 4294967295)
  br i1 %40, label %42, label %41

; <label>:41                                      ; preds = %39
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str15, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 28, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:42                                      ; preds = %39
  %43 = tail call zeroext i1 @_Z2eqdl(double 0x41F0000000000000, i64 4294967296)
  br i1 %43, label %45, label %44

; <label>:44                                      ; preds = %42
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str16, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 29, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:45                                      ; preds = %42
  %46 = tail call zeroext i1 @_Z2eqdl(double 0x41F0000000080000, i64 4294967296)
  br i1 %46, label %48, label %47

; <label>:47                                      ; preds = %45
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 30, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:48                                      ; preds = %45
  %49 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F1FF80000, i64 14294967295)
  br i1 %49, label %51, label %50

; <label>:50                                      ; preds = %48
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 31, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:51                                      ; preds = %48
  %52 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F1FFC0000, i64 14294967295)
  br i1 %52, label %54, label %53

; <label>:53                                      ; preds = %51
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str19, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 32, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:54                                      ; preds = %51
  %55 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F20000000, i64 14294967296)
  br i1 %55, label %57, label %56

; <label>:56                                      ; preds = %54
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str20, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 33, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:57                                      ; preds = %54
  %58 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F20040000, i64 14294967296)
  br i1 %58, label %60, label %59

; <label>:59                                      ; preds = %57
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str21, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 34, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:60                                      ; preds = %57
  %61 = tail call zeroext i1 @_Z2eqdl(double 0xC1EFFFFFFFE00000, i64 -4294967295)
  br i1 %61, label %63, label %62

; <label>:62                                      ; preds = %60
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 35, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:63                                      ; preds = %60
  %64 = tail call zeroext i1 @_Z2eqdl(double 0xC1EFFFFFFFF00000, i64 -4294967295)
  br i1 %64, label %66, label %65

; <label>:65                                      ; preds = %63
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str23, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 36, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:66                                      ; preds = %63
  %67 = tail call zeroext i1 @_Z2eqdl(double 0xC1F0000000000000, i64 -4294967296)
  br i1 %67, label %69, label %68

; <label>:68                                      ; preds = %66
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str24, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 37, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:69                                      ; preds = %66
  %70 = tail call zeroext i1 @_Z2eqdl(double 0xC1F0000000080000, i64 -4294967296)
  br i1 %70, label %72, label %71

; <label>:71                                      ; preds = %69
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str25, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 38, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:72                                      ; preds = %69
  %73 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F1FF80000, i64 -14294967295)
  br i1 %73, label %75, label %74

; <label>:74                                      ; preds = %72
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str26, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 39, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:75                                      ; preds = %72
  %76 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F1FFC0000, i64 -14294967295)
  br i1 %76, label %78, label %77

; <label>:77                                      ; preds = %75
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str27, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 40, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:78                                      ; preds = %75
  %79 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F20000000, i64 -14294967296)
  br i1 %79, label %81, label %80

; <label>:80                                      ; preds = %78
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str28, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 41, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:81                                      ; preds = %78
  %82 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F20040000, i64 -14294967296)
  br i1 %82, label %84, label %83

; <label>:83                                      ; preds = %81
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str29, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 42, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:84                                      ; preds = %81
  %85 = tail call zeroext i1 @_Z2eqdl(double 0x41EFFFFFFFE9999A, i64 4294967295)
  br i1 %85, label %87, label %86

; <label>:86                                      ; preds = %84
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str30, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 44, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:87                                      ; preds = %84
  %88 = tail call zeroext i1 @_Z2eqdl(double 0x41F000000004CCCD, i64 4294967296)
  br i1 %88, label %90, label %89

; <label>:89                                      ; preds = %87
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str31, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 45, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:90                                      ; preds = %87
  %91 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F1FFA6666, i64 14294967295)
  br i1 %91, label %93, label %92

; <label>:92                                      ; preds = %90
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str32, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 46, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:93                                      ; preds = %90
  %94 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F20026666, i64 14294967296)
  br i1 %94, label %96, label %95

; <label>:95                                      ; preds = %93
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str33, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 47, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:96                                      ; preds = %93
  %97 = tail call zeroext i1 @_Z2eqdl(double 0xC1EFFFFFFFE9999A, i64 -4294967295)
  br i1 %97, label %99, label %98

; <label>:98                                      ; preds = %96
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str34, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 48, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:99                                      ; preds = %96
  %100 = tail call zeroext i1 @_Z2eqdl(double 0xC1F000000004CCCD, i64 -4294967296)
  br i1 %100, label %102, label %101

; <label>:101                                     ; preds = %99
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str35, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 49, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:102                                     ; preds = %99
  %103 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F1FFA6666, i64 -14294967295)
  br i1 %103, label %105, label %104

; <label>:104                                     ; preds = %102
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str36, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 50, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:105                                     ; preds = %102
  %106 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F20026666, i64 -14294967296)
  br i1 %106, label %108, label %107

; <label>:107                                     ; preds = %105
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str37, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 51, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:108                                     ; preds = %105
  %109 = tail call zeroext i1 @_Z2eqdl(double 0x41EFFFFFFFF9999A, i64 4294967295)
  br i1 %109, label %111, label %110

; <label>:110                                     ; preds = %108
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str38, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 53, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:111                                     ; preds = %108
  %112 = tail call zeroext i1 @_Z2eqdl(double 0x41F00000000CCCCD, i64 4294967296)
  br i1 %112, label %114, label %113

; <label>:113                                     ; preds = %111
  tail call void @__assert_fail(i8* getelementptr inbounds ([31 x i8]* @.str39, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 54, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:114                                     ; preds = %111
  %115 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F1FFE6666, i64 14294967295)
  br i1 %115, label %117, label %116

; <label>:116                                     ; preds = %114
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str40, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 55, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:117                                     ; preds = %114
  %118 = tail call zeroext i1 @_Z2eqdl(double 0x420AA05F20066666, i64 14294967296)
  br i1 %118, label %120, label %119

; <label>:119                                     ; preds = %117
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str41, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 56, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:120                                     ; preds = %117
  %121 = tail call zeroext i1 @_Z2eqdl(double 0xC1EFFFFFFFF9999A, i64 -4294967295)
  br i1 %121, label %123, label %122

; <label>:122                                     ; preds = %120
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str42, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 57, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:123                                     ; preds = %120
  %124 = tail call zeroext i1 @_Z2eqdl(double 0xC1F00000000CCCCD, i64 -4294967296)
  br i1 %124, label %126, label %125

; <label>:125                                     ; preds = %123
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8]* @.str43, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 58, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:126                                     ; preds = %123
  %127 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F1FFE6666, i64 -14294967295)
  br i1 %127, label %129, label %128

; <label>:128                                     ; preds = %126
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str44, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 59, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:129                                     ; preds = %126
  %130 = tail call zeroext i1 @_Z2eqdl(double 0xC20AA05F20066666, i64 -14294967296)
  br i1 %130, label %132, label %131

; <label>:131                                     ; preds = %129
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str45, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 60, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:132                                     ; preds = %129
  %133 = tail call zeroext i1 @_Z2eqdl(double 0x4340000000000000, i64 9007199254740992)
  br i1 %133, label %135, label %134

; <label>:134                                     ; preds = %132
  tail call void @__assert_fail(i8* getelementptr inbounds ([44 x i8]* @.str46, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 64, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:135                                     ; preds = %132
  %136 = tail call zeroext i1 @_Z2eqdl(double 0xC340000000000000, i64 -9007199254740992)
  br i1 %136, label %138, label %137

; <label>:137                                     ; preds = %135
  tail call void @__assert_fail(i8* getelementptr inbounds ([46 x i8]* @.str47, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8]* @.str2, i64 0, i64 0), i32 65, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:138                                     ; preds = %135
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #3

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { noinline nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
