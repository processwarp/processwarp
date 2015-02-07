; ModuleID = 'test_stdvec.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<S, std::allocator<S> >::_Vector_impl" }
%"struct.std::_Vector_base<S, std::allocator<S> >::_Vector_impl" = type { %struct.S*, %struct.S*, %struct.S* }
%struct.S = type { i32, float }

@.str = private unnamed_addr constant [9 x i8] c"%d:%.2f\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z3fooif(i32 %a, float %b) #0 {
  %1 = fpext float %b to double
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %a, double %1)
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #2 {
  %ar = alloca %"class.std::vector", align 8
  %s = alloca i64, align 8
  %tmpcast = bitcast i64* %s to %struct.S*
  %1 = bitcast %"class.std::vector"* %ar to i8*
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 24, i32 8, i1 false) #4
  %2 = bitcast i64* %s to i32*
  store i32 789, i32* %2, align 8, !tbaa !1
  %3 = getelementptr inbounds %struct.S* %tmpcast, i64 0, i32 1
  store float 0x405EDD2F20000000, float* %3, align 4, !tbaa !7
  %4 = getelementptr inbounds %"class.std::vector"* %ar, i64 0, i32 0, i32 0, i32 1
  invoke void @_ZNSt6vectorI1SSaIS0_EE19_M_emplace_back_auxIJRKS0_EEEvDpOT_(%"class.std::vector"* %ar, %struct.S* %tmpcast)
          to label %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit unwind label %33

_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit:     ; preds = %0
  %5 = getelementptr inbounds %"class.std::vector"* %ar, i64 0, i32 0, i32 0, i32 2
  %.pre = load %struct.S** %4, align 8, !tbaa !8
  %.pre6 = load %struct.S** %5, align 8, !tbaa !12
  store i32 0, i32* %2, align 8, !tbaa !1
  store float 0x4059066660000000, float* %3, align 4, !tbaa !7
  %6 = icmp eq %struct.S* %.pre, %.pre6
  br i1 %6, label %14, label %7

; <label>:7                                       ; preds = %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit
  %8 = icmp eq %struct.S* %.pre, null
  br i1 %8, label %_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit.i2, label %9

; <label>:9                                       ; preds = %7
  %10 = bitcast %struct.S* %.pre to i64*
  %11 = load i64* %s, align 8
  store i64 %11, i64* %10, align 4
  br label %_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit.i2

_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit.i2: ; preds = %9, %7
  %12 = phi %struct.S* [ null, %7 ], [ %.pre, %9 ]
  %13 = getelementptr inbounds %struct.S* %12, i64 1
  store %struct.S* %13, %struct.S** %4, align 8, !tbaa !8
  br label %15

; <label>:14                                      ; preds = %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit
  invoke void @_ZNSt6vectorI1SSaIS0_EE19_M_emplace_back_auxIJRKS0_EEEvDpOT_(%"class.std::vector"* %ar, %struct.S* %tmpcast)
          to label %15 unwind label %33

; <label>:15                                      ; preds = %14, %_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit.i2
  %16 = getelementptr inbounds %"class.std::vector"* %ar, i64 0, i32 0, i32 0, i32 0
  %17 = load %struct.S** %16, align 8, !tbaa !13
  %18 = getelementptr inbounds %struct.S* %17, i64 0, i32 0
  %19 = load i32* %18, align 4, !tbaa !1
  %20 = getelementptr inbounds %struct.S* %17, i64 0, i32 1
  %21 = load float* %20, align 4, !tbaa !7
  %22 = fpext float %21 to double
  %23 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %19, double %22) #4
  %24 = getelementptr inbounds %struct.S* %17, i64 1, i32 0
  %25 = load i32* %24, align 4, !tbaa !1
  %26 = getelementptr inbounds %struct.S* %17, i64 1, i32 1
  %27 = load float* %26, align 4, !tbaa !7
  %28 = fpext float %27 to double
  %29 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %25, double %28) #4
  %30 = icmp eq %struct.S* %17, null
  br i1 %30, label %_ZNSt6vectorI1SSaIS0_EED2Ev.exit5, label %31

; <label>:31                                      ; preds = %15
  %32 = bitcast %struct.S* %17 to i8*
  tail call void @_ZdlPv(i8* %32) #4
  br label %_ZNSt6vectorI1SSaIS0_EED2Ev.exit5

_ZNSt6vectorI1SSaIS0_EED2Ev.exit5:                ; preds = %31, %15
  ret i32 0

; <label>:33                                      ; preds = %14, %0
  %34 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %35 = getelementptr inbounds %"class.std::vector"* %ar, i64 0, i32 0, i32 0, i32 0
  %36 = load %struct.S** %35, align 8, !tbaa !13
  %37 = icmp eq %struct.S* %36, null
  br i1 %37, label %_ZNSt6vectorI1SSaIS0_EED2Ev.exit, label %38

; <label>:38                                      ; preds = %33
  %39 = bitcast %struct.S* %36 to i8*
  tail call void @_ZdlPv(i8* %39) #4
  br label %_ZNSt6vectorI1SSaIS0_EED2Ev.exit

