; ModuleID = 'test_mmap.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [23 x i8] c"munmap(map, 5000) == 0\00", align 1
@.str1 = private unnamed_addr constant [18 x i8] c"tmp/test_mmap.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@.str2 = private unnamed_addr constant [21 x i8] c"map != ((void *) -1)\00", align 1
@.str3 = private unnamed_addr constant [12 x i8] c"map[i] == i\00", align 1
@.str4 = private unnamed_addr constant [28 x i8] c"munmap(map, NUM_BYTES) == 0\00", align 1
@.str5 = private unnamed_addr constant [12 x i8] c"hello,world\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  br label %3

; <label>:1                                       ; preds = %3
  %2 = icmp slt i32 %7, 10
  br i1 %2, label %3, label %9

; <label>:3                                       ; preds = %1, %0
  %i.06 = phi i32 [ 0, %0 ], [ %7, %1 ]
  %4 = tail call i8* @mmap(i8* null, i64 5000, i32 3, i32 33, i32 -1, i64 0) #3
  %5 = tail call i32 @munmap(i8* %4, i64 5000) #3
  %6 = icmp eq i32 %5, 0
  %7 = add nsw i32 %i.06, 1
  br i1 %6, label %1, label %8

; <label>:8                                       ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([23 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), i32 12, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:9                                       ; preds = %1
  %10 = tail call i8* @mmap(i8* null, i64 8388608, i32 3, i32 33, i32 -1, i64 0) #3
  %11 = bitcast i8* %10 to i32*
  %12 = icmp eq i8* %10, inttoptr (i64 -1 to i8*)
  br i1 %12, label %19, label %vector.body

vector.body:                                      ; preds = %vector.body, %9
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %9 ]
  %13 = getelementptr inbounds i32* %11, i64 %index
  %14 = trunc i64 %index to i32
  %broadcast.splatinsert10 = insertelement <4 x i32> undef, i32 %14, i32 0
  %broadcast.splat11 = shufflevector <4 x i32> %broadcast.splatinsert10, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction12 = add <4 x i32> %broadcast.splat11, <i32 0, i32 1, i32 2, i32 3>
  %induction13 = add <4 x i32> %broadcast.splat11, <i32 4, i32 5, i32 6, i32 7>
  %15 = bitcast i32* %13 to <4 x i32>*
  store <4 x i32> %induction12, <4 x i32>* %15, align 4
  %.sum14 = or i64 %index, 4
  %16 = getelementptr i32* %11, i64 %.sum14
  %17 = bitcast i32* %16 to <4 x i32>*
  store <4 x i32> %induction13, <4 x i32>* %17, align 4
  %index.next = add i64 %index, 8
  %18 = icmp eq i64 %index.next, 2097152
  br i1 %18, label %.preheader, label %vector.body, !llvm.loop !1

; <label>:19                                      ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([21 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), i32 20, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:20                                      ; preds = %.preheader
  %21 = trunc i64 %indvars.iv.next to i32
  %22 = icmp slt i32 %21, 2097152
  br i1 %22, label %.preheader, label %28

.preheader:                                       ; preds = %20, %vector.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %20 ], [ 0, %vector.body ]
  %23 = getelementptr inbounds i32* %11, i64 %indvars.iv
  %24 = load i32* %23, align 4, !tbaa !4
  %25 = trunc i64 %indvars.iv to i32
  %26 = icmp eq i32 %24, %25
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  br i1 %26, label %20, label %27

; <label>:27                                      ; preds = %.preheader
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), i32 29, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:28                                      ; preds = %20
  %29 = tail call i32 @munmap(i8* %10, i64 8388608) #3
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %32, label %31

; <label>:31                                      ; preds = %28
  tail call void @__assert_fail(i8* getelementptr inbounds ([28 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), i32 32, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:32                                      ; preds = %28
  %33 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str5, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i8* @mmap(i8*, i64, i32, i32, i32, i64) #1

; Function Attrs: nounwind
declare i32 @munmap(i8*, i64) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

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
!5 = metadata !{metadata !"int", metadata !6, i64 0}
!6 = metadata !{metadata !"omnipotent char", metadata !7, i64 0}
!7 = metadata !{metadata !"Simple C/C++ TBAA"}
