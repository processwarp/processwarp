; ModuleID = 'test_i32_mul_precise.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%u\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = icmp sgt i32 %argc, 1000
  br i1 %1, label %2, label %5

; <label>:2                                       ; preds = %0
  %3 = add i32 %argc, 1419063521
  %4 = sub i32 -2072208547, %argc
  br label %5

; <label>:5                                       ; preds = %2, %0
  %d1.0 = phi i32 [ %4, %2 ], [ -2072208547, %0 ]
  %q.0 = phi i32 [ %3, %2 ], [ 1419063521, %0 ]
  %6 = mul i32 %q.0, %d1.0
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %6) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
