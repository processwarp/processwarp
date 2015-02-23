; ModuleID = 'test_alloca.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"%p %x\0A%p %x\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca [4 x i8], align 2
  %2 = alloca [4 x i8], align 2
  %.sub1 = getelementptr inbounds [4 x i8]* %2, i64 0, i64 0
  %.sub = getelementptr inbounds [4 x i8]* %1, i64 0, i64 0
  %3 = icmp ult [4 x i8]* %1, %2
  br i1 %3, label %4, label %8

; <label>:4                                       ; preds = %0
  %5 = ptrtoint [4 x i8]* %2 to i64
  %6 = ptrtoint [4 x i8]* %1 to i64
  %7 = sub i64 %5, %6
  call void @llvm.memset.p0i8.i64(i8* %.sub, i8 1, i64 %7, i32 2, i1 false)
  %.phi.trans.insert = bitcast [4 x i8]* %1 to i16*
  %.pre = load i16* %.phi.trans.insert, align 2, !tbaa !1
  %phitmp = sext i16 %.pre to i32
  br label %12

; <label>:8                                       ; preds = %0
  %9 = ptrtoint [4 x i8]* %1 to i64
  %10 = ptrtoint [4 x i8]* %2 to i64
  %11 = sub i64 %9, %10
  call void @llvm.memset.p0i8.i64(i8* %.sub1, i8 1, i64 %11, i32 2, i1 false)
  %.phi.trans.insert2 = bitcast [4 x i8]* %2 to i16*
  %.pre3 = load i16* %.phi.trans.insert2, align 2, !tbaa !1
  %phitmp7 = sext i16 %.pre3 to i32
  br label %12

; <label>:12                                      ; preds = %8, %4
  %13 = phi i32 [ %phitmp7, %8 ], [ 0, %4 ]
  %14 = phi i32 [ 0, %8 ], [ %phitmp, %4 ]
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str, i64 0, i64 0), i8* %.sub, i32 %14, i8* %.sub1, i32 %13) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"short", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
