; ModuleID = 'hello8.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct.SPerson = type <{ [21 x i8], i32, i8, i8 }>

@person = global %struct.SPerson <{ [21 x i8] c"sample tarou\00\00\00\00\00\00\00\00\00", i32 20, i8 5, i8 102 }>, align 1
@.str = private unnamed_addr constant [49 x i8] c"SPerson \E3\81\AE\E3\82\B5\E3\82\A4\E3\82\BA\E3\81\AF %zu \E3\83\90\E3\82\A4\E3\83\88\E3\81\A7\E3\81\99\E3\80\82\0A \00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c" %02x\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([49 x i8]* @.str, i64 0, i64 0), i64 27) #2
  br label %2

; <label>:2                                       ; preds = %2, %0
  %i.01 = phi i64 [ 0, %0 ], [ %7, %2 ]
  %3 = getelementptr inbounds %struct.SPerson* @person, i64 0, i32 0, i64 %i.01
  %4 = load i8* %3, align 1, !tbaa !1
  %5 = sext i8 %4 to i32
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 %5) #2
  %7 = add i64 %i.01, 1
  %exitcond = icmp eq i64 %7, 27
  br i1 %exitcond, label %8, label %2

; <label>:8                                       ; preds = %2
  %putchar = tail call i32 @putchar(i32 10) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @putchar(i32) #2

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
