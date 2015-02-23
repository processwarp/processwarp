; ModuleID = 'test_i64_varargs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str3 = private unnamed_addr constant [4 x i8] c"...\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1
@str = private unnamed_addr constant [5 x i8] c"nada\00"

; Function Attrs: nounwind uwtable
define i64 @ccv_cache_generate_signature(i8* nocapture readonly %msg, i32 %len, i64 %sig_start, ...) #0 {
  %v = alloca [1 x %struct.__va_list_tag], align 16
  %1 = icmp slt i64 %sig_start, 10123
  br i1 %1, label %3, label %.thread

.thread:                                          ; preds = %0
  %2 = bitcast [1 x %struct.__va_list_tag]* %v to i8*
  call void @llvm.va_start(i8* %2)
  %.pre.pre = sext i32 %len to i64
  br label %8

; <label>:3                                       ; preds = %0
  %4 = sext i32 %len to i64
  %5 = getelementptr inbounds i8* %msg, i64 %4
  %puts1 = call i32 @puts(i8* %5)
  %6 = bitcast [1 x %struct.__va_list_tag]* %v to i8*
  call void @llvm.va_start(i8* %6)
  %7 = icmp sgt i64 %sig_start, 1413
  br i1 %7, label %8, label %14

; <label>:8                                       ; preds = %3, %.thread
  %.pre.pre-phi = phi i64 [ %.pre.pre, %.thread ], [ %4, %3 ]
  %9 = phi i8* [ %2, %.thread ], [ %6, %3 ]
  %10 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %v, i64 4) #2
  %11 = bitcast i8* %10 to i32*
  %12 = load i32* %11, align 4, !tbaa !1
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %12) #2
  br label %15

; <label>:14                                      ; preds = %3
  %puts = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0))
  br label %15

; <label>:15                                      ; preds = %14, %8
  %.pre-phi = phi i64 [ %4, %14 ], [ %.pre.pre-phi, %8 ]
  %16 = phi i8* [ %6, %14 ], [ %9, %8 ]
  call void @llvm.va_end(i8* %16)
  %17 = mul nsw i64 %.pre-phi, %sig_start
  %18 = load i8* %msg, align 1, !tbaa !5
  %19 = sext i8 %18 to i64
  %20 = add i64 %19, 1
  %21 = mul nsw i64 %17, %20
  ret i64 %21
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

declare i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]*, i64) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture %argv) #0 {
  store i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i8** %argv, align 8, !tbaa !6
  %1 = icmp sgt i32 %argc, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %2 = sext i32 %argc to i64
  %3 = mul nsw i64 %2, %2
  br label %4

; <label>:4                                       ; preds = %._crit_edge2, %.lr.ph
  %5 = phi i8* [ getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), %.lr.ph ], [ %.pre, %._crit_edge2 ]
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %._crit_edge2 ]
  %6 = trunc i64 %indvars.iv to i32
  %7 = srem i32 %6, 123123
  %8 = icmp eq i32 %7, 0
  %9 = add nsw i64 %indvars.iv, 2
  %10 = trunc i64 %9 to i32
  br i1 %8, label %11, label %13

; <label>:11                                      ; preds = %4
  %12 = tail call i64 (i8*, i32, i64, ...)* @ccv_cache_generate_signature(i8* %5, i32 %10, i64 %3, double 5.411100e+01)
  br label %15

; <label>:13                                      ; preds = %4
  %14 = tail call i64 (i8*, i32, i64, ...)* @ccv_cache_generate_signature(i8* %5, i32 %10, i64 %3, i32 13)
  br label %15

; <label>:15                                      ; preds = %13, %11
  %x.0 = phi i64 [ %12, %11 ], [ %14, %13 ]
  %16 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i64 %x.0) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %argc
  br i1 %exitcond, label %._crit_edge, label %._crit_edge2

._crit_edge2:                                     ; preds = %15
  %.phi.trans.insert = getelementptr inbounds i8** %argv, i64 %indvars.iv.next
  %.pre = load i8** %.phi.trans.insert, align 8, !tbaa !6
  br label %4

._crit_edge:                                      ; preds = %15, %0
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !3, metadata !3, i64 0}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"any pointer", metadata !3, i64 0}
