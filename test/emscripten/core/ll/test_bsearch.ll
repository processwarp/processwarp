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
  %b = alloca i64, align 8
  %1 = bitcast [6 x i32]* %a to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* bitcast ([6 x i32]* @main.a to i8*), i64 24, i32 16, i1 false)
  store i64 4294967296, i64* %b, align 8
  br label %2

; <label>:2                                       ; preds = %printResult.exit, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %printResult.exit ]
  %3 = getelementptr inbounds [6 x i32]* %a, i64 0, i64 %indvars.iv
  %4 = load i32* %3, align 4, !tbaa !1
  br label %.lr.ph.i.i

.outer.loopexit.i.i:                              ; preds = %8
  %5 = icmp ult i64 %__l.02.i.i, %10
  br i1 %5, label %.lr.ph.i.i, label %bsearch.exit.thread.i

.lr.ph.i.i:                                       ; preds = %.outer.loopexit.i.i, %2
  %__l.0.ph5.i.i = phi i64 [ %__l.02.i.i, %.outer.loopexit.i.i ], [ 0, %2 ]
  %__u.0.ph4.i.i = phi i64 [ %10, %.outer.loopexit.i.i ], [ 6, %2 ]
  br label %8

; <label>:6                                       ; preds = %15
  %7 = icmp ult i64 %17, %__u.0.ph4.i.i
  br i1 %7, label %8, label %bsearch.exit.thread.i

; <label>:8                                       ; preds = %6, %.lr.ph.i.i
  %__l.02.i.i = phi i64 [ %__l.0.ph5.i.i, %.lr.ph.i.i ], [ %17, %6 ]
  %9 = add i64 %__l.02.i.i, %__u.0.ph4.i.i
  %10 = lshr i64 %9, 1
  %11 = getelementptr [6 x i32]* %a, i64 0, i64 %10
  %12 = load i32* %11, align 4, !tbaa !1
  %13 = sub nsw i32 %4, %12
  %14 = icmp slt i32 %13, 0
  br i1 %14, label %.outer.loopexit.i.i, label %15

; <label>:15                                      ; preds = %8
  %16 = icmp sgt i32 %13, 0
  %17 = add i64 %10, 1
  br i1 %16, label %6, label %bsearch.exit.i

bsearch.exit.i:                                   ; preds = %15
  %18 = icmp eq i32* %11, null
  br i1 %18, label %bsearch.exit.thread.i, label %19

bsearch.exit.thread.i:                            ; preds = %bsearch.exit.i, %6, %.outer.loopexit.i.i
  %puts.i = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0)) #3
  br label %printResult.exit

; <label>:19                                      ; preds = %bsearch.exit.i
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %12) #3
  br label %printResult.exit

printResult.exit:                                 ; preds = %19, %bsearch.exit.thread.i
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 6
  br i1 %exitcond, label %.lr.ph.i.i4, label %2

.outer.loopexit.i.i1:                             ; preds = %24
  %21 = icmp ult i64 %__l.02.i.i5, %26
  br i1 %21, label %.lr.ph.i.i4, label %bsearch.exit.thread.i8

.lr.ph.i.i4:                                      ; preds = %.outer.loopexit.i.i1, %printResult.exit
  %__l.0.ph5.i.i2 = phi i64 [ %__l.02.i.i5, %.outer.loopexit.i.i1 ], [ 0, %printResult.exit ]
  %__u.0.ph4.i.i3 = phi i64 [ %26, %.outer.loopexit.i.i1 ], [ 6, %printResult.exit ]
  br label %24

; <label>:22                                      ; preds = %31
  %23 = icmp ult i64 %33, %__u.0.ph4.i.i3
  br i1 %23, label %24, label %bsearch.exit.thread.i8

