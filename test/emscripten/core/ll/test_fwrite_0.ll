; ModuleID = 'test_fwrite_0.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [6 x i8] c"a.txt\00", align 1
@.str1 = private unnamed_addr constant [3 x i8] c"wb\00", align 1
@.str2 = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@main.data = private unnamed_addr constant [7 x i8] c"foobar\00", align 1
@.str3 = private unnamed_addr constant [13 x i8] c"written=%zu\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %data = alloca [7 x i8], align 1
  %1 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str1, i64 0, i64 0)) #3
  %2 = icmp eq %struct._IO_FILE* %1, null
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  tail call void @exit(i32 1) #4
  unreachable

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @fclose(%struct._IO_FILE* %1) #3
  %6 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @.str2, i64 0, i64 0)) #3
  %7 = icmp eq %struct._IO_FILE* %6, null
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %4
  tail call void @exit(i32 1) #4
  unreachable

; <label>:9                                       ; preds = %4
  %10 = getelementptr inbounds [7 x i8]* %data, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %10, i8* getelementptr inbounds ([7 x i8]* @main.data, i64 0, i64 0), i64 7, i32 1, i1 false)
  %11 = call i64 @fwrite(i8* %10, i64 1, i64 7, %struct._IO_FILE* %6) #3
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str3, i64 0, i64 0), i64 %11) #3
  ret i32 0
}

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind
declare i64 @fwrite(i8* nocapture, i64, i64, %struct._IO_FILE* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
