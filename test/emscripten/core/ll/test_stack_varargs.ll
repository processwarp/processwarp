; ModuleID = 'test_stack_varargs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [118 x i8] c"%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\0A\00", align 1
@str = private unnamed_addr constant [4 x i8] c"ok!\00"

; Function Attrs: nounwind uwtable
define void @_Z4funci(i32 %i) #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([118 x i8]* @.str, i64 0, i64 0), i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i, i32 %i) #2
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %i.01 = phi i32 [ 0, %0 ], [ %3, %1 ]
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([118 x i8]* @.str, i64 0, i64 0), i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01, i32 %i.01) #2
  %3 = add nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %3, 1024
  br i1 %exitcond, label %4, label %1

; <label>:4                                       ; preds = %1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
