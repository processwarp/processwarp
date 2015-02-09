; ModuleID = 'test_memcpy_memcmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"%2d,\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str2 = private unnamed_addr constant [12 x i8] c"[%d,%d,%d] \00", align 1
@.str3 = private unnamed_addr constant [39 x i8] c"memcmp(buffer + i, buffer + j, k) == 0\00", align 1
@.str4 = private unnamed_addr constant [27 x i8] c"cpp/test_memcpy_memcmp.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str5 = private unnamed_addr constant [38 x i8] c"memcmp(buffer + i, buffer + j, k) > 0\00", align 1
@.str6 = private unnamed_addr constant [38 x i8] c"memcmp(buffer + i, buffer + j, k) < 0\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z5resetPh(i8* nocapture %buffer) #0 {
vector.ph:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %broadcast.splatinsert = insertelement <2 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <2 x i64> %broadcast.splatinsert, <2 x i64> undef, <2 x i32> zeroinitializer
  %0 = add <2 x i64> %broadcast.splat, <i64 1, i64 2>
  %1 = getelementptr inbounds i8* %buffer, i64 %index
  %2 = trunc <2 x i64> %0 to <2 x i8>
  %3 = bitcast i8* %1 to <2 x i8>*
  store <2 x i8> %2, <2 x i8>* %3, align 1
  %index.next = add i64 %index, 2
  %4 = icmp eq i64 %index.next, 48
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z4dumpPh(i8* nocapture readonly %buffer) #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %1 ]
  %2 = getelementptr inbounds i8* %buffer, i64 %indvars.iv
  %3 = load i8* %2, align 1, !tbaa !4
  %4 = zext i8 %3 to i32
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i32 %4) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 47
  br i1 %exitcond, label %6, label %1

; <label>:6                                       ; preds = %1
  %7 = getelementptr inbounds i8* %buffer, i64 47
  %8 = load i8* %7, align 1, !tbaa !4
  %9 = zext i8 %8 to i32
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %9) #2
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buffer = alloca [48 x i8], align 16
  %1 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 0
  call void @llvm.lifetime.start(i64 48, i8* %1) #2
  %2 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 47
  br label %.preheader9

.preheader9:                                      ; preds = %72, %0
  %indvars.iv14 = phi i64 [ 12, %0 ], [ %indvars.iv.next15, %72 ]
  %3 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %indvars.iv14
  br label %.preheader

.preheader:                                       ; preds = %69, %.preheader9
  %indvars.iv12 = phi i64 [ 12, %.preheader9 ], [ %indvars.iv.next13, %69 ]
  %4 = trunc i64 %indvars.iv12 to i32
  %5 = trunc i64 %indvars.iv14 to i32
  %6 = icmp eq i32 %5, %4
  %7 = icmp slt i32 %5, %4
  %8 = icmp slt i32 %4, %5
  %9 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %indvars.iv12
  br label %10

; <label>:10                                      ; preds = %66, %.preheader
  %indvars.iv = phi i64 [ 1, %.preheader ], [ %indvars.iv.next, %66 ]
  br i1 %6, label %66, label %11

; <label>:11                                      ; preds = %10
  %12 = add nsw i64 %indvars.iv, %indvars.iv14
  %13 = trunc i64 %12 to i32
  %14 = icmp sgt i32 %13, %4
  %or.cond = and i1 %7, %14
  br i1 %or.cond, label %66, label %15

; <label>:15                                      ; preds = %11
  %16 = add nsw i64 %indvars.iv, %indvars.iv12
  %17 = trunc i64 %16 to i32
  %18 = icmp sgt i32 %17, %5
  %or.cond3 = and i1 %8, %18
  br i1 %or.cond3, label %66, label %vector.ph

vector.ph:                                        ; preds = %15
  %19 = trunc i64 %indvars.iv to i32
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str2, i64 0, i64 0), i32 %5, i32 %4, i32 %19) #2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %broadcast.splatinsert = insertelement <2 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <2 x i64> %broadcast.splatinsert, <2 x i64> undef, <2 x i32> zeroinitializer
  %21 = add <2 x i64> %broadcast.splat, <i64 1, i64 2>
  %22 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %index
  %23 = trunc <2 x i64> %21 to <2 x i8>
  %24 = bitcast i8* %22 to <2 x i8>*
  store <2 x i8> %23, <2 x i8>* %24, align 2
  %index.next = add i64 %index, 2
  %25 = icmp eq i64 %index.next, 48
  br i1 %25, label %_Z5resetPh.exit, label %vector.body, !llvm.loop !7

