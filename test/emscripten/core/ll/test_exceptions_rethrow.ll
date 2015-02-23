; ModuleID = 'test_exceptions_rethrow.bc'
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
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"class.std::ios_base::failure" = type { %"class.std::exception", %"class.std::basic_string" }
%"class.std::exception" = type { i32 (...)** }
%"class.std::basic_istringstream" = type { %"class.std::basic_istream.base", %"class.std::basic_stringbuf", %"class.std::basic_ios" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_stringbuf" = type { %"class.std::basic_streambuf", i32, %"class.std::basic_string" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }
%"class.std::basic_istream" = type { i32 (...)**, i64, %"class.std::basic_ios" }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@_ZTINSt8ios_base7failureE = external constant i8*
@_ZTISt9exception = external constant i8*
@.str = private unnamed_addr constant [6 x i8] c"Three\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str1 = private unnamed_addr constant [73 x i8] c"No exception thrown; Failed to convert 'Three' to TestEnum::type... fail\00", align 1
@.str2 = private unnamed_addr constant [51 x i8] c"Successfully converted 'Three' to TestEnum::type: \00", align 1
@.str3 = private unnamed_addr constant [9 x i8] c"... fail\00", align 1
@.str4 = private unnamed_addr constant [64 x i8] c"Unknown exception caught converting 'Three' to TestEnum... fail\00", align 1
@.str5 = private unnamed_addr constant [19 x i8] c"Caught exception: \00", align 1
@.str6 = private unnamed_addr constant [33 x i8] c"Caught std::ios_base::failure: |\00", align 1
@.str7 = private unnamed_addr constant [8 x i8] c"|... ok\00", align 1
@_ZTVSt19basic_istringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [10 x i8*]
@_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [4 x i8*]
@_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external unnamed_addr constant [4 x i8*]
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@.str8 = private unnamed_addr constant [5 x i8] c"Zero\00", align 1
@.str9 = private unnamed_addr constant [4 x i8] c"One\00", align 1
@.str10 = private unnamed_addr constant [16 x i8] c"<input failure>\00", align 1
@.str11 = private unnamed_addr constant [35 x i8] c"Throwing std::ios_base::failure: |\00", align 1
@.str12 = private unnamed_addr constant [5 x i8] c"|...\00", align 1
@_ZTVNSt8ios_base7failureE = external unnamed_addr constant [5 x i8*]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: uwtable
define i32 @main() #2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator", align 1
  %7 = alloca i32, align 4
  %8 = alloca %"class.std::allocator", align 1
  %raw.i = alloca %"class.std::basic_string", align 8
  %failz.i = alloca %"class.std::ios_base::failure", align 8
  %9 = alloca %"class.std::basic_string", align 8
  %10 = alloca %"class.std::allocator", align 1
  %11 = alloca i32, align 4
  %12 = alloca %"class.std::allocator", align 1
  %iss = alloca %"class.std::basic_istringstream", align 8
  %13 = alloca %"class.std::basic_string", align 8
  %14 = alloca %"class.std::allocator", align 1
  %15 = bitcast %"class.std::basic_istringstream"* %iss to i8*
  call void @llvm.lifetime.start(i64 360, i8* %15) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %13, i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %14)
          to label %16 unwind label %268

; <label>:16                                      ; preds = %0
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss, %"class.std::basic_string"* %13, i32 8)
          to label %17 unwind label %272

; <label>:17                                      ; preds = %16
  %18 = getelementptr inbounds %"class.std::allocator"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %18)
  %19 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %20 = load i8** %19, align 8, !tbaa !1
  %21 = getelementptr inbounds i8* %20, i64 -24
  %22 = bitcast i8* %21 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %23 = icmp eq i8* %21, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %23, label %36, label %24, !prof !7

; <label>:24                                      ; preds = %17
  %25 = getelementptr inbounds i8* %20, i64 -8
  %26 = bitcast i8* %25 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %27, label %31

; <label>:27                                      ; preds = %24
  %28 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %28)
  %29 = atomicrmw volatile add i32* %26, i32 -1 acq_rel
  store i32 %29, i32* %11, align 4
  %30 = load volatile i32* %11, align 4
  call void @llvm.lifetime.end(i64 4, i8* %28)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:31                                      ; preds = %24
  %32 = load i32* %26, align 4, !tbaa !8
  %33 = add nsw i32 %32, -1
  store i32 %33, i32* %26, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %31, %27
  %.0.i.i.i.i = phi i32 [ %30, %27 ], [ %32, %31 ]
  %34 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %34, label %35, label %36

; <label>:35                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %22, %"class.std::allocator"* %12) #1
  br label %36

; <label>:36                                      ; preds = %35, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %17
  call void @llvm.lifetime.end(i64 1, i8* %18)
  %37 = bitcast %"class.std::basic_istringstream"* %iss to i8**
  %38 = load i8** %37, align 8, !tbaa !10
  %39 = getelementptr i8* %38, i64 -24
  %40 = bitcast i8* %39 to i64*
  %41 = load i64* %40, align 8
  %42 = getelementptr inbounds i8* %15, i64 %41
  %43 = bitcast i8* %42 to %"class.std::basic_ios"*
  %.sum111 = add i64 %41, 28
  %44 = getelementptr inbounds i8* %15, i64 %.sum111
  %45 = bitcast i8* %44 to i32*
  store i32 4, i32* %45, align 4, !tbaa !12
  %.sum112 = add i64 %41, 32
  %46 = getelementptr inbounds i8* %15, i64 %.sum112
  %47 = bitcast i8* %46 to i32*
  %48 = load i32* %47, align 4, !tbaa !19
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %43, i32 %48)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit unwind label %294

_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit: ; preds = %36
  %49 = bitcast %"class.std::basic_istringstream"* %iss to %"class.std::basic_istream"*
  %50 = bitcast %"class.std::basic_string"* %raw.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %50)
  %51 = bitcast %"class.std::ios_base::failure"* %failz.i to i8*
  call void @llvm.lifetime.start(i64 16, i8* %51)
  %52 = bitcast %"class.std::basic_string"* %9 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %52)
  %53 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %53)
  %54 = getelementptr inbounds %"class.std::basic_string"* %raw.i, i64 0, i32 0, i32 0
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %54, align 8, !tbaa !20
  %55 = invoke %"class.std::basic_istream"* @_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RSbIS4_S5_T1_E(%"class.std::basic_istream"* %49, %"class.std::basic_string"* %raw.i)
          to label %56 unwind label %68

