; ModuleID = 'test_bsearch.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@main.a = private unnamed_addr constant [6 x i32] [i32 -2, i32 -1, i32 0, i32 6, i32 7, i32 9], align 16
@str = private unnamed_addr constant [5 x i8] c"null\00"

; Function Attrs: nounwind readonly uwtable
define i32 @cmp(i8* nocapture readonly %key, i8* nocapture readonly %member) #0 {
  %1 = bitcast i8* %key to i32*
  %2 = load i32* %1, align 4, !tbaa !1
  %3 = bitcast i8* %member to i32*
  %4 = load i32* %3, align 4, !tbaa !1
  %5 = sub nsw i32 %2, %4
  ret i32 %5
}

; Function Attrs: nounwind uwtable
define void @printResult(i32* nocapture readonly %needle, i32* readonly %haystack, i32 %len) #1 {
  %1 = icmp eq i32 %len, 0
  br i1 %1, label %bsearch.exit.thread, label %.lr.ph.i.preheader

.lr.ph.i.preheader:                               ; preds = %0
  %2 = zext i32 %len to i64
  %3 = load i32* %needle, align 4, !tbaa !1
  br label %.lr.ph.i

.outer.loopexit.i:                                ; preds = %7
  %4 = icmp ult i64 %__l.02.i, %9
  br i1 %4, label %.lr.ph.i, label %bsearch.exit.thread

.lr.ph.i:                                         ; preds = %.outer.loopexit.i, %.lr.ph.i.preheader
  %__l.0.ph5.i = phi i64 [ %__l.02.i, %.outer.loopexit.i ], [ 0, %.lr.ph.i.preheader ]
  %__u.0.ph4.i = phi i64 [ %9, %.outer.loopexit.i ], [ %2, %.lr.ph.i.preheader ]
  br label %7

; <label>:5                                       ; preds = %14
  %6 = icmp ult i64 %16, %__u.0.ph4.i
  br i1 %6, label %7, label %bsearch.exit.thread

; <label>:7                                       ; preds = %5, %.lr.ph.i
  %__l.02.i = phi i64 [ %__l.0.ph5.i, %.lr.ph.i ], [ %16, %5 ]
  %8 = add i64 %__l.02.i, %__u.0.ph4.i
  %9 = lshr i64 %8, 1
  %10 = getelementptr i32* %haystack, i64 %9
  %11 = load i32* %10, align 4, !tbaa !1
  %12 = sub nsw i32 %3, %11
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %.outer.loopexit.i, label %14

; <label>:14                                      ; preds = %7
  %15 = icmp sgt i32 %12, 0
  %16 = add i64 %9, 1
  br i1 %15, label %5, label %bsearch.exit

bsearch.exit:                                     ; preds = %14
  %17 = icmp eq i32* %10, null
  br i1 %17, label %bsearch.exit.thread, label %18

bsearch.exit.thread:                              ; preds = %bsearch.exit, %5, %.outer.loopexit.i, %0
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0))
  br label %20

; <label>:18                                      ; preds = %bsearch.exit
  %19 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %11) #3
  br label %20

; <label>:20                                      ; preds = %18, %bsearch.exit.thread
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
  %a = alloca [6 x i32], align 16
  %1 = bitcast [6 x i32]* %a to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* bitcast ([6 x i32]* @main.a to i8*), i64 24, i32 16, i1 false)
  br label %.lr.ph.i.i

.outer.loopexit.i.i:                              ; preds = %5
  %2 = icmp ult i64 %__l.02.i.i, %7
  br i1 %2, label %.lr.ph.i.i, label %bsearch.exit.thread.i

.lr.ph.i.i:                                       ; preds = %.outer.loopexit.i.i, %0
  %__l.0.ph5.i.i = phi i64 [ %__l.02.i.i, %.outer.loopexit.i.i ], [ 0, %0 ]
  %__u.0.ph4.i.i = phi i64 [ %7, %.outer.loopexit.i.i ], [ 6, %0 ]
  br label %5

; <label>:3                                       ; preds = %12
  %4 = icmp ult i64 %14, %__u.0.ph4.i.i
  br i1 %4, label %5, label %bsearch.exit.thread.i

; <label>:5                                       ; preds = %3, %.lr.ph.i.i
  %__l.02.i.i = phi i64 [ %__l.0.ph5.i.i, %.lr.ph.i.i ], [ %14, %3 ]
  %6 = add i64 %__l.02.i.i, %__u.0.ph4.i.i
  %7 = lshr i64 %6, 1
  %8 = getelementptr [6 x i32]* %a, i64 0, i64 %7
  %9 = load i32* %8, align 4, !tbaa !1
  %10 = sub nsw i32 -2, %9
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %.outer.loopexit.i.i, label %12

; <label>:12                                      ; preds = %5
  %13 = icmp sgt i32 %10, 0
  %14 = add i64 %7, 1
  br i1 %13, label %3, label %bsearch.exit.i

bsearch.exit.i:                                   ; preds = %12
  %15 = icmp eq i32* %8, null
  br i1 %15, label %bsearch.exit.thread.i, label %16

bsearch.exit.thread.i:                            ; preds = %bsearch.exit.i, %3, %.outer.loopexit.i.i
  %puts.i = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0)) #3
  br label %printResult.exit

; <label>:16                                      ; preds = %bsearch.exit.i
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %9) #3
  br label %printResult.exit

printResult.exit:                                 ; preds = %16, %bsearch.exit.thread.i
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