; <label>:24                                      ; preds = %22, %.lr.ph.i.i4
  %__l.02.i.i5 = phi i64 [ %__l.0.ph5.i.i2, %.lr.ph.i.i4 ], [ %33, %22 ]
  %25 = add i64 %__l.02.i.i5, %__u.0.ph4.i.i3
  %26 = lshr i64 %25, 1
  %27 = getelementptr [6 x i32]* %a, i64 0, i64 %26
  %28 = load i32* %27, align 4, !tbaa !1
  %29 = sub nsw i32 3, %28
  %30 = icmp slt i32 %29, 0
  br i1 %30, label %.outer.loopexit.i.i1, label %31

; <label>:31                                      ; preds = %24
  %32 = icmp sgt i32 %29, 0
  %33 = add i64 %26, 1
  br i1 %32, label %22, label %bsearch.exit.i6

bsearch.exit.i6:                                  ; preds = %31
  %34 = icmp eq i32* %27, null
  br i1 %34, label %bsearch.exit.thread.i8, label %35

bsearch.exit.thread.i8:                           ; preds = %bsearch.exit.i6, %22, %.outer.loopexit.i.i1
  %puts.i7 = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0)) #3
  br label %.lr.ph.i.i13

; <label>:35                                      ; preds = %bsearch.exit.i6
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %28) #3
  br label %.lr.ph.i.i13

.outer.loopexit.i.i10:                            ; preds = %40
  %37 = icmp ult i64 %__l.02.i.i14, %42
  br i1 %37, label %.lr.ph.i.i13, label %bsearch.exit.thread.i17

.lr.ph.i.i13:                                     ; preds = %.outer.loopexit.i.i10, %35, %bsearch.exit.thread.i8
  %__l.0.ph5.i.i11 = phi i64 [ %__l.02.i.i14, %.outer.loopexit.i.i10 ], [ 0, %bsearch.exit.thread.i8 ], [ 0, %35 ]
  %__u.0.ph4.i.i12 = phi i64 [ %42, %.outer.loopexit.i.i10 ], [ 6, %bsearch.exit.thread.i8 ], [ 6, %35 ]
  br label %40

; <label>:38                                      ; preds = %47
  %39 = icmp ult i64 %49, %__u.0.ph4.i.i12
  br i1 %39, label %40, label %bsearch.exit.thread.i17

; <label>:40                                      ; preds = %38, %.lr.ph.i.i13
  %__l.02.i.i14 = phi i64 [ %__l.0.ph5.i.i11, %.lr.ph.i.i13 ], [ %49, %38 ]
  %41 = add i64 %__l.02.i.i14, %__u.0.ph4.i.i12
  %42 = lshr i64 %41, 1
  %43 = getelementptr [6 x i32]* %a, i64 0, i64 %42
  %44 = load i32* %43, align 4, !tbaa !1
  %45 = sub nsw i32 8, %44
  %46 = icmp slt i32 %45, 0
  br i1 %46, label %.outer.loopexit.i.i10, label %47

; <label>:47                                      ; preds = %40
  %48 = icmp sgt i32 %45, 0
  %49 = add i64 %42, 1
  br i1 %48, label %38, label %bsearch.exit.i15

bsearch.exit.i15:                                 ; preds = %47
  %50 = icmp eq i32* %43, null
  br i1 %50, label %bsearch.exit.thread.i17, label %51

bsearch.exit.thread.i17:                          ; preds = %bsearch.exit.i15, %38, %.outer.loopexit.i.i10
  %puts.i16 = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0)) #3
  br label %printResult.exit18

; <label>:51                                      ; preds = %bsearch.exit.i15
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %44) #3
  br label %printResult.exit18

printResult.exit18:                               ; preds = %51, %bsearch.exit.thread.i17
  %53 = bitcast i64* %b to i32*
  br label %.lr.ph.i.i22

.outer.loopexit.i.i19:                            ; preds = %57
  %54 = icmp ult i64 %__l.02.i.i23, %59
  br i1 %54, label %.lr.ph.i.i22, label %bsearch.exit.thread.i26

.lr.ph.i.i22:                                     ; preds = %.outer.loopexit.i.i19, %printResult.exit18
  %__l.0.ph5.i.i20 = phi i64 [ %__l.02.i.i23, %.outer.loopexit.i.i19 ], [ 0, %printResult.exit18 ]
  %__u.0.ph4.i.i21 = phi i64 [ %59, %.outer.loopexit.i.i19 ], [ 2, %printResult.exit18 ]
  br label %57

