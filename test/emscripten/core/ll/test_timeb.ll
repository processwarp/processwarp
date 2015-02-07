; ModuleID = 'test_timeb.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timeb = type { i64, i16, i16, i16 }

@.str = private unnamed_addr constant [5 x i8] c"*%d\0A\00", align 1
@.str1 = private unnamed_addr constant [16 x i8] c"tb.time > 10000\00", align 1
@.str2 = private unnamed_addr constant [19 x i8] c"tmp/test_timeb.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str3 = private unnamed_addr constant [17 x i8] c"tb.timezone == 0\00", align 1
@.str4 = private unnamed_addr constant [16 x i8] c"tb.dstflag == 0\00", align 1

; Function Attrs: uwtable
define i32 @main() #0 {
  %tb = alloca %struct.timeb, align 8
  %1 = getelementptr inbounds %struct.timeb* %tb, i64 0, i32 2
  store i16 1, i16* %1, align 2, !tbaa !1
  %2 = call i32 @ftime(%struct.timeb* %tb)
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i32 %2)
  %4 = getelementptr inbounds %struct.timeb* %tb, i64 0, i32 0
  %5 = load i64* %4, align 8, !tbaa !7
  %6 = icmp sgt i64 %5, 10000
  br i1 %6, label %8, label %7

; <label>:7                                       ; preds = %0
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str2, i64 0, i64 0), i32 9, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:8                                       ; preds = %0
  %9 = load i16* %1, align 2, !tbaa !1
  %10 = icmp eq i16 %9, 0
  br i1 %10, label %12, label %11

; <label>:11                                      ; preds = %8
  call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str2, i64 0, i64 0), i32 10, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:12                                      ; preds = %8
  %13 = getelementptr inbounds %struct.timeb* %tb, i64 0, i32 3
  %14 = load i16* %13, align 4, !tbaa !8
  %15 = icmp eq i16 %14, 0
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %12
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @.str2, i64 0, i64 0), i32 11, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:17                                      ; preds = %12
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare i32 @ftime(%struct.timeb*) #2

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #3

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !6, i64 10}
!2 = metadata !{metadata !"_ZTS5timeb", metadata !3, i64 0, metadata !6, i64 8, metadata !6, i64 10, metadata !6, i64 12}
!3 = metadata !{metadata !"long", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"short", metadata !4, i64 0}
!7 = metadata !{metadata !2, metadata !3, i64 0}
!8 = metadata !{metadata !2, metadata !6, i64 12}