_Z5resetPh.exit:                                  ; preds = %vector.body
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %9, i64 %indvars.iv, i32 1, i1 false)
  br label %26

; <label>:26                                      ; preds = %26, %_Z5resetPh.exit
  %indvars.iv.i4 = phi i64 [ 0, %_Z5resetPh.exit ], [ %indvars.iv.next.i5, %26 ]
  %27 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %indvars.iv.i4
  %28 = load i8* %27, align 1, !tbaa !4
  %29 = zext i8 %28 to i32
  %30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i32 %29) #2
  %indvars.iv.next.i5 = add nuw nsw i64 %indvars.iv.i4, 1
  %exitcond.i6 = icmp eq i64 %indvars.iv.next.i5, 47
  br i1 %exitcond.i6, label %_Z4dumpPh.exit, label %26

_Z4dumpPh.exit:                                   ; preds = %26
  %31 = load i8* %2, align 1, !tbaa !4
  %32 = zext i8 %31 to i32
  %33 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %32) #2
  %34 = call i32 @memcmp(i8* %3, i8* %9, i64 %indvars.iv) #5
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %37, label %36

; <label>:36                                      ; preds = %_Z4dumpPh.exit
  tail call void @__assert_fail(i8* getelementptr inbounds ([39 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8]* @.str4, i64 0, i64 0), i32 25, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:37                                      ; preds = %_Z4dumpPh.exit
  %38 = sdiv i32 %19, 2
  %39 = add nsw i32 %38, %5
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %40
  %42 = load i8* %41, align 1, !tbaa !4
  %43 = add i8 %42, 1
  store i8 %43, i8* %41, align 1, !tbaa !4
  %44 = icmp eq i8 %43, 0
  %45 = call i32 @memcmp(i8* %3, i8* %9, i64 %indvars.iv) #5
  br i1 %44, label %49, label %46

; <label>:46                                      ; preds = %37
  %47 = icmp sgt i32 %45, 0
  br i1 %47, label %52, label %48

; <label>:48                                      ; preds = %46
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8]* @.str4, i64 0, i64 0), i32 28, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:49                                      ; preds = %37
  %50 = icmp slt i32 %45, 0
  br i1 %50, label %52, label %51

; <label>:51                                      ; preds = %49
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8]* @.str4, i64 0, i64 0), i32 30, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:52                                      ; preds = %49, %46
  store i8 %42, i8* %41, align 1, !tbaa !4
  %53 = add nsw i32 %38, %4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %54
  %56 = load i8* %55, align 1, !tbaa !4
  %57 = add i8 %56, 1
  store i8 %57, i8* %55, align 1, !tbaa !4
  %58 = icmp eq i8 %57, 0
  %59 = call i32 @memcmp(i8* %3, i8* %9, i64 %indvars.iv) #5
  br i1 %58, label %63, label %60

; <label>:60                                      ; preds = %52
  %61 = icmp slt i32 %59, 0
  br i1 %61, label %66, label %62

; <label>:62                                      ; preds = %60
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8]* @.str4, i64 0, i64 0), i32 35, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:63                                      ; preds = %52
  %64 = icmp sgt i32 %59, 0
  br i1 %64, label %66, label %65

; <label>:65                                      ; preds = %63
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8]* @.str4, i64 0, i64 0), i32 37, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:66                                      ; preds = %63, %60, %15, %11, %10
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %67 = trunc i64 %indvars.iv.next to i32
  %68 = icmp slt i32 %67, 12
  br i1 %68, label %10, label %69

; <label>:69                                      ; preds = %66
  %indvars.iv.next13 = add nuw nsw i64 %indvars.iv12, 1
  %70 = trunc i64 %indvars.iv.next13 to i32
  %71 = icmp slt i32 %70, 36
  br i1 %71, label %.preheader, label %72

; <label>:72                                      ; preds = %69
  %indvars.iv.next15 = add nuw nsw i64 %indvars.iv14, 1
  %73 = trunc i64 %indvars.iv.next15 to i32
  %74 = icmp slt i32 %73, 36
  br i1 %74, label %.preheader9, label %75

; <label>:75                                      ; preds = %72
  call void @llvm.lifetime.end(i64 48, i8* %1) #2
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: nounwind readonly
declare i32 @memcmp(i8* nocapture, i8* nocapture, i64) #3

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !1, metadata !2, metadata !3}
!2 = metadata !{metadata !"llvm.loop.vectorize.width", i32 1}
!3 = metadata !{metadata !"llvm.loop.interleave.count", i32 1}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !7, metadata !2, metadata !3}
