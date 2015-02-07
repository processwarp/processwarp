; ModuleID = 'test_i64_i16.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@str = private unnamed_addr constant [4 x i8] c"<=0\00"
@str2 = private unnamed_addr constant [3 x i8] c">0\00"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = add nsw i32 %argc, 100
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts1 = tail call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str2, i64 0, i64 0))
  br label %5

; <label>:4                                       ; preds = %0
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str, i64 0, i64 0))
  br label %5

; <label>:5                                       ; preds = %4, %3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
