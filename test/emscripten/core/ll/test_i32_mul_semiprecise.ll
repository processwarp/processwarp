; ModuleID = 'test_i32_mul_semiprecise.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@state = internal unnamed_addr global [624 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [8 x i8] c"%d: %u\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @seedMT(i32 %seed) #0 {
  store i32 %seed, i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 0), align 16, !tbaa !1
  br label %1

; <label>:1                                       ; preds = %1, %0
  %indvars.iv = phi i64 [ 1, %0 ], [ %indvars.iv.next, %1 ]
  %.01 = phi i32 [ %seed, %0 ], [ %6, %1 ]
  %2 = lshr i32 %.01, 30
  %3 = xor i32 %2, %.01
  %4 = mul i32 %3, 1812433253
  %5 = trunc i64 %indvars.iv to i32
  %6 = add i32 %4, %5
  %7 = getelementptr inbounds [624 x i32]* @state, i64 0, i64 %indvars.iv
  store i32 %6, i32* %7, align 4, !tbaa !1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 624
  br i1 %exitcond, label %8, label %1

; <label>:8                                       ; preds = %1
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store i32 5497, i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 0), align 16, !tbaa !1
  br label %1

; <label>:1                                       ; preds = %1, %0
  %indvars.iv.i = phi i64 [ 1, %0 ], [ %indvars.iv.next.i, %1 ]
  %.01.i = phi i32 [ 5497, %0 ], [ %6, %1 ]
  %2 = lshr i32 %.01.i, 30
  %3 = xor i32 %2, %.01.i
  %4 = mul i32 %3, 1812433253
  %5 = trunc i64 %indvars.iv.i to i32
  %6 = add i32 %4, %5
  %7 = getelementptr inbounds [624 x i32]* @state, i64 0, i64 %indvars.iv.i
  store i32 %6, i32* %7, align 4, !tbaa !1
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.i = icmp eq i64 %indvars.iv.next.i, 624
  br i1 %exitcond.i, label %seedMT.exit.preheader, label %1

seedMT.exit.preheader:                            ; preds = %1
  %8 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 0), align 16, !tbaa !1
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 0, i32 %8) #2
  %10 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 1), align 4, !tbaa !1
  %11 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 1, i32 %10) #2
  %12 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 2), align 8, !tbaa !1
  %13 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 2, i32 %12) #2
  %14 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 3), align 4, !tbaa !1
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 3, i32 %14) #2
  %16 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 4), align 16, !tbaa !1
  %17 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 4, i32 %16) #2
  %18 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 5), align 4, !tbaa !1
  %19 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 5, i32 %18) #2
  %20 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 6), align 8, !tbaa !1
  %21 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 6, i32 %20) #2
  %22 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 7), align 4, !tbaa !1
  %23 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 7, i32 %22) #2
  %24 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 8), align 16, !tbaa !1
  %25 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 8, i32 %24) #2
  %26 = load i32* getelementptr inbounds ([624 x i32]* @state, i64 0, i64 9), align 4, !tbaa !1
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 9, i32 %26) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