; <label>:56                                      ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit
  %57 = bitcast %"class.std::basic_istream"* %55 to i8**
  %58 = load i8** %57, align 8, !tbaa !10
  %59 = getelementptr i8* %58, i64 -24
  %60 = bitcast i8* %59 to i64*
  %61 = load i64* %60, align 8
  %62 = bitcast %"class.std::basic_istream"* %55 to i8*
  %.sum24.i = add i64 %61, 32
  %63 = getelementptr inbounds i8* %62, i64 %.sum24.i
  %64 = bitcast i8* %63 to i32*
  %65 = load i32* %64, align 4, !tbaa !19
  %66 = and i32 %65, 5
  %67 = icmp eq i32 %66, 0
  br i1 %67, label %71, label %156

; <label>:68                                      ; preds = %75, %71, %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit
  %69 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %70 = extractvalue { i8*, i32 } %69, 0
  br label %175

; <label>:71                                      ; preds = %56
  %72 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw.i, i8* getelementptr inbounds ([5 x i8]* @.str8, i64 0, i64 0))
          to label %73 unwind label %68

; <label>:73                                      ; preds = %71
  %74 = icmp eq i32 %72, 0
  br i1 %74, label %156, label %75

; <label>:75                                      ; preds = %73
  %76 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw.i, i8* getelementptr inbounds ([4 x i8]* @.str9, i64 0, i64 0))
          to label %77 unwind label %68

; <label>:77                                      ; preds = %75
  %78 = icmp eq i32 %76, 0
  br i1 %78, label %156, label %79

; <label>:79                                      ; preds = %77
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %9, i8* getelementptr inbounds ([16 x i8]* @.str10, i64 0, i64 0), %"class.std::allocator"* %10)
          to label %80 unwind label %146

; <label>:80                                      ; preds = %79
  call void @_ZNSt8ios_base7failureC1ERKSs(%"class.std::ios_base::failure"* %failz.i, %"class.std::basic_string"* %9) #1
  %81 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %81)
  %82 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %83 = load i8** %82, align 8, !tbaa !1
  %84 = getelementptr inbounds i8* %83, i64 -24
  %85 = bitcast i8* %84 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %86 = icmp eq i8* %84, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %86, label %99, label %87, !prof !7

; <label>:87                                      ; preds = %80
  %88 = getelementptr inbounds i8* %83, i64 -8
  %89 = bitcast i8* %88 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %90, label %94

; <label>:90                                      ; preds = %87
  %91 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %91)
  %92 = atomicrmw volatile add i32* %89, i32 -1 acq_rel
  store i32 %92, i32* %7, align 4
  %93 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %91)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:94                                      ; preds = %87
  %95 = load i32* %89, align 4, !tbaa !8
  %96 = add nsw i32 %95, -1
  store i32 %96, i32* %89, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %94, %90
  %.0.i.i.i.i.i = phi i32 [ %93, %90 ], [ %95, %94 ]
  %97 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %97, label %98, label %99

; <label>:98                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %85, %"class.std::allocator"* %8) #1
  br label %99

; <label>:99                                      ; preds = %98, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %80
  call void @llvm.lifetime.end(i64 1, i8* %81)
  %100 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([35 x i8]* @.str11, i64 0, i64 0), i64 34)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i unwind label %149

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i: ; preds = %99
  %101 = call i8* @_ZNKSt8ios_base7failure4whatEv(%"class.std::ios_base::failure"* %failz.i) #1
  %102 = icmp eq i8* %101, null
  br i1 %102, label %103, label %114

; <label>:103                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i
  %104 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %105 = getelementptr i8* %104, i64 -24
  %106 = bitcast i8* %105 to i64*
  %107 = load i64* %106, align 8
  %108 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %107
  %109 = bitcast i8* %108 to %"class.std::basic_ios"*
  %.sum.i.i = add i64 %107, 32
  %110 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i.i
  %111 = bitcast i8* %110 to i32*
  %112 = load i32* %111, align 4, !tbaa !19
  %113 = or i32 %112, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %109, i32 %113)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i unwind label %149

; <label>:114                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i
  %115 = call i64 @strlen(i8* %101) #1
  %116 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %101, i64 %115)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i unwind label %149

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i: ; preds = %114, %103
  %117 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([5 x i8]* @.str12, i64 0, i64 0), i64 4)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i unwind label %149

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i
  %118 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %119 = getelementptr i8* %118, i64 -24
  %120 = bitcast i8* %119 to i64*
  %121 = load i64* %120, align 8
  %.sum25.i = add i64 %121, 240
  %122 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum25.i
  %123 = bitcast i8* %122 to %"class.std::ctype"**
  %124 = load %"class.std::ctype"** %123, align 8, !tbaa !21
  %125 = icmp eq %"class.std::ctype"* %124, null
  br i1 %125, label %126, label %.noexc18.i

; <label>:126                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc22.i unwind label %149

.noexc22.i:                                       ; preds = %126
  unreachable

.noexc18.i:                                       ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i
  %127 = getelementptr inbounds %"class.std::ctype"* %124, i64 0, i32 6
  %128 = load i8* %127, align 1, !tbaa !24
  %129 = icmp eq i8 %128, 0
  br i1 %129, label %133, label %130

; <label>:130                                     ; preds = %.noexc18.i
  %131 = getelementptr inbounds %"class.std::ctype"* %124, i64 0, i32 7, i64 10
  %132 = load i8* %131, align 1, !tbaa !26
  br label %.noexc11.i

; <label>:133                                     ; preds = %.noexc18.i
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %124)
          to label %.noexc20.i unwind label %149

.noexc20.i:                                       ; preds = %133
  %134 = bitcast %"class.std::ctype"* %124 to i8 (%"class.std::ctype"*, i8)***
  %135 = load i8 (%"class.std::ctype"*, i8)*** %134, align 8, !tbaa !10
  %136 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %135, i64 6
  %137 = load i8 (%"class.std::ctype"*, i8)** %136, align 8
  %138 = invoke signext i8 %137(%"class.std::ctype"* %124, i8 signext 10)
          to label %.noexc11.i unwind label %149

.noexc11.i:                                       ; preds = %.noexc20.i, %130
  %.0.i.i = phi i8 [ %132, %130 ], [ %138, %.noexc20.i ]
  %139 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i.i)
          to label %.noexc12.i unwind label %149

.noexc12.i:                                       ; preds = %.noexc11.i
  %140 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %139)
          to label %_ZNSolsEPFRSoS_E.exit.i unwind label %149

