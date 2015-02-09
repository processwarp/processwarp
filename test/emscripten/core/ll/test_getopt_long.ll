; ModuleID = 'test_getopt_long.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.option = type { i8*, i32, i32*, i32 }

@optind = external global i32
@_ZZ4mainE12long_options = internal global <{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }> <{ { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 1, i32* null, i32 0, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str1, i32 0, i32 0), i32 0, i32* null, i32 0, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str2, i32 0, i32 0), i32 1, i32* null, i32 0, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([8 x i8]* @.str3, i32 0, i32 0), i32 0, i32* null, i32 0, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str4, i32 0, i32 0), i32 1, i32* null, i32 99, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([5 x i8]* @.str5, i32 0, i32 0), i32 1, i32* null, i32 0, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* null, i32 0, i32* null, i32 0, [4 x i8] undef } }>, align 16
@.str = private unnamed_addr constant [4 x i8] c"add\00", align 1
@.str1 = private unnamed_addr constant [7 x i8] c"append\00", align 1
@.str2 = private unnamed_addr constant [7 x i8] c"delete\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"verbose\00", align 1
@.str4 = private unnamed_addr constant [7 x i8] c"create\00", align 1
@.str5 = private unnamed_addr constant [5 x i8] c"file\00", align 1
@.str6 = private unnamed_addr constant [10 x i8] c"abc:d:012\00", align 1
@.str7 = private unnamed_addr constant [10 x i8] c"option %s\00", align 1
@optarg = external global i8*
@.str8 = private unnamed_addr constant [13 x i8] c" with arg %s\00", align 1
@.str11 = private unnamed_addr constant [11 x i8] c"option %c\0A\00", align 1
@.str14 = private unnamed_addr constant [26 x i8] c"option c with value '%s'\0A\00", align 1
@.str15 = private unnamed_addr constant [26 x i8] c"option d with value '%s'\0A\00", align 1
@.str16 = private unnamed_addr constant [42 x i8] c"?? getopt returned character code 0%o ??\0A\00", align 1
@.str17 = private unnamed_addr constant [27 x i8] c"non-option ARGV-elements: \00", align 1
@.str18 = private unnamed_addr constant [4 x i8] c"%s \00", align 1
@str = private unnamed_addr constant [9 x i8] c"option b\00"
@str19 = private unnamed_addr constant [9 x i8] c"option a\00"
@str20 = private unnamed_addr constant [45 x i8] c"digits occur in two different argv-elements.\00"

; Function Attrs: noreturn nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %option_index = alloca i32, align 4
  br label %.backedge

.backedge:                                        ; preds = %30, %27, %24, %23, %22, %20, %15, %.backedge, %0
  %digit_optind.0 = phi i32 [ 0, %0 ], [ %digit_optind.0, %30 ], [ %digit_optind.0, %27 ], [ %digit_optind.0, %24 ], [ %digit_optind.0, %23 ], [ %digit_optind.0, %22 ], [ %3, %20 ], [ %digit_optind.0, %15 ], [ %digit_optind.0, %.backedge ]
  %1 = load i32* @optind, align 4, !tbaa !1
  %2 = icmp ne i32 %1, 0
  %3 = select i1 %2, i32 %1, i32 1
  store i32 0, i32* %option_index, align 4, !tbaa !1
  %4 = call i32 @getopt_long(i32 %argc, i8** %argv, i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), %struct.option* bitcast (<{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }>* @_ZZ4mainE12long_options to %struct.option*), i32* %option_index) #3
  switch i32 %4, label %30 [
    i32 -1, label %32
    i32 0, label %5
    i32 48, label %16
    i32 49, label %16
    i32 50, label %16
    i32 97, label %22
    i32 98, label %23
    i32 99, label %24
    i32 100, label %27
    i32 63, label %.backedge
  ]

