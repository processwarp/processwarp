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
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %a, double %1) #3
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit:
  %ar = alloca %"class.std::vector", align 8
  %s = alloca i64, align 8
  %tmpcast = bitcast i64* %s to %struct.S*
  %0 = bitcast %"class.std::vector"* %ar to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 24, i32 8, i1 false) #3
  %1 = bitcast i64* %s to i32*
  store i32 789, i32* %1, align 8, !tbaa !1
  %2 = getelementptr inbounds %struct.S* %tmpcast, i64 0, i32 1
  store float 0x405EDD2F20000000, float* %2, align 4, !tbaa !7
  %3 = getelementptr inbounds %"class.std::vector"* %ar, i64 0, i32 0, i32 0, i32 1
  %4 = getelementptr inbounds %"class.std::vector"* %ar, i64 0, i32 0, i32 0, i32 2
  call void @_ZNSt6vectorI1SSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_(%"class.std::vector"* %ar, %struct.S* null, %struct.S* %tmpcast) #3
  %.pre = load %struct.S** %3, align 8, !tbaa !8
  %.pre4 = load %struct.S** %4, align 8, !tbaa !12
  store i32 0, i32* %1, align 8, !tbaa !1
  store float 0x4059066660000000, float* %2, align 4, !tbaa !7
  %5 = icmp eq %struct.S* %.pre, %.pre4
  br i1 %5, label %13, label %6

; <label>:6                                       ; preds = %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit
  %7 = icmp eq %struct.S* %.pre, null
  br i1 %7, label %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit.i2, label %8

; <label>:8                                       ; preds = %6
  %9 = bitcast %struct.S* %.pre to i64*
  %10 = load i64* %s, align 8
  store i64 %10, i64* %9, align 4
  br label %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit.i2

_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit.i2: ; preds = %8, %6
  %11 = phi %struct.S* [ null, %6 ], [ %.pre, %8 ]
  %12 = getelementptr inbounds %struct.S* %11, i64 1
  store %struct.S* %12, %struct.S** %3, align 8, !tbaa !8
  br label %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit3

; <label>:13                                      ; preds = %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit
  call void @_ZNSt6vectorI1SSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_(%"class.std::vector"* %ar, %struct.S* %.pre4, %struct.S* %tmpcast) #3
  br label %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit3

_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit3:    ; preds = %13, %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit.i2
  %14 = getelementptr inbounds %"class.std::vector"* %ar, i64 0, i32 0, i32 0, i32 0
  %15 = load %struct.S** %14, align 8, !tbaa !13
  %16 = getelementptr inbounds %struct.S* %15, i64 0, i32 0
  %17 = load i32* %16, align 4, !tbaa !1
  %18 = getelementptr inbounds %struct.S* %15, i64 0, i32 1
  %19 = load float* %18, align 4, !tbaa !7
  %20 = fpext float %19 to double
  %21 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %17, double %20) #3
  %22 = getelementptr inbounds %struct.S* %15, i64 1, i32 0
  %23 = load i32* %22, align 4, !tbaa !1
  %24 = getelementptr inbounds %struct.S* %15, i64 1, i32 1
  %25 = load float* %24, align 4, !tbaa !7
  %26 = fpext float %25 to double
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %23, double %26) #3
  %28 = icmp eq %struct.S* %15, null
  br i1 %28, label %_ZNSt6vectorI1SSaIS0_EED2Ev.exit, label %29

; <label>:29                                      ; preds = %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit3
  %30 = bitcast %struct.S* %15 to i8*
  tail call void @_ZdlPv(i8* %30) #3
  br label %_ZNSt6vectorI1SSaIS0_EED2Ev.exit

_ZNSt6vectorI1SSaIS0_EED2Ev.exit:                 ; preds = %29, %_ZNSt6vectorI1SSaIS0_EE9push_backERKS0_.exit3
  ret i32 0
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZNSt6vectorI1SSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_(%"class.std::vector"* nocapture %this, %struct.S* %__position.coerce, %struct.S* nocapture readonly %__x) #0 align 2 {
  %1 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 1
  %2 = load %struct.S** %1, align 8, !tbaa !8
  %3 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 2
  %4 = load %struct.S** %3, align 8, !tbaa !12
  %5 = icmp eq %struct.S* %2, %4
  br i1 %5, label %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit, label %6