_ZNSolsEPFRSoS_E.exit.i:                          ; preds = %.noexc12.i
  %141 = call i8* @__cxa_allocate_exception(i64 16) #1
  %142 = bitcast i8* %141 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVNSt8ios_base7failureE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %142, align 8, !tbaa !10
  %143 = getelementptr inbounds i8* %141, i64 8
  %144 = bitcast i8* %143 to %"class.std::basic_string"*
  %145 = getelementptr inbounds %"class.std::ios_base::failure"* %failz.i, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %144, %"class.std::basic_string"* %145)
          to label %_ZNSt8ios_base7failureC2ERKS0_.exit.i unwind label %.body.i

_ZNSt8ios_base7failureC2ERKS0_.exit.i:            ; preds = %_ZNSolsEPFRSoS_E.exit.i
  invoke void @__cxa_throw(i8* %141, i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*), i8* bitcast (void (%"class.std::ios_base::failure"*)* @_ZNSt8ios_base7failureD1Ev to i8*)) #8
          to label %231 unwind label %149

; <label>:146                                     ; preds = %79
  %147 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %148 = extractvalue { i8*, i32 } %147, 0
  br label %175

; <label>:149                                     ; preds = %_ZNSt8ios_base7failureC2ERKS0_.exit.i, %.noexc12.i, %.noexc11.i, %.noexc20.i, %133, %126, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i, %114, %103, %99
  %150 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %151 = extractvalue { i8*, i32 } %150, 0
  br label %155

.body.i:                                          ; preds = %_ZNSolsEPFRSoS_E.exit.i
  %152 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %153 = bitcast i8* %141 to %"class.std::exception"*
  call void @_ZNSt9exceptionD2Ev(%"class.std::exception"* %153) #1
  %154 = extractvalue { i8*, i32 } %152, 0
  call void @__cxa_free_exception(i8* %141) #1
  br label %155

; <label>:155                                     ; preds = %.body.i, %149
  %.01.i = phi i8* [ %151, %149 ], [ %154, %.body.i ]
  call void @_ZNSt8ios_base7failureD1Ev(%"class.std::ios_base::failure"* %failz.i) #1
  br label %175

; <label>:156                                     ; preds = %77, %73, %56
  %157 = phi i32 [ 0, %56 ], [ 0, %73 ], [ 1, %77 ]
  %158 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %158)
  %159 = load i8** %54, align 8, !tbaa !1
  %160 = getelementptr inbounds i8* %159, i64 -24
  %161 = bitcast i8* %160 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %162 = icmp eq i8* %160, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %162, label %232, label %163, !prof !7

; <label>:163                                     ; preds = %156
  %164 = getelementptr inbounds i8* %159, i64 -8
  %165 = bitcast i8* %164 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %166, label %170

; <label>:166                                     ; preds = %163
  %167 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %167)
  %168 = atomicrmw volatile add i32* %165, i32 -1 acq_rel
  store i32 %168, i32* %3, align 4
  %169 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %167)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i

; <label>:170                                     ; preds = %163
  %171 = load i32* %165, align 4, !tbaa !8
  %172 = add nsw i32 %171, -1
  store i32 %172, i32* %165, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i: ; preds = %170, %166
  %.0.i.i.i.i15.i = phi i32 [ %169, %166 ], [ %171, %170 ]
  %173 = icmp slt i32 %.0.i.i.i.i15.i, 1
  br i1 %173, label %174, label %232

; <label>:174                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %161, %"class.std::allocator"* %4) #1
  br label %232

; <label>:175                                     ; preds = %155, %146, %68
  %.12.i = phi i8* [ %.01.i, %155 ], [ %148, %146 ], [ %70, %68 ]
  %176 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %176)
  %177 = load i8** %54, align 8, !tbaa !1
  %178 = getelementptr inbounds i8* %177, i64 -24
  %179 = bitcast i8* %178 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %180 = icmp eq i8* %178, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %180, label %193, label %181, !prof !7

; <label>:181                                     ; preds = %175
  %182 = getelementptr inbounds i8* %177, i64 -8
  %183 = bitcast i8* %182 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %184, label %188

; <label>:184                                     ; preds = %181
  %185 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %185)
  %186 = atomicrmw volatile add i32* %183, i32 -1 acq_rel
  store i32 %186, i32* %5, align 4
  %187 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %185)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i

; <label>:188                                     ; preds = %181
  %189 = load i32* %183, align 4, !tbaa !8
  %190 = add nsw i32 %189, -1
  store i32 %190, i32* %183, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i: ; preds = %188, %184
  %.0.i.i.i.i3.i = phi i32 [ %187, %184 ], [ %189, %188 ]
  %191 = icmp slt i32 %.0.i.i.i.i3.i, 1
  br i1 %191, label %192, label %193

; <label>:192                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %179, %"class.std::allocator"* %6) #1
  br label %193

; <label>:193                                     ; preds = %192, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i, %175
  call void @llvm.lifetime.end(i64 1, i8* %176)
  %194 = call i8* @__cxa_begin_catch(i8* %.12.i) #1
  %195 = load i8** %37, align 8, !tbaa !10
  %196 = getelementptr i8* %195, i64 -24
  %197 = bitcast i8* %196 to i64*
  %198 = load i64* %197, align 8
  %199 = getelementptr inbounds i8* %15, i64 %198
  %200 = bitcast i8* %199 to %"class.std::basic_ios"*
  %.sum.i = add i64 %198, 28
  %201 = getelementptr inbounds i8* %15, i64 %.sum.i
  %202 = bitcast i8* %201 to i32*
  %203 = load i32* %202, align 4, !tbaa !12
  %204 = and i32 %203, 4
  %205 = icmp eq i32 %204, 0
  %.sum23.i = add i64 %198, 32
  %206 = getelementptr inbounds i8* %15, i64 %.sum23.i
  %207 = bitcast i8* %206 to i32*
  %208 = load i32* %207, align 4, !tbaa !19
  %209 = or i32 %208, 4
  br i1 %205, label %223, label %210

; <label>:210                                     ; preds = %193
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %200, i32 %209)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i unwind label %215

; <label>:211                                     ; preds = %223, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i, %221
  %212 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %213 = extractvalue { i8*, i32 } %212, 0
  %214 = extractvalue { i8*, i32 } %212, 1
  br label %224

; <label>:215                                     ; preds = %210
  %216 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %217 = extractvalue { i8*, i32 } %216, 0
  %218 = extractvalue { i8*, i32 } %216, 1
  %219 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #1
  %220 = icmp eq i32 %218, %219
  br i1 %220, label %221, label %224

