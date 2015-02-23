; ModuleID = 'test_posixtime.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timespec = type { i64, i64 }

@.str = private unnamed_addr constant [44 x i8] c"%sTests for clockid_t=%d\0A-----------------\0A\00", align 1
@.str1 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str4 = private unnamed_addr constant [48 x i8] c"clock_getres resolution not enough (%ld.%09ld)\0A\00", align 1
@.str6 = private unnamed_addr constant [22 x i8] c"clock_gettime failed\0A\00", align 1
@.str7 = private unnamed_addr constant [18 x i8] c"clock_gettime OK\0A\00", align 1
@.str12 = private unnamed_addr constant [43 x i8] c"\0ATests for clockid_t=%d\0A-----------------\0A\00", align 1
@str = private unnamed_addr constant [38 x i8] c"clock_gettime failed with EINVAL (OK)\00"
@str17 = private unnamed_addr constant [37 x i8] c"clock_getres failed with EINVAL (OK)\00"
@str20 = private unnamed_addr constant [32 x i8] c"clock_getres should have failed\00"
@str21 = private unnamed_addr constant [33 x i8] c"clock_gettime should have failed\00"
@str22 = private unnamed_addr constant [27 x i8] c"clock_getres resolution OK\00"
@str23 = private unnamed_addr constant [43 x i8] c"clock_settime failed with wrong error code\00"
@str24 = private unnamed_addr constant [38 x i8] c"clock_settime failed with EINVAL (OK)\00"
@str25 = private unnamed_addr constant [37 x i8] c"clock_settime failed with EPERM (OK)\00"
@str26 = private unnamed_addr constant [33 x i8] c"clock_settime should have failed\00"
@str27 = private unnamed_addr constant [20 x i8] c"clock_getres failed\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %ts = alloca %struct.timespec, align 8
  %ts1 = alloca %struct.timespec, align 8
  %1 = getelementptr inbounds %struct.timespec* %ts, i64 0, i32 0
  %2 = getelementptr inbounds %struct.timespec* %ts, i64 0, i32 1
  %3 = call i32* @__errno_location() #4
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([1 x i8]* @.str1, i64 0, i64 0), i32 0) #3
  %5 = call i32 @clock_getres(i32 0, %struct.timespec* %ts) #3
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %8, label %7

; <label>:7                                       ; preds = %0
  %puts12 = call i32 @puts(i8* getelementptr inbounds ([20 x i8]* @str27, i64 0, i64 0))
  br label %15

; <label>:8                                       ; preds = %0
  %9 = load i64* %1, align 8, !tbaa !1
  %10 = icmp ne i64 %9, 0
  %11 = load i64* %2, align 8, !tbaa !6
  %12 = icmp sgt i64 %11, 50000000
  %or.cond = or i1 %10, %12
  br i1 %or.cond, label %._crit_edge, label %14

._crit_edge:                                      ; preds = %8
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([48 x i8]* @.str4, i64 0, i64 0), i64 %9, i64 %11) #3
  br label %15

; <label>:14                                      ; preds = %8
  %puts7 = call i32 @puts(i8* getelementptr inbounds ([27 x i8]* @str22, i64 0, i64 0))
  br label %15

; <label>:15                                      ; preds = %14, %._crit_edge, %7
  %16 = call i32 @clock_gettime(i32 0, %struct.timespec* %ts) #3
  %17 = icmp ne i32 %16, 0
  %18 = select i1 %17, i8* getelementptr inbounds ([22 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str7, i64 0, i64 0)
  %19 = call i32 (i8*, ...)* @printf(i8* %18) #3
  store i32 0, i32* %3, align 4, !tbaa !7
  %20 = call i32 @clock_settime(i32 0, %struct.timespec* %ts) #3
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %23

; <label>:22                                      ; preds = %15
  %puts11 = call i32 @puts(i8* getelementptr inbounds ([33 x i8]* @str26, i64 0, i64 0))
  br label %28

; <label>:23                                      ; preds = %15
  %24 = load i32* %3, align 4, !tbaa !7
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %27

; <label>:26                                      ; preds = %23
  %puts10 = call i32 @puts(i8* getelementptr inbounds ([37 x i8]* @str25, i64 0, i64 0))
  br label %28

; <label>:27                                      ; preds = %23
  %puts8 = call i32 @puts(i8* getelementptr inbounds ([43 x i8]* @str23, i64 0, i64 0))
  br label %28

; <label>:28                                      ; preds = %27, %26, %22
  %29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str2, i64 0, i64 0), i32 1) #3
  %30 = call i32 @clock_getres(i32 1, %struct.timespec* %ts) #3
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %55, label %54

; <label>:32                                      ; preds = %75
  %33 = load i32* %3, align 4, !tbaa !7
  %34 = icmp eq i32 %33, 22
  br i1 %34, label %36, label %35

; <label>:35                                      ; preds = %75, %32
  %puts6 = call i32 @puts(i8* getelementptr inbounds ([33 x i8]* @str21, i64 0, i64 0))
  br label %37

