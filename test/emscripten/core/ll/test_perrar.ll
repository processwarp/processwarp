; ModuleID = 'test_perrar.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"NonExistingFile\00", align 1
@.str1 = private unnamed_addr constant [28 x i8] c"Cannot open NonExistingFile\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call i32 (i8*, i32, ...)* @open(i8* getelementptr inbounds ([16 x i8]* @.str, i64 0, i64 0), i32 0) #3
  %2 = icmp eq i32 %1, -1
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  tail call void @perror(i8* getelementptr inbounds ([28 x i8]* @.str1, i64 0, i64 0)) #4
  br label %4

; <label>:4                                       ; preds = %3, %0
  ret i32 0
}

declare i32 @open(i8* nocapture readonly, i32, ...) #1

; Function Attrs: nounwind
declare void @perror(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { cold nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
