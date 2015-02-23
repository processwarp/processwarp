; ModuleID = 'test_atexit.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@str = private unnamed_addr constant [2 x i8] c"B\00"
@str9 = private unnamed_addr constant [3 x i8] c"B2\00"
@str10 = private unnamed_addr constant [2 x i8] c"A\00"
@str11 = private unnamed_addr constant [3 x i8] c"A2\00"
@str12 = private unnamed_addr constant [4 x i8] c"A22\00"
@str13 = private unnamed_addr constant [4 x i8] c"A21\00"
@str14 = private unnamed_addr constant [3 x i8] c"A1\00"
@str15 = private unnamed_addr constant [4 x i8] c"A12\00"
@str16 = private unnamed_addr constant [4 x i8] c"A11\00"

; Function Attrs: noreturn nounwind uwtable
define i32 @main() #0 {
  %1 = tail call i32 @atexit(void ()* @exitA) #4
  %2 = tail call i32 @atexit(void ()* @exitB) #4
  tail call void @exit(i32 2) #5
  unreachable
}

; Function Attrs: nounwind
declare i32 @atexit(void ()*) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: nounwind uwtable
define internal void @exitB() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str, i64 0, i64 0))
  %1 = tail call i32 @atexit(void ()* @exitB1) #4
  %2 = tail call i32 @atexit(void ()* @exitB2) #4
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @exitB2() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str9, i64 0, i64 0))
  ret void
}

; Function Attrs: noreturn nounwind uwtable
define internal void @exitB1() #0 {
  tail call void @exit(i32 1) #5
  unreachable
}

; Function Attrs: nounwind uwtable
define internal void @exitA() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str10, i64 0, i64 0))
  %1 = tail call i32 @atexit(void ()* @exitA1) #4
  %2 = tail call i32 @atexit(void ()* @exitA2) #4
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @exitA2() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str11, i64 0, i64 0))
  %1 = tail call i32 @atexit(void ()* @exitA21) #4
  %2 = tail call i32 @atexit(void ()* @exitA22) #4
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @exitA22() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str12, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @exitA21() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str13, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @exitA1() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str14, i64 0, i64 0))
  %1 = tail call i32 @atexit(void ()* @exitA11) #4
  %2 = tail call i32 @atexit(void ()* @exitA12) #4
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @exitA12() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str15, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @exitA11() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str16, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
