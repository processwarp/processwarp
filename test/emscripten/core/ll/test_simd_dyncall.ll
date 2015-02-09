; ModuleID = 'test_simd_dyncall.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"class.std::allocator" = type { i8 }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@.str = private unnamed_addr constant [14 x i8] c"[%f,%f,%f,%f]\00", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]

; Function Attrs: noinline nounwind uwtable
define void @_Z6to_strDv4_f(%"class.std::basic_string"* noalias sret %agg.result, <4 x float> %m) #0 {
  %str = alloca [256 x i8], align 16
  %1 = alloca %"class.std::allocator", align 1
  %2 = getelementptr inbounds [256 x i8]* %str, i64 0, i64 0
  call void @llvm.lifetime.start(i64 256, i8* %2) #1
  %3 = extractelement <4 x float> %m, i32 3
  %4 = fpext float %3 to double
  %5 = extractelement <4 x float> %m, i32 2
  %6 = fpext float %5 to double
  %7 = extractelement <4 x float> %m, i32 1
  %8 = fpext float %7 to double
  %9 = extractelement <4 x float> %m, i32 0
  %10 = fpext float %9 to double
  %11 = call i32 (i8*, i8*, ...)* @sprintf(i8* %2, i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), double %4, double %6, double %8, double %10) #1
  %puts = call i32 @puts(i8* %2)
  call void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %agg.result, i8* getelementptr inbounds ([2 x i8]* @.str2, i64 0, i64 0), %"class.std::allocator"* %1) #1
  call void @llvm.lifetime.end(i64 256, i8* %2) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @sprintf(i8* nocapture, i8* nocapture readonly, ...) #2

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #3

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main() #4 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator", align 1
  %7 = alloca %"class.std::basic_string", align 8
  %8 = alloca %"class.std::basic_string", align 8
  %9 = alloca %"class.std::basic_string", align 8
  call void @_Z6to_strDv4_f(%"class.std::basic_string"* sret %7, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  call void @_Z6to_strDv4_f(%"class.std::basic_string"* sret %8, <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>)
  call void @_Z6to_strDv4_f(%"class.std::basic_string"* sret %9, <4 x float> <float 3.000000e+00, float 3.000000e+00, float 3.000000e+00, float 3.000000e+00>)
  %10 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %10) #1
  %11 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %12 = load i8** %11, align 8, !tbaa !1
  %13 = getelementptr inbounds i8* %12, i64 -24
  %14 = bitcast i8* %13 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %15 = icmp eq i8* %13, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %15, label %_ZNSsD1Ev.exit6, label %16, !prof !7

; <label>:16                                      ; preds = %0
  %17 = getelementptr inbounds i8* %12, i64 -8
  %18 = bitcast i8* %17 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %19, label %23

; <label>:19                                      ; preds = %16
  %20 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %20)
  %21 = atomicrmw volatile add i32* %18, i32 -1 acq_rel
  store i32 %21, i32* %1, align 4
  %22 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %20)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5

; <label>:23                                      ; preds = %16
  %24 = load i32* %18, align 4, !tbaa !8
  %25 = add nsw i32 %24, -1
  store i32 %25, i32* %18, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5: ; preds = %23, %19
  %.0.i.i.i.i4 = phi i32 [ %22, %19 ], [ %24, %23 ]
  %26 = icmp slt i32 %.0.i.i.i.i4, 1
  br i1 %26, label %27, label %_ZNSsD1Ev.exit6

; <label>:27                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %14, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit6

_ZNSsD1Ev.exit6:                                  ; preds = %27, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5, %0
  call void @llvm.lifetime.end(i64 1, i8* %10) #1
  %28 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %28) #1
  %29 = getelementptr inbounds %"class.std::basic_string"* %8, i64 0, i32 0, i32 0
  %30 = load i8** %29, align 8, !tbaa !1
  %31 = getelementptr inbounds i8* %30, i64 -24
  %32 = bitcast i8* %31 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %33 = icmp eq i8* %31, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %33, label %_ZNSsD1Ev.exit3, label %34, !prof !7

; <label>:34                                      ; preds = %_ZNSsD1Ev.exit6
  %35 = getelementptr inbounds i8* %30, i64 -8
  %36 = bitcast i8* %35 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %37, label %41

; <label>:37                                      ; preds = %34
  %38 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %38)
  %39 = atomicrmw volatile add i32* %36, i32 -1 acq_rel
  store i32 %39, i32* %3, align 4
  %40 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %38)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2

; <label>:41                                      ; preds = %34
  %42 = load i32* %36, align 4, !tbaa !8
  %43 = add nsw i32 %42, -1
  store i32 %43, i32* %36, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2: ; preds = %41, %37
  %.0.i.i.i.i1 = phi i32 [ %40, %37 ], [ %42, %41 ]
  %44 = icmp slt i32 %.0.i.i.i.i1, 1
  br i1 %44, label %45, label %_ZNSsD1Ev.exit3

; <label>:45                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %32, %"class.std::allocator"* %4) #1
  br label %_ZNSsD1Ev.exit3

_ZNSsD1Ev.exit3:                                  ; preds = %45, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2, %_ZNSsD1Ev.exit6
  call void @llvm.lifetime.end(i64 1, i8* %28) #1
  %46 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %46) #1
  %47 = getelementptr inbounds %"class.std::basic_string"* %7, i64 0, i32 0, i32 0
  %48 = load i8** %47, align 8, !tbaa !1
  %49 = getelementptr inbounds i8* %48, i64 -24
  %50 = bitcast i8* %49 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %51 = icmp eq i8* %49, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %51, label %_ZNSsD1Ev.exit, label %52, !prof !7

; <label>:52                                      ; preds = %_ZNSsD1Ev.exit3
  %53 = getelementptr inbounds i8* %48, i64 -8
  %54 = bitcast i8* %53 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %55, label %59

; <label>:55                                      ; preds = %52
  %56 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %56)
  %57 = atomicrmw volatile add i32* %54, i32 -1 acq_rel
  store i32 %57, i32* %5, align 4
  %58 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %56)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:59                                      ; preds = %52
  %60 = load i32* %54, align 4, !tbaa !8
  %61 = add nsw i32 %60, -1
  store i32 %61, i32* %54, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %59, %55
  %.0.i.i.i.i = phi i32 [ %58, %55 ], [ %60, %59 ]
  %62 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %62, label %63, label %_ZNSsD1Ev.exit

; <label>:63                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %50, %"class.std::allocator"* %6) #1
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %63, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNSsD1Ev.exit3
  call void @llvm.lifetime.end(i64 1, i8* %46) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #2

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { noinline nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !4, i64 0}
!2 = metadata !{metadata !"_ZTSSs", metadata !3, i64 0}
!3 = metadata !{metadata !"_ZTSNSs12_Alloc_hiderE", metadata !4, i64 0}
!4 = metadata !{metadata !"any pointer", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"int", metadata !5, i64 0}
