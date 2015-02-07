; ModuleID = 'test_memmove2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str2 = private unnamed_addr constant [12 x i8] c"final: %d.\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buffer = alloca [256 x i8], align 16
  %1 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 0
  call void @llvm.lifetime.start(i64 256, i8* %1) #1
  br label %.preheader8

.preheader8:                                      ; preds = %25, %0
  %indvars.iv22 = phi i64 [ 0, %0 ], [ %indvars.iv.next23, %25 ]
  %sum.012 = phi i32 [ 0, %0 ], [ %sum.4, %25 ]
  %2 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv22
  br label %.preheader5

.preheader5:                                      ; preds = %24, %.preheader8
  %indvars.iv19 = phi i64 [ 0, %.preheader8 ], [ %indvars.iv.next20, %24 ]
  %sum.110 = phi i32 [ %sum.012, %.preheader8 ], [ %sum.4, %24 ]
  %3 = trunc i64 %indvars.iv19 to i32
  %4 = trunc i64 %indvars.iv22 to i32
  %5 = icmp eq i32 %4, %3
  %6 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv19
  br label %vector.ph

vector.ph:                                        ; preds = %.loopexit, %.preheader5
  %indvars.iv16 = phi i64 [ 0, %.preheader5 ], [ %indvars.iv.next17, %.loopexit ]
  %sum.27 = phi i32 [ %sum.110, %.preheader5 ], [ %sum.4, %.loopexit ]
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = trunc i64 %index to i8
  %broadcast.splatinsert26 = insertelement <16 x i8> undef, i8 %7, i32 0
  %broadcast.splat27 = shufflevector <16 x i8> %broadcast.splatinsert26, <16 x i8> undef, <16 x i32> zeroinitializer
  %induction28 = add <16 x i8> %broadcast.splat27, <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>
  %induction29 = add <16 x i8> %broadcast.splat27, <i8 16, i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 23, i8 24, i8 25, i8 26, i8 27, i8 28, i8 29, i8 30, i8 31>
  %8 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %index
  %9 = bitcast i8* %8 to <16 x i8>*
  store <16 x i8> %induction28, <16 x i8>* %9, align 16
  %.sum49 = or i64 %index, 16
  %10 = getelementptr [256 x i8]* %buffer, i64 0, i64 %.sum49
  %11 = bitcast i8* %10 to <16 x i8>*
  store <16 x i8> %induction29, <16 x i8>* %11, align 16
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, 256
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body
  br i1 %5, label %.loopexit, label %vector.ph30

vector.ph30:                                      ; preds = %middle.block
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %2, i8* %6, i64 %indvars.iv16, i32 1, i1 false)
  %13 = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %sum.27, i32 0
  br label %vector.body31

vector.body31:                                    ; preds = %vector.body31, %vector.ph30
  %index34 = phi i64 [ 0, %vector.ph30 ], [ %index.next38, %vector.body31 ]
  %vec.phi = phi <4 x i32> [ %13, %vector.ph30 ], [ %20, %vector.body31 ]
  %vec.phi43 = phi <4 x i32> [ zeroinitializer, %vector.ph30 ], [ %21, %vector.body31 ]
  %14 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %index34
  %15 = bitcast i8* %14 to <4 x i8>*
  %wide.load = load <4 x i8>* %15, align 8
  %.sum50 = or i64 %index34, 4
  %16 = getelementptr [256 x i8]* %buffer, i64 0, i64 %.sum50
  %17 = bitcast i8* %16 to <4 x i8>*
  %wide.load44 = load <4 x i8>* %17, align 4
  %18 = sext <4 x i8> %wide.load to <4 x i32>
  %19 = sext <4 x i8> %wide.load44 to <4 x i32>
  %20 = add nsw <4 x i32> %18, %vec.phi
  %21 = add nsw <4 x i32> %19, %vec.phi43
  %index.next38 = add i64 %index34, 8
  %22 = icmp eq i64 %index.next38, 256
  br i1 %22, label %middle.block32, label %vector.body31, !llvm.loop !4

middle.block32:                                   ; preds = %vector.body31
  %bin.rdx = add <4 x i32> %21, %20
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx46 = add <4 x i32> %bin.rdx, %rdx.shuf
  %rdx.shuf47 = shufflevector <4 x i32> %bin.rdx46, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx48 = add <4 x i32> %bin.rdx46, %rdx.shuf47
  %23 = extractelement <4 x i32> %bin.rdx48, i32 0
  br label %.loopexit

.loopexit:                                        ; preds = %middle.block32, %middle.block
  %sum.4 = phi i32 [ %sum.27, %middle.block ], [ %23, %middle.block32 ]
  %indvars.iv.next17 = add nuw nsw i64 %indvars.iv16, 1
  %exitcond18 = icmp eq i64 %indvars.iv.next17, 35
  br i1 %exitcond18, label %24, label %vector.ph

; <label>:24                                      ; preds = %.loopexit
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  %exitcond21 = icmp eq i64 %indvars.iv.next20, 10
  br i1 %exitcond21, label %25, label %.preheader5

; <label>:25                                      ; preds = %24
  %indvars.iv.next23 = add nuw nsw i64 %indvars.iv22, 1
  %exitcond24 = icmp eq i64 %indvars.iv.next23, 10
  br i1 %exitcond24, label %26, label %.preheader8

; <label>:26                                      ; preds = %25
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str2, i64 0, i64 0), i32 %sum.4)
  call void @llvm.lifetime.end(i64 256, i8* %1) #1
  ret i32 1
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !1, metadata !2, metadata !3}
!2 = metadata !{metadata !"llvm.loop.vectorize.width", i32 1}
!3 = metadata !{metadata !"llvm.loop.interleave.count", i32 1}
!4 = metadata !{metadata !4, metadata !2, metadata !3}