; <label>:221                                     ; preds = %215
  %222 = call i8* @__cxa_begin_catch(i8* %217) #1
  invoke void @__cxa_end_catch()
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i unwind label %211

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i: ; preds = %221, %210
  invoke void @__cxa_rethrow() #8
          to label %231 unwind label %211

; <label>:223                                     ; preds = %193
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %200, i32 %209)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i unwind label %211

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i: ; preds = %223
  invoke void @__cxa_end_catch()
          to label %232 unwind label %294

; <label>:224                                     ; preds = %215, %211
  %.03.i = phi i32 [ %214, %211 ], [ %218, %215 ]
  %.3.i = phi i8* [ %213, %211 ], [ %217, %215 ]
  invoke void @__cxa_end_catch()
          to label %225 unwind label %228

; <label>:225                                     ; preds = %224
  %226 = insertvalue { i8*, i32 } undef, i8* %.3.i, 0
  %227 = insertvalue { i8*, i32 } %226, i32 %.03.i, 1
  br label %.body

; <label>:228                                     ; preds = %224
  %229 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %230 = extractvalue { i8*, i32 } %229, 0
  call void @__clang_call_terminate(i8* %230) #9
  unreachable

; <label>:231                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i, %_ZNSt8ios_base7failureC2ERKS0_.exit.i
  unreachable

; <label>:232                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i, %174, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i, %156
  %233 = phi i32 [ %157, %156 ], [ %157, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i ], [ %157, %174 ], [ 0, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i ]
  call void @llvm.lifetime.end(i64 8, i8* %50)
  call void @llvm.lifetime.end(i64 16, i8* %51)
  call void @llvm.lifetime.end(i64 8, i8* %52)
  call void @llvm.lifetime.end(i64 1, i8* %53)
  %234 = load i8** %37, align 8, !tbaa !10
  %235 = getelementptr i8* %234, i64 -24
  %236 = bitcast i8* %235 to i64*
  %237 = load i64* %236, align 8
  %.sum113 = add i64 %237, 32
  %238 = getelementptr inbounds i8* %15, i64 %.sum113
  %239 = bitcast i8* %238 to i32*
  %240 = load i32* %239, align 4, !tbaa !19
  %241 = and i32 %240, 5
  %242 = icmp eq i32 %241, 0
  br i1 %242, label %298, label %243

; <label>:243                                     ; preds = %232
  %244 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([73 x i8]* @.str1, i64 0, i64 0), i64 72)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %294

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %243
  %245 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %246 = getelementptr i8* %245, i64 -24
  %247 = bitcast i8* %246 to i64*
  %248 = load i64* %247, align 8
  %.sum115 = add i64 %248, 240
  %249 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum115
  %250 = bitcast i8* %249 to %"class.std::ctype"**
  %251 = load %"class.std::ctype"** %250, align 8, !tbaa !21
  %252 = icmp eq %"class.std::ctype"* %251, null
  br i1 %252, label %253, label %.noexc72

; <label>:253                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc101 unwind label %294

.noexc101:                                        ; preds = %253
  unreachable

.noexc72:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %254 = getelementptr inbounds %"class.std::ctype"* %251, i64 0, i32 6
  %255 = load i8* %254, align 1, !tbaa !24
  %256 = icmp eq i8 %255, 0
  br i1 %256, label %260, label %257

; <label>:257                                     ; preds = %.noexc72
  %258 = getelementptr inbounds %"class.std::ctype"* %251, i64 0, i32 7, i64 10
  %259 = load i8* %258, align 1, !tbaa !26
  br label %.noexc13

; <label>:260                                     ; preds = %.noexc72
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %251)
          to label %.noexc76 unwind label %294

.noexc76:                                         ; preds = %260
  %261 = bitcast %"class.std::ctype"* %251 to i8 (%"class.std::ctype"*, i8)***
  %262 = load i8 (%"class.std::ctype"*, i8)*** %261, align 8, !tbaa !10
  %263 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %262, i64 6
  %264 = load i8 (%"class.std::ctype"*, i8)** %263, align 8
  %265 = invoke signext i8 %264(%"class.std::ctype"* %251, i8 signext 10)
          to label %.noexc13 unwind label %294

.noexc13:                                         ; preds = %.noexc76, %257
  %.0.i75 = phi i8 [ %259, %257 ], [ %265, %.noexc76 ]
  %266 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i75)
          to label %.noexc14 unwind label %294

.noexc14:                                         ; preds = %.noexc13
  %267 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %266)
          to label %_ZNSolsEPFRSoS_E.exit12 unwind label %294

; <label>:268                                     ; preds = %0
  %269 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %270 = extractvalue { i8*, i32 } %269, 0
  %271 = extractvalue { i8*, i32 } %269, 1
  br label %_ZNSsD1Ev.exit21

; <label>:272                                     ; preds = %16
  %273 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %274 = extractvalue { i8*, i32 } %273, 0
  %275 = extractvalue { i8*, i32 } %273, 1
  %276 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %276)
  %277 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %278 = load i8** %277, align 8, !tbaa !1
  %279 = getelementptr inbounds i8* %278, i64 -24
  %280 = bitcast i8* %279 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %281 = icmp eq i8* %279, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %281, label %_ZNSsD1Ev.exit21, label %282, !prof !7

; <label>:282                                     ; preds = %272
  %283 = getelementptr inbounds i8* %278, i64 -8
  %284 = bitcast i8* %283 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %285, label %289

; <label>:285                                     ; preds = %282
  %286 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %286)
  %287 = atomicrmw volatile add i32* %284, i32 -1 acq_rel
  store i32 %287, i32* %1, align 4
  %288 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %286)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i20

; <label>:289                                     ; preds = %282
  %290 = load i32* %284, align 4, !tbaa !8
  %291 = add nsw i32 %290, -1
  store i32 %291, i32* %284, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i20

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i20: ; preds = %289, %285
  %.0.i.i.i.i19 = phi i32 [ %288, %285 ], [ %290, %289 ]
  %292 = icmp slt i32 %.0.i.i.i.i19, 1
  br i1 %292, label %293, label %_ZNSsD1Ev.exit21

; <label>:293                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i20
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %280, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit21

; <label>:294                                     ; preds = %.noexc29, %.noexc28, %.noexc83, %320, %313, %301, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit23, %298, %.noexc14, %.noexc13, %.noexc76, %260, %253, %243, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i, %36
  %295 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  br label %.body

.body:                                            ; preds = %294, %225
  %eh.lpad-body = phi { i8*, i32 } [ %295, %294 ], [ %227, %225 ]
  %296 = extractvalue { i8*, i32 } %eh.lpad-body, 0
  %297 = extractvalue { i8*, i32 } %eh.lpad-body, 1
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss)
          to label %_ZNSsD1Ev.exit21 unwind label %474

