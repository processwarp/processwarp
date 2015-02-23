; ModuleID = 'test_alloca.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"argc == 1\00", align 1
@.str1 = private unnamed_addr constant [14 x i8] c"test_alloca.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@.str2 = private unnamed_addr constant [19 x i8] c"((int)pc) % 4 == 0\00", align 1
@.str3 = private unnamed_addr constant [20 x i8] c"((int)pc2) % 4 == 0\00", align 1
@.str4 = private unnamed_addr constant [13 x i8] c"z:%d*%d*%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = icmp eq i32 %argc, 1
  br i1 %1, label %3, label %2

; <label>:2                                       ; preds = %0
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str1, i64 0, i64 0), i32 7, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #3
  unreachable

; <label>:3                                       ; preds = %0
  %4 = alloca [5 x i8], align 1
  %5 = ptrtoint [5 x i8]* %4 to i64
  %6 = trunc i64 %5 to i32
  %7 = and i32 %6, 3
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %10, label %9

; <label>:9                                       ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([19 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str1, i64 0, i64 0), i32 9, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #3
  unreachable

; <label>:10                                      ; preds = %3
  %11 = alloca [5 x i8], align 1
  %12 = ptrtoint [5 x i8]* %11 to i64
  %13 = trunc i64 %12 to i32
  %14 = and i32 %13, 3
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %17, label %16

; <label>:16                                      ; preds = %10
  call void @__assert_fail(i8* getelementptr inbounds ([20 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str1, i64 0, i64 0), i32 11, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #3
  unreachable

; <label>:17                                      ; preds = %10
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str4, i64 0, i64 0), i32 1, i32 %6, i32 %13) #4
  ret i32 0
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
