; ModuleID = 'test_strptime_reentrant.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i8* }

@.str = private unnamed_addr constant [5 x i8] c"2007\00", align 1
@.str1 = private unnamed_addr constant [3 x i8] c"%Y\00", align 1
@.str2 = private unnamed_addr constant [3 x i8] c"12\00", align 1
@.str3 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str4 = private unnamed_addr constant [4 x i8] c"Feb\00", align 1
@.str5 = private unnamed_addr constant [3 x i8] c"%b\00", align 1
@.str6 = private unnamed_addr constant [3 x i8] c"13\00", align 1
@.str7 = private unnamed_addr constant [3 x i8] c"%M\00", align 1
@.str8 = private unnamed_addr constant [3 x i8] c"21\00", align 1
@.str9 = private unnamed_addr constant [3 x i8] c"%S\00", align 1
@.str10 = private unnamed_addr constant [3 x i8] c"16\00", align 1
@.str11 = private unnamed_addr constant [3 x i8] c"%H\00", align 1
@.str12 = private unnamed_addr constant [19 x i8] c"ERR: returned NULL\00", align 1
@.str13 = private unnamed_addr constant [51 x i8] c"ERR: unexpected tm content (1) - %d/%d/%d %d:%d:%d\00", align 1
@.str14 = private unnamed_addr constant [2 x i8] c"8\00", align 1
@.str15 = private unnamed_addr constant [21 x i8] c"ERR: strptime failed\00", align 1
@.str16 = private unnamed_addr constant [51 x i8] c"ERR: unexpected tm content (2) - %d/%d/%d %d:%d:%d\00", align 1
@.str17 = private unnamed_addr constant [3 x i8] c"OK\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %tm = alloca %struct.tm, align 8
  %1 = bitcast %struct.tm* %tm to i8*
  call void @llvm.lifetime.start(i64 56, i8* %1) #1
  call void @llvm.memset.p0i8.i64(i8* %1, i8 -86, i64 56, i32 8, i1 false)
  %2 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str1, i64 0, i64 0), %struct.tm* %tm) #1
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %19, label %4

; <label>:4                                       ; preds = %0
  %5 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), %struct.tm* %tm) #1
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %19, label %7

; <label>:7                                       ; preds = %4
  %8 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* getelementptr inbounds ([4 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str5, i64 0, i64 0), %struct.tm* %tm) #1
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %19, label %10

; <label>:10                                      ; preds = %7
  %11 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str7, i64 0, i64 0), %struct.tm* %tm) #1
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %19, label %13

; <label>:13                                      ; preds = %10
  %14 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str9, i64 0, i64 0), %struct.tm* %tm) #1
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %19, label %16

; <label>:16                                      ; preds = %13
  %17 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str11, i64 0, i64 0), %struct.tm* %tm) #1
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %16, %13, %10, %7, %4, %0
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str12, i64 0, i64 0)) #1
  call void @exit(i32 1) #5
  unreachable

; <label>:21                                      ; preds = %16
  %22 = bitcast %struct.tm* %tm to i64*
  %23 = load i64* %22, align 8
  %24 = trunc i64 %23 to i32
  %25 = icmp eq i32 %24, 21
  %26 = lshr i64 %23, 32
  %27 = trunc i64 %26 to i32
  %28 = icmp eq i32 %27, 13
  %or.cond17 = and i1 %25, %28
  br i1 %or.cond17, label %29, label %._crit_edge

; <label>:29                                      ; preds = %21
  %30 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 2
  %31 = bitcast i32* %30 to i64*
  %32 = load i64* %31, align 8
  %33 = icmp eq i64 %32, 51539607568
  br i1 %33, label %34, label %._crit_edge

; <label>:34                                      ; preds = %29
  %35 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 4
  %36 = bitcast i32* %35 to i64*
  %37 = load i64* %36, align 8
  %38 = icmp eq i64 %37, 459561500673
  br i1 %38, label %39, label %._crit_edge

; <label>:39                                      ; preds = %34
  %40 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 6
  %41 = bitcast i32* %40 to i64*
  %42 = load i64* %41, align 8
  %43 = icmp eq i64 %42, 180388626433
  br i1 %43, label %57, label %._crit_edge

