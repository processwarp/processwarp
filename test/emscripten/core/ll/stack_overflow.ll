; ModuleID = 'stack_overflow.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"act     %d\0A\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"recurse %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @act(i32* nocapture readonly %a) #0 {
  %1 = load volatile i32* %a, align 4, !tbaa !1
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i32 %1) #2
  %3 = load volatile i32* %a, align 4, !tbaa !1
  %4 = sext i32 %3 to i64
  %5 = alloca i8, i64 %4, align 1
  %6 = ptrtoint i8* %5 to i64
  %7 = trunc i64 %6 to i32
  %8 = load volatile i32* %a, align 4, !tbaa !1
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %13

; <label>:10                                      ; preds = %0
  %11 = getelementptr inbounds i32* %a, i64 -1
  %12 = load volatile i32* %a, align 4, !tbaa !1
  br label %13

; <label>:13                                      ; preds = %10, %0
  %.0 = phi i32* [ %11, %10 ], [ %a, %0 ]
  %14 = load volatile i32* %.0, align 4, !tbaa !1
  call void @recurse(i32 %14)
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define void @recurse(i32 %x) #0 {
  %a = alloca i32, align 4
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 %x) #2
  store volatile i32 %x, i32* %a, align 4, !tbaa !1
  %2 = mul nsw i32 %x, %x
  %3 = icmp slt i32 %2, %x
  br i1 %3, label %4, label %9

; <label>:4                                       ; preds = %0
  call void @act(i32* %a)
  %5 = load volatile i32* %a, align 4, !tbaa !1
  %6 = icmp slt i32 %5, %x
  br i1 %6, label %7, label %13

; <label>:7                                       ; preds = %4
  %8 = load volatile i32* %a, align 4, !tbaa !1
  br label %13

; <label>:9                                       ; preds = %0
  %10 = icmp sgt i32 %x, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %9
  %12 = add nsw i32 %x, -1
  tail call void @recurse(i32 %12)
  br label %13

; <label>:13                                      ; preds = %11, %9, %7, %4
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %a.i = alloca i32, align 4
  %1 = bitcast i32* %a.i to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1) #2
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0), i32 1000000) #2
  store volatile i32 1000000, i32* %a.i, align 4, !tbaa !1
  call void @act(i32* %a.i) #2
  %3 = load volatile i32* %a.i, align 4, !tbaa !1
  %4 = icmp slt i32 %3, 1000000
  br i1 %4, label %5, label %recurse.exit

; <label>:5                                       ; preds = %0
  %6 = load volatile i32* %a.i, align 4, !tbaa !1
  br label %recurse.exit

recurse.exit:                                     ; preds = %5, %0
  call void @llvm.lifetime.end(i64 4, i8* %1) #2
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
