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

; Function Attrs: noinline uwtable
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
  call void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %agg.result, i8* getelementptr inbounds ([2 x i8]* @.str2, i64 0, i64 0), %"class.std::allocator"* %1)
  call void @llvm.lifetime.end(i64 256, i8* %2) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @sprintf(i8* nocapture, i8* nocapture readonly, ...) #2

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #3

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: uwtable
define i32 @main() #4 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator", align 1
  %7 = alloca i32, align 4
  %8 = alloca %"class.std::allocator", align 1
  %9 = alloca i32, align 4
  %10 = alloca %"class.std::allocator", align 1
  %11 = alloca %"class.std::basic_string", align 8
  %12 = alloca %"class.std::basic_string", align 8
  %13 = alloca %"class.std::basic_string", align 8
  call void @_Z6to_strDv4_f(%"class.std::basic_string"* sret %11, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  invoke void @_Z6to_strDv4_f(%"class.std::basic_string"* sret %12, <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>)
          to label %14 unwind label %70

; <label>:14                                      ; preds = %0
  invoke void @_Z6to_strDv4_f(%"class.std::basic_string"* sret %13, <4 x float> <float 3.000000e+00, float 3.000000e+00, float 3.000000e+00, float 3.000000e+00>)
          to label %15 unwind label %74

; <label>:15                                      ; preds = %14
  %16 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %16) #1
  %17 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %18 = load i8** %17, align 8, !tbaa !1
  %19 = getelementptr inbounds i8* %18, i64 -24
  %20 = bitcast i8* %19 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %21 = icmp eq i8* %19, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %21, label %_ZNSsD1Ev.exit13, label %22, !prof !7

; <label>:22                                      ; preds = %15
  %23 = getelementptr inbounds i8* %18, i64 -8
  %24 = bitcast i8* %23 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %25, label %29

; <label>:25                                      ; preds = %22
  %26 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %26)
  %27 = atomicrmw volatile add i32* %24, i32 -1 acq_rel
  store i32 %27, i32* %1, align 4
  %28 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %26)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12

; <label>:29                                      ; preds = %22
  %30 = load i32* %24, align 4, !tbaa !8
  %31 = add nsw i32 %30, -1
  store i32 %31, i32* %24, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12: ; preds = %29, %25
  %.0.i.i.i.i11 = phi i32 [ %28, %25 ], [ %30, %29 ]
  %32 = icmp slt i32 %.0.i.i.i.i11, 1
  br i1 %32, label %33, label %_ZNSsD1Ev.exit13

; <label>:33                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %20, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit13

_ZNSsD1Ev.exit13:                                 ; preds = %33, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12, %15
  call void @llvm.lifetime.end(i64 1, i8* %16) #1
  %34 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %34) #1
  %35 = getelementptr inbounds %"class.std::basic_string"* %12, i64 0, i32 0, i32 0
  %36 = load i8** %35, align 8, !tbaa !1
  %37 = getelementptr inbounds i8* %36, i64 -24
  %38 = bitcast i8* %37 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %39 = icmp eq i8* %37, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %39, label %_ZNSsD1Ev.exit10, label %40, !prof !7

; <label>:40                                      ; preds = %_ZNSsD1Ev.exit13
  %41 = getelementptr inbounds i8* %36, i64 -8
  %42 = bitcast i8* %41 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %43, label %47

; <label>:43                                      ; preds = %40
  %44 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %44)
  %45 = atomicrmw volatile add i32* %42, i32 -1 acq_rel
  store i32 %45, i32* %3, align 4
  %46 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %44)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i9

; <label>:47                                      ; preds = %40
  %48 = load i32* %42, align 4, !tbaa !8
  %49 = add nsw i32 %48, -1
  store i32 %49, i32* %42, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i9

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i9: ; preds = %47, %43
  %.0.i.i.i.i8 = phi i32 [ %46, %43 ], [ %48, %47 ]
  %50 = icmp slt i32 %.0.i.i.i.i8, 1
  br i1 %50, label %51, label %_ZNSsD1Ev.exit10

; <label>:51                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i9
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %38, %"class.std::allocator"* %4) #1
  br label %_ZNSsD1Ev.exit10

_ZNSsD1Ev.exit10:                                 ; preds = %51, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i9, %_ZNSsD1Ev.exit13
  call void @llvm.lifetime.end(i64 1, i8* %34) #1
  %52 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %52) #1
  %53 = getelementptr inbounds %"class.std::basic_string"* %11, i64 0, i32 0, i32 0
  %54 = load i8** %53, align 8, !tbaa !1
  %55 = getelementptr inbounds i8* %54, i64 -24
  %56 = bitcast i8* %55 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %57 = icmp eq i8* %55, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %57, label %_ZNSsD1Ev.exit7, label %58, !prof !7

; <label>:58                                      ; preds = %_ZNSsD1Ev.exit10
  %59 = getelementptr inbounds i8* %54, i64 -8
  %60 = bitcast i8* %59 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %61, label %65

