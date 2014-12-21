; ModuleID = 'hello4.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

@HELLOS = internal unnamed_addr constant [3 x i8*] [i8* getelementptr inbounds ([11 x i8]* @.str1, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8]* @.str3, i32 0, i32 0)], align 16
@.str1 = private unnamed_addr constant [11 x i8] c"hello you!\00", align 1
@.str2 = private unnamed_addr constant [10 x i8] c"hello me!\00", align 1
@.str3 = private unnamed_addr constant [11 x i8] c"hello all!\00", align 1

; Function Attrs: noreturn nounwind ssp uwtable
define i32 @main() #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %i.0 = phi i32 [ 0, %0 ], [ %6, %1 ]
  %2 = srem i32 %i.0, 3
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds [3 x i8*]* @HELLOS, i64 0, i64 %3
  %5 = load i8** %4, align 8, !tbaa !1
  %puts = tail call i32 @puts(i8* %5)
  %6 = add nsw i32 %i.0, 1
  br label %1
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { noreturn nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.54) (based on LLVM 3.5svn)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
