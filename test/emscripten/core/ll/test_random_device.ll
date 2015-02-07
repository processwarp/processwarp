; ModuleID = 'test_random_device.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type { i32 (...)**, i32 }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type { %"class.std::locale::facet", %struct.__locale_struct*, i8, i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8 }
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet" }
%"class.std::num_get" = type { %"class.std::locale::facet" }
%"class.std::allocator" = type { i8 }
%"class.std::random_device" = type { %union.anon }
%union.anon = type { %"class.std::mersenne_twister_engine" }
%"class.std::mersenne_twister_engine" = type { [624 x i64], i64 }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }
%"class.std::exception" = type { i32 (...)** }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@_ZTISt9exception = external constant i8*
@.str = private unnamed_addr constant [8 x i8] c"default\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str1 = private unnamed_addr constant [16 x i8] c"random was read\00", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@_ZSt4cerr = external global %"class.std::basic_ostream"
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #1

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: uwtable
define i32 @main() #3 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %rd = alloca %"class.std::random_device", align 8
  %5 = alloca %"class.std::basic_string", align 8
  %6 = alloca %"class.std::allocator", align 1
  %7 = bitcast %"class.std::random_device"* %rd to i8*
  call void @llvm.lifetime.start(i64 5000, i8* %7) #2
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %5, i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %6)
          to label %8 unwind label %32

; <label>:8                                       ; preds = %0
  invoke void @_ZNSt13random_device7_M_initERKSs(%"class.std::random_device"* %rd, %"class.std::basic_string"* %5)
          to label %_ZNSt13random_deviceC2ERKSs.exit unwind label %36

_ZNSt13random_deviceC2ERKSs.exit:                 ; preds = %8
  %9 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %9) #2
  %10 = getelementptr inbounds %"class.std::basic_string"* %5, i64 0, i32 0, i32 0
  %11 = load i8** %10, align 8, !tbaa !1
  %12 = getelementptr inbounds i8* %11, i64 -24
  %13 = bitcast i8* %12 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %14 = icmp eq i8* %12, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %14, label %_ZNSsD1Ev.exit, label %15, !prof !7

; <label>:15                                      ; preds = %_ZNSt13random_deviceC2ERKSs.exit
  %16 = getelementptr inbounds i8* %11, i64 -8
  %17 = bitcast i8* %16 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %18, label %22

; <label>:18                                      ; preds = %15
  %19 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %19)
  %20 = atomicrmw volatile add i32* %17, i32 -1 acq_rel
  store i32 %20, i32* %3, align 4
  %21 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %19)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:22                                      ; preds = %15
  %23 = load i32* %17, align 4, !tbaa !8
  %24 = add nsw i32 %23, -1
  store i32 %24, i32* %17, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %22, %18
  %.0.i.i.i.i = phi i32 [ %21, %18 ], [ %23, %22 ]
  %25 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %25, label %26, label %_ZNSsD1Ev.exit

; <label>:26                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %13, %"class.std::allocator"* %4) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %26, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNSt13random_deviceC2ERKSs.exit
  call void @llvm.lifetime.end(i64 1, i8* %9) #2
  %27 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([16 x i8]* @.str1, i64 0, i64 0), i64 15)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6 unwind label %58

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6: ; preds = %_ZNSsD1Ev.exit
  %28 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([2 x i8]* @.str2, i64 0, i64 0), i64 1)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit8 unwind label %58

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit8: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6
  invoke void @_ZNSt13random_device7_M_finiEv(%"class.std::random_device"* %rd)
          to label %_ZNSt13random_deviceD2Ev.exit unwind label %29

; <label>:29                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit8
  %30 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %31 = extractvalue { i8*, i32 } %30, 0
  call void @__clang_call_terminate(i8* %31) #7
  unreachable

; <label>:32                                      ; preds = %0
  %33 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %34 = extractvalue { i8*, i32 } %33, 0
  %35 = extractvalue { i8*, i32 } %33, 1
  br label %_ZNSt13random_deviceD2Ev.exit12

; <label>:36                                      ; preds = %8
  %37 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %38 = extractvalue { i8*, i32 } %37, 0
  %39 = extractvalue { i8*, i32 } %37, 1
  %40 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %40) #2
  %41 = getelementptr inbounds %"class.std::basic_string"* %5, i64 0, i32 0, i32 0
  %42 = load i8** %41, align 8, !tbaa !1
  %43 = getelementptr inbounds i8* %42, i64 -24
  %44 = bitcast i8* %43 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %45 = icmp eq i8* %43, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %45, label %_ZNSt13random_deviceD2Ev.exit12, label %46, !prof !7

; <label>:46                                      ; preds = %36
  %47 = getelementptr inbounds i8* %42, i64 -8
  %48 = bitcast i8* %47 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %49, label %53

; <label>:49                                      ; preds = %46
  %50 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %50)
  %51 = atomicrmw volatile add i32* %48, i32 -1 acq_rel
  store i32 %51, i32* %1, align 4
  %52 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %50)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10

; <label>:53                                      ; preds = %46
  %54 = load i32* %48, align 4, !tbaa !8
  %55 = add nsw i32 %54, -1
  store i32 %55, i32* %48, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10: ; preds = %53, %49
  %.0.i.i.i.i9 = phi i32 [ %52, %49 ], [ %54, %53 ]
  %56 = icmp slt i32 %.0.i.i.i.i9, 1
  br i1 %56, label %57, label %_ZNSt13random_deviceD2Ev.exit12

