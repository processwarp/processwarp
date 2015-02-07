; ModuleID = 'test_gmtime.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i8* }

@.str = private unnamed_addr constant [20 x i8] c"yday: %d, hour: %d\0A\00", align 1
@.str1 = private unnamed_addr constant [21 x i8] c"yday == ptm->tm_yday\00", align 1
@.str2 = private unnamed_addr constant [20 x i8] c"tmp/test_gmtime.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@str = private unnamed_addr constant [4 x i8] c"ok!\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %t = alloca i64, align 8
  %1 = call i64 @time(i64* null) #3
  store i64 %1, i64* %t, align 8, !tbaa !1
  %2 = call %struct.tm* @gmtime(i64* %t) #3
  %3 = getelementptr inbounds %struct.tm* %2, i64 0, i32 2
  %4 = load i32* %3, align 8
  %5 = mul nsw i32 %4, 3600
  %6 = sext i32 %5 to i64
  %7 = load i64* %t, align 8, !tbaa !1
  %8 = sub nsw i64 %7, %6
  store i64 %8, i64* %t, align 8, !tbaa !1
  br label %9

; <label>:9                                       ; preds = %19, %0
  %yday.02 = phi i32 [ -1, %0 ], [ %yday.1, %19 ]
  %hour.01 = phi i32 [ 0, %0 ], [ %22, %19 ]
  %10 = call %struct.tm* @gmtime(i64* %t) #3
  %11 = getelementptr inbounds %struct.tm* %10, i64 0, i32 7
  %12 = load i32* %11, align 4, !tbaa !5
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str, i64 0, i64 0), i32 %12, i32 %hour.01)
  %14 = icmp eq i32 %yday.02, -1
  %15 = load i32* %11, align 4, !tbaa !5
  br i1 %14, label %19, label %16

; <label>:16                                      ; preds = %9
  %17 = icmp eq i32 %yday.02, %15
  br i1 %17, label %19, label %18

; <label>:18                                      ; preds = %16
  call void @__assert_fail(i8* getelementptr inbounds ([21 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([20 x i8]* @.str2, i64 0, i64 0), i32 21, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:19                                      ; preds = %16, %9
  %yday.1 = phi i32 [ %yday.02, %16 ], [ %15, %9 ]
  %20 = load i64* %t, align 8, !tbaa !1
  %21 = add nsw i64 %20, 3600
  store i64 %21, i64* %t, align 8, !tbaa !1
  %22 = add nsw i32 %hour.01, 1
  %23 = icmp slt i32 %22, 24
  br i1 %23, label %9, label %24

; <label>:24                                      ; preds = %19
  %puts = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @time(i64*) #1

; Function Attrs: nounwind
declare %struct.tm* @gmtime(i64*) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"long", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !7, i64 28}
!6 = metadata !{metadata !"_ZTS2tm", metadata !7, i64 0, metadata !7, i64 4, metadata !7, i64 8, metadata !7, i64 12, metadata !7, i64 16, metadata !7, i64 20, metadata !7, i64 24, metadata !7, i64 28, metadata !7, i64 32, metadata !2, i64 40, metadata !8, i64 48}
!7 = metadata !{metadata !"int", metadata !3, i64 0}
!8 = metadata !{metadata !"any pointer", metadata !3, i64 0}