; <label>:298                                     ; preds = %232
  %299 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([51 x i8]* @.str2, i64 0, i64 0), i64 50)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit23 unwind label %294

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit23: ; preds = %298
  %300 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %233)
          to label %301 unwind label %294

; <label>:301                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit23
  %302 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %300, i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit25 unwind label %294

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit25: ; preds = %301
  %303 = bitcast %"class.std::basic_ostream"* %300 to i8**
  %304 = load i8** %303, align 8, !tbaa !10
  %305 = getelementptr i8* %304, i64 -24
  %306 = bitcast i8* %305 to i64*
  %307 = load i64* %306, align 8
  %308 = bitcast %"class.std::basic_ostream"* %300 to i8*
  %.sum114 = add i64 %307, 240
  %309 = getelementptr inbounds i8* %308, i64 %.sum114
  %310 = bitcast i8* %309 to %"class.std::ctype"**
  %311 = load %"class.std::ctype"** %310, align 8, !tbaa !21
  %312 = icmp eq %"class.std::ctype"* %311, null
  br i1 %312, label %313, label %.noexc79

; <label>:313                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit25
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc103 unwind label %294

.noexc103:                                        ; preds = %313
  unreachable

.noexc79:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit25
  %314 = getelementptr inbounds %"class.std::ctype"* %311, i64 0, i32 6
  %315 = load i8* %314, align 1, !tbaa !24
  %316 = icmp eq i8 %315, 0
  br i1 %316, label %320, label %317

; <label>:317                                     ; preds = %.noexc79
  %318 = getelementptr inbounds %"class.std::ctype"* %311, i64 0, i32 7, i64 10
  %319 = load i8* %318, align 1, !tbaa !26
  br label %.noexc28

; <label>:320                                     ; preds = %.noexc79
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %311)
          to label %.noexc83 unwind label %294

.noexc83:                                         ; preds = %320
  %321 = bitcast %"class.std::ctype"* %311 to i8 (%"class.std::ctype"*, i8)***
  %322 = load i8 (%"class.std::ctype"*, i8)*** %321, align 8, !tbaa !10
  %323 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %322, i64 6
  %324 = load i8 (%"class.std::ctype"*, i8)** %323, align 8
  %325 = invoke signext i8 %324(%"class.std::ctype"* %311, i8 signext 10)
          to label %.noexc28 unwind label %294

.noexc28:                                         ; preds = %.noexc83, %317
  %.0.i82 = phi i8 [ %319, %317 ], [ %325, %.noexc83 ]
  %326 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %300, i8 signext %.0.i82)
          to label %.noexc29 unwind label %294

.noexc29:                                         ; preds = %.noexc28
  %327 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %326)
          to label %_ZNSolsEPFRSoS_E.exit12 unwind label %294

_ZNSolsEPFRSoS_E.exit12:                          ; preds = %.noexc29, %.noexc14
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss)
          to label %382 unwind label %328

; <label>:328                                     ; preds = %_ZNSolsEPFRSoS_E.exit12
  %329 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %330 = extractvalue { i8*, i32 } %329, 0
  %331 = extractvalue { i8*, i32 } %329, 1
  br label %_ZNSsD1Ev.exit21

_ZNSsD1Ev.exit21:                                 ; preds = %328, %.body, %293, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i20, %272, %268
  %.13 = phi i32 [ %331, %328 ], [ %297, %.body ], [ %271, %268 ], [ %275, %272 ], [ %275, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i20 ], [ %275, %293 ]
  %.1 = phi i8* [ %330, %328 ], [ %296, %.body ], [ %270, %268 ], [ %274, %272 ], [ %274, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i20 ], [ %274, %293 ]
  %332 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #1
  %333 = icmp eq i32 %.13, %332
  br i1 %333, label %334, label %383

; <label>:334                                     ; preds = %_ZNSsD1Ev.exit21
  %335 = call i8* @__cxa_begin_catch(i8* %.1) #1
  %336 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([33 x i8]* @.str6, i64 0, i64 0), i64 32)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35 unwind label %467

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35: ; preds = %334
  %337 = bitcast i8* %335 to %"class.std::ios_base::failure"*
  %338 = bitcast i8* %335 to i8* (%"class.std::ios_base::failure"*)***
  %339 = load i8* (%"class.std::ios_base::failure"*)*** %338, align 8, !tbaa !10
  %340 = getelementptr inbounds i8* (%"class.std::ios_base::failure"*)** %339, i64 2
  %341 = load i8* (%"class.std::ios_base::failure"*)** %340, align 8
  %342 = call i8* %341(%"class.std::ios_base::failure"* %337) #1
  %343 = icmp eq i8* %342, null
  br i1 %343, label %344, label %355

; <label>:344                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35
  %345 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %346 = getelementptr i8* %345, i64 -24
  %347 = bitcast i8* %346 to i64*
  %348 = load i64* %347, align 8
  %349 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %348
  %350 = bitcast i8* %349 to %"class.std::basic_ios"*
  %.sum.i36 = add i64 %348, 32
  %351 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i36
  %352 = bitcast i8* %351 to i32*
  %353 = load i32* %352, align 4, !tbaa !19
  %354 = or i32 %353, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %350, i32 %354)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit39 unwind label %467

; <label>:355                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35
  %356 = call i64 @strlen(i8* %342) #1
  %357 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %342, i64 %356)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit39 unwind label %467

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit39: ; preds = %355, %344
  %358 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i64 7)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41 unwind label %467

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit39
  %359 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %360 = getelementptr i8* %359, i64 -24
  %361 = bitcast i8* %360 to i64*
  %362 = load i64* %361, align 8
  %.sum110 = add i64 %362, 240
  %363 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum110
  %364 = bitcast i8* %363 to %"class.std::ctype"**
  %365 = load %"class.std::ctype"** %364, align 8, !tbaa !21
  %366 = icmp eq %"class.std::ctype"* %365, null
  br i1 %366, label %367, label %.noexc86

; <label>:367                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc105 unwind label %467

.noexc105:                                        ; preds = %367
  unreachable

.noexc86:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41
  %368 = getelementptr inbounds %"class.std::ctype"* %365, i64 0, i32 6
  %369 = load i8* %368, align 1, !tbaa !24
  %370 = icmp eq i8 %369, 0
  br i1 %370, label %374, label %371

; <label>:371                                     ; preds = %.noexc86
  %372 = getelementptr inbounds %"class.std::ctype"* %365, i64 0, i32 7, i64 10
  %373 = load i8* %372, align 1, !tbaa !26
  br label %.noexc44

