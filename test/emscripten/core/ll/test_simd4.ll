; ModuleID = 'test_simd4.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [24 x i8] c"averagex4 result: %.1f\0A\00", align 1

; Function Attrs: nounwind readonly uwtable
define float @_Z11simdAveragePfi(float* nocapture readonly %src, i32 %len) #0 {
  %1 = icmp sgt i32 %len, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %0
  %.03 = phi float* [ %5, %.lr.ph ], [ %src, %0 ]
  %sumx4.02 = phi <4 x float> [ %4, %.lr.ph ], [ zeroinitializer, %0 ]
  %i.01 = phi i32 [ %6, %.lr.ph ], [ 0, %0 ]
  %2 = bitcast float* %.03 to <4 x float>*
  %3 = load <4 x float>* %2, align 16, !tbaa !1
  %4 = fadd <4 x float> %sumx4.02, %3
  %5 = getelementptr inbounds float* %.03, i64 4
  %6 = add nsw i32 %i.01, 4
  %7 = icmp slt i32 %6, %len
  br i1 %7, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %0
  %sumx4.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %4, %.lr.ph ]
  %8 = extractelement <4 x float> %sumx4.0.lcssa, i32 0
  %9 = extractelement <4 x float> %sumx4.0.lcssa, i32 1
  %10 = fadd float %8, %9
  %11 = extractelement <4 x float> %sumx4.0.lcssa, i32 2
  %12 = fadd float %11, %10
  %13 = extractelement <4 x float> %sumx4.0.lcssa, i32 3
  %14 = fadd float %13, %12
  %15 = sitofp i32 %len to float
  %16 = fdiv float %14, %15
  ret float %16
}

; Function Attrs: nounwind uwtable
define void @_Z9initArrayPfi(float* nocapture %src, i32 %len) #1 {
  %1 = icmp sgt i32 %len, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %0
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %0 ]
  %2 = trunc i64 %indvars.iv to i32
  %3 = sitofp i32 %2 to double
  %4 = fmul double %3, 1.000000e-01
  %5 = fptrunc double %4 to float
  %6 = getelementptr inbounds float* %src, i64 %indvars.iv
  store float %5, float* %6, align 4, !tbaa !4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %len
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
  %src = alloca [100000 x float], align 16
  %1 = bitcast [100000 x float]* %src to i8*
  call void @llvm.lifetime.start(i64 400000, i8* %1) #2
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i, %0
  %indvars.iv.i = phi i64 [ %indvars.iv.next.i, %.lr.ph.i ], [ 0, %0 ]
  %2 = trunc i64 %indvars.iv.i to i32
  %3 = sitofp i32 %2 to double
  %4 = fmul double %3, 1.000000e-01
  %5 = fptrunc double %4 to float
  %6 = getelementptr inbounds [100000 x float]* %src, i64 0, i64 %indvars.iv.i
  store float %5, float* %6, align 4, !tbaa !4
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond = icmp eq i64 %indvars.iv.next.i, 100000
  br i1 %exitcond, label %.lr.ph.i1.preheader, label %.lr.ph.i

.lr.ph.i1.preheader:                              ; preds = %.lr.ph.i
  %7 = getelementptr inbounds [100000 x float]* %src, i64 0, i64 0
  br label %.lr.ph.i1

.lr.ph.i1:                                        ; preds = %.lr.ph.i1, %.lr.ph.i1.preheader
  %.03.i = phi float* [ %11, %.lr.ph.i1 ], [ %7, %.lr.ph.i1.preheader ]
  %sumx4.02.i = phi <4 x float> [ %10, %.lr.ph.i1 ], [ zeroinitializer, %.lr.ph.i1.preheader ]
  %i.01.i = phi i32 [ %12, %.lr.ph.i1 ], [ 0, %.lr.ph.i1.preheader ]
  %8 = bitcast float* %.03.i to <4 x float>*
  %9 = load <4 x float>* %8, align 16, !tbaa !1
  %10 = fadd <4 x float> %sumx4.02.i, %9
  %11 = getelementptr inbounds float* %.03.i, i64 4
  %12 = add nsw i32 %i.01.i, 4
  %13 = icmp slt i32 %12, 100000
  br i1 %13, label %.lr.ph.i1, label %_Z11simdAveragePfi.exit

_Z11simdAveragePfi.exit:                          ; preds = %.lr.ph.i1
  %14 = extractelement <4 x float> %10, i32 0
  %15 = extractelement <4 x float> %10, i32 1
  %16 = fadd float %14, %15
  %17 = extractelement <4 x float> %10, i32 2
  %18 = fadd float %17, %16
  %19 = extractelement <4 x float> %10, i32 3
  %20 = fadd float %19, %18
  %21 = fdiv float %20, 1.000000e+05
  %22 = fpext float %21 to double
  %23 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str, i64 0, i64 0), double %22) #2
  call void @llvm.lifetime.end(i64 400000, i8* %1) #2
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

attributes #0 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"float", metadata !2, i64 0}