_ZNSt6vectorI1SSaIS0_EED2Ev.exit:                 ; preds = %38, %33
  resume { i8*, i32 } %34
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: uwtable
define linkonce_odr void @_ZNSt6vectorI1SSaIS0_EE19_M_emplace_back_auxIJRKS0_EEEvDpOT_(%"class.std::vector"* nocapture %this, %struct.S* nocapture readonly %__args) #2 align 2 {
_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit:
  %0 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 1
  %1 = load %struct.S** %0, align 8, !tbaa !8
  %2 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 0
  %3 = load %struct.S** %2, align 8, !tbaa !13
  %4 = ptrtoint %struct.S* %1 to i64
  %5 = ptrtoint %struct.S* %3 to i64
  %6 = sub i64 %4, %5
  %7 = ashr exact i64 %6, 3
  %8 = icmp eq i64 %7, 0
  %9 = select i1 %8, i64 1, i64 %7
  %uadd.i = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %7, i64 %9)
  %10 = extractvalue { i64, i1 } %uadd.i, 0
  %11 = extractvalue { i64, i1 } %uadd.i, 1
  %12 = icmp ugt i64 %10, 2305843009213693951
  %or.cond.i = or i1 %11, %12
  %13 = select i1 %or.cond.i, i64 2305843009213693951, i64 %10
  %14 = icmp eq i64 %13, 0
  br i1 %14, label %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit, label %15

; <label>:15                                      ; preds = %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit
  %16 = icmp ugt i64 %13, 2305843009213693951
  br i1 %16, label %17, label %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i

; <label>:17                                      ; preds = %15
  tail call void @_ZSt17__throw_bad_allocv() #8
  unreachable

_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i: ; preds = %15
  %18 = shl i64 %13, 3
  %19 = tail call noalias i8* @_Znwm(i64 %18)
  %20 = bitcast i8* %19 to %struct.S*
  %.pre = load %struct.S** %0, align 8, !tbaa !8
  %.pre2 = load %struct.S** %2, align 8, !tbaa !13
  br label %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit

_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit: ; preds = %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i, %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit
  %21 = phi %struct.S* [ %.pre2, %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i ], [ %3, %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit ]
  %22 = phi %struct.S* [ %.pre, %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i ], [ %1, %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit ]
  %23 = phi %struct.S* [ %20, %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i ], [ null, %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit ]
  %24 = ptrtoint %struct.S* %22 to i64
  %25 = ptrtoint %struct.S* %21 to i64
  %26 = sub i64 %24, %25
  %27 = ashr exact i64 %26, 3
  %28 = getelementptr inbounds %struct.S* %23, i64 %27
  %29 = icmp eq %struct.S* %28, null
  br i1 %29, label %_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit, label %30

; <label>:30                                      ; preds = %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit
  %31 = bitcast %struct.S* %__args to i64*
  %32 = bitcast %struct.S* %28 to i64*
  %33 = load i64* %31, align 4
  store i64 %33, i64* %32, align 4
  br label %_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit

_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit: ; preds = %30, %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit
  %34 = icmp eq i64 %27, 0
  br i1 %34, label %38, label %35

; <label>:35                                      ; preds = %_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit
  %36 = bitcast %struct.S* %23 to i8*
  %37 = bitcast %struct.S* %21 to i8*
  tail call void @llvm.memmove.p0i8.p0i8.i64(i8* %36, i8* %37, i64 %26, i32 4, i1 false) #4
  br label %38

; <label>:38                                      ; preds = %35, %_ZNSt16allocator_traitsISaI1SEE9constructIS0_JRKS0_EEEDTcl12_S_constructfp_fp0_spclsr3stdE7forwardIT0_Efp1_EEERS1_PT_DpOS6_.exit
  %.sum = add i64 %27, 1
  %39 = getelementptr inbounds %struct.S* %23, i64 %.sum
  %40 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 2
  %41 = icmp eq %struct.S* %21, null
  br i1 %41, label %_ZNSt12_Vector_baseI1SSaIS0_EE13_M_deallocateEPS0_m.exit1, label %42

; <label>:42                                      ; preds = %38
  %43 = bitcast %struct.S* %21 to i8*
  tail call void @_ZdlPv(i8* %43) #4
  br label %_ZNSt12_Vector_baseI1SSaIS0_EE13_M_deallocateEPS0_m.exit1

_ZNSt12_Vector_baseI1SSaIS0_EE13_M_deallocateEPS0_m.exit1: ; preds = %42, %38
  store %struct.S* %23, %struct.S** %2, align 8, !tbaa !13
  store %struct.S* %39, %struct.S** %0, align 8, !tbaa !8
  %44 = getelementptr inbounds %struct.S* %23, i64 %13
  store %struct.S* %44, %struct.S** %40, align 8, !tbaa !12
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #3

; Function Attrs: nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: noreturn
declare void @_ZSt17__throw_bad_allocv() #5

; Function Attrs: nobuiltin
declare noalias i8* @_Znwm(i64) #6

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #4

; Function Attrs: nounwind readnone
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #7

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readnone }
attributes #8 = { noreturn }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS1S", metadata !3, i64 0, metadata !6, i64 4}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"float", metadata !4, i64 0}
!7 = metadata !{metadata !2, metadata !6, i64 4}
!8 = metadata !{metadata !9, metadata !11, i64 8}
!9 = metadata !{metadata !"_ZTSSt12_Vector_baseI1SSaIS0_EE", metadata !10, i64 0}
!10 = metadata !{metadata !"_ZTSNSt12_Vector_baseI1SSaIS0_EE12_Vector_implE", metadata !11, i64 0, metadata !11, i64 8, metadata !11, i64 16}
!11 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!12 = metadata !{metadata !9, metadata !11, i64 16}
!13 = metadata !{metadata !9, metadata !11, i64 0}
