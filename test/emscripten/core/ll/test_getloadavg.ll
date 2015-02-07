; ModuleID = 'test_getloadavg.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"ret: %d\0A\00", align 1
@.str1 = private unnamed_addr constant [16 x i8] c"load[0]: %.3lf\0A\00", align 1
@.str2 = private unnamed_addr constant [16 x i8] c"load[1]: %.3lf\0A\00", align 1
@.str3 = private unnamed_addr constant [16 x i8] c"load[2]: %.3lf\0A\00", align 1
@.str4 = private unnamed_addr constant [16 x i8] c"load[3]: %.3lf\0A\00", align 1
@.str5 = private unnamed_addr constant [16 x i8] c"load[4]: %.3lf\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %load = alloca [5 x double], align 16
  %1 = bitcast [5 x double]* %load to i8*
  call void @llvm.lifetime.start(i64 40, i8* %1) #1
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 32, i32 16, i1 false)
  %2 = getelementptr [5 x double]* %load, i64 0, i64 0
  store double 4.213000e+01, double* %2, align 16
  %3 = getelementptr [5 x double]* %load, i64 0, i64 1
  store double 4.213000e+01, double* %3, align 8
  %4 = getelementptr [5 x double]* %load, i64 0, i64 2
  store double 4.213000e+01, double* %4, align 16
  %5 = getelementptr [5 x double]* %load, i64 0, i64 3
  store double 4.213000e+01, double* %5, align 8
  %6 = getelementptr [5 x double]* %load, i64 0, i64 4
  store double 4.213000e+01, double* %6, align 16
  %7 = call i32 @getloadavg(double* %2, i32 5) #1
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %7)
  %9 = load double* %2, align 16, !tbaa !1
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str1, i64 0, i64 0), double %9)
  %11 = load double* %3, align 8, !tbaa !1
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str2, i64 0, i64 0), double %11)
  %13 = load double* %4, align 16, !tbaa !1
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str3, i64 0, i64 0), double %13)
  %15 = load double* %5, align 8, !tbaa !1
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str4, i64 0, i64 0), double %15)
  %17 = load double* %6, align 16, !tbaa !1
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str5, i64 0, i64 0), double %17)
  call void @llvm.lifetime.end(i64 40, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @getloadavg(double*, i32) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"double", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