._crit_edge:                                      ; preds = %39, %34, %29, %21
  %44 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 4
  %45 = bitcast i32* %44 to i64*
  %46 = load i64* %45, align 8
  %47 = trunc i64 %46 to i32
  %48 = add nsw i32 %47, 1
  %49 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 3
  %50 = load i32* %49, align 4, !tbaa !1
  %51 = lshr i64 %46, 32
  %52 = trunc i64 %51 to i32
  %53 = add nsw i32 %52, 1900
  %54 = getelementptr inbounds %struct.tm* %tm, i64 0, i32 2
  %55 = load i32* %54, align 8, !tbaa !8
  %56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([51 x i8]* @.str13, i64 0, i64 0), i32 %48, i32 %50, i32 %53, i32 %55, i32 %27, i32 %24) #1
  call void @exit(i32 1) #5
  unreachable

; <label>:57                                      ; preds = %39
  %58 = call i32 (i8*, i8*, %struct.tm*, ...)* bitcast (i32 (...)* @strptime to i32 (i8*, i8*, %struct.tm*, ...)*)(i8* getelementptr inbounds ([2 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), %struct.tm* %tm) #1
  %59 = icmp eq i32 %58, 0
  br i1 %59, label %60, label %62

; <label>:60                                      ; preds = %57
  %61 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str15, i64 0, i64 0)) #1
  call void @exit(i32 1) #5
  unreachable

; <label>:62                                      ; preds = %57
  %63 = load i64* %22, align 8
  %64 = trunc i64 %63 to i32
  %65 = icmp eq i32 %64, 21
  %66 = lshr i64 %63, 32
  %67 = trunc i64 %66 to i32
  %68 = icmp eq i32 %67, 13
  %or.cond = and i1 %65, %68
  %69 = load i64* %31, align 8
  %70 = trunc i64 %69 to i32
  %71 = icmp eq i32 %70, 16
  %or.cond3 = and i1 %or.cond, %71
  %72 = lshr i64 %69, 32
  %73 = trunc i64 %72 to i32
  %74 = icmp eq i32 %73, 8
  %or.cond5 = and i1 %or.cond3, %74
  %75 = load i64* %36, align 8
  %76 = trunc i64 %75 to i32
  %77 = icmp eq i32 %76, 1
  %or.cond7 = and i1 %or.cond5, %77
  %78 = lshr i64 %75, 32
  %79 = trunc i64 %78 to i32
  %80 = icmp eq i32 %79, 107
  %or.cond9 = and i1 %or.cond7, %80
  %81 = load i64* %41, align 8
  %82 = trunc i64 %81 to i32
  %83 = icmp eq i32 %82, 4
  %or.cond11 = and i1 %or.cond9, %83
  %.mask16 = and i64 %81, -4294967296
  %84 = icmp eq i64 %.mask16, 163208757248
  %or.cond13 = and i1 %or.cond11, %84
  br i1 %or.cond13, label %89, label %85

; <label>:85                                      ; preds = %62
  %86 = add nsw i32 %76, 1
  %87 = add nsw i32 %79, 1900
  %88 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([51 x i8]* @.str16, i64 0, i64 0), i32 %86, i32 %73, i32 %87, i32 %70, i32 %67, i32 %64) #1
  call void @exit(i32 1) #5
  unreachable

; <label>:89                                      ; preds = %62
  %90 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str17, i64 0, i64 0)) #1
  call void @llvm.lifetime.end(i64 56, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

declare i32 @strptime(...) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 12}
!2 = metadata !{metadata !"tm", metadata !3, i64 0, metadata !3, i64 4, metadata !3, i64 8, metadata !3, i64 12, metadata !3, i64 16, metadata !3, i64 20, metadata !3, i64 24, metadata !3, i64 28, metadata !3, i64 32, metadata !6, i64 40, metadata !7, i64 48}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"long", metadata !4, i64 0}
!7 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!8 = metadata !{metadata !2, metadata !3, i64 8}