; <label>:374                                     ; preds = %.noexc86
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %365)
          to label %.noexc90 unwind label %467

.noexc90:                                         ; preds = %374
  %375 = bitcast %"class.std::ctype"* %365 to i8 (%"class.std::ctype"*, i8)***
  %376 = load i8 (%"class.std::ctype"*, i8)*** %375, align 8, !tbaa !10
  %377 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %376, i64 6
  %378 = load i8 (%"class.std::ctype"*, i8)** %377, align 8
  %379 = invoke signext i8 %378(%"class.std::ctype"* %365, i8 signext 10)
          to label %.noexc44 unwind label %467

.noexc44:                                         ; preds = %.noexc90, %371
  %.0.i89 = phi i8 [ %373, %371 ], [ %379, %.noexc90 ]
  %380 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i89)
          to label %.noexc45 unwind label %467

.noexc45:                                         ; preds = %.noexc44
  %381 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %380)
          to label %_ZNSolsEPFRSoS_E.exit43 unwind label %467

_ZNSolsEPFRSoS_E.exit43:                          ; preds = %.noexc45
  call void @__cxa_end_catch()
  br label %382

; <label>:382                                     ; preds = %_ZNSolsEPFRSoS_E.exit, %_ZNSolsEPFRSoS_E.exit59, %_ZNSolsEPFRSoS_E.exit43, %_ZNSolsEPFRSoS_E.exit12
  ret i32 0

; <label>:383                                     ; preds = %_ZNSsD1Ev.exit21
  %384 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #1
  %385 = icmp eq i32 %.13, %384
  %386 = call i8* @__cxa_begin_catch(i8* %.1) #1
  br i1 %385, label %387, label %434

; <label>:387                                     ; preds = %383
  %388 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str5, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51 unwind label %463

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51: ; preds = %387
  %389 = bitcast i8* %386 to %"class.std::exception"*
  %390 = bitcast i8* %386 to i8* (%"class.std::exception"*)***
  %391 = load i8* (%"class.std::exception"*)*** %390, align 8, !tbaa !10
  %392 = getelementptr inbounds i8* (%"class.std::exception"*)** %391, i64 2
  %393 = load i8* (%"class.std::exception"*)** %392, align 8
  %394 = call i8* %393(%"class.std::exception"* %389) #1
  %395 = icmp eq i8* %394, null
  br i1 %395, label %396, label %407

; <label>:396                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51
  %397 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %398 = getelementptr i8* %397, i64 -24
  %399 = bitcast i8* %398 to i64*
  %400 = load i64* %399, align 8
  %401 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %400
  %402 = bitcast i8* %401 to %"class.std::basic_ios"*
  %.sum.i52 = add i64 %400, 32
  %403 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i52
  %404 = bitcast i8* %403 to i32*
  %405 = load i32* %404, align 4, !tbaa !19
  %406 = or i32 %405, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %402, i32 %406)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit55 unwind label %463

; <label>:407                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51
  %408 = call i64 @strlen(i8* %394) #1
  %409 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %394, i64 %408)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit55 unwind label %463

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit55: ; preds = %407, %396
  %410 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57 unwind label %463

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit55
  %411 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %412 = getelementptr i8* %411, i64 -24
  %413 = bitcast i8* %412 to i64*
  %414 = load i64* %413, align 8
  %.sum109 = add i64 %414, 240
  %415 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum109
  %416 = bitcast i8* %415 to %"class.std::ctype"**
  %417 = load %"class.std::ctype"** %416, align 8, !tbaa !21
  %418 = icmp eq %"class.std::ctype"* %417, null
  br i1 %418, label %419, label %.noexc93

; <label>:419                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc107 unwind label %463

.noexc107:                                        ; preds = %419
  unreachable

.noexc93:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57
  %420 = getelementptr inbounds %"class.std::ctype"* %417, i64 0, i32 6
  %421 = load i8* %420, align 1, !tbaa !24
  %422 = icmp eq i8 %421, 0
  br i1 %422, label %426, label %423

; <label>:423                                     ; preds = %.noexc93
  %424 = getelementptr inbounds %"class.std::ctype"* %417, i64 0, i32 7, i64 10
  %425 = load i8* %424, align 1, !tbaa !26
  br label %.noexc60

; <label>:426                                     ; preds = %.noexc93
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %417)
          to label %.noexc97 unwind label %463

.noexc97:                                         ; preds = %426
  %427 = bitcast %"class.std::ctype"* %417 to i8 (%"class.std::ctype"*, i8)***
  %428 = load i8 (%"class.std::ctype"*, i8)*** %427, align 8, !tbaa !10
  %429 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %428, i64 6
  %430 = load i8 (%"class.std::ctype"*, i8)** %429, align 8
  %431 = invoke signext i8 %430(%"class.std::ctype"* %417, i8 signext 10)
          to label %.noexc60 unwind label %463

.noexc60:                                         ; preds = %.noexc97, %423
  %.0.i96 = phi i8 [ %425, %423 ], [ %431, %.noexc97 ]
  %432 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i96)
          to label %.noexc61 unwind label %463

.noexc61:                                         ; preds = %.noexc60
  %433 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %432)
          to label %_ZNSolsEPFRSoS_E.exit59 unwind label %463

_ZNSolsEPFRSoS_E.exit59:                          ; preds = %.noexc61
  call void @__cxa_end_catch()
  br label %382

; <label>:434                                     ; preds = %383
  %435 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([64 x i8]* @.str4, i64 0, i64 0), i64 63)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit67 unwind label %459

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit67: ; preds = %434
  %436 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %437 = getelementptr i8* %436, i64 -24
  %438 = bitcast i8* %437 to i64*
  %439 = load i64* %438, align 8
  %.sum = add i64 %439, 240
  %440 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %441 = bitcast i8* %440 to %"class.std::ctype"**
  %442 = load %"class.std::ctype"** %441, align 8, !tbaa !21
  %443 = icmp eq %"class.std::ctype"* %442, null
  br i1 %443, label %444, label %.noexc68

; <label>:444                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit67
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc100 unwind label %459

.noexc100:                                        ; preds = %444
  unreachable

.noexc68:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit67
  %445 = getelementptr inbounds %"class.std::ctype"* %442, i64 0, i32 6
  %446 = load i8* %445, align 1, !tbaa !24
  %447 = icmp eq i8 %446, 0
  br i1 %447, label %451, label %448

