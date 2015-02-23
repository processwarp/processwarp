; ModuleID = 'test_sscanf.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"en-us 2\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"%s %d\00", align 1
@.str2 = private unnamed_addr constant [9 x i8] c"%s : %d\0A\00", align 1
@.str3 = private unnamed_addr constant [5 x i8] c"en-r\00", align 1
@.str4 = private unnamed_addr constant [5 x i8] c"en 3\00", align 1
@.str5 = private unnamed_addr constant [8 x i8] c"%f, %f\0A\00", align 1
@.str6 = private unnamed_addr constant [9 x i8] c"1.234567\00", align 1
@.str7 = private unnamed_addr constant [6 x i8] c"cheez\00", align 1
@main.format = private unnamed_addr constant [3 x i8] c"%_\00", align 1
@.str8 = private unnamed_addr constant [8 x i8] c" 2.8208\00", align 1
@.str9 = private unnamed_addr constant [6 x i8] c"%.4f\0A\00", align 1
@.str10 = private unnamed_addr constant [6 x i8] c"-3.03\00", align 1
@.str11 = private unnamed_addr constant [36 x i8] c"cheez some thing moar 123\0Ayet more\0A\00", align 1
@.str12 = private unnamed_addr constant [9 x i8] c"cheez %s\00", align 1
@.str13 = private unnamed_addr constant [6 x i8] c"|%s|\0A\00", align 1
@.str14 = private unnamed_addr constant [35 x i8] c"cheez something\0Amoar 123\0Ayet more\0A\00", align 1
@.str15 = private unnamed_addr constant [30 x i8] c"cheez somethingmoar\09yet more\0A\00", align 1
@.str16 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str17 = private unnamed_addr constant [16 x i8] c"\09numverts 1499\0A\00", align 1
@.str18 = private unnamed_addr constant [13 x i8] c" numverts %d\00", align 1
@.str19 = private unnamed_addr constant [36 x i8] c"\09vert 87 ( 0.481565 0.059481 ) 0 1\0A\00", align 1
@.str20 = private unnamed_addr constant [27 x i8] c" vert %d ( %f %f ) %hu %hu\00", align 1
@.str21 = private unnamed_addr constant [22 x i8] c"%d,%.6f,%.6f,%hu,%hu\0A\00", align 1
@.str22 = private unnamed_addr constant [16 x i8] c"-123 -765 -34-6\00", align 1
@.str23 = private unnamed_addr constant [9 x i8] c"%d %u %d\00", align 1
@.str24 = private unnamed_addr constant [10 x i8] c"%d,%u,%d\0A\00", align 1
@.str25 = private unnamed_addr constant [2 x i8] c"1\00", align 1
@.str26 = private unnamed_addr constant [3 x i8] c"%i\00", align 1
@.str27 = private unnamed_addr constant [4 x i8] c"%i\0A\00", align 1
@.str28 = private unnamed_addr constant [14 x i8] c"level=4:ref=3\00", align 1
@.str29 = private unnamed_addr constant [31 x i8] c"%255[^:=]=%255[^:]:%255[^=]=%c\00", align 1
@.str30 = private unnamed_addr constant [20 x i8] c"%d, %s, %s, %s, %s\0A\00", align 1
@.str31 = private unnamed_addr constant [8 x i8] c"def|456\00", align 1
@.str32 = private unnamed_addr constant [14 x i8] c"%[a-z]|%[0-9]\00", align 1
@.str33 = private unnamed_addr constant [12 x i8] c"%d, %s, %s\0A\00", align 1
@.str34 = private unnamed_addr constant [8 x i8] c"3-4,-ab\00", align 1
@.str35 = private unnamed_addr constant [17 x i8] c"%[-0-9],%[ab-z-]\00", align 1
@.str36 = private unnamed_addr constant [12 x i8] c"Hello,World\00", align 1
@.str37 = private unnamed_addr constant [18 x i8] c"%[A-Za-z],%[^0-9]\00", align 1
@.str38 = private unnamed_addr constant [10 x i8] c"Hello4711\00", align 1
@.str39 = private unnamed_addr constant [16 x i8] c"%[^0-9],%[^0-9]\00", align 1
@.str40 = private unnamed_addr constant [8 x i8] c"%d, %s\0A\00", align 1
@.str41 = private unnamed_addr constant [11 x i8] c"JavaScript\00", align 1
@.str42 = private unnamed_addr constant [11 x i8] c"%4[A-Za-z]\00", align 1
@.str43 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str44 = private unnamed_addr constant [11 x i8] c"%1[[]%1[]]\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %name = alloca [1000 x i8], align 16
  %prio = alloca i32, align 4
  %name1 = alloca [1000 x i8], align 16
  %prio2 = alloca i32, align 4
  %name3 = alloca [1000 x i8], align 16
  %prio4 = alloca i32, align 4
  %format = alloca [3 x i8], align 1
  %n = alloca float, align 4
  %a = alloca float, align 4
  %buffy = alloca [100 x i8], align 16
  %numverts = alloca i32, align 4
  %index = alloca i32, align 4
  %u = alloca float, align 4
  %v = alloca float, align 4
  %start = alloca i16, align 2
  %count = alloca i16, align 2
  %neg = alloca i32, align 4
  %neg2 = alloca i32, align 4
  %neg3 = alloca i32, align 4
  %a5 = alloca i32, align 4
  %buf1 = alloca [100 x i8], align 16
  %buf2 = alloca [100 x i8], align 16
  %buf3 = alloca [100 x i8], align 16
  %buf4 = alloca [100 x i8], align 16
  %1 = getelementptr inbounds [1000 x i8]* %name, i64 0, i64 0
  call void @llvm.lifetime.start(i64 1000, i8* %1) #1
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 1000, i32 16, i1 false)
  store i32 99, i32* %prio, align 4, !tbaa !1
  %2 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* %1, i32* %prio) #1
  %3 = load i32* %prio, align 4, !tbaa !1
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i64 0, i64 0), i8* %1, i32 %3) #1
  call void @llvm.lifetime.end(i64 1000, i8* %1) #1
  %5 = getelementptr inbounds [1000 x i8]* %name1, i64 0, i64 0
  call void @llvm.lifetime.start(i64 1000, i8* %5) #1
  call void @llvm.memset.p0i8.i64(i8* %5, i8 0, i64 1000, i32 16, i1 false)
  store i32 99, i32* %prio2, align 4, !tbaa !1
  %6 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([5 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* %5, i32* %prio2) #1
  %7 = load i32* %prio2, align 4, !tbaa !1
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i64 0, i64 0), i8* %5, i32 %7) #1
  call void @llvm.lifetime.end(i64 1000, i8* %5) #1
  %9 = getelementptr inbounds [1000 x i8]* %name3, i64 0, i64 0
  call void @llvm.lifetime.start(i64 1000, i8* %9) #1
  call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 1000, i32 16, i1 false)
  store i32 99, i32* %prio4, align 4, !tbaa !1
  %10 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([5 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* %9, i32* %prio4) #1
  %11 = load i32* %prio4, align 4, !tbaa !1
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i64 0, i64 0), i8* %9, i32 %11) #1
  call void @llvm.lifetime.end(i64 1000, i8* %9) #1
  %13 = call double @strtod(i8* nocapture getelementptr inbounds ([9 x i8]* @.str6, i64 0, i64 0), i8** null) #1
  %14 = call double @strtod(i8* nocapture getelementptr inbounds ([6 x i8]* @.str7, i64 0, i64 0), i8** null) #1
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), double %13, double %14) #1
  %16 = getelementptr inbounds [3 x i8]* %format, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %16, i8* getelementptr inbounds ([3 x i8]* @main.format, i64 0, i64 0), i64 3, i32 1, i1 false)
  %17 = getelementptr inbounds [3 x i8]* %format, i64 0, i64 1
  store i8 102, i8* %17, align 1, !tbaa !5
  store float -1.000000e+00, float* %n, align 4, !tbaa !6
  %18 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* %16, float* %n) #1
  %19 = load float* %n, align 4, !tbaa !6
  %20 = fpext float %19 to double
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %20) #1
  store float -1.000000e+00, float* %a, align 4, !tbaa !6
  %22 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([6 x i8]* @.str10, i64 0, i64 0), i8* %16, float* %a) #1
  %23 = load float* %a, align 4, !tbaa !6
  %24 = fpext float %23 to double
  %25 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %24) #1
  store i8 101, i8* %17, align 1, !tbaa !5
  store float -1.000000e+00, float* %n, align 4, !tbaa !6
  %26 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* %16, float* %n) #1
  %27 = load float* %n, align 4, !tbaa !6
  %28 = fpext float %27 to double
  %29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %28) #1
  store float -1.000000e+00, float* %a, align 4, !tbaa !6
  %30 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([6 x i8]* @.str10, i64 0, i64 0), i8* %16, float* %a) #1
  %31 = load float* %a, align 4, !tbaa !6
  %32 = fpext float %31 to double
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %32) #1
  store i8 103, i8* %17, align 1, !tbaa !5
  store float -1.000000e+00, float* %n, align 4, !tbaa !6
  %34 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* %16, float* %n) #1
  %35 = load float* %n, align 4, !tbaa !6
  %36 = fpext float %35 to double
  %37 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %36) #1
  store float -1.000000e+00, float* %a, align 4, !tbaa !6
  %38 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([6 x i8]* @.str10, i64 0, i64 0), i8* %16, float* %a) #1
  %39 = load float* %a, align 4, !tbaa !6
  %40 = fpext float %39 to double
  %41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %40) #1
  store i8 69, i8* %17, align 1, !tbaa !5
  store float -1.000000e+00, float* %n, align 4, !tbaa !6
  %42 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i8* %16, float* %n) #1
  %43 = load float* %n, align 4, !tbaa !6
  %44 = fpext float %43 to double
  %45 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %44) #1
  store float -1.000000e+00, float* %a, align 4, !tbaa !6
  %46 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([6 x i8]* @.str10, i64 0, i64 0), i8* %16, float* %a) #1
  %47 = load float* %a, align 4, !tbaa !6
  %48 = fpext float %47 to double
  %49 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), double %48) #1
  %50 = getelementptr inbounds [100 x i8]* %buffy, i64 0, i64 0
  call void @llvm.lifetime.start(i64 100, i8* %50) #1
  %51 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([36 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str12, i64 0, i64 0), i8* %50) #1
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i8* %50) #1
  %53 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str12, i64 0, i64 0), i8* %50) #1
  %54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i8* %50) #1
  %55 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([30 x i8]* @.str15, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str12, i64 0, i64 0), i8* %50) #1
  %56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str13, i64 0, i64 0), i8* %50) #1
  store i32 -1, i32* %numverts, align 4, !tbaa !1
  %57 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([16 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8]* @.str18, i64 0, i64 0), i32* %numverts) #1
  %58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str16, i64 0, i64 0), i32 %57) #1
  %59 = load i32* %numverts, align 4, !tbaa !1
  %60 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str16, i64 0, i64 0), i32 %59) #1
  %61 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([36 x i8]* @.str19, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8]* @.str20, i64 0, i64 0), i32* %index, float* %u, float* %v, i16* %start, i16* %count) #1
  %62 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str16, i64 0, i64 0), i32 %61) #1
  %63 = load i32* %index, align 4, !tbaa !1
  %64 = load float* %u, align 4, !tbaa !6
  %65 = fpext float %64 to double
  %66 = load float* %v, align 4, !tbaa !6
  %67 = fpext float %66 to double
  %68 = load i16* %start, align 2, !tbaa !8
  %69 = sext i16 %68 to i32
  %70 = load i16* %count, align 2, !tbaa !8
  %71 = sext i16 %70 to i32
  %72 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str21, i64 0, i64 0), i32 %63, double %65, double %67, i32 %69, i32 %71) #1
  store i32 0, i32* %neg3, align 4, !tbaa !1
  %73 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([16 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @.str23, i64 0, i64 0), i32* %neg, i32* %neg2, i32* %neg3) #1
  %74 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str16, i64 0, i64 0), i32 %73) #1
  %75 = load i32* %neg, align 4, !tbaa !1
  %76 = load i32* %neg2, align 4, !tbaa !1
  %77 = load i32* %neg3, align 4, !tbaa !1
  %78 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str24, i64 0, i64 0), i32 %75, i32 %76, i32 %77) #1
  store i32 0, i32* %a5, align 4, !tbaa !1
  %79 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([2 x i8]* @.str25, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str26, i64 0, i64 0), i32* %a5) #1
  %80 = load i32* %a5, align 4, !tbaa !1
  %81 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str27, i64 0, i64 0), i32 %80) #1
  %82 = getelementptr inbounds [100 x i8]* %buf1, i64 0, i64 0
  call void @llvm.lifetime.start(i64 100, i8* %82) #1
  %83 = getelementptr inbounds [100 x i8]* %buf2, i64 0, i64 0
  call void @llvm.lifetime.start(i64 100, i8* %83) #1
  %84 = getelementptr inbounds [100 x i8]* %buf3, i64 0, i64 0
  call void @llvm.lifetime.start(i64 100, i8* %84) #1
  %85 = getelementptr inbounds [100 x i8]* %buf4, i64 0, i64 0
  call void @llvm.lifetime.start(i64 100, i8* %85) #1
  call void @llvm.memset.p0i8.i64(i8* %85, i8 0, i64 100, i32 16, i1 false)
  %86 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([14 x i8]* @.str28, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8]* @.str29, i64 0, i64 0), i8* %82, i8* %83, i8* %84, i8* %85) #1
  %87 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str30, i64 0, i64 0), i32 %86, i8* %82, i8* %83, i8* %84, i8* %85) #1
  %88 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([8 x i8]* @.str31, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str32, i64 0, i64 0), i8* %82, i8* %83) #1
  %89 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str33, i64 0, i64 0), i32 %88, i8* %82, i8* %83) #1
  %90 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([8 x i8]* @.str34, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8]* @.str35, i64 0, i64 0), i8* %82, i8* %83) #1
  %91 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str33, i64 0, i64 0), i32 %90, i8* %82, i8* %83) #1
  %92 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([12 x i8]* @.str36, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str37, i64 0, i64 0), i8* %82, i8* %83) #1
  %93 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str33, i64 0, i64 0), i32 %92, i8* %82, i8* %83) #1
  %94 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([10 x i8]* @.str38, i64 0, i64 0), i8* getelementptr inbounds ([16 x i8]* @.str39, i64 0, i64 0), i8* %82, i8* %83) #1
  %95 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str40, i64 0, i64 0), i32 %94, i8* %82) #1
  %96 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([11 x i8]* @.str41, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8]* @.str42, i64 0, i64 0), i8* %82) #1
  %97 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str40, i64 0, i64 0), i32 %96, i8* %82) #1
  %98 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([3 x i8]* @.str43, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8]* @.str44, i64 0, i64 0), i8* %82, i8* %83) #1
  %99 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str33, i64 0, i64 0), i32 %98, i8* %82, i8* %83) #1
  call void @llvm.lifetime.end(i64 100, i8* %85) #1
  call void @llvm.lifetime.end(i64 100, i8* %84) #1
  call void @llvm.lifetime.end(i64 100, i8* %83) #1
  call void @llvm.lifetime.end(i64 100, i8* %82) #1
  call void @llvm.lifetime.end(i64 100, i8* %50) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare double @strtod(i8* readonly, i8** nocapture) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !3, metadata !3, i64 0}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"float", metadata !3, i64 0}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"short", metadata !3, i64 0}
