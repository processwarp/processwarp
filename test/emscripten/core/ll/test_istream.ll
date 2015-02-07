; ModuleID = 'test_istream.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::allocator" = type { i8 }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"class.std::basic_istringstream" = type { %"class.std::basic_istream.base", %"class.std::basic_stringbuf", %"class.std::basic_ios" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_stringbuf" = type { %"class.std::basic_streambuf", i32, %"class.std::basic_string" }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type { i32 (...)**, i32 }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::ctype" = type { %"class.std::locale::facet", %struct.__locale_struct*, i8, i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8 }
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet" }
%"class.std::num_get" = type { %"class.std::locale::facet" }
%"class.std::basic_istream" = type { i32 (...)**, i64, %"class.std::basic_ios" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str = private unnamed_addr constant [6 x i8] c"1 2 3\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"%i %i %i\00", align 1
@_ZTVSt19basic_istringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [10 x i8*]
@_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [4 x i8*]
@_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external unnamed_addr constant [4 x i8*]
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
  %mystring = alloca %"class.std::basic_string", align 8
  %5 = alloca %"class.std::allocator", align 1
  %is = alloca %"class.std::basic_istringstream", align 8
  %one = alloca i32, align 4
  %two = alloca i32, align 4
  %three = alloca i32, align 4
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %mystring, i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %5)
          to label %6 unwind label %38

; <label>:6                                       ; preds = %0
  %7 = bitcast %"class.std::basic_istringstream"* %is to i8*
  call void @llvm.lifetime.start(i64 360, i8* %7) #2
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %is, %"class.std::basic_string"* %mystring, i32 8)
          to label %8 unwind label %42

; <label>:8                                       ; preds = %6
  %9 = bitcast %"class.std::basic_istringstream"* %is to %"class.std::basic_istream"*
  %10 = invoke %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* %9, i32* %one)
          to label %11 unwind label %46

; <label>:11                                      ; preds = %8
  %12 = invoke %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* %10, i32* %two)
          to label %13 unwind label %46

; <label>:13                                      ; preds = %11
  %14 = invoke %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* %12, i32* %three)
          to label %15 unwind label %46

; <label>:15                                      ; preds = %13
  %16 = load i32* %one, align 4, !tbaa !1
  %17 = load i32* %two, align 4, !tbaa !1
  %18 = load i32* %three, align 4, !tbaa !1
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), i32 %16, i32 %17, i32 %18)
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %is) #2
  call void @llvm.lifetime.end(i64 360, i8* %7) #2
  %20 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %20) #2
  %21 = getelementptr inbounds %"class.std::basic_string"* %mystring, i64 0, i32 0, i32 0
  %22 = load i8** %21, align 8, !tbaa !5
  %23 = getelementptr inbounds i8* %22, i64 -24
  %24 = bitcast i8* %23 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %25 = icmp eq i8* %23, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %25, label %_ZNSsD1Ev.exit5, label %26, !prof !9

; <label>:26                                      ; preds = %15
  %27 = getelementptr inbounds i8* %22, i64 -8
  %28 = bitcast i8* %27 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %29, label %33

; <label>:29                                      ; preds = %26
  %30 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %30)
  %31 = atomicrmw volatile add i32* %28, i32 -1 acq_rel
  store i32 %31, i32* %1, align 4
  %32 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %30)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

; <label>:33                                      ; preds = %26
  %34 = load i32* %28, align 4, !tbaa !1
  %35 = add nsw i32 %34, -1
  store i32 %35, i32* %28, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4: ; preds = %33, %29
  %.0.i.i.i.i3 = phi i32 [ %32, %29 ], [ %34, %33 ]
  %36 = icmp slt i32 %.0.i.i.i.i3, 1
  br i1 %36, label %37, label %_ZNSsD1Ev.exit5

; <label>:37                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %24, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit5

_ZNSsD1Ev.exit5:                                  ; preds = %37, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4, %15
  call void @llvm.lifetime.end(i64 1, i8* %20) #2
  ret i32 0

