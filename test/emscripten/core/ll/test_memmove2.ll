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

.preheader8:                                      ; preds = %18, %0
  %indvars.iv22 = phi i64 [ 0, %0 ], [ %indvars.iv.next23, %18 ]
  %sum.012 = phi i32 [ 0, %0 ], [ %sum.4, %18 ]
  %2 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv22
  br label %.preheader5

.preheader5:                                      ; preds = %17, %.preheader8
  %indvars.iv19 = phi i64 [ 0, %.preheader8 ], [ %indvars.iv.next20, %17 ]
  %sum.110 = phi i32 [ %sum.012, %.preheader8 ], [ %sum.4, %17 ]
  %3 = trunc i64 %indvars.iv19 to i32
  %4 = trunc i64 %indvars.iv22 to i32
  %5 = icmp eq i32 %4, %3
  %6 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv19
  br label %.preheader

.preheader:                                       ; preds = %.loopexit, %.preheader5
  %indvars.iv16 = phi i64 [ 0, %.preheader5 ], [ %indvars.iv.next17, %.loopexit ]
  %sum.27 = phi i32 [ %sum.110, %.preheader5 ], [ %sum.4, %.loopexit ]
  br label %7

; <label>:7                                       ; preds = %7, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %7 ]
  %8 = trunc i64 %indvars.iv to i8
  %9 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv
  store i8 %8, i8* %9, align 1, !tbaa !1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 256
  br i1 %exitcond, label %10, label %7

; <label>:10                                      ; preds = %7
  br i1 %5, label %.loopexit, label %11

; <label>:11                                      ; preds = %10
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %2, i8* %6, i64 %indvars.iv16, i32 1, i1 false)
  br label %12

; <label>:12                                      ; preds = %12, %11
  %indvars.iv13 = phi i64 [ 0, %11 ], [ %indvars.iv.next14, %12 ]
  %sum.33 = phi i32 [ %sum.27, %11 ], [ %16, %12 ]
  %13 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv13
  %14 = load i8* %13, align 1, !tbaa !1
  %15 = sext i8 %14 to i32
  %16 = add nsw i32 %15, %sum.33
  %indvars.iv.next14 = add nuw nsw i64 %indvars.iv13, 1
  %exitcond15 = icmp eq i64 %indvars.iv.next14, 256
  br i1 %exitcond15, label %.loopexit, label %12

.loopexit:                                        ; preds = %12, %10
  %sum.4 = phi i32 [ %sum.27, %10 ], [ %16, %12 ]
  %indvars.iv.next17 = add nuw nsw i64 %indvars.iv16, 1
  %exitcond18 = icmp eq i64 %indvars.iv.next17, 35
  br i1 %exitcond18, label %17, label %.preheader

; <label>:17                                      ; preds = %.loopexit
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  %exitcond21 = icmp eq i64 %indvars.iv.next20, 10
  br i1 %exitcond21, label %18, label %.preheader5

; <label>:18                                      ; preds = %17
  %indvars.iv.next23 = add nuw nsw i64 %indvars.iv22, 1
  %exitcond24 = icmp eq i64 %indvars.iv.next23, 10
  br i1 %exitcond24, label %19, label %.preheader8

; <label>:19                                      ; preds = %18
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str2, i64 0, i64 0), i32 %sum.4) #1
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
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