; <label>:6                                       ; preds = %0
  %7 = icmp eq %struct.S* %2, null
  br i1 %7, label %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit, label %8

; <label>:8                                       ; preds = %6
  %9 = getelementptr inbounds %struct.S* %2, i64 -1
  %10 = bitcast %struct.S* %9 to i64*
  %11 = bitcast %struct.S* %2 to i64*
  %12 = load i64* %10, align 4
  store i64 %12, i64* %11, align 4
  %.pre = load %struct.S** %1, align 8, !tbaa !8
  br label %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit

_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit: ; preds = %8, %6
  %13 = phi %struct.S* [ null, %6 ], [ %.pre, %8 ]
  %14 = getelementptr inbounds %struct.S* %13, i64 1
  store %struct.S* %14, %struct.S** %1, align 8, !tbaa !8
  %15 = bitcast %struct.S* %__x to i64*
  %16 = load i64* %15, align 4
  %17 = getelementptr inbounds %struct.S* %13, i64 -1
  %18 = ptrtoint %struct.S* %17 to i64
  %19 = ptrtoint %struct.S* %__position.coerce to i64
  %20 = sub i64 %18, %19
  %21 = ashr exact i64 %20, 3
  %22 = icmp eq i64 %21, 0
  br i1 %22, label %_ZSt13copy_backwardIP1SS1_ET0_T_S3_S2_.exit, label %23

; <label>:23                                      ; preds = %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit
  %.pre.i.i.i.i = sub i64 0, %21
  %.pre1.i.i.i.i = getelementptr inbounds %struct.S* %13, i64 %.pre.i.i.i.i
  %24 = bitcast %struct.S* %.pre1.i.i.i.i to i8*
  %25 = bitcast %struct.S* %__position.coerce to i8*
  tail call void @llvm.memmove.p0i8.p0i8.i64(i8* %24, i8* %25, i64 %20, i32 4, i1 false) #3
  br label %_ZSt13copy_backwardIP1SS1_ET0_T_S3_S2_.exit

_ZSt13copy_backwardIP1SS1_ET0_T_S3_S2_.exit:      ; preds = %23, %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit
  %26 = bitcast %struct.S* %__position.coerce to i64*
  store i64 %16, i64* %26, align 4
  br label %78

_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit: ; preds = %0
  %27 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 0
  %28 = load %struct.S** %27, align 8, !tbaa !13
  %29 = ptrtoint %struct.S* %2 to i64
  %30 = ptrtoint %struct.S* %28 to i64
  %31 = sub i64 %29, %30
  %32 = ashr exact i64 %31, 3
  %33 = icmp eq i64 %32, 0
  %34 = select i1 %33, i64 1, i64 %32
  %uadd.i = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %32, i64 %34) #3
  %35 = extractvalue { i64, i1 } %uadd.i, 0
  %36 = extractvalue { i64, i1 } %uadd.i, 1
  %37 = icmp ugt i64 %35, 2305843009213693951
  %or.cond.i = or i1 %36, %37
  %38 = select i1 %or.cond.i, i64 2305843009213693951, i64 %35
  %39 = ptrtoint %struct.S* %__position.coerce to i64
  %40 = sub i64 %39, %30
  %41 = ashr exact i64 %40, 3
  %42 = icmp eq i64 %38, 0
  br i1 %42, label %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit, label %43

; <label>:43                                      ; preds = %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit
  %44 = icmp ugt i64 %38, 2305843009213693951
  br i1 %44, label %45, label %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i

; <label>:45                                      ; preds = %43
  tail call void @_ZSt17__throw_bad_allocv() #7
  unreachable

_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i: ; preds = %43
  %46 = shl i64 %38, 3
  %47 = tail call noalias i8* @_Znwm(i64 %46) #3
  %48 = bitcast i8* %47 to %struct.S*
  br label %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit

_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit: ; preds = %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i, %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit
  %49 = phi %struct.S* [ %48, %_ZN9__gnu_cxx13new_allocatorI1SE8allocateEmPKv.exit.i ], [ null, %_ZNKSt6vectorI1SSaIS0_EE12_M_check_lenEmPKc.exit ]
  %50 = getelementptr inbounds %struct.S* %49, i64 %41
  %51 = icmp eq %struct.S* %50, null
  br i1 %51, label %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit2, label %52

; <label>:52                                      ; preds = %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit
  %53 = bitcast %struct.S* %__x to i64*
  %54 = bitcast %struct.S* %50 to i64*
  %55 = load i64* %53, align 4
  store i64 %55, i64* %54, align 4
  br label %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit2

_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit2: ; preds = %52, %_ZNSt12_Vector_baseI1SSaIS0_EE11_M_allocateEm.exit
  %56 = load %struct.S** %27, align 8, !tbaa !13
  %57 = ptrtoint %struct.S* %56 to i64
  %58 = sub i64 %39, %57
  %59 = ashr exact i64 %58, 3
  %60 = icmp eq i64 %59, 0
  br i1 %60, label %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit1, label %61

; <label>:61                                      ; preds = %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit2
  %62 = bitcast %struct.S* %49 to i8*
  %63 = bitcast %struct.S* %56 to i8*
  tail call void @llvm.memmove.p0i8.p0i8.i64(i8* %62, i8* %63, i64 %58, i32 4, i1 false) #3
  br label %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit1

_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit1: ; preds = %61, %_ZN9__gnu_cxx14__alloc_traitsISaI1SEE9constructIS1_EEvRS2_PS1_RKT_.exit2
  %.sum = add i64 %59, 1
  %64 = load %struct.S** %1, align 8, !tbaa !8
  %65 = ptrtoint %struct.S* %64 to i64
  %66 = sub i64 %65, %39
  %67 = ashr exact i64 %66, 3
  %68 = icmp eq i64 %67, 0
  br i1 %68, label %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit, label %69

; <label>:69                                      ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit1
  %70 = getelementptr inbounds %struct.S* %49, i64 %.sum
  %71 = bitcast %struct.S* %70 to i8*
  %72 = bitcast %struct.S* %__position.coerce to i8*
  tail call void @llvm.memmove.p0i8.p0i8.i64(i8* %71, i8* %72, i64 %66, i32 4, i1 false) #3
  br label %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit

_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit: ; preds = %69, %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit1
  %.sum3 = add i64 %67, %.sum
  %73 = getelementptr inbounds %struct.S* %49, i64 %.sum3
  %74 = icmp eq %struct.S* %56, null
  br i1 %74, label %_ZNSt12_Vector_baseI1SSaIS0_EE13_M_deallocateEPS0_m.exit, label %75

; <label>:75                                      ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit
  %76 = bitcast %struct.S* %56 to i8*
  tail call void @_ZdlPv(i8* %76) #3
  br label %_ZNSt12_Vector_baseI1SSaIS0_EE13_M_deallocateEPS0_m.exit

_ZNSt12_Vector_baseI1SSaIS0_EE13_M_deallocateEPS0_m.exit: ; preds = %75, %_ZSt34__uninitialized_move_if_noexcept_aIP1SS1_SaIS0_EET0_T_S4_S3_RT1_.exit
  store %struct.S* %49, %struct.S** %27, align 8, !tbaa !13
  store %struct.S* %73, %struct.S** %1, align 8, !tbaa !8
  %77 = getelementptr inbounds %struct.S* %49, i64 %38
  store %struct.S* %77, %struct.S** %3, align 8, !tbaa !12
  br label %78

; <label>:78                                      ; preds = %_ZNSt12_Vector_baseI1SSaIS0_EE13_M_deallocateEPS0_m.exit, %_ZSt13copy_backwardIP1SS1_ET0_T_S3_S2_.exit
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #2

; Function Attrs: nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noreturn
declare void @_ZSt17__throw_bad_allocv() #4

; Function Attrs: nobuiltin
declare noalias i8* @_Znwm(i64) #5

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #3

; Function Attrs: nounwind readnone
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #6

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nobuiltin nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone }
attributes #7 = { noreturn nounwind }

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
