; ModuleID = 'test_i64_cmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"*%d,%d,%d,%d,%d,%d*\0A\00", align 1

; Function Attrs: nounwind readnone uwtable
define zeroext i1 @_Z7comparex(i64 %val) #0 {
  %1 = icmp eq i64 %val, -12
  ret i1 %1
}

; Function Attrs: nounwind readnone uwtable
define zeroext i1 @_Z8compare2x(i64 %val) #0 {
  %1 = icmp slt i64 %val, -12
  ret i1 %1
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #1 {
  %1 = icmp eq i32 %argc, 1
  %2 = zext i1 %1 to i32
  %3 = add nsw i32 %argc, 1000
  %4 = icmp eq i32 %3, -12
  %5 = zext i1 %4 to i32
  %6 = add nsw i32 %argc, -11
  %7 = icmp slt i32 %6, -12
  %8 = zext i1 %7 to i32
  %9 = add nsw i32 %argc, -15
  %10 = icmp slt i32 %9, -12
  %11 = zext i1 %10 to i32
  %12 = icmp slt i32 %3, -12
  %13 = zext i1 %12 to i32
  %14 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), i32 %argc, i32 %2, i32 %5, i32 %8, i32 %11, i32 %13) #3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
