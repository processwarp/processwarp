; ModuleID = 'test_fast_math.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"total: %g\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %endptr = alloca i8*, align 8
  %.013 = add nsw i32 %argc, -1
  %1 = icmp eq i32 %.013, 0
  br i1 %1, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %0
  %.016 = phi i32 [ %.01, %.lr.ph ], [ %.013, %0 ]
  %argv.pn = phi i8** [ %.05, %.lr.ph ], [ %argv, %0 ]
  %total.04 = phi double [ %4, %.lr.ph ], [ 0.000000e+00, %0 ]
  %.05 = getelementptr inbounds i8** %argv.pn, i64 1
  %2 = load i8** %.05, align 8, !tbaa !1
  %3 = call double @strtod(i8* %2, i8** %endptr) #2
  %4 = fadd double %total.04, %3
  %.01 = add nsw i32 %.016, -1
  %5 = icmp eq i32 %.01, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  %total.0.lcssa = phi double [ 0.000000e+00, %0 ], [ %4, %.lr.ph ]
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i64 0, i64 0), double %total.0.lcssa)
  ret i32 0
}

; Function Attrs: nounwind
declare double @strtod(i8* readonly, i8** nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
