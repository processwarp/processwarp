; ModuleID = 'test_statics.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.XYZ = type { float, float, float }

@func = global i8* (i8*, i8*)* null, align 8
@_ZZ8conoutfvPKcE3buf = internal global [32 x i8] zeroinitializer, align 16
@.str = private unnamed_addr constant [12 x i8] c"*staticccz*\00", align 1
@.str1 = private unnamed_addr constant [18 x i8] c"*%.2f,%.2f,%.2f*\0A\00", align 1
@_ZZN1S11getIdentityEvE2iT = linkonce_odr global %struct.XYZ zeroinitializer, align 4
@_ZGVZN1S11getIdentityEvE2iT = linkonce_odr global i64 0
@_ZZN3XYZ11getIdentityEvE2iT = linkonce_odr global %struct.XYZ zeroinitializer, align 4
@_ZGVZN3XYZ11getIdentityEvE2iT = linkonce_odr global i64 0

; Function Attrs: nounwind uwtable
define void @_Z8conoutfvPKc(i8* %fmt) #0 {
  %1 = load i8* (i8*, i8*)** @func, align 8, !tbaa !1
  %2 = tail call i8* %1(i8* getelementptr inbounds ([32 x i8]* @_ZZ8conoutfvPKcE3buf, i64 0, i64 0), i8* %fmt) #2
  %3 = tail call i32 @puts(i8* getelementptr inbounds ([32 x i8]* @_ZZ8conoutfvPKcE3buf, i64 0, i64 0)) #2
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store i8* (i8*, i8*)* @strcpy, i8* (i8*, i8*)** @func, align 8, !tbaa !1
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([32 x i8]* @_ZZ8conoutfvPKcE3buf, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i64 12, i32 1, i1 false)
  %1 = tail call i32 @puts(i8* getelementptr inbounds ([32 x i8]* @_ZZ8conoutfvPKcE3buf, i64 0, i64 0)) #2
  %2 = load atomic i8* bitcast (i64* @_ZGVZN1S11getIdentityEvE2iT to i8*) acquire, align 8
  %3 = icmp eq i8 %2, 0
  br i1 %3, label %4, label %_ZN1S11getIdentityEv.exit

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZN1S11getIdentityEvE2iT) #2
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %_ZN1S11getIdentityEv.exit, label %7

; <label>:7                                       ; preds = %4
  %8 = load atomic i8* bitcast (i64* @_ZGVZN3XYZ11getIdentityEvE2iT to i8*) acquire, align 8
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %10, label %_ZN3XYZ11getIdentityEv.exit.i

; <label>:10                                      ; preds = %7
  %11 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZN3XYZ11getIdentityEvE2iT) #2
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %_ZN3XYZ11getIdentityEv.exit.i, label %13

; <label>:13                                      ; preds = %10
  store float 1.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 0), align 4, !tbaa !5
  store float 2.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 1), align 4, !tbaa !8
  store float 3.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 2), align 4, !tbaa !9
  tail call void @__cxa_guard_release(i64* @_ZGVZN3XYZ11getIdentityEvE2iT) #2
  br label %_ZN3XYZ11getIdentityEv.exit.i

_ZN3XYZ11getIdentityEv.exit.i:                    ; preds = %13, %10, %7
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT to i8*), i8* bitcast (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT to i8*), i64 12, i32 4, i1 false) #2, !tbaa.struct !10
  %14 = tail call {}* @llvm.invariant.start(i64 12, i8* bitcast (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT to i8*)) #2
  tail call void @__cxa_guard_release(i64* @_ZGVZN1S11getIdentityEvE2iT) #2
  br label %_ZN1S11getIdentityEv.exit

_ZN1S11getIdentityEv.exit:                        ; preds = %_ZN3XYZ11getIdentityEv.exit.i, %4, %0
  %15 = load float* getelementptr inbounds (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT, i64 0, i32 0), align 4, !tbaa !5
  %16 = fpext float %15 to double
  %17 = load atomic i8* bitcast (i64* @_ZGVZN1S11getIdentityEvE2iT to i8*) acquire, align 8
  %18 = icmp eq i8 %17, 0
  br i1 %18, label %19, label %_ZN1S11getIdentityEv.exit2

; <label>:19                                      ; preds = %_ZN1S11getIdentityEv.exit
  %20 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZN1S11getIdentityEvE2iT) #2
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %_ZN1S11getIdentityEv.exit2, label %22

; <label>:22                                      ; preds = %19
  %23 = load atomic i8* bitcast (i64* @_ZGVZN3XYZ11getIdentityEvE2iT to i8*) acquire, align 8
  %24 = icmp eq i8 %23, 0
  br i1 %24, label %25, label %_ZN3XYZ11getIdentityEv.exit.i1

