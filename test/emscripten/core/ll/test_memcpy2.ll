; ModuleID = 'test_memcpy2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [21 x i8] c"cpp/test_memcpy2.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str2 = private unnamed_addr constant [26 x i8] c"memcmp(dest, src, k) == 0\00", align 1
@str = private unnamed_addr constant [4 x i8] c"ok.\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buffer = alloca [256 x i8], align 16
  %1 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 0
  call void @llvm.lifetime.start(i64 256, i8* %1) #1
  br label %.preheader4

.preheader4:                                      ; preds = %19, %0
  %indvars.iv11 = phi i64 [ 0, %0 ], [ %indvars.iv.next12, %19 ]
  %.sum = add i64 %indvars.iv11, 128
  %2 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %.sum
  br label %.preheader2

.preheader2:                                      ; preds = %16, %.preheader4
  %indvars.iv9 = phi i64 [ 0, %.preheader4 ], [ %indvars.iv.next10, %16 ]
  %3 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv9
  br label %vector.ph

; <label>:4                                       ; preds = %middle.block
  %5 = trunc i64 %indvars.iv.next8 to i32
  %6 = icmp slt i32 %5, 35
  br i1 %6, label %vector.ph, label %16

vector.ph:                                        ; preds = %4, %.preheader2
  %indvars.iv7 = phi i64 [ 0, %.preheader2 ], [ %indvars.iv.next8, %4 ]
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = trunc i64 %index to i8
  %broadcast.splatinsert14 = insertelement <16 x i8> undef, i8 %7, i32 0
  %broadcast.splat15 = shufflevector <16 x i8> %broadcast.splatinsert14, <16 x i8> undef, <16 x i32> zeroinitializer
  %induction16 = add <16 x i8> %broadcast.splat15, <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>
  %induction17 = add <16 x i8> %broadcast.splat15, <i8 16, i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 23, i8 24, i8 25, i8 26, i8 27, i8 28, i8 29, i8 30, i8 31>
  %8 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %index
  %9 = bitcast i8* %8 to <16 x i8>*
  store <16 x i8> %induction16, <16 x i8>* %9, align 16
  %.sum1819 = or i64 %index, 16
  %10 = getelementptr [256 x i8]* %buffer, i64 0, i64 %.sum1819
  %11 = bitcast i8* %10 to <16 x i8>*
  store <16 x i8> %induction17, <16 x i8>* %11, align 16
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, 256
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 %indvars.iv7, i32 1, i1 false)
  %13 = call i32 @memcmp(i8* %2, i8* %3, i64 %indvars.iv7) #4
  %14 = icmp eq i32 %13, 0
  %indvars.iv.next8 = add nuw nsw i64 %indvars.iv7, 1
  br i1 %14, label %4, label %15

; <label>:15                                      ; preds = %middle.block
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8]* @.str1, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:16                                      ; preds = %4
  %indvars.iv.next10 = add nuw nsw i64 %indvars.iv9, 1
  %17 = trunc i64 %indvars.iv.next10 to i32
  %18 = icmp slt i32 %17, 10
  br i1 %18, label %.preheader2, label %19

; <label>:19                                      ; preds = %16
  %indvars.iv.next12 = add nuw nsw i64 %indvars.iv11, 1
  %20 = trunc i64 %indvars.iv.next12 to i32
  %21 = icmp slt i32 %20, 10
  br i1 %21, label %.preheader4, label %22

; <label>:22                                      ; preds = %19
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str, i64 0, i64 0))
  call void @llvm.lifetime.end(i64 256, i8* %1) #1
  ret i32 1
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: nounwind readonly
declare i32 @memcmp(i8* nocapture, i8* nocapture, i64) #3

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !1, metadata !2, metadata !3}
!2 = metadata !{metadata !"llvm.loop.vectorize.width", i32 1}
!3 = metadata !{metadata !"llvm.loop.interleave.count", i32 1}
