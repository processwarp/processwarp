; ModuleID = 'test_linked_list.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.worker_args = type { i32, %struct.worker_args* }

@.str = private unnamed_addr constant [9 x i8] c"*%d,%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %b = alloca %struct.worker_args, align 8
  %chunk = alloca [10 x %struct.worker_args], align 16
  %1 = getelementptr inbounds %struct.worker_args* %b, i64 0, i32 0
  store i32 900, i32* %1, align 8, !tbaa !1
  %2 = getelementptr inbounds %struct.worker_args* %b, i64 0, i32 1
  store %struct.worker_args* null, %struct.worker_args** %2, align 8, !tbaa !7
  br label %3

; <label>:3                                       ; preds = %._crit_edge, %0
  %4 = phi %struct.worker_args* [ %b, %0 ], [ %.pre6, %._crit_edge ]
  %5 = phi i32 [ 60, %0 ], [ %.pre, %._crit_edge ]
  %total.03 = phi i32 [ 0, %0 ], [ %6, %._crit_edge ]
  %6 = add nsw i32 %5, %total.03
  %7 = icmp eq %struct.worker_args* %4, null
  br i1 %7, label %8, label %._crit_edge

._crit_edge:                                      ; preds = %3
  %.phi.trans.insert = getelementptr inbounds %struct.worker_args* %4, i64 0, i32 0
  %.pre = load i32* %.phi.trans.insert, align 4, !tbaa !1
  %.phi.trans.insert5 = getelementptr inbounds %struct.worker_args* %4, i64 0, i32 1
  %.pre6 = load %struct.worker_args** %.phi.trans.insert5, align 8, !tbaa !7
  br label %3

; <label>:8                                       ; preds = %3
  %9 = bitcast [10 x %struct.worker_args]* %chunk to i8*
  call void @llvm.lifetime.start(i64 160, i8* %9) #1
  %10 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 0, i32 0
  store i32 0, i32* %10, align 16, !tbaa !1
  %11 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 1
  %12 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 0, i32 1
  store %struct.worker_args* %11, %struct.worker_args** %12, align 8, !tbaa !7
  %13 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 1, i32 0
  store i32 10, i32* %13, align 16, !tbaa !1
  %14 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 2
  %15 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 1, i32 1
  store %struct.worker_args* %14, %struct.worker_args** %15, align 8, !tbaa !7
  %16 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 2, i32 0
  store i32 20, i32* %16, align 16, !tbaa !1
  %17 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 3
  %18 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 2, i32 1
  store %struct.worker_args* %17, %struct.worker_args** %18, align 8, !tbaa !7
  %19 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 3, i32 0
  store i32 30, i32* %19, align 16, !tbaa !1
  %20 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 4
  %21 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 3, i32 1
  store %struct.worker_args* %20, %struct.worker_args** %21, align 8, !tbaa !7
  %22 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 4, i32 0
  store i32 40, i32* %22, align 16, !tbaa !1
  %23 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 5
  %24 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 4, i32 1
  store %struct.worker_args* %23, %struct.worker_args** %24, align 8, !tbaa !7
  %25 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 5, i32 0
  store i32 50, i32* %25, align 16, !tbaa !1
  %26 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 6
  %27 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 5, i32 1
  store %struct.worker_args* %26, %struct.worker_args** %27, align 8, !tbaa !7
  %28 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 6, i32 0
  store i32 60, i32* %28, align 16, !tbaa !1
  %29 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 7
  %30 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 6, i32 1
  store %struct.worker_args* %29, %struct.worker_args** %30, align 8, !tbaa !7
  %31 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 7, i32 0
  store i32 70, i32* %31, align 16, !tbaa !1
  %32 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 8
  %33 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 7, i32 1
  store %struct.worker_args* %32, %struct.worker_args** %33, align 8, !tbaa !7
  %34 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 8, i32 0
  store i32 80, i32* %34, align 16, !tbaa !1
  %35 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 9
  %36 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 8, i32 1
  store %struct.worker_args* %35, %struct.worker_args** %36, align 8, !tbaa !7
  %37 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 9, i32 0
  store i32 90, i32* %37, align 16, !tbaa !1
  %38 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 0
  %39 = getelementptr inbounds [10 x %struct.worker_args]* %chunk, i64 0, i64 9, i32 1
  store %struct.worker_args* %38, %struct.worker_args** %39, align 8, !tbaa !7
  br label %40

; <label>:40                                      ; preds = %40, %8
  %c.1 = phi %struct.worker_args* [ %38, %8 ], [ %45, %40 ]
  %total.1 = phi i32 [ %6, %8 ], [ %43, %40 ]
  %41 = getelementptr inbounds %struct.worker_args* %c.1, i64 0, i32 0
  %42 = load i32* %41, align 4, !tbaa !1
  %43 = add nsw i32 %42, %total.1
  %44 = getelementptr inbounds %struct.worker_args* %c.1, i64 0, i32 1
  %45 = load %struct.worker_args** %44, align 8, !tbaa !7
  %46 = icmp eq %struct.worker_args* %45, %38
  br i1 %46, label %47, label %40

; <label>:47                                      ; preds = %40
  %48 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %43, %struct.worker_args* null)
  call void @llvm.lifetime.end(i64 160, i8* %9) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS11worker_args", metadata !3, i64 0, metadata !6, i64 8}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!7 = metadata !{metadata !2, metadata !6, i64 8}
