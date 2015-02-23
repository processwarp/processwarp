; ModuleID = 'test_memcpy_memcmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"%2d,\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str2 = private unnamed_addr constant [12 x i8] c"[%d,%d,%d] \00", align 1
@.str3 = private unnamed_addr constant [39 x i8] c"memcmp(buffer + i, buffer + j, k) == 0\00", align 1
@.str4 = private unnamed_addr constant [21 x i8] c"test_memcpy_memcmp.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str5 = private unnamed_addr constant [38 x i8] c"memcmp(buffer + i, buffer + j, k) > 0\00", align 1
@.str6 = private unnamed_addr constant [38 x i8] c"memcmp(buffer + i, buffer + j, k) < 0\00", align 1

; Function Attrs: nounwind uwtable
define void @reset(i8* nocapture %buffer) #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %1 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %2 = getelementptr inbounds i8* %buffer, i64 %indvars.iv
  %3 = trunc i64 %indvars.iv.next to i8
  store i8 %3, i8* %2, align 1, !tbaa !1
  %exitcond = icmp eq i64 %indvars.iv.next, 48
  br i1 %exitcond, label %4, label %1

; <label>:4                                       ; preds = %1
  ret void
}

; Function Attrs: nounwind uwtable
define void @dump(i8* nocapture readonly %buffer) #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %1 ]
  %2 = getelementptr inbounds i8* %buffer, i64 %indvars.iv
  %3 = load i8* %2, align 1, !tbaa !1
  %4 = zext i8 %3 to i32
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i32 %4) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 47
  br i1 %exitcond, label %6, label %1

; <label>:6                                       ; preds = %1
  %7 = getelementptr inbounds i8* %buffer, i64 47
  %8 = load i8* %7, align 1, !tbaa !1
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

.preheader9:                                      ; preds = %71, %0
  %indvars.iv14 = phi i64 [ 12, %0 ], [ %indvars.iv.next15, %71 ]
  %3 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %indvars.iv14
  br label %.preheader

.preheader:                                       ; preds = %68, %.preheader9
  %indvars.iv12 = phi i64 [ 12, %.preheader9 ], [ %indvars.iv.next13, %68 ]
  %4 = trunc i64 %indvars.iv12 to i32
  %5 = trunc i64 %indvars.iv14 to i32
  %6 = icmp eq i32 %5, %4
  %7 = icmp slt i32 %5, %4
  %8 = icmp slt i32 %4, %5
  %9 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %indvars.iv12
  br label %10

; <label>:10                                      ; preds = %65, %.preheader
  %indvars.iv = phi i64 [ 1, %.preheader ], [ %indvars.iv.next, %65 ]
  br i1 %6, label %65, label %11

; <label>:11                                      ; preds = %10
  %12 = add nsw i64 %indvars.iv, %indvars.iv14
  %13 = trunc i64 %12 to i32
  %14 = icmp sgt i32 %13, %4
  %or.cond = and i1 %7, %14
  br i1 %or.cond, label %65, label %15

; <label>:15                                      ; preds = %11
  %16 = add nsw i64 %indvars.iv, %indvars.iv12
  %17 = trunc i64 %16 to i32
  %18 = icmp sgt i32 %17, %5
  %or.cond3 = and i1 %8, %18
  br i1 %or.cond3, label %65, label %19

; <label>:19                                      ; preds = %15
  %20 = trunc i64 %indvars.iv to i32
  %21 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str2, i64 0, i64 0), i32 %5, i32 %4, i32 %20) #2
  br label %22

; <label>:22                                      ; preds = %22, %19
  %indvars.iv.i = phi i64 [ 0, %19 ], [ %indvars.iv.next.i, %22 ]
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %23 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %indvars.iv.i
  %24 = trunc i64 %indvars.iv.next.i to i8
  store i8 %24, i8* %23, align 1, !tbaa !1
  %exitcond.i = icmp eq i64 %indvars.iv.next.i, 48
  br i1 %exitcond.i, label %reset.exit, label %22

reset.exit:                                       ; preds = %22
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %9, i64 %indvars.iv, i32 1, i1 false)
  br label %25

