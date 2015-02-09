; ModuleID = 'test_static_variable.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.DATA = type { i32 }

@_ZZ7GetDatavE4data = internal global %struct.DATA zeroinitializer, align 4
@_ZGVZ7GetDatavE4data = internal global i64 0
@.str = private unnamed_addr constant [9 x i8] c"value:%i\00", align 1

; Function Attrs: nounwind uwtable
define %struct.DATA* @_Z7GetDatav() #0 {
  %1 = load atomic i8* bitcast (i64* @_ZGVZ7GetDatavE4data to i8*) acquire, align 8
  %2 = icmp eq i8 %1, 0
  br i1 %2, label %3, label %7

; <label>:3                                       ; preds = %0
  %4 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZ7GetDatavE4data) #1
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %7, label %6

; <label>:6                                       ; preds = %3
  store i32 0, i32* getelementptr inbounds (%struct.DATA* @_ZZ7GetDatavE4data, i64 0, i32 0), align 4, !tbaa !1
  tail call void @__cxa_guard_release(i64* @_ZGVZ7GetDatavE4data) #1
  br label %7

; <label>:7                                       ; preds = %6, %3, %0
  ret %struct.DATA* @_ZZ7GetDatavE4data
}

; Function Attrs: nounwind
declare i32 @__cxa_guard_acquire(i64*) #1

; Function Attrs: nounwind
declare void @__cxa_guard_release(i64*) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = load atomic i8* bitcast (i64* @_ZGVZ7GetDatavE4data to i8*) acquire, align 8
  %2 = icmp eq i8 %1, 0
  br i1 %2, label %3, label %_Z7GetDatav.exit

; <label>:3                                       ; preds = %0
  %4 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZ7GetDatavE4data) #1
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %_Z7GetDatav.exit, label %6

; <label>:6                                       ; preds = %3
  store i32 0, i32* getelementptr inbounds (%struct.DATA* @_ZZ7GetDatavE4data, i64 0, i32 0), align 4, !tbaa !1
  tail call void @__cxa_guard_release(i64* @_ZGVZ7GetDatavE4data) #1
  br label %_Z7GetDatav.exit

_Z7GetDatav.exit:                                 ; preds = %6, %3, %0
  store i32 10, i32* getelementptr inbounds (%struct.DATA* @_ZZ7GetDatavE4data, i64 0, i32 0), align 4, !tbaa !1
  %7 = load atomic i8* bitcast (i64* @_ZGVZ7GetDatavE4data to i8*) acquire, align 8
  %8 = icmp eq i8 %7, 0
  br i1 %8, label %9, label %_Z7GetDatav.exit1

; <label>:9                                       ; preds = %_Z7GetDatav.exit
  %10 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZ7GetDatavE4data) #1
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %_Z7GetDatav.exit1, label %12

; <label>:12                                      ; preds = %9
  store i32 0, i32* getelementptr inbounds (%struct.DATA* @_ZZ7GetDatavE4data, i64 0, i32 0), align 4, !tbaa !1
  tail call void @__cxa_guard_release(i64* @_ZGVZ7GetDatavE4data) #1
  br label %_Z7GetDatav.exit1

_Z7GetDatav.exit1:                                ; preds = %12, %9, %_Z7GetDatav.exit
  %13 = load i32* getelementptr inbounds (%struct.DATA* @_ZZ7GetDatavE4data, i64 0, i32 0), align 4, !tbaa !1
  %14 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %13) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS4DATA", metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