; <label>:25                                      ; preds = %22
  %26 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZN3XYZ11getIdentityEvE2iT) #2
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %_ZN3XYZ11getIdentityEv.exit.i1, label %28

; <label>:28                                      ; preds = %25
  store float 1.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 0), align 4, !tbaa !5
  store float 2.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 1), align 4, !tbaa !8
  store float 3.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 2), align 4, !tbaa !9
  tail call void @__cxa_guard_release(i64* @_ZGVZN3XYZ11getIdentityEvE2iT) #2
  br label %_ZN3XYZ11getIdentityEv.exit.i1

_ZN3XYZ11getIdentityEv.exit.i1:                   ; preds = %28, %25, %22
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT to i8*), i8* bitcast (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT to i8*), i64 12, i32 4, i1 false) #2, !tbaa.struct !10
  %29 = tail call {}* @llvm.invariant.start(i64 12, i8* bitcast (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT to i8*)) #2
  tail call void @__cxa_guard_release(i64* @_ZGVZN1S11getIdentityEvE2iT) #2
  br label %_ZN1S11getIdentityEv.exit2

_ZN1S11getIdentityEv.exit2:                       ; preds = %_ZN3XYZ11getIdentityEv.exit.i1, %19, %_ZN1S11getIdentityEv.exit
  %30 = load float* getelementptr inbounds (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT, i64 0, i32 1), align 4, !tbaa !8
  %31 = fpext float %30 to double
  %32 = load atomic i8* bitcast (i64* @_ZGVZN1S11getIdentityEvE2iT to i8*) acquire, align 8
  %33 = icmp eq i8 %32, 0
  br i1 %33, label %34, label %_ZN1S11getIdentityEv.exit4

; <label>:34                                      ; preds = %_ZN1S11getIdentityEv.exit2
  %35 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZN1S11getIdentityEvE2iT) #2
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %_ZN1S11getIdentityEv.exit4, label %37

; <label>:37                                      ; preds = %34
  %38 = load atomic i8* bitcast (i64* @_ZGVZN3XYZ11getIdentityEvE2iT to i8*) acquire, align 8
  %39 = icmp eq i8 %38, 0
  br i1 %39, label %40, label %_ZN3XYZ11getIdentityEv.exit.i3

; <label>:40                                      ; preds = %37
  %41 = tail call i32 @__cxa_guard_acquire(i64* @_ZGVZN3XYZ11getIdentityEvE2iT) #2
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %_ZN3XYZ11getIdentityEv.exit.i3, label %43

; <label>:43                                      ; preds = %40
  store float 1.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 0), align 4, !tbaa !5
  store float 2.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 1), align 4, !tbaa !8
  store float 3.000000e+00, float* getelementptr inbounds (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT, i64 0, i32 2), align 4, !tbaa !9
  tail call void @__cxa_guard_release(i64* @_ZGVZN3XYZ11getIdentityEvE2iT) #2
  br label %_ZN3XYZ11getIdentityEv.exit.i3

_ZN3XYZ11getIdentityEv.exit.i3:                   ; preds = %43, %40, %37
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT to i8*), i8* bitcast (%struct.XYZ* @_ZZN3XYZ11getIdentityEvE2iT to i8*), i64 12, i32 4, i1 false) #2, !tbaa.struct !10
  %44 = tail call {}* @llvm.invariant.start(i64 12, i8* bitcast (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT to i8*)) #2
  tail call void @__cxa_guard_release(i64* @_ZGVZN1S11getIdentityEvE2iT) #2
  br label %_ZN1S11getIdentityEv.exit4

_ZN1S11getIdentityEv.exit4:                       ; preds = %_ZN3XYZ11getIdentityEv.exit.i3, %34, %_ZN1S11getIdentityEv.exit2
  %45 = load float* getelementptr inbounds (%struct.XYZ* @_ZZN1S11getIdentityEvE2iT, i64 0, i32 2), align 4, !tbaa !9
  %46 = fpext float %45 to double
  %47 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), double %16, double %31, double %46) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8* nocapture readonly) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @__cxa_guard_acquire(i64*) #2

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: nounwind
declare {}* @llvm.invariant.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @__cxa_guard_release(i64*) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !7, i64 0}
!6 = metadata !{metadata !"_ZTS3XYZ", metadata !7, i64 0, metadata !7, i64 4, metadata !7, i64 8}
!7 = metadata !{metadata !"float", metadata !3, i64 0}
!8 = metadata !{metadata !6, metadata !7, i64 4}
!9 = metadata !{metadata !6, metadata !7, i64 8}
!10 = metadata !{i64 0, i64 4, metadata !11, i64 4, i64 4, metadata !11, i64 8, i64 4, metadata !11}
!11 = metadata !{metadata !7, metadata !7, i64 0}
