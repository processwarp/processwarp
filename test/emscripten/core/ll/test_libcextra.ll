; ModuleID = 'test_libcextra.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i32] [i32 72, i32 101, i32 108, i32 108, i32 111, i32 0], align 4
@.str1 = private unnamed_addr constant [12 x i8] c"wcslen: %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = tail call i64 @wcslen(i32* getelementptr inbounds ([6 x i32]* @.str, i64 0, i64 0)) #3
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i64 %1) #4
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readonly
declare i64 @wcslen(i32*) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
