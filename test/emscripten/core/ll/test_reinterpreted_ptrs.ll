; ModuleID = 'test_reinterpreted_ptrs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%class.Foo = type { float, i32 }

@magic1 = global %class.Foo* inttoptr (i64 3735884063 to %class.Foo*), align 8
@magic2 = global %class.Foo* inttoptr (i64 3735914639 to %class.Foo*), align 8
@.str1 = private unnamed_addr constant [7 x i8] c"magic1\00", align 1
@.str2 = private unnamed_addr constant [7 x i8] c"magic2\00", align 1

; Function Attrs: nounwind readonly uwtable
define i32 @_ZNK3Foo6getBarEv(%class.Foo* nocapture readonly %this) #0 align 2 {
  %1 = getelementptr inbounds %class.Foo* %this, i64 0, i32 0
  %2 = load float* %1, align 4, !tbaa !1
  %3 = fptosi float %2 to i32
  ret i32 %3
}

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #1 {
_ZL7runTestv.exit:
  %0 = load %class.Foo** @magic2, align 8, !tbaa !7
  %1 = load %class.Foo** @magic1, align 8, !tbaa !7
  %2 = icmp eq %class.Foo* %0, %1
  %. = select i1 %2, i8* getelementptr inbounds ([7 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str2, i64 0, i64 0)
  %puts.i = tail call i32 @puts(i8* %.)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS3Foo", metadata !3, i64 0, metadata !6, i64 4}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"int", metadata !4, i64 0}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"any pointer", metadata !4, i64 0}
