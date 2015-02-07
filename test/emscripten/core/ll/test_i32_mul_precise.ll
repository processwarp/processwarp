; ModuleID = 'test_i32_mul_precise.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"%lu\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = icmp sgt i32 %argc, 1000
  br i1 %1, label %2, label %6

; <label>:2                                       ; preds = %0
  %3 = sext i32 %argc to i64
  %4 = add i64 %3, 1419063521
  %5 = sub i64 2222758749, %3
  br label %6

; <label>:6                                       ; preds = %2, %0
  %d1.0 = phi i64 [ %5, %2 ], [ 2222758749, %0 ]
  %q.0 = phi i64 [ %4, %2 ], [ 1419063521, %0 ]
  %7 = mul i64 %q.0, %d1.0
  %8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i64 %7)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