; <label>:36                                      ; preds = %32
  %puts = call i32 @puts(i8* getelementptr inbounds ([38 x i8]* @str, i64 0, i64 0))
  br label %37

; <label>:37                                      ; preds = %36, %35
  %38 = call i32 @clock_getres(i32 42, %struct.timespec* %ts1) #3
  %39 = icmp eq i32 %38, 0
  br i1 %39, label %43, label %40

; <label>:40                                      ; preds = %37
  %41 = load i32* %3, align 4, !tbaa !7
  %42 = icmp eq i32 %41, 22
  br i1 %42, label %44, label %43

; <label>:43                                      ; preds = %40, %37
  %puts5 = call i32 @puts(i8* getelementptr inbounds ([32 x i8]* @str20, i64 0, i64 0))
  br label %45

; <label>:44                                      ; preds = %40
  %puts2 = call i32 @puts(i8* getelementptr inbounds ([37 x i8]* @str17, i64 0, i64 0))
  br label %45

; <label>:45                                      ; preds = %44, %43
  %46 = call i32 @clock_settime(i32 42, %struct.timespec* %ts1) #3
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %51, label %48

; <label>:48                                      ; preds = %45
  %49 = load i32* %3, align 4, !tbaa !7
  %50 = icmp eq i32 %49, 22
  br i1 %50, label %52, label %51

; <label>:51                                      ; preds = %48, %45
  %puts4 = call i32 @puts(i8* getelementptr inbounds ([33 x i8]* @str26, i64 0, i64 0))
  br label %53

; <label>:52                                      ; preds = %48
  %puts3 = call i32 @puts(i8* getelementptr inbounds ([38 x i8]* @str24, i64 0, i64 0))
  br label %53

; <label>:53                                      ; preds = %52, %51
  ret i32 0

; <label>:54                                      ; preds = %28
  %puts12.1 = call i32 @puts(i8* getelementptr inbounds ([20 x i8]* @str27, i64 0, i64 0))
  br label %62

; <label>:55                                      ; preds = %28
  %56 = load i64* %1, align 8, !tbaa !1
  %57 = icmp ne i64 %56, 0
  %58 = load i64* %2, align 8, !tbaa !6
  %59 = icmp sgt i64 %58, 50000000
  %or.cond17 = or i1 %57, %59
  br i1 %or.cond17, label %._crit_edge15, label %60

; <label>:60                                      ; preds = %55
  %puts7.1 = call i32 @puts(i8* getelementptr inbounds ([27 x i8]* @str22, i64 0, i64 0))
  br label %62

._crit_edge15:                                    ; preds = %55
  %61 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([48 x i8]* @.str4, i64 0, i64 0), i64 %56, i64 %58) #3
  br label %62

; <label>:62                                      ; preds = %._crit_edge15, %60, %54
  %63 = call i32 @clock_gettime(i32 1, %struct.timespec* %ts) #3
  %64 = icmp ne i32 %63, 0
  %65 = select i1 %64, i8* getelementptr inbounds ([22 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str7, i64 0, i64 0)
  %66 = call i32 (i8*, ...)* @printf(i8* %65) #3
  store i32 0, i32* %3, align 4, !tbaa !7
  %67 = call i32 @clock_settime(i32 1, %struct.timespec* %ts) #3
  %68 = icmp eq i32 %67, 0
  br i1 %68, label %74, label %69

; <label>:69                                      ; preds = %62
  %70 = load i32* %3, align 4, !tbaa !7
  %71 = icmp eq i32 %70, 22
  br i1 %71, label %73, label %72

; <label>:72                                      ; preds = %69
  %puts8.1 = call i32 @puts(i8* getelementptr inbounds ([43 x i8]* @str23, i64 0, i64 0))
  br label %75

; <label>:73                                      ; preds = %69
  %puts9.1 = call i32 @puts(i8* getelementptr inbounds ([38 x i8]* @str24, i64 0, i64 0))
  br label %75

; <label>:74                                      ; preds = %62
  %puts11.1 = call i32 @puts(i8* getelementptr inbounds ([33 x i8]* @str26, i64 0, i64 0))
  br label %75

; <label>:75                                      ; preds = %74, %73, %72
  %76 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([43 x i8]* @.str12, i64 0, i64 0), i32 42) #3
  %77 = call i32 @clock_gettime(i32 42, %struct.timespec* %ts1) #3
  %78 = icmp eq i32 %77, 0
  br i1 %78, label %35, label %32
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @clock_getres(i32, %struct.timespec*) #1

; Function Attrs: nounwind
declare i32 @clock_gettime(i32, %struct.timespec*) #1

; Function Attrs: nounwind readnone
declare i32* @__errno_location() #2

; Function Attrs: nounwind
declare i32 @clock_settime(i32, %struct.timespec*) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"timespec", metadata !3, i64 0, metadata !3, i64 8}
!3 = metadata !{metadata !"long", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !2, metadata !3, i64 8}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"int", metadata !4, i64 0}
