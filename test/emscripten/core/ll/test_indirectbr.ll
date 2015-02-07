; ModuleID = 'test_indirectbr.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@_ZZ4mainE5addrs = private unnamed_addr constant [2 x i8*] [i8* blockaddress(@main, %12), i8* blockaddress(@main, %15)], align 16
@str = private unnamed_addr constant [5 x i8] c"good\00"
@str2 = private unnamed_addr constant [4 x i8] c"bad\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %which.03 = phi i32 [ 0, %0 ], [ %4, %1 ]
  %x.02 = phi i32 [ 0, %0 ], [ %5, %1 ]
  %2 = mul nsw i32 %x.02, %x.02
  %3 = add nsw i32 %which.03, %2
  %4 = srem i32 %3, 7
  %5 = add nsw i32 %x.02, 1
  %exitcond = icmp eq i32 %5, 1000
  br i1 %exitcond, label %6, label %1

; <label>:6                                       ; preds = %1
  %7 = srem i32 %4, 2
  %8 = add nsw i32 %7, 1
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [2 x i8*]* @_ZZ4mainE5addrs, i64 0, i64 %9
  %11 = load i8** %10, align 8, !tbaa !1
  br label %13

; <label>:12                                      ; preds = %13
  %puts1 = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str2, i64 0, i64 0))
  ret i32 0

; <label>:13                                      ; preds = %15, %6
  %14 = phi i8* [ %11, %6 ], [ blockaddress(@main, %12), %15 ]
  indirectbr i8* %14, [label %12, label %15]

; <label>:15                                      ; preds = %13
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0))
  br label %13
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
