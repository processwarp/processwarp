; ModuleID = 'test_vprintf.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [33 x i8] c"Call with %d variable argument.\0A\00", align 1
@.str1 = private unnamed_addr constant [27 x i8] c"Call with %d variable %s.\0A\00", align 1
@.str2 = private unnamed_addr constant [10 x i8] c"arguments\00", align 1
@stdout = external global %struct._IO_FILE*

; Function Attrs: nounwind uwtable
define void @print(i8* nocapture readonly %format, ...) #0 {
  %args = alloca [1 x %struct.__va_list_tag], align 16
  %1 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i64 0, i64 0
  %2 = bitcast [1 x %struct.__va_list_tag]* %args to i8*
  call void @llvm.va_start(i8* %2)
  %3 = load %struct._IO_FILE** @stdout, align 8, !tbaa !1
  %4 = call i32 @vfprintf(%struct._IO_FILE* %3, i8* %format, %struct.__va_list_tag* %1) #1
  call void @llvm.va_end(i8* %2)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  tail call void (i8*, ...)* @print(i8* getelementptr inbounds ([33 x i8]* @.str, i64 0, i64 0), i32 1)
  tail call void (i8*, ...)* @print(i8* getelementptr inbounds ([27 x i8]* @.str1, i64 0, i64 0), i32 2, i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @vfprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, %struct.__va_list_tag*) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