; <label>:55                                      ; preds = %63
  %56 = icmp ult i64 %65, %__u.0.ph4.i.i21
  br i1 %56, label %57, label %bsearch.exit.thread.i26

; <label>:57                                      ; preds = %55, %.lr.ph.i.i22
  %__l.02.i.i23 = phi i64 [ %__l.0.ph5.i.i20, %.lr.ph.i.i22 ], [ %65, %55 ]
  %58 = add i64 %__l.02.i.i23, %__u.0.ph4.i.i21
  %59 = lshr i64 %58, 1
  %60 = getelementptr i32* %53, i64 %59
  %61 = load i32* %60, align 4, !tbaa !1
  %62 = icmp sgt i32 %61, -1
  br i1 %62, label %.outer.loopexit.i.i19, label %63

; <label>:63                                      ; preds = %57
  %64 = icmp slt i32 %61, -1
  %65 = add i64 %59, 1
  br i1 %64, label %55, label %bsearch.exit.i24

bsearch.exit.i24:                                 ; preds = %63
  %66 = icmp eq i32* %60, null
  br i1 %66, label %bsearch.exit.thread.i26, label %67

bsearch.exit.thread.i26:                          ; preds = %bsearch.exit.i24, %55, %.outer.loopexit.i.i19
  %puts.i25 = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0)) #3
  br label %.lr.ph.i.i31

; <label>:67                                      ; preds = %bsearch.exit.i24
  %68 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %61) #3
  br label %.lr.ph.i.i31

.outer.loopexit.i.i28:                            ; preds = %72
  %69 = icmp ult i64 %__l.02.i.i32, %74
  br i1 %69, label %.lr.ph.i.i31, label %bsearch.exit.thread.i35

.lr.ph.i.i31:                                     ; preds = %.outer.loopexit.i.i28, %67, %bsearch.exit.thread.i26
  %__l.0.ph5.i.i29 = phi i64 [ %__l.02.i.i32, %.outer.loopexit.i.i28 ], [ 0, %bsearch.exit.thread.i26 ], [ 0, %67 ]
  %__u.0.ph4.i.i30 = phi i64 [ %74, %.outer.loopexit.i.i28 ], [ 2, %bsearch.exit.thread.i26 ], [ 2, %67 ]
  br label %72

; <label>:70                                      ; preds = %79
  %71 = icmp ult i64 %81, %__u.0.ph4.i.i30
  br i1 %71, label %72, label %bsearch.exit.thread.i35

; <label>:72                                      ; preds = %70, %.lr.ph.i.i31
  %__l.02.i.i32 = phi i64 [ %__l.0.ph5.i.i29, %.lr.ph.i.i31 ], [ %81, %70 ]
  %73 = add i64 %__l.02.i.i32, %__u.0.ph4.i.i30
  %74 = lshr i64 %73, 1
  %75 = getelementptr i32* %53, i64 %74
  %76 = load i32* %75, align 4, !tbaa !1
  %77 = sub nsw i32 2, %76
  %78 = icmp slt i32 %77, 0
  br i1 %78, label %.outer.loopexit.i.i28, label %79

; <label>:79                                      ; preds = %72
  %80 = icmp sgt i32 %77, 0
  %81 = add i64 %74, 1
  br i1 %80, label %70, label %bsearch.exit.i33

bsearch.exit.i33:                                 ; preds = %79
  %82 = icmp eq i32* %75, null
  br i1 %82, label %bsearch.exit.thread.i35, label %83

bsearch.exit.thread.i35:                          ; preds = %bsearch.exit.i33, %70, %.outer.loopexit.i.i28
  %puts.i34 = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0)) #3
  br label %printResult.exit36

; <label>:83                                      ; preds = %bsearch.exit.i33
  %84 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %76) #3
  br label %printResult.exit36

printResult.exit36:                               ; preds = %83, %bsearch.exit.thread.i35
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