; <label>:25                                      ; preds = %25, %reset.exit
  %indvars.iv.i4 = phi i64 [ 0, %reset.exit ], [ %indvars.iv.next.i5, %25 ]
  %26 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %indvars.iv.i4
  %27 = load i8* %26, align 1, !tbaa !1
  %28 = zext i8 %27 to i32
  %29 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i32 %28) #2
  %indvars.iv.next.i5 = add nuw nsw i64 %indvars.iv.i4, 1
  %exitcond.i6 = icmp eq i64 %indvars.iv.next.i5, 47
  br i1 %exitcond.i6, label %dump.exit, label %25

dump.exit:                                        ; preds = %25
  %30 = load i8* %2, align 1, !tbaa !1
  %31 = zext i8 %30 to i32
  %32 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %31) #2
  %33 = call i32 @memcmp(i8* %3, i8* %9, i64 %indvars.iv) #5
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %36, label %35

; <label>:35                                      ; preds = %dump.exit
  tail call void @__assert_fail(i8* getelementptr inbounds ([39 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8]* @.str4, i64 0, i64 0), i32 25, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:36                                      ; preds = %dump.exit
  %37 = sdiv i32 %20, 2
  %38 = add nsw i32 %37, %5
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %39
  %41 = load i8* %40, align 1, !tbaa !1
  %42 = add i8 %41, 1
  store i8 %42, i8* %40, align 1, !tbaa !1
  %43 = icmp eq i8 %42, 0
  %44 = call i32 @memcmp(i8* %3, i8* %9, i64 %indvars.iv) #5
  br i1 %43, label %48, label %45

; <label>:45                                      ; preds = %36
  %46 = icmp sgt i32 %44, 0
  br i1 %46, label %51, label %47

; <label>:47                                      ; preds = %45
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8]* @.str4, i64 0, i64 0), i32 28, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:48                                      ; preds = %36
  %49 = icmp slt i32 %44, 0
  br i1 %49, label %51, label %50

; <label>:50                                      ; preds = %48
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8]* @.str4, i64 0, i64 0), i32 30, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:51                                      ; preds = %48, %45
  store i8 %41, i8* %40, align 1, !tbaa !1
  %52 = add nsw i32 %37, %4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [48 x i8]* %buffer, i64 0, i64 %53
  %55 = load i8* %54, align 1, !tbaa !1
  %56 = add i8 %55, 1
  store i8 %56, i8* %54, align 1, !tbaa !1
  %57 = icmp eq i8 %56, 0
  %58 = call i32 @memcmp(i8* %3, i8* %9, i64 %indvars.iv) #5
  br i1 %57, label %62, label %59

; <label>:59                                      ; preds = %51
  %60 = icmp slt i32 %58, 0
  br i1 %60, label %65, label %61

; <label>:61                                      ; preds = %59
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8]* @.str4, i64 0, i64 0), i32 35, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:62                                      ; preds = %51
  %63 = icmp sgt i32 %58, 0
  br i1 %63, label %65, label %64

; <label>:64                                      ; preds = %62
  tail call void @__assert_fail(i8* getelementptr inbounds ([38 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8]* @.str4, i64 0, i64 0), i32 37, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #6
  unreachable

; <label>:65                                      ; preds = %62, %59, %15, %11, %10
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %66 = trunc i64 %indvars.iv.next to i32
  %67 = icmp slt i32 %66, 12
  br i1 %67, label %10, label %68

; <label>:68                                      ; preds = %65
  %indvars.iv.next13 = add nuw nsw i64 %indvars.iv12, 1
  %69 = trunc i64 %indvars.iv.next13 to i32
  %70 = icmp slt i32 %69, 36
  br i1 %70, label %.preheader, label %71

; <label>:71                                      ; preds = %68
  %indvars.iv.next15 = add nuw nsw i64 %indvars.iv14, 1
  %72 = trunc i64 %indvars.iv.next15 to i32
  %73 = icmp slt i32 %72, 36
  br i1 %73, label %.preheader9, label %74

; <label>:74                                      ; preds = %71
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
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
