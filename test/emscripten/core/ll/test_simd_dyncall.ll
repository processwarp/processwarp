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
          to label %14 unwind label %72

; <label>:14                                      ; preds = %0
  invoke void @_Z6to_strDv4_f(%"class.std::basic_string"* sret %13, <4 x float> <float 3.000000e+00, float 3.000000e+00, float 3.000000e+00, float 3.000000e+00>)
          to label %15 unwind label %76

; <label>:15                                      ; preds = %14
  %16 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %16) #1
  %17 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %18 = load i8** %17, align 8, !tbaa !1
  %19 = getelementptr inbounds i8* %18, i64 -24
  %20 = bitcast i8* %19 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %21 = icmp eq i8* %19, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %21, label %34, label %22, !prof !7

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
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i13

; <label>:29                                      ; preds = %22
  %30 = load i32* %24, align 4, !tbaa !8
  %31 = add nsw i32 %30, -1
  store i32 %31, i32* %24, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i13

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i13: ; preds = %29, %25
  %.0.i.i.i.i12 = phi i32 [ %28, %25 ], [ %30, %29 ]
  %32 = icmp slt i32 %.0.i.i.i.i12, 1
  br i1 %32, label %33, label %34

; <label>:33                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i13
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %20, %"class.std::allocator"* %2) #1
  br label %34

; <label>:34                                      ; preds = %33, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i13, %15
  call void @llvm.lifetime.end(i64 1, i8* %16) #1
  %35 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %35) #1
  %36 = getelementptr inbounds %"class.std::basic_string"* %12, i64 0, i32 0, i32 0
  %37 = load i8** %36, align 8, !tbaa !1
  %38 = getelementptr inbounds i8* %37, i64 -24
  %39 = bitcast i8* %38 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %40 = icmp eq i8* %38, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %40, label %53, label %41, !prof !7

; <label>:41                                      ; preds = %34
  %42 = getelementptr inbounds i8* %37, i64 -8
  %43 = bitcast i8* %42 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %44, label %48

; <label>:44                                      ; preds = %41
  %45 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %45)
  %46 = atomicrmw volatile add i32* %43, i32 -1 acq_rel
  store i32 %46, i32* %3, align 4
  %47 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %45)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10

; <label>:48                                      ; preds = %41
  %49 = load i32* %43, align 4, !tbaa !8
  %50 = add nsw i32 %49, -1
  store i32 %50, i32* %43, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10: ; preds = %48, %44
  %.0.i.i.i.i9 = phi i32 [ %47, %44 ], [ %49, %48 ]
  %51 = icmp slt i32 %.0.i.i.i.i9, 1
  br i1 %51, label %52, label %53

; <label>:52                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %39, %"class.std::allocator"* %4) #1
  br label %53

; <label>:53                                      ; preds = %52, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10, %34
  call void @llvm.lifetime.end(i64 1, i8* %35) #1
  %54 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %54) #1
  %55 = getelementptr inbounds %"class.std::basic_string"* %11, i64 0, i32 0, i32 0
  %56 = load i8** %55, align 8, !tbaa !1
  %57 = getelementptr inbounds i8* %56, i64 -24
  %58 = bitcast i8* %57 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %59 = icmp eq i8* %57, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %59, label %_ZNSsD1Ev.exit8, label %60, !prof !7

; <label>:60                                      ; preds = %53
  %61 = getelementptr inbounds i8* %56, i64 -8
  %62 = bitcast i8* %61 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %63, label %67

; <label>:63                                      ; preds = %60
  %64 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %64)
  %65 = atomicrmw volatile add i32* %62, i32 -1 acq_rel
  store i32 %65, i32* %5, align 4
  %66 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %64)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i7

; <label>:67                                      ; preds = %60
  %68 = load i32* %62, align 4, !tbaa !8
  %69 = add nsw i32 %68, -1
  store i32 %69, i32* %62, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i7

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i7: ; preds = %67, %63
  %.0.i.i.i.i6 = phi i32 [ %66, %63 ], [ %68, %67 ]
  %70 = icmp slt i32 %.0.i.i.i.i6, 1
  br i1 %70, label %71, label %_ZNSsD1Ev.exit8

