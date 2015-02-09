; ModuleID = 'test_mod_globalstruct.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.malloc_params = type { i64, i64 }

@mparams = global %struct.malloc_params zeroinitializer, align 8
@.str = private unnamed_addr constant [15 x i8] c"*%d,%d,%d,%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store i64 4096, i64* getelementptr inbounds (%struct.malloc_params* @mparams, i64 0, i32 1), align 8, !tbaa !1
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0), i64 4096, i64 4096, i64 8192, i64 69632) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 8}
!2 = metadata !{metadata !"_ZTS13malloc_params", metadata !3, i64 0, metadata !3, i64 8}
!3 = metadata !{metadata !"long", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