; <label>:38                                      ; preds = %0
  %39 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %40 = extractvalue { i8*, i32 } %39, 0
  %41 = extractvalue { i8*, i32 } %39, 1
  br label %_ZNSsD1Ev.exit

; <label>:42                                      ; preds = %6
  %43 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %44 = extractvalue { i8*, i32 } %43, 0
  %45 = extractvalue { i8*, i32 } %43, 1
  br label %50

; <label>:46                                      ; preds = %13, %11, %8
  %47 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %48 = extractvalue { i8*, i32 } %47, 0
  %49 = extractvalue { i8*, i32 } %47, 1
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %is) #2
  br label %50

; <label>:50                                      ; preds = %46, %42
  %.01 = phi i8* [ %48, %46 ], [ %44, %42 ]
  %.0 = phi i32 [ %49, %46 ], [ %45, %42 ]
  %51 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %51) #2
  %52 = getelementptr inbounds %"class.std::basic_string"* %mystring, i64 0, i32 0, i32 0
  %53 = load i8** %52, align 8, !tbaa !5
  %54 = getelementptr inbounds i8* %53, i64 -24
  %55 = bitcast i8* %54 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %56 = icmp eq i8* %54, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %56, label %_ZNSsD1Ev.exit, label %57, !prof !9

; <label>:57                                      ; preds = %50
  %58 = getelementptr inbounds i8* %53, i64 -8
  %59 = bitcast i8* %58 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %60, label %64

; <label>:60                                      ; preds = %57
  %61 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %61)
  %62 = atomicrmw volatile add i32* %59, i32 -1 acq_rel
  store i32 %62, i32* %3, align 4
  %63 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %61)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:64                                      ; preds = %57
  %65 = load i32* %59, align 4, !tbaa !1
  %66 = add nsw i32 %65, -1
  store i32 %66, i32* %59, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %64, %60
  %.0.i.i.i.i = phi i32 [ %63, %60 ], [ %65, %64 ]
  %67 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %67, label %68, label %_ZNSsD1Ev.exit

; <label>:68                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %55, %"class.std::allocator"* %4) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %68, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %50, %38
  %.12 = phi i8* [ %40, %38 ], [ %.01, %50 ], [ %.01, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %.01, %68 ]
  %.1 = phi i32 [ %41, %38 ], [ %.0, %50 ], [ %.0, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %.0, %68 ]
  %69 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %70 = insertvalue { i8*, i32 } %69, i32 %.1, 1
  resume { i8*, i32 } %70
}

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = bitcast %"class.std::basic_istringstream"* %this to i8*
  %4 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2
  %5 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0
  call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %5) #2
  %6 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %6, align 8, !tbaa !10
  %7 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %7, align 8, !tbaa !12
  %8 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %8, align 1, !tbaa !15
  %9 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %9, align 1, !tbaa !16
  %10 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 4
  %11 = bitcast %"class.std::basic_streambuf"** %10 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 32, i32 8, i1 false) #2
  %12 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %13 = bitcast %"class.std::basic_istringstream"* %this to i8**
  %14 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 0
  %.c.i = bitcast i8* %12 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %14, align 8, !tbaa !10
  %15 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %16 = getelementptr i8* %12, i64 -24
  %17 = bitcast i8* %16 to i64*
  %18 = load i64* %17, align 8
  %19 = getelementptr inbounds i8* %3, i64 %18
  %20 = bitcast i8* %19 to i8**
  store i8* %15, i8** %20, align 8, !tbaa !10
  %21 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %21, align 8, !tbaa !17
  %22 = load i8** %13, align 8, !tbaa !10
  %23 = getelementptr i8* %22, i64 -24
  %24 = bitcast i8* %23 to i64*
  %25 = load i64* %24, align 8
  %26 = getelementptr inbounds i8* %3, i64 %25
  %27 = bitcast i8* %26 to %"class.std::basic_ios"*
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %27, %"class.std::basic_streambuf"* null)
          to label %_ZNSiC2Ev.exit unwind label %38

