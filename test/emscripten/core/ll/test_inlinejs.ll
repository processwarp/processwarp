; ModuleID = 'test_inlinejs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%.2f\0A\00", align 1

; Function Attrs: nounwind uwtable
define double @_Z3getv() #0 {
  %1 = tail call double asm sideeffect "Math.abs(-12/3.3)", "=r,~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !1
  tail call void asm sideeffect "#comment1", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !2
  tail call void asm sideeffect "#comment2", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !3
  tail call void asm sideeffect "#comment3\0A#comment4\0A", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !4
  ret double %1
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  tail call void asm sideeffect "Module.print('Inline JS is very cool')", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !5
  %1 = tail call double asm sideeffect "Math.abs(-12/3.3)", "=r,~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !1
  tail call void asm sideeffect "#comment1", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !2
  tail call void asm sideeffect "#comment2", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !3
  tail call void asm sideeffect "#comment3\0A#comment4\0A", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !4
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), double %1)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{i32 76}
!2 = metadata !{i32 140}
!3 = metadata !{i32 169}
!4 = metadata !{i32 205, i32 226}
!5 = metadata !{i32 277}
