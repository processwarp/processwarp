; ModuleID = 'test_getopt.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [4 x i8] c"nt:\00", align 1
@stderr = external global %struct._IO_FILE*
@.str1 = private unnamed_addr constant [32 x i8] c"Usage: %s [-t nsecs] [-n] name\0A\00", align 1
@.str2 = private unnamed_addr constant [30 x i8] c"flags=%d; tfnd=%d; optind=%d\0A\00", align 1
@optind = external global i32
@.str3 = private unnamed_addr constant [33 x i8] c"Expected argument after options\0A\00", align 1
@.str4 = private unnamed_addr constant [20 x i8] c"name argument = %s\0A\00", align 1

; Function Attrs: noreturn nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  br label %.outer

.outer:                                           ; preds = %1, %0
  %flags.0.ph = phi i32 [ 0, %0 ], [ 1, %1 ]
  %tfnd.0.ph = phi i32 [ 0, %0 ], [ %tfnd.0, %1 ]
  br label %1

; <label>:1                                       ; preds = %1, %.outer
  %tfnd.0 = phi i32 [ %tfnd.0.ph, %.outer ], [ 1, %1 ]
  %2 = tail call i32 @getopt(i32 %argc, i8** %argv, i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0)) #3
  switch i32 %2, label %3 [
    i32 -1, label %7
    i32 110, label %.outer
    i32 116, label %1
  ]

; <label>:3                                       ; preds = %1
  %4 = load %struct._IO_FILE** @stderr, align 8, !tbaa !1
  %5 = load i8** %argv, align 8, !tbaa !1
  %6 = tail call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([32 x i8]* @.str1, i64 0, i64 0), i8* %5) #4
  tail call void @exit(i32 1) #5
  unreachable

; <label>:7                                       ; preds = %1
  %8 = load i32* @optind, align 4, !tbaa !5
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str2, i64 0, i64 0), i32 %flags.0.ph, i32 %tfnd.0, i32 %8) #3
  %10 = load i32* @optind, align 4, !tbaa !5
  %11 = icmp slt i32 %10, %argc
  br i1 %11, label %15, label %12

; <label>:12                                      ; preds = %7
  %13 = load %struct._IO_FILE** @stderr, align 8, !tbaa !1
  %14 = tail call i64 @fwrite(i8* getelementptr inbounds ([33 x i8]* @.str3, i64 0, i64 0), i64 32, i64 1, %struct._IO_FILE* %13) #6
  tail call void @exit(i32 1) #5
  unreachable

; <label>:15                                      ; preds = %7
  %16 = sext i32 %10 to i64
  %17 = getelementptr inbounds i8** %argv, i64 %16
  %18 = load i8** %17, align 8, !tbaa !1
  %19 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str4, i64 0, i64 0), i8* %18) #3
  tail call void @exit(i32 0) #5
  unreachable
}

; Function Attrs: nounwind
declare i32 @getopt(i32, i8**, i8*) #1

; Function Attrs: nounwind
declare i32 @fprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i64 @fwrite(i8* nocapture, i64, i64, %struct._IO_FILE* nocapture) #3

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { cold nounwind }
attributes #5 = { noreturn nounwind }
attributes #6 = { cold }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"int", metadata !3, i64 0}
