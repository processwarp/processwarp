; ModuleID = 'test_corruption_3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [35 x i8] c"buffer[i] == (char)((i * i) % 256)\00", align 1
@.str2 = private unnamed_addr constant [26 x i8] c"cpp/test_corruption_3.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@str = private unnamed_addr constant [7 x i8] c"all ok\00"

; Function Attrs: nounwind uwtable
define void @_Z3byev() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
vector.ph:
  %0 = tail call i32 @atexit(void ()* @_Z3byev) #3
  %1 = tail call noalias i8* @malloc(i64 100) #3
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %2 = trunc i64 %index to i32
  %broadcast.splatinsert6 = insertelement <4 x i32> undef, i32 %2, i32 0
  %broadcast.splat7 = shufflevector <4 x i32> %broadcast.splatinsert6, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction8 = add <4 x i32> %broadcast.splat7, <i32 0, i32 1, i32 2, i32 3>
  %3 = mul nsw <4 x i32> %induction8, %induction8
  %4 = trunc <4 x i32> %3 to <4 x i8>
  %5 = getelementptr inbounds i8* %1, i64 %index
  %6 = bitcast i8* %5 to <4 x i8>*
  store <4 x i8> %4, <4 x i8>* %6, align 1
  %index.next = add i64 %index, 4
  %7 = icmp eq i64 %index.next, 100
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body
  %8 = add nsw i32 %argc, 50
  %9 = sext i32 %8 to i64
  %10 = tail call i8* @realloc(i8* %1, i64 %9) #3
  %11 = icmp sgt i32 %8, 0
  br i1 %11, label %.lr.ph, label %._crit_edge

; <label>:12                                      ; preds = %.lr.ph
  %13 = trunc i64 %indvars.iv.next to i32
  %14 = icmp slt i32 %13, %8
  br i1 %14, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %12, %middle.block
  %indvars.iv = phi i64 [ %indvars.iv.next, %12 ], [ 0, %middle.block ]
  %15 = getelementptr inbounds i8* %10, i64 %indvars.iv
  %16 = load i8* %15, align 1, !tbaa !4
  %17 = sext i8 %16 to i32
  %18 = trunc i64 %indvars.iv to i32
  %19 = shl i32 %18, 24
  %sext = mul i32 %19, %18
  %20 = ashr exact i32 %sext, 24
  %21 = icmp eq i32 %17, %20
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  br i1 %21, label %12, label %22

; <label>:22                                      ; preds = %.lr.ph
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8]* @.str2, i64 0, i64 0), i32 16, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

._crit_edge:                                      ; preds = %12, %middle.block
  ret i32 1
}

; Function Attrs: nounwind
declare i32 @atexit(void ()*) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare noalias i8* @realloc(i8* nocapture, i64) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !1, metadata !2, metadata !3}
!2 = metadata !{metadata !"llvm.loop.vectorize.width", i32 1}
!3 = metadata !{metadata !"llvm.loop.interleave.count", i32 1}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
