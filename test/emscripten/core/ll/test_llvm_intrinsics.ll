; ModuleID = 'test_llvm_intrinsics.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"%x,%x\0A\00", align 1
@.str1 = private unnamed_addr constant [13 x i8] c"%x,%x,%x,%x\0A\00", align 1
@.str2 = private unnamed_addr constant [7 x i8] c"%d,%d\0A\00", align 1
@.str3 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: uwtable
define i32 @main() #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i32 239, i32 200)
  %2 = tail call zeroext i16 @llvm_bswap_i16(i16 zeroext -14097)
  %3 = zext i16 %2 to i32
  %4 = and i32 %3, 255
  %5 = lshr i32 %3, 8
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i32 %4, i32 %5)
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 138, i32 21, i32 222, i32 197)
  %8 = tail call i32 @llvm_bswap_i32(i32 -975301238)
  %9 = and i32 %8, 255
  %10 = lshr i32 %8, 8
  %11 = and i32 %10, 255
  %12 = lshr i32 %8, 16
  %13 = and i32 %12, 255
  %14 = lshr i32 %8, 24
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %9, i32 %11, i32 %13, i32 %14)
  %16 = tail call i64 @llvm_ctlz_i64(i64 1099511627776)
  %17 = trunc i64 %16 to i32
  %18 = tail call i32 @llvm_ctlz_i32(i32 1024)
  %19 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str2, i64 0, i64 0), i32 %17, i32 %18)
  %20 = tail call i64 @llvm_cttz_i64(i64 1099511627776)
  %21 = trunc i64 %20 to i32
  %22 = tail call i32 @llvm_cttz_i32(i32 1024)
  %23 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str2, i64 0, i64 0), i32 %21, i32 %22)
  %24 = tail call i64 @llvm_ctpop_i64(i64 53880364728321)
  %25 = trunc i64 %24 to i32
  %26 = tail call i32 @llvm_ctpop_i32(i32 12545)
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str2, i64 0, i64 0), i32 %25, i32 %26)
  %28 = tail call i32 @llvm_ctpop_i32(i32 -594093059)
  %29 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i32 %28)
  %30 = urem i16 %2, 27
  %31 = zext i16 %30 to i32
  %32 = tail call i32 @llvm_expect_i32(i32 %31, i32 3)
  %33 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i32 %32)
  %34 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i64 72057594037927936)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare zeroext i16 @llvm_bswap_i16(i16 zeroext) #2

declare i32 @llvm_bswap_i32(i32) #2

declare i64 @llvm_ctlz_i64(i64) #2

declare i32 @llvm_ctlz_i32(i32) #2

declare i64 @llvm_cttz_i64(i64) #2

declare i32 @llvm_cttz_i32(i32) #2

declare i64 @llvm_ctpop_i64(i64) #2

declare i32 @llvm_ctpop_i32(i32) #2

declare i32 @llvm_expect_i32(i32, i32) #2

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
