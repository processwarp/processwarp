; ModuleID = 'test_regex.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.re_pattern_buffer = type { i8*, i64, i64, i64, i8*, i8*, i64, i8 }
%struct.regmatch_t = type { i32, i32 }

@.str = private unnamed_addr constant [35 x i8] c"a very simple simple simple string\00", align 1
@.str1 = private unnamed_addr constant [18 x i8] c"\5C(sim[a-z]le\5C) \5C1\00", align 1
@.str2 = private unnamed_addr constant [42 x i8] c"regcomp() failed, returning nonzero (%d)\0A\00", align 1
@.str3 = private unnamed_addr constant [46 x i8] c"Failed to match '%s' with '%s',returning %d.\0A\00", align 1
@.str4 = private unnamed_addr constant [86 x i8] c"With the whole expression, a matched substring \22%.*s\22 is found at position %d to %d.\0A\00", align 1
@.str5 = private unnamed_addr constant [84 x i8] c"With the sub-expression, a matched substring \22%.*s\22 is found at position %d to %d.\0A\00", align 1

; Function Attrs: uwtable
define i32 @main() #0 {
  %preg = alloca %struct.re_pattern_buffer, align 8
  %pmatch = alloca [2 x %struct.regmatch_t], align 16
  %1 = bitcast %struct.re_pattern_buffer* %preg to i8*
  call void @llvm.lifetime.start(i64 64, i8* %1) #1
  %2 = call i32 @regcomp(%struct.re_pattern_buffer* %preg, i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), i32 0)
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %6, label %4

; <label>:4                                       ; preds = %0
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str2, i64 0, i64 0), i32 %2)
  call void @exit(i32 1) #5
  unreachable

; <label>:6                                       ; preds = %0
  %7 = getelementptr inbounds [2 x %struct.regmatch_t]* %pmatch, i64 0, i64 0
  %8 = call i32 @regexec(%struct.re_pattern_buffer* %preg, i8* getelementptr inbounds ([35 x i8]* @.str, i64 0, i64 0), i64 2, %struct.regmatch_t* %7, i32 0)
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %12, label %10

; <label>:10                                      ; preds = %6
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([46 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), i32 %8)
  br label %31

; <label>:12                                      ; preds = %6
  %13 = getelementptr inbounds [2 x %struct.regmatch_t]* %pmatch, i64 0, i64 0, i32 1
  %14 = load i32* %13, align 4, !tbaa !1
  %15 = getelementptr inbounds [2 x %struct.regmatch_t]* %pmatch, i64 0, i64 0, i32 0
  %16 = load i32* %15, align 16, !tbaa !6
  %17 = sub nsw i32 %14, %16
  %18 = sext i32 %16 to i64
  %19 = getelementptr inbounds [35 x i8]* @.str, i64 0, i64 %18
  %20 = add nsw i32 %14, -1
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([86 x i8]* @.str4, i64 0, i64 0), i32 %17, i8* %19, i32 %16, i32 %20)
  %22 = getelementptr inbounds [2 x %struct.regmatch_t]* %pmatch, i64 0, i64 1, i32 1
  %23 = load i32* %22, align 4, !tbaa !1
  %24 = getelementptr inbounds [2 x %struct.regmatch_t]* %pmatch, i64 0, i64 1, i32 0
  %25 = load i32* %24, align 8, !tbaa !6
  %26 = sub nsw i32 %23, %25
  %27 = sext i32 %25 to i64
  %28 = getelementptr inbounds [35 x i8]* @.str, i64 0, i64 %27
  %29 = add nsw i32 %23, -1
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([84 x i8]* @.str5, i64 0, i64 0), i32 %26, i8* %28, i32 %25, i32 %29)
  br label %31

; <label>:31                                      ; preds = %12, %10
  call void @regfree(%struct.re_pattern_buffer* %preg)
  call void @llvm.lifetime.end(i64 64, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare i32 @regcomp(%struct.re_pattern_buffer*, i8*, i32) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32) #4

declare i32 @regexec(%struct.re_pattern_buffer*, i8*, i64, %struct.regmatch_t*, i32) #2

declare void @regfree(%struct.re_pattern_buffer*) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 4}
!2 = metadata !{metadata !"_ZTS10regmatch_t", metadata !3, i64 0, metadata !3, i64 4}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !2, metadata !3, i64 0}
