; ModuleID = 'test_compare.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str1 = private unnamed_addr constant [19 x i8] c"%d %d %d %d %d %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %argc) #2
  %2 = add nsw i32 %argc, -2
  %sext = shl i32 %2, 24
  %3 = and i32 %2, 255
  %4 = icmp eq i32 %3, 255
  %5 = zext i1 %4 to i32
  %6 = icmp slt i32 %sext, 251658240
  %7 = zext i1 %6 to i32
  %8 = icmp sgt i32 %sext, 251658240
  %9 = zext i1 %8 to i32
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 0, i32 %5, i32 1, i32 0, i32 %7, i32 %9) #2
  %11 = icmp eq i32 %2, -1
  %12 = zext i1 %11 to i32
  %13 = icmp ne i32 %2, -1
  %14 = zext i1 %13 to i32
  %.lobit = lshr i32 %2, 31
  %.lobit.not = xor i32 %.lobit, 1
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str1, i64 0, i64 0), i32 %12, i32 %12, i32 %14, i32 0, i32 %.lobit.not, i32 %.lobit) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