; <label>:448                                     ; preds = %.noexc68
  %449 = getelementptr inbounds %"class.std::ctype"* %442, i64 0, i32 7, i64 10
  %450 = load i8* %449, align 1, !tbaa !26
  br label %.noexc

; <label>:451                                     ; preds = %.noexc68
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %442)
          to label %.noexc70 unwind label %459

.noexc70:                                         ; preds = %451
  %452 = bitcast %"class.std::ctype"* %442 to i8 (%"class.std::ctype"*, i8)***
  %453 = load i8 (%"class.std::ctype"*, i8)*** %452, align 8, !tbaa !10
  %454 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %453, i64 6
  %455 = load i8 (%"class.std::ctype"*, i8)** %454, align 8
  %456 = invoke signext i8 %455(%"class.std::ctype"* %442, i8 signext 10)
          to label %.noexc unwind label %459

.noexc:                                           ; preds = %.noexc70, %448
  %.0.i = phi i8 [ %450, %448 ], [ %456, %.noexc70 ]
  %457 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc5 unwind label %459

.noexc5:                                          ; preds = %.noexc
  %458 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %457)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %459

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc5
  call void @__cxa_end_catch()
  br label %382

; <label>:459                                     ; preds = %.noexc5, %.noexc, %.noexc70, %451, %444, %434
  %460 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %461 = extractvalue { i8*, i32 } %460, 0
  %462 = extractvalue { i8*, i32 } %460, 1
  invoke void @__cxa_end_catch()
          to label %471 unwind label %474

; <label>:463                                     ; preds = %.noexc61, %.noexc60, %.noexc97, %426, %419, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit55, %407, %396, %387
  %464 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %465 = extractvalue { i8*, i32 } %464, 0
  %466 = extractvalue { i8*, i32 } %464, 1
  invoke void @__cxa_end_catch()
          to label %471 unwind label %474

; <label>:467                                     ; preds = %.noexc45, %.noexc44, %.noexc90, %374, %367, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit39, %355, %344, %334
  %468 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %469 = extractvalue { i8*, i32 } %468, 0
  %470 = extractvalue { i8*, i32 } %468, 1
  invoke void @__cxa_end_catch()
          to label %471 unwind label %474

; <label>:471                                     ; preds = %467, %463, %459
  %.24 = phi i32 [ %470, %467 ], [ %466, %463 ], [ %462, %459 ]
  %.2 = phi i8* [ %469, %467 ], [ %465, %463 ], [ %461, %459 ]
  %472 = insertvalue { i8*, i32 } undef, i8* %.2, 0
  %473 = insertvalue { i8*, i32 } %472, i32 %.24, 1
  resume { i8*, i32 } %473

; <label>:474                                     ; preds = %467, %463, %459, %.body
  %475 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %476 = extractvalue { i8*, i32 } %475, 0
  call void @__clang_call_terminate(i8* %476) #9
  unreachable
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = bitcast %"class.std::basic_istringstream"* %this to i8*
  %4 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2
  %5 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0
  call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %5) #1
  %6 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %6, align 8, !tbaa !10
  %7 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %7, align 8, !tbaa !27
  %8 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %8, align 1, !tbaa !28
  %9 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %9, align 1, !tbaa !29
  %10 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 4
  %11 = bitcast %"class.std::basic_streambuf"** %10 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 32, i32 8, i1 false) #1
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
  store i64 0, i64* %21, align 8, !tbaa !30
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
  call void @llvm.lifetime.start(i64 1, i8* %51)
  %52 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %53 = load i8** %52, align 8, !tbaa !1
  %54 = getelementptr inbounds i8* %53, i64 -24
  %55 = bitcast i8* %54 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %56 = icmp eq i8* %54, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %56, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit, label %57, !prof !7

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
  %65 = load i32* %59, align 4, !tbaa !8
  %66 = add nsw i32 %65, -1
  store i32 %66, i32* %59, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %64, %60
  %.0.i.i.i.i.i = phi i32 [ %63, %60 ], [ %65, %64 ]
  %67 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %67, label %68, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

; <label>:68                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %55, %"class.std::allocator"* %2) #1
  br label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %68, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %46
  call void @llvm.lifetime.end(i64 1, i8* %51)
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !10
  %69 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %69) #1
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
  store i64 0, i64* %21, align 8, !tbaa !30
  br label %78

; <label>:78                                      ; preds = %70, %38
  %.12 = phi i8* [ %.01, %70 ], [ %40, %38 ]
  %.1 = phi i32 [ %.0, %70 ], [ %41, %38 ]
  invoke void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %5)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEED2Ev.exit unwind label %81

_ZNSt9basic_iosIcSt11char_traitsIcEED2Ev.exit:    ; preds = %78
  %79 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %80 = insertvalue { i8*, i32 } %79, i32 %.1, 1
  resume { i8*, i32 } %80

; <label>:81                                      ; preds = %78
  %82 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %83 = extractvalue { i8*, i32 } %82, 0
  call void @__clang_call_terminate(i8* %83) #9
  unreachable
}

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #3 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #1
  tail call void @_ZSt9terminatev() #9
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"*, i32) #0

; Function Attrs: uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %this) unnamed_addr #2 align 2 {
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
  call void @llvm.lifetime.start(i64 1, i8* %13)
  %14 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %15 = load i8** %14, align 8, !tbaa !1
  %16 = getelementptr inbounds i8* %15, i64 -24
  %17 = bitcast i8* %16 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %18 = icmp eq i8* %16, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %18, label %31, label %19, !prof !7

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
  %27 = load i32* %21, align 4, !tbaa !8
  %28 = add nsw i32 %27, -1
  store i32 %28, i32* %21, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i: ; preds = %26, %22
  %.0.i.i.i.i.i.i = phi i32 [ %25, %22 ], [ %27, %26 ]
  %29 = icmp slt i32 %.0.i.i.i.i.i.i, 1
  br i1 %29, label %30, label %31

; <label>:30                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %17, %"class.std::allocator"* %2) #1
  br label %31

; <label>:31                                      ; preds = %30, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %0
  call void @llvm.lifetime.end(i64 1, i8* %13)
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !10
  %32 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %32) #1
  %33 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.c.i.i = bitcast i8* %33 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %4, align 8, !tbaa !10
  %34 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %35 = getelementptr i8* %33, i64 -24
  %36 = bitcast i8* %35 to i64*
  %37 = load i64* %36, align 8
  %38 = getelementptr inbounds i8* %9, i64 %37
  %39 = bitcast i8* %38 to i8**
  store i8* %34, i8** %39, align 8, !tbaa !10
  %40 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %40, align 8, !tbaa !30
  %41 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %41)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #4

