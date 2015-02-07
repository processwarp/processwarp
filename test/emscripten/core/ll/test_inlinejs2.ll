; ModuleID = 'test_inlinejs2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @_Z3mixii(i32 %x, i32 %y) #0 {
  %1 = tail call i32 asm "Math.pow(2, $0+$1+1)", "=r,r,r,~{dirflag},~{fpsr},~{flags}"(i32 %x, i32 %y) #2, !srcloc !1
  ret i32 %1
}

; Function Attrs: nounwind uwtable
define void @_Z4multv() #0 {
  tail call void asm sideeffect "var $$_$$1 = Math.abs(-100); $$_$$1 *= 2; Module.print($$_$$1)", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !2
  tail call void asm sideeffect "Module.print('done')", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !3
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = sdiv i32 %argc, 2
  %2 = tail call i32 asm "Math.pow(2, $0+$1+1)", "=r,r,r,~{dirflag},~{fpsr},~{flags}"(i32 %argc, i32 %1) #2, !srcloc !1
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %2)
  tail call void asm sideeffect "var $$_$$1 = Math.abs(-100); $$_$$1 *= 2; Module.print($$_$$1)", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !2
  tail call void asm sideeffect "Module.print('done')", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{i32 63}
!2 = metadata !{i32 173}
!3 = metadata !{i32 267}
