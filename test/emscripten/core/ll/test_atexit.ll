; ModuleID = 'test_atexit.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = tail call i32 @atexit(void ()* @_ZL6cleanAv) #2
  %2 = tail call i32 @atexit(void ()* @_ZL6cleanBv) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @atexit(void ()*) #1

; Function Attrs: nounwind uwtable
define internal void @_ZL6cleanAv() #0 {
  %putchar = tail call i32 @putchar(i32 65)
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @_ZL6cleanBv() #0 {
  %putchar = tail call i32 @putchar(i32 66)
  ret void
}

; Function Attrs: nounwind
declare i32 @putchar(i32) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
