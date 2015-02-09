; ModuleID = 'test_assert.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"1 == false\00", align 1
@.str1 = private unnamed_addr constant [20 x i8] c"cpp/test_assert.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1

; Function Attrs: noreturn nounwind uwtable
define i32 @main() #0 {
  tail call void @__assert_fail(i8* getelementptr inbounds ([11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([20 x i8]* @.str1, i64 0, i64 0), i32 5, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #2
  unreachable
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #1

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
