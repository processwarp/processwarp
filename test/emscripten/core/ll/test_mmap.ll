; ModuleID = 'test_mmap.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [23 x i8] c"munmap(map, 5000) == 0\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"test_mmap.c\00", align 1
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
  tail call void @__assert_fail(i8* getelementptr inbounds ([23 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 12, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:9                                       ; preds = %1
  %10 = tail call i8* @mmap(i8* null, i64 8388608, i32 3, i32 33, i32 -1, i64 0) #3
  %11 = bitcast i8* %10 to i32*
  %12 = icmp eq i8* %10, inttoptr (i64 -1 to i8*)
  br i1 %12, label %13, label %.preheader4

; <label>:13                                      ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([21 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 20, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

.preheader4:                                      ; preds = %.preheader4, %9
  %indvars.iv7 = phi i64 [ %indvars.iv.next8, %.preheader4 ], [ 0, %9 ]
  %14 = getelementptr inbounds i32* %11, i64 %indvars.iv7
  %15 = trunc i64 %indvars.iv7 to i32
  store i32 %15, i32* %14, align 4, !tbaa !1
  %indvars.iv.next8 = add nuw nsw i64 %indvars.iv7, 1
  %exitcond = icmp eq i64 %indvars.iv.next8, 2097152
  br i1 %exitcond, label %.preheader, label %.preheader4

; <label>:16                                      ; preds = %.preheader
  %17 = trunc i64 %indvars.iv.next to i32
  %18 = icmp slt i32 %17, 2097152
  br i1 %18, label %.preheader, label %24

.preheader:                                       ; preds = %16, %.preheader4
  %indvars.iv = phi i64 [ %indvars.iv.next, %16 ], [ 0, %.preheader4 ]
  %19 = getelementptr inbounds i32* %11, i64 %indvars.iv
  %20 = load i32* %19, align 4, !tbaa !1
  %21 = trunc i64 %indvars.iv to i32
  %22 = icmp eq i32 %20, %21
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  br i1 %22, label %16, label %23

; <label>:23                                      ; preds = %.preheader
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 29, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:24                                      ; preds = %16
  %25 = tail call i32 @munmap(i8* %10, i64 8388608) #3
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %28, label %27

; <label>:27                                      ; preds = %24
  tail call void @__assert_fail(i8* getelementptr inbounds ([28 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 32, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

; <label>:28                                      ; preds = %24
  %29 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str5, i64 0, i64 0)) #3
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
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