_ZNSiC2Ev.exit:                                   ; preds = %0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*]* @_ZTVSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %14, align 8, !tbaa !10
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*]* @_ZTVSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %6, align 8, !tbaa !10
  %28 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1
  %29 = or i32 %__mode, 8
  invoke void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %28, %"class.std::basic_string"* %__str, i32 %29)
          to label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit unwind label %42

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit: ; preds = %_ZNSiC2Ev.exit
  %30 = load i8** %13, align 8, !tbaa !10
  %31 = getelementptr i8* %30, i64 -24
  %32 = bitcast i8* %31 to i64*
  %33 = load i64* %32, align 8
  %34 = getelementptr inbounds i8* %3, i64 %33
  %35 = bitcast i8* %34 to %"class.std::basic_ios"*
  %36 = getelementptr inbounds %"class.std::basic_stringbuf"* %28, i64 0, i32 0
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %35, %"class.std::basic_streambuf"* %36)
          to label %37 unwind label %46

; <label>:37                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit
  ret void

; <label>:38                                      ; preds = %0
  %39 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %40 = extractvalue { i8*, i32 } %39, 0
  %41 = extractvalue { i8*, i32 } %39, 1
  br label %78

; <label>:42                                      ; preds = %_ZNSiC2Ev.exit
  %43 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %44 = extractvalue { i8*, i32 } %43, 0
  %45 = extractvalue { i8*, i32 } %43, 1
  br label %70

; <label>:46                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit
  %47 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %48 = extractvalue { i8*, i32 } %47, 0
  %49 = extractvalue { i8*, i32 } %47, 1
  %50 = getelementptr inbounds %"class.std::basic_stringbuf"* %28, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !10
  %51 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %51) #2
  %52 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %53 = load i8** %52, align 8, !tbaa !5
  %54 = getelementptr inbounds i8* %53, i64 -24
  %55 = bitcast i8* %54 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %56 = icmp eq i8* %54, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %56, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit, label %57, !prof !9

; <label>:57                                      ; preds = %46
  %58 = getelementptr inbounds i8* %53, i64 -8
  %59 = bitcast i8* %58 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %60, label %64

; <label>:60                                      ; preds = %57
  %61 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %61)
  %62 = atomicrmw volatile add i32* %59, i32 -1 acq_rel
  store i32 %62, i32* %1, align 4
  %63 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %61)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:64                                      ; preds = %57
  %65 = load i32* %59, align 4, !tbaa !1
  %66 = add nsw i32 %65, -1
  store i32 %66, i32* %59, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %64, %60
  %.0.i.i.i.i.i = phi i32 [ %63, %60 ], [ %65, %64 ]
  %67 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %67, label %68, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

; <label>:68                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %55, %"class.std::allocator"* %2) #2
  br label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %68, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %46
  call void @llvm.lifetime.end(i64 1, i8* %51) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !10
  %69 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %69) #2
  %.pre = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.pre4 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  br label %70

; <label>:70                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit, %42
  %71 = phi i8* [ %.pre4, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %15, %42 ]
  %72 = phi i8* [ %.pre, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %12, %42 ]
  %.01 = phi i8* [ %48, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %44, %42 ]
  %.0 = phi i32 [ %49, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %45, %42 ]
  %.c.i3 = bitcast i8* %72 to i32 (...)**
  store i32 (...)** %.c.i3, i32 (...)*** %14, align 8, !tbaa !10
  %73 = getelementptr i8* %72, i64 -24
  %74 = bitcast i8* %73 to i64*
  %75 = load i64* %74, align 8
  %76 = getelementptr inbounds i8* %3, i64 %75
  %77 = bitcast i8* %76 to i8**
  store i8* %71, i8** %77, align 8, !tbaa !10
  store i64 0, i64* %21, align 8, !tbaa !17
  br label %78

; <label>:78                                      ; preds = %70, %38
  %.12 = phi i8* [ %.01, %70 ], [ %40, %38 ]
  %.1 = phi i32 [ %.0, %70 ], [ %41, %38 ]
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %5) #2
  %79 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %80 = insertvalue { i8*, i32 } %79, i32 %.1, 1
  resume { i8*, i32 } %80
}