; <label>:5                                       ; preds = %.backedge
  %6 = load i32* %option_index, align 4, !tbaa !1
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [7 x %struct.option]* bitcast (<{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }>* @_ZZ4mainE12long_options to [7 x %struct.option]*), i64 0, i64 %7, i32 0
  %9 = load i8** %8, align 16, !tbaa !5
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str7, i64 0, i64 0), i8* %9) #3
  %11 = load i8** @optarg, align 8, !tbaa !8
  %12 = icmp eq i8* %11, null
  br i1 %12, label %15, label %13

; <label>:13                                      ; preds = %5
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str8, i64 0, i64 0), i8* %11) #3
  br label %15

; <label>:15                                      ; preds = %13, %5
  %putchar = call i32 @putchar(i32 10) #3
  br label %.backedge

; <label>:16                                      ; preds = %.backedge, %.backedge, %.backedge
  %17 = icmp eq i32 %digit_optind.0, 0
  %18 = icmp eq i32 %digit_optind.0, %3
  %or.cond = or i1 %17, %18
  br i1 %or.cond, label %20, label %19

; <label>:19                                      ; preds = %16
  %puts2 = call i32 @puts(i8* getelementptr inbounds ([45 x i8]* @str20, i64 0, i64 0))
  br label %20

; <label>:20                                      ; preds = %19, %16
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str11, i64 0, i64 0), i32 %4) #3
  br label %.backedge

; <label>:22                                      ; preds = %.backedge
  %puts1 = call i32 @puts(i8* getelementptr inbounds ([9 x i8]* @str19, i64 0, i64 0))
  br label %.backedge

; <label>:23                                      ; preds = %.backedge
  %puts = call i32 @puts(i8* getelementptr inbounds ([9 x i8]* @str, i64 0, i64 0))
  br label %.backedge

; <label>:24                                      ; preds = %.backedge
  %25 = load i8** @optarg, align 8, !tbaa !8
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str14, i64 0, i64 0), i8* %25) #3
  br label %.backedge

; <label>:27                                      ; preds = %.backedge
  %28 = load i8** @optarg, align 8, !tbaa !8
  %29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str15, i64 0, i64 0), i8* %28) #3
  br label %.backedge

; <label>:30                                      ; preds = %.backedge
  %31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str16, i64 0, i64 0), i32 %4) #3
  br label %.backedge

; <label>:32                                      ; preds = %.backedge
  %33 = load i32* @optind, align 4, !tbaa !1
  %34 = icmp slt i32 %33, %argc
  br i1 %34, label %35, label %47

; <label>:35                                      ; preds = %32
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str17, i64 0, i64 0)) #3
  %37 = load i32* @optind, align 4, !tbaa !1
  %38 = icmp slt i32 %37, %argc
  br i1 %38, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %35
  %39 = phi i32 [ %45, %.lr.ph ], [ %37, %35 ]
  %40 = add nsw i32 %39, 1
  store i32 %40, i32* @optind, align 4, !tbaa !1
  %41 = sext i32 %39 to i64
  %42 = getelementptr inbounds i8** %argv, i64 %41
  %43 = load i8** %42, align 8, !tbaa !8
  %44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str18, i64 0, i64 0), i8* %43) #3
  %45 = load i32* @optind, align 4, !tbaa !1
  %46 = icmp slt i32 %45, %argc
  br i1 %46, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %35
  %putchar3 = call i32 @putchar(i32 10) #3
  br label %47

; <label>:47                                      ; preds = %._crit_edge, %32
  call void @exit(i32 0) #4
  unreachable
}

; Function Attrs: nounwind
declare i32 @getopt_long(i32, i8**, i8*, %struct.option*, i32*) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

; Function Attrs: nounwind
declare i32 @putchar(i32) #3

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !7, i64 0}
!6 = metadata !{metadata !"_ZTS6option", metadata !7, i64 0, metadata !2, i64 8, metadata !7, i64 16, metadata !2, i64 24}
!7 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!8 = metadata !{metadata !7, metadata !7, i64 0}