; <label>:57                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %44, %"class.std::allocator"* %2) #2
  br label %_ZNSt13random_deviceD2Ev.exit12

; <label>:58                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6, %_ZNSsD1Ev.exit
  %59 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %60 = extractvalue { i8*, i32 } %59, 0
  %61 = extractvalue { i8*, i32 } %59, 1
  invoke void @_ZNSt13random_device7_M_finiEv(%"class.std::random_device"* %rd)
          to label %_ZNSt13random_deviceD2Ev.exit12 unwind label %62

; <label>:62                                      ; preds = %58
  %63 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %64 = extractvalue { i8*, i32 } %63, 0
  call void @__clang_call_terminate(i8* %64) #7
  unreachable

_ZNSt13random_deviceD2Ev.exit12:                  ; preds = %58, %57, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10, %36, %32
  %.12 = phi i32 [ %35, %32 ], [ %61, %58 ], [ %39, %36 ], [ %39, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10 ], [ %39, %57 ]
  %.1 = phi i8* [ %34, %32 ], [ %60, %58 ], [ %38, %36 ], [ %38, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i10 ], [ %38, %57 ]
  %65 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #2
  %66 = icmp eq i32 %.12, %65
  br i1 %66, label %67, label %94

; <label>:67                                      ; preds = %_ZNSt13random_deviceD2Ev.exit12
  %68 = call i8* @__cxa_begin_catch(i8* %.1) #2
  %69 = bitcast i8* %68 to %"class.std::exception"*
  %70 = bitcast i8* %68 to i8* (%"class.std::exception"*)***
  %71 = load i8* (%"class.std::exception"*)*** %70, align 8, !tbaa !10
  %72 = getelementptr inbounds i8* (%"class.std::exception"*)** %71, i64 2
  %73 = load i8* (%"class.std::exception"*)** %72, align 8
  %74 = call i8* %73(%"class.std::exception"* %69) #2
  %75 = icmp eq i8* %74, null
  br i1 %75, label %76, label %87

; <label>:76                                      ; preds = %67
  %77 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cerr to i8**), align 8, !tbaa !10
  %78 = getelementptr i8* %77, i64 -24
  %79 = bitcast i8* %78 to i64*
  %80 = load i64* %79, align 8
  %81 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cerr to i8*), i64 %80
  %82 = bitcast i8* %81 to %"class.std::basic_ios"*
  %.sum.i = add i64 %80, 32
  %83 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cerr to i8*), i64 %.sum.i
  %84 = bitcast i8* %83 to i32*
  %85 = load i32* %84, align 4, !tbaa !12
  %86 = or i32 %85, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %82, i32 %86)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %90

; <label>:87                                      ; preds = %67
  %88 = call i64 @strlen(i8* %74) #2
  %89 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cerr, i8* %74, i64 %88)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %90

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %87, %76
  call void @__cxa_end_catch()
  br label %_ZNSt13random_deviceD2Ev.exit

_ZNSt13random_deviceD2Ev.exit:                    ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit8
  ret i32 0

; <label>:90                                      ; preds = %87, %76
  %91 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %92 = extractvalue { i8*, i32 } %91, 0
  %93 = extractvalue { i8*, i32 } %91, 1
  invoke void @__cxa_end_catch()
          to label %94 unwind label %97

; <label>:94                                      ; preds = %90, %_ZNSt13random_deviceD2Ev.exit12
  %.23 = phi i32 [ %93, %90 ], [ %.12, %_ZNSt13random_deviceD2Ev.exit12 ]
  %.2 = phi i8* [ %92, %90 ], [ %.1, %_ZNSt13random_deviceD2Ev.exit12 ]
  %95 = insertvalue { i8*, i32 } undef, i8* %.2, 0
  %96 = insertvalue { i8*, i32 } %95, i32 %.23, 1
  resume { i8*, i32 } %96

; <label>:97                                      ; preds = %90
  %98 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %99 = extractvalue { i8*, i32 } %98, 0
  call void @__clang_call_terminate(i8* %99) #7
  unreachable
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #4

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #5 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #2
  tail call void @_ZSt9terminatev() #7
  unreachable
}

declare void @_ZSt9terminatev()

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #6

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

declare void @_ZNSt13random_device7_M_finiEv(%"class.std::random_device"*) #0

declare void @_ZNSt13random_device7_M_initERKSs(%"class.std::random_device"*, %"class.std::basic_string"*) #0

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #2
  ret void
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }
attributes #5 = { noinline noreturn nounwind }
attributes #6 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn nounwind }

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
!10 = metadata !{metadata !11, metadata !11, i64 0}
!11 = metadata !{metadata !"vtable pointer", metadata !6, i64 0}
!12 = metadata !{metadata !13, metadata !16, i64 32}
!13 = metadata !{metadata !"_ZTSSt8ios_base", metadata !14, i64 8, metadata !14, i64 16, metadata !15, i64 24, metadata !16, i64 28, metadata !16, i64 32, metadata !4, i64 40, metadata !17, i64 48, metadata !5, i64 64, metadata !9, i64 192, metadata !4, i64 200, metadata !18, i64 208}
!14 = metadata !{metadata !"long", metadata !5, i64 0}
!15 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !5, i64 0}
!16 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !5, i64 0}
!17 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !4, i64 0, metadata !14, i64 8}
!18 = metadata !{metadata !"_ZTSSt6locale", metadata !4, i64 0}
