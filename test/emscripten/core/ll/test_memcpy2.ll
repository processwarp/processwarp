; ModuleID = 'test_memcpy2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [15 x i8] c"test_memcpy2.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str2 = private unnamed_addr constant [26 x i8] c"memcmp(dest, src, k) == 0\00", align 1
@str = private unnamed_addr constant [4 x i8] c"ok.\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buffer = alloca [256 x i8], align 16
  %1 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 0
  call void @llvm.lifetime.start(i64 256, i8* %1) #1
  br label %.preheader4

.preheader4:                                      ; preds = %17, %0
  %indvars.iv11 = phi i64 [ 0, %0 ], [ %indvars.iv.next12, %17 ]
  %.sum = add i64 %indvars.iv11, 128
  %2 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %.sum
  br label %.preheader2

.preheader2:                                      ; preds = %14, %.preheader4
  %indvars.iv9 = phi i64 [ 0, %.preheader4 ], [ %indvars.iv.next10, %14 ]
  %3 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 %indvars.iv9
  br label %.preheader

; <label>:4                                       ; preds = %10
  %5 = trunc i64 %indvars.iv.next8 to i32
  %6 = icmp slt i32 %5, 35
  br i1 %6, label %.preheader, label %14

.preheader:                                       ; preds = %4, %.preheader2
  %indvars.iv7 = phi i64 [ 0, %.preheader2 ], [ %indvars.iv.next8, %4 ]
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
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 %indvars.iv7, i32 1, i1 false)
  %11 = call i32 @memcmp(i8* %2, i8* %3, i64 %indvars.iv7) #4
  %12 = icmp eq i32 %11, 0
  %indvars.iv.next8 = add nuw nsw i64 %indvars.iv7, 1
  br i1 %12, label %4, label %13

; <label>:13                                      ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8]* @.str1, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:14                                      ; preds = %4
  %indvars.iv.next10 = add nuw nsw i64 %indvars.iv9, 1
  %15 = trunc i64 %indvars.iv.next10 to i32
  %16 = icmp slt i32 %15, 10
  br i1 %16, label %.preheader2, label %17

; <label>:17                                      ; preds = %14
  %indvars.iv.next12 = add nuw nsw i64 %indvars.iv11, 1
  %18 = trunc i64 %indvars.iv.next12 to i32
  %19 = icmp slt i32 %18, 10
  br i1 %19, label %.preheader4, label %20

; <label>:20                                      ; preds = %17
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
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