declare void @__cxa_end_catch()

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #5

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

; Function Attrs: uwtable
define available_externally void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::allocator", align 1
  %4 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !10
  %5 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 1
  %6 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 7
  %7 = bitcast i8** %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 48, i32 8, i1 false) #1
  call void @_ZNSt6localeC1Ev(%"class.std::locale"* %6) #1
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !10
  %8 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 1
  store i32 0, i32* %8, align 4, !tbaa !32
  %9 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2
  %10 = getelementptr inbounds %"class.std::basic_string"* %__str, i64 0, i32 0, i32 0
  %11 = load i8** %10, align 8, !tbaa !1
  %12 = getelementptr inbounds i8* %11, i64 -24
  %13 = bitcast i8* %12 to i64*
  %14 = load i64* %13, align 8, !tbaa !35
  invoke void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"* %9, i8* %11, i64 %14, %"class.std::allocator"* %3)
          to label %15 unwind label %22

; <label>:15                                      ; preds = %0
  store i32 %__mode, i32* %8, align 4, !tbaa !32
  %16 = and i32 %__mode, 3
  %17 = icmp eq i32 %16, 0
  %.phi.trans.insert.i = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2, i32 0, i32 0
  %.pre.i = load i8** %.phi.trans.insert.i, align 8, !tbaa !1
  br i1 %17, label %._crit_edge.i, label %18

; <label>:18                                      ; preds = %15
  %19 = getelementptr inbounds i8* %.pre.i, i64 -24
  %20 = bitcast i8* %19 to i64*
  %21 = load i64* %20, align 8, !tbaa !35
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
  call void @llvm.lifetime.start(i64 1, i8* %30)
  %31 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %32 = load i8** %31, align 8, !tbaa !1
  %33 = getelementptr inbounds i8* %32, i64 -24
  %34 = bitcast i8* %33 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %35 = icmp eq i8* %33, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %35, label %_ZNSsD1Ev.exit, label %36, !prof !7

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
  %44 = load i32* %38, align 4, !tbaa !8
  %45 = add nsw i32 %44, -1
  store i32 %45, i32* %38, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %43, %39
  %.0.i.i.i.i = phi i32 [ %42, %39 ], [ %44, %43 ]
  %46 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %46, label %47, label %_ZNSsD1Ev.exit

; <label>:47                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %34, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %47, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %26, %22
  %.01 = phi i8* [ %24, %22 ], [ %28, %26 ], [ %28, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %28, %47 ]
  %.0 = phi i32 [ %25, %22 ], [ %29, %26 ], [ %29, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %29, %47 ]
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !10
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %6) #1
  %48 = insertvalue { i8*, i32 } undef, i8* %.01, 0
  %49 = insertvalue { i8*, i32 } %48, i32 %.0, 1
  resume { i8*, i32 } %49
}

declare void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"*, i8*, i64, %"class.std::allocator"*) #0

declare void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"*, i8*, i64, i64) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeC1Ev(%"class.std::locale"*) #5

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"*) #5

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #6

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #7

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #5

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #5

declare %"class.std::basic_istream"* @_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RSbIS4_S5_T1_E(%"class.std::basic_istream"*, %"class.std::basic_string"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base7failureC1ERKSs(%"class.std::ios_base::failure"*, %"class.std::basic_string"*) #5

; Function Attrs: nounwind
declare i8* @_ZNKSt8ios_base7failure4whatEv(%"class.std::ios_base::failure"*) #5

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_free_exception(i8*)

; Function Attrs: nounwind
declare void @_ZNSt8ios_base7failureD1Ev(%"class.std::ios_base::failure"*) #5

declare void @__cxa_throw(i8*, i8*, i8*)

declare void @__cxa_rethrow()

declare void @_ZNSsC1ERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #0

; Function Attrs: nounwind
declare void @_ZNSt9exceptionD2Ev(%"class.std::exception"*) #5

declare i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"*, i8*) #0

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline noreturn nounwind }
attributes #4 = { nounwind readnone }
attributes #5 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { noreturn }
attributes #9 = { noreturn nounwind }

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
!12 = metadata !{metadata !13, metadata !16, i64 28}
!13 = metadata !{metadata !"_ZTSSt8ios_base", metadata !14, i64 8, metadata !14, i64 16, metadata !15, i64 24, metadata !16, i64 28, metadata !16, i64 32, metadata !4, i64 40, metadata !17, i64 48, metadata !5, i64 64, metadata !9, i64 192, metadata !4, i64 200, metadata !18, i64 208}
!14 = metadata !{metadata !"long", metadata !5, i64 0}
!15 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !5, i64 0}
!16 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !5, i64 0}
!17 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !4, i64 0, metadata !14, i64 8}
!18 = metadata !{metadata !"_ZTSSt6locale", metadata !4, i64 0}
!19 = metadata !{metadata !13, metadata !16, i64 32}
!20 = metadata !{metadata !3, metadata !4, i64 0}
!21 = metadata !{metadata !22, metadata !4, i64 240}
!22 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !4, i64 216, metadata !5, i64 224, metadata !23, i64 225, metadata !4, i64 232, metadata !4, i64 240, metadata !4, i64 248, metadata !4, i64 256}
!23 = metadata !{metadata !"bool", metadata !5, i64 0}
!24 = metadata !{metadata !25, metadata !5, i64 56}
!25 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !4, i64 16, metadata !23, i64 24, metadata !4, i64 32, metadata !4, i64 40, metadata !4, i64 48, metadata !5, i64 56, metadata !5, i64 57, metadata !5, i64 313, metadata !5, i64 569}
!26 = metadata !{metadata !5, metadata !5, i64 0}
!27 = metadata !{metadata !22, metadata !4, i64 216}
!28 = metadata !{metadata !22, metadata !5, i64 224}
!29 = metadata !{metadata !22, metadata !23, i64 225}
!30 = metadata !{metadata !31, metadata !14, i64 8}
!31 = metadata !{metadata !"_ZTSSi", metadata !14, i64 8}
!32 = metadata !{metadata !33, metadata !34, i64 64}
!33 = metadata !{metadata !"_ZTSSt15basic_stringbufIcSt11char_traitsIcESaIcEE", metadata !34, i64 64, metadata !2, i64 72}
!34 = metadata !{metadata !"_ZTSSt13_Ios_Openmode", metadata !5, i64 0}
!35 = metadata !{metadata !36, metadata !14, i64 0}
!36 = metadata !{metadata !"_ZTSNSs9_Rep_baseE", metadata !14, i64 0, metadata !14, i64 8, metadata !9, i64 16}