; <label>:61                                      ; preds = %58
  %62 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %62)
  %63 = atomicrmw volatile add i32* %60, i32 -1 acq_rel
  store i32 %63, i32* %5, align 4
  %64 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %62)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6

; <label>:65                                      ; preds = %58
  %66 = load i32* %60, align 4, !tbaa !8
  %67 = add nsw i32 %66, -1
  store i32 %67, i32* %60, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6: ; preds = %65, %61
  %.0.i.i.i.i5 = phi i32 [ %64, %61 ], [ %66, %65 ]
  %68 = icmp slt i32 %.0.i.i.i.i5, 1
  br i1 %68, label %69, label %_ZNSsD1Ev.exit7

; <label>:69                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %56, %"class.std::allocator"* %6) #1
  br label %_ZNSsD1Ev.exit7

_ZNSsD1Ev.exit7:                                  ; preds = %69, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6, %_ZNSsD1Ev.exit10
  call void @llvm.lifetime.end(i64 1, i8* %52) #1
  ret i32 0

; <label>:70                                      ; preds = %0
  %71 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %72 = extractvalue { i8*, i32 } %71, 0
  %73 = extractvalue { i8*, i32 } %71, 1
  br label %_ZNSsD1Ev.exit4

; <label>:74                                      ; preds = %14
  %75 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %76 = extractvalue { i8*, i32 } %75, 0
  %77 = extractvalue { i8*, i32 } %75, 1
  %78 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %78) #1
  %79 = getelementptr inbounds %"class.std::basic_string"* %12, i64 0, i32 0, i32 0
  %80 = load i8** %79, align 8, !tbaa !1
  %81 = getelementptr inbounds i8* %80, i64 -24
  %82 = bitcast i8* %81 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %83 = icmp eq i8* %81, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %83, label %_ZNSsD1Ev.exit4, label %84, !prof !7

; <label>:84                                      ; preds = %74
  %85 = getelementptr inbounds i8* %80, i64 -8
  %86 = bitcast i8* %85 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %87, label %91

; <label>:87                                      ; preds = %84
  %88 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %88)
  %89 = atomicrmw volatile add i32* %86, i32 -1 acq_rel
  store i32 %89, i32* %7, align 4
  %90 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %88)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

; <label>:91                                      ; preds = %84
  %92 = load i32* %86, align 4, !tbaa !8
  %93 = add nsw i32 %92, -1
  store i32 %93, i32* %86, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3: ; preds = %91, %87
  %.0.i.i.i.i2 = phi i32 [ %90, %87 ], [ %92, %91 ]
  %94 = icmp slt i32 %.0.i.i.i.i2, 1
  br i1 %94, label %95, label %_ZNSsD1Ev.exit4

; <label>:95                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %82, %"class.std::allocator"* %8) #1
  br label %_ZNSsD1Ev.exit4

_ZNSsD1Ev.exit4:                                  ; preds = %95, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3, %74, %70
  %.01 = phi i8* [ %72, %70 ], [ %76, %74 ], [ %76, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3 ], [ %76, %95 ]
  %.0 = phi i32 [ %73, %70 ], [ %77, %74 ], [ %77, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3 ], [ %77, %95 ]
  %96 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %96) #1
  %97 = getelementptr inbounds %"class.std::basic_string"* %11, i64 0, i32 0, i32 0
  %98 = load i8** %97, align 8, !tbaa !1
  %99 = getelementptr inbounds i8* %98, i64 -24
  %100 = bitcast i8* %99 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %101 = icmp eq i8* %99, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %101, label %_ZNSsD1Ev.exit, label %102, !prof !7

; <label>:102                                     ; preds = %_ZNSsD1Ev.exit4
  %103 = getelementptr inbounds i8* %98, i64 -8
  %104 = bitcast i8* %103 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %105, label %109

; <label>:105                                     ; preds = %102
  %106 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %106)
  %107 = atomicrmw volatile add i32* %104, i32 -1 acq_rel
  store i32 %107, i32* %9, align 4
  %108 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %106)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:109                                     ; preds = %102
  %110 = load i32* %104, align 4, !tbaa !8
  %111 = add nsw i32 %110, -1
  store i32 %111, i32* %104, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %109, %105
  %.0.i.i.i.i = phi i32 [ %108, %105 ], [ %110, %109 ]
  %112 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %112, label %113, label %_ZNSsD1Ev.exit

; <label>:113                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %100, %"class.std::allocator"* %10) #1
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %113, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNSsD1Ev.exit4
  call void @llvm.lifetime.end(i64 1, i8* %96) #1
  %114 = insertvalue { i8*, i32 } undef, i8* %.01, 0
  %115 = insertvalue { i8*, i32 } %114, i32 %.0, 1
  resume { i8*, i32 } %115
}

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #2

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { noinline uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

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