declare %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"*, i32*) #0

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %this) unnamed_addr #4 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 0), align 8
  %4 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 0
  %.c.i = bitcast i8* %3 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %4, align 8, !tbaa !10
  %5 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3), align 8
  %6 = getelementptr i8* %3, i64 -24
  %7 = bitcast i8* %6 to i64*
  %8 = load i64* %7, align 8
  %9 = bitcast %"class.std::basic_istringstream"* %this to i8*
  %10 = getelementptr inbounds i8* %9, i64 %8
  %11 = bitcast i8* %10 to i8**
  store i8* %5, i8** %11, align 8, !tbaa !10
  %12 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !10
  %13 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %13) #2
  %14 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %15 = load i8** %14, align 8, !tbaa !5
  %16 = getelementptr inbounds i8* %15, i64 -24
  %17 = bitcast i8* %16 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %18 = icmp eq i8* %16, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %18, label %_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit, label %19, !prof !9

; <label>:19                                      ; preds = %0
  %20 = getelementptr inbounds i8* %15, i64 -8
  %21 = bitcast i8* %20 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %22, label %26

; <label>:22                                      ; preds = %19
  %23 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %23)
  %24 = atomicrmw volatile add i32* %21, i32 -1 acq_rel
  store i32 %24, i32* %1, align 4
  %25 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %23)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

; <label>:26                                      ; preds = %19
  %27 = load i32* %21, align 4, !tbaa !1
  %28 = add nsw i32 %27, -1
  store i32 %28, i32* %21, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i: ; preds = %26, %22
  %.0.i.i.i.i.i.i = phi i32 [ %25, %22 ], [ %27, %26 ]
  %29 = icmp slt i32 %.0.i.i.i.i.i.i, 1
  br i1 %29, label %30, label %_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit

; <label>:30                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %17, %"class.std::allocator"* %2) #2
  br label %_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %30, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %0
  call void @llvm.lifetime.end(i64 1, i8* %13) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !10
  %31 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %31) #2
  %32 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.c.i.i = bitcast i8* %32 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %4, align 8, !tbaa !10
  %33 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %34 = getelementptr i8* %32, i64 -24
  %35 = bitcast i8* %34 to i64*
  %36 = load i64* %35, align 8
  %37 = getelementptr inbounds i8* %9, i64 %36
  %38 = bitcast i8* %37 to i8**
  store i8* %33, i8** %38, align 8, !tbaa !10
  %39 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %39, align 8, !tbaa !17
  %40 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %40) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #1

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #1

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

; Function Attrs: uwtable
define available_externally void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::allocator", align 1
  %4 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !10
  %5 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 1
  %6 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 7
  %7 = bitcast i8** %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 48, i32 8, i1 false) #2
  call void @_ZNSt6localeC1Ev(%"class.std::locale"* %6) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !10
  %8 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 1
  store i32 0, i32* %8, align 4, !tbaa !20
  %9 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2
  %10 = getelementptr inbounds %"class.std::basic_string"* %__str, i64 0, i32 0, i32 0
  %11 = load i8** %10, align 8, !tbaa !5
  %12 = getelementptr inbounds i8* %11, i64 -24
  %13 = bitcast i8* %12 to i64*
  %14 = load i64* %13, align 8, !tbaa !23
  invoke void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"* %9, i8* %11, i64 %14, %"class.std::allocator"* %3)
          to label %15 unwind label %22

; <label>:15                                      ; preds = %0
  store i32 %__mode, i32* %8, align 4, !tbaa !20
  %16 = and i32 %__mode, 3
  %17 = icmp eq i32 %16, 0
  %.phi.trans.insert.i = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2, i32 0, i32 0
  %.pre.i = load i8** %.phi.trans.insert.i, align 8, !tbaa !5
  br i1 %17, label %._crit_edge.i, label %18

; <label>:18                                      ; preds = %15
  %19 = getelementptr inbounds i8* %.pre.i, i64 -24
  %20 = bitcast i8* %19 to i64*
  %21 = load i64* %20, align 8, !tbaa !23
  br label %._crit_edge.i

