; ModuleID = 'test_strings.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [24 x i8] c"abc_10.b1_xyz9_543_defg\00", align 1
@.str1 = private unnamed_addr constant [24 x i8] c"abc_%d.%2x_xyz9_%3d_%3s\00", align 1
@.str2 = private unnamed_addr constant [16 x i8] c"%d:%d,%d,%d,%s\0A\00", align 1
@.str3 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str8 = private unnamed_addr constant [5 x i8] c"test\00", align 1
@.str9 = private unnamed_addr constant [12 x i8] c"one 1 ONE !\00", align 1
@.str10 = private unnamed_addr constant [12 x i8] c"two 2 TWO ?\00", align 1
@.str11 = private unnamed_addr constant [9 x i8] c"waka %s\0A\00", align 1
@.str12 = private unnamed_addr constant [28 x i8] c"string number one top notch\00", align 1
@.str13 = private unnamed_addr constant [48 x i8] c"fa la sa ho fi FI FO FUM WHEN WHERE WHY HOW WHO\00", align 1
@.str14 = private unnamed_addr constant [10 x i8] c"cat |%s|\0A\00", align 1
@.str15 = private unnamed_addr constant [15 x i8] c"returned |%s|\0A\00", align 1
@str = private unnamed_addr constant [16 x i8] c"/* a comment */\00"
@str16 = private unnamed_addr constant [11 x i8] c"// another\00"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %xx = alloca i32, align 4
  %yy = alloca i32, align 4
  %zz = alloca i32, align 4
  %s = alloca [32 x i8], align 16
  %three = alloca [1024 x i8], align 16
  %three3 = alloca [1000 x i8], align 16
  %1 = getelementptr inbounds [32 x i8]* %s, i64 0, i64 0
  %2 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* getelementptr inbounds ([24 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8]* @.str1, i64 0, i64 0), i32* %xx, i32* %yy, i32* %zz, i8* %1) #2
  %3 = load i32* %xx, align 4, !tbaa !1
  %4 = load i32* %yy, align 4, !tbaa !1
  %5 = load i32* %zz, align 4, !tbaa !1
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str2, i64 0, i64 0), i32 %2, i32 %3, i32 %4, i32 %5, i8* %1) #2
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i32 %argc) #2
  %8 = getelementptr inbounds i8** %argv, i64 1
  %9 = load i8** %8, align 8, !tbaa !5
  %10 = call i32 @puts(i8* %9) #2
  %11 = getelementptr inbounds i8** %argv, i64 2
  %12 = load i8** %11, align 8, !tbaa !5
  %13 = call i32 @puts(i8* %12) #2
  %14 = getelementptr inbounds i8** %argv, i64 3
  %15 = load i8** %14, align 8, !tbaa !5
  %16 = call i64 @strtol(i8* nocapture %15, i8** null, i32 10) #2
  %17 = trunc i64 %16 to i32
  %18 = add nsw i32 %17, 2
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i32 %18) #2
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i64 5) #2
  %puts = call i32 @puts(i8* null) #2
  %puts4 = call i32 @puts(i8* getelementptr inbounds ([16 x i8]* @str, i64 0, i64 0)) #2
  %puts5 = call i32 @puts(i8* getelementptr inbounds ([11 x i8]* @str16, i64 0, i64 0)) #2
  %21 = call noalias i8* @malloc(i64 5) #2
  %22 = icmp eq i8* %21, null
  br i1 %22, label %24, label %23

; <label>:23                                      ; preds = %0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %21, i8* getelementptr inbounds ([5 x i8]* @.str8, i64 0, i64 0), i64 5, i32 1, i1 false)
  br label %24

; <label>:24                                      ; preds = %23, %0
  %puts6 = call i32 @puts(i8* %21) #2
  call void @free(i8* %21) #2
  %25 = getelementptr inbounds [1024 x i8]* %three, i64 0, i64 0
  call void @llvm.lifetime.start(i64 1024, i8* %25) #2
  call void @llvm.memset.p0i8.i64(i8* %25, i8 46, i64 1024, i32 16, i1 false)
  %26 = getelementptr inbounds [1024 x i8]* %three, i64 0, i64 50
  store i8 0, i8* %26, align 2, !tbaa !7
  %27 = sext i32 %argc to i64
  %28 = getelementptr inbounds [1024 x i8]* %three, i64 0, i64 %27
  %29 = sdiv i32 %argc, 2
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [12 x i8]* @.str9, i64 0, i64 %30
  %32 = add nsw i32 %argc, 1
  %33 = sext i32 %32 to i64
  %34 = call i8* @strncpy(i8* %28, i8* %31, i64 %33) #2
  %35 = mul nsw i32 %argc, 3
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [1024 x i8]* %three, i64 0, i64 %36
  %38 = sdiv i32 %argc, 3
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [12 x i8]* @.str10, i64 0, i64 %39
  %41 = add nsw i32 %argc, 2
  %42 = sext i32 %41 to i64
  %43 = call i8* @strncpy(i8* %37, i8* %40, i64 %42) #2
  %44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str11, i64 0, i64 0), i8* %25) #2
  call void @llvm.lifetime.end(i64 1024, i8* %25) #2
  %45 = getelementptr inbounds [1000 x i8]* %three3, i64 0, i64 0
  call void @llvm.lifetime.start(i64 1000, i8* %45) #2
  %46 = shl nsw i32 %argc, 1
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [28 x i8]* @.str12, i64 0, i64 %47
  %49 = call i8* @strcpy(i8* %45, i8* %48) #2
  %50 = getelementptr inbounds [48 x i8]* @.str13, i64 0, i64 %36
  %51 = call i8* @strcat(i8* %45, i8* %50) #2
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str14, i64 0, i64 0), i8* %45) #2
  %53 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str15, i64 0, i64 0), i8* %51) #2
  call void @llvm.lifetime.end(i64 1000, i8* %45) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: nounwind
declare void @free(i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

; Function Attrs: nounwind
declare i8* @strncpy(i8*, i8* nocapture readonly, i64) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8* nocapture readonly) #1

; Function Attrs: nounwind
declare i8* @strcat(i8*, i8* nocapture readonly) #1

; Function Attrs: nounwind
declare i64 @strtol(i8* readonly, i8** nocapture, i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!7 = metadata !{metadata !3, metadata !3, i64 0}