; <label>:71                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i7
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %58, %"class.std::allocator"* %6) #1
  br label %_ZNSsD1Ev.exit8

_ZNSsD1Ev.exit8:                                  ; preds = %71, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i7, %53
  call void @llvm.lifetime.end(i64 1, i8* %54) #1
  ret i32 0

; <label>:72                                      ; preds = %0
  %73 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %74 = extractvalue { i8*, i32 } %73, 0
  %75 = extractvalue { i8*, i32 } %73, 1
  br label %_ZNSsD1Ev.exit5

; <label>:76                                      ; preds = %14
  %77 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %78 = extractvalue { i8*, i32 } %77, 0
  %79 = extractvalue { i8*, i32 } %77, 1
  %80 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %80) #1
  %81 = getelementptr inbounds %"class.std::basic_string"* %12, i64 0, i32 0, i32 0
  %82 = load i8** %81, align 8, !tbaa !1
  %83 = getelementptr inbounds i8* %82, i64 -24
  %84 = bitcast i8* %83 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %85 = icmp eq i8* %83, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %85, label %_ZNSsD1Ev.exit5, label %86, !prof !7

; <label>:86                                      ; preds = %76
  %87 = getelementptr inbounds i8* %82, i64 -8
  %88 = bitcast i8* %87 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %89, label %93

; <label>:89                                      ; preds = %86
  %90 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %90)
  %91 = atomicrmw volatile add i32* %88, i32 -1 acq_rel
  store i32 %91, i32* %7, align 4
  %92 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %90)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

; <label>:93                                      ; preds = %86
  %94 = load i32* %88, align 4, !tbaa !8
  %95 = add nsw i32 %94, -1
  store i32 %95, i32* %88, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4: ; preds = %93, %89
  %.0.i.i.i.i3 = phi i32 [ %92, %89 ], [ %94, %93 ]
  %96 = icmp slt i32 %.0.i.i.i.i3, 1
  br i1 %96, label %97, label %_ZNSsD1Ev.exit5

; <label>:97                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %84, %"class.std::allocator"* %8) #1
  br label %_ZNSsD1Ev.exit5

_ZNSsD1Ev.exit5:                                  ; preds = %97, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4, %76, %72
  %.12 = phi i8* [ %74, %72 ], [ %78, %76 ], [ %78, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4 ], [ %78, %97 ]
  %.1 = phi i32 [ %75, %72 ], [ %79, %76 ], [ %79, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4 ], [ %79, %97 ]
  %98 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %98) #1
  %99 = getelementptr inbounds %"class.std::basic_string"* %11, i64 0, i32 0, i32 0
  %100 = load i8** %99, align 8, !tbaa !1
  %101 = getelementptr inbounds i8* %100, i64 -24
  %102 = bitcast i8* %101 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %103 = icmp eq i8* %101, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %103, label %116, label %104, !prof !7

; <label>:104                                     ; preds = %_ZNSsD1Ev.exit5
  %105 = getelementptr inbounds i8* %100, i64 -8
  %106 = bitcast i8* %105 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %107, label %111

; <label>:107                                     ; preds = %104
  %108 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %108)
  %109 = atomicrmw volatile add i32* %106, i32 -1 acq_rel
  store i32 %109, i32* %9, align 4
  %110 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %108)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:111                                     ; preds = %104
  %112 = load i32* %106, align 4, !tbaa !8
  %113 = add nsw i32 %112, -1
  store i32 %113, i32* %106, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %111, %107
  %.0.i.i.i.i = phi i32 [ %110, %107 ], [ %112, %111 ]
  %114 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %114, label %115, label %116

; <label>:115                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %102, %"class.std::allocator"* %10) #1
  br label %116

; <label>:116                                     ; preds = %115, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNSsD1Ev.exit5
  call void @llvm.lifetime.end(i64 1, i8* %98) #1
  %117 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %118 = insertvalue { i8*, i32 } %117, i32 %.1, 1
  resume { i8*, i32 } %118
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