._crit_edge.i:                                    ; preds = %18, %15
  %__len.0.i = phi i64 [ %21, %18 ], [ 0, %15 ]
  invoke void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"* %this, i8* %.pre.i, i64 0, i64 %__len.0.i)
          to label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE17_M_stringbuf_initESt13_Ios_Openmode.exit unwind label %26

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE17_M_stringbuf_initESt13_Ios_Openmode.exit: ; preds = %._crit_edge.i
  ret void

; <label>:22                                      ; preds = %0
  %23 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %24 = extractvalue { i8*, i32 } %23, 0
  %25 = extractvalue { i8*, i32 } %23, 1
  br label %_ZNSsD1Ev.exit

; <label>:26                                      ; preds = %._crit_edge.i
  %27 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  %29 = extractvalue { i8*, i32 } %27, 1
  %30 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %30) #2
  %31 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %32 = load i8** %31, align 8, !tbaa !5
  %33 = getelementptr inbounds i8* %32, i64 -24
  %34 = bitcast i8* %33 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %35 = icmp eq i8* %33, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %35, label %_ZNSsD1Ev.exit, label %36, !prof !9

; <label>:36                                      ; preds = %26
  %37 = getelementptr inbounds i8* %32, i64 -8
  %38 = bitcast i8* %37 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %39, label %43

; <label>:39                                      ; preds = %36
  %40 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %40)
  %41 = atomicrmw volatile add i32* %38, i32 -1 acq_rel
  store i32 %41, i32* %1, align 4
  %42 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %40)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:43                                      ; preds = %36
  %44 = load i32* %38, align 4, !tbaa !1
  %45 = add nsw i32 %44, -1
  store i32 %45, i32* %38, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %43, %39
  %.0.i.i.i.i = phi i32 [ %42, %39 ], [ %44, %43 ]
  %46 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %46, label %47, label %_ZNSsD1Ev.exit

; <label>:47                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %34, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %47, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %26, %22
  %.01 = phi i8* [ %24, %22 ], [ %28, %26 ], [ %28, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %28, %47 ]
  %.0 = phi i32 [ %25, %22 ], [ %29, %26 ], [ %29, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %29, %47 ]
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !10
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %6) #2
  %48 = insertvalue { i8*, i32 } undef, i8* %.01, 0
  %49 = insertvalue { i8*, i32 } %48, i32 %.0, 1
  resume { i8*, i32 } %49
}

declare void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"*, i8*, i64, %"class.std::allocator"*) #0

declare void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"*, i8*, i64, i64) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeC1Ev(%"class.std::locale"*) #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"*) #1

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !8, i64 0}
!6 = metadata !{metadata !"_ZTSSs", metadata !7, i64 0}
!7 = metadata !{metadata !"_ZTSNSs12_Alloc_hiderE", metadata !8, i64 0}
!8 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!9 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!10 = metadata !{metadata !11, metadata !11, i64 0}
!11 = metadata !{metadata !"vtable pointer", metadata !4, i64 0}
!12 = metadata !{metadata !13, metadata !8, i64 216}
!13 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !8, i64 216, metadata !3, i64 224, metadata !14, i64 225, metadata !8, i64 232, metadata !8, i64 240, metadata !8, i64 248, metadata !8, i64 256}
!14 = metadata !{metadata !"bool", metadata !3, i64 0}
!15 = metadata !{metadata !13, metadata !3, i64 224}
!16 = metadata !{metadata !13, metadata !14, i64 225}
!17 = metadata !{metadata !18, metadata !19, i64 8}
!18 = metadata !{metadata !"_ZTSSi", metadata !19, i64 8}
!19 = metadata !{metadata !"long", metadata !3, i64 0}
!20 = metadata !{metadata !21, metadata !22, i64 64}
!21 = metadata !{metadata !"_ZTSSt15basic_stringbufIcSt11char_traitsIcESaIcEE", metadata !22, i64 64, metadata !6, i64 72}
!22 = metadata !{metadata !"_ZTSSt13_Ios_Openmode", metadata !3, i64 0}
!23 = metadata !{metadata !24, metadata !19, i64 0}
!24 = metadata !{metadata !"_ZTSNSs9_Rep_baseE", metadata !19, i64 0, metadata !19, i64 8, metadata !2, i64 16}
