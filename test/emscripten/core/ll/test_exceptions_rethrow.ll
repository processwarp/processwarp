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
  call void @llvm.lifetime.start(i64 360, i8* %15) #2
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %13, i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %14)
          to label %16 unwind label %266

; <label>:16                                      ; preds = %0
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss, %"class.std::basic_string"* %13, i32 8)
          to label %17 unwind label %270

; <label>:17                                      ; preds = %16
  %18 = getelementptr inbounds %"class.std::allocator"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %18) #2
  %19 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %20 = load i8** %19, align 8, !tbaa !1
  %21 = getelementptr inbounds i8* %20, i64 -24
  %22 = bitcast i8* %21 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %23 = icmp eq i8* %21, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %23, label %_ZNSsD1Ev.exit, label %24, !prof !7

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
  br i1 %34, label %35, label %_ZNSsD1Ev.exit

; <label>:35                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %22, %"class.std::allocator"* %12) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %35, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %17
  call void @llvm.lifetime.end(i64 1, i8* %18) #2
  %36 = bitcast %"class.std::basic_istringstream"* %iss to i8**
  %37 = load i8** %36, align 8, !tbaa !10
  %38 = getelementptr i8* %37, i64 -24
  %39 = bitcast i8* %38 to i64*
  %40 = load i64* %39, align 8
  %41 = getelementptr inbounds i8* %15, i64 %40
  %42 = bitcast i8* %41 to %"class.std::basic_ios"*
  %.sum111 = add i64 %40, 28
  %43 = getelementptr inbounds i8* %15, i64 %.sum111
  %44 = bitcast i8* %43 to i32*
  store i32 4, i32* %44, align 4, !tbaa !12
  %.sum112 = add i64 %40, 32
  %45 = getelementptr inbounds i8* %15, i64 %.sum112
  %46 = bitcast i8* %45 to i32*
  %47 = load i32* %46, align 4, !tbaa !19
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %42, i32 %47)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit unwind label %292

_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit: ; preds = %_ZNSsD1Ev.exit
  %48 = bitcast %"class.std::basic_istringstream"* %iss to %"class.std::basic_istream"*
  %49 = bitcast %"class.std::basic_string"* %raw.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %49)
  %50 = bitcast %"class.std::ios_base::failure"* %failz.i to i8*
  call void @llvm.lifetime.start(i64 16, i8* %50)
  %51 = bitcast %"class.std::basic_string"* %9 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %51)
  %52 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %52)
  %53 = getelementptr inbounds %"class.std::basic_string"* %raw.i, i64 0, i32 0, i32 0
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %53, align 8, !tbaa !20
  %54 = invoke %"class.std::basic_istream"* @_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RSbIS4_S5_T1_E(%"class.std::basic_istream"* %48, %"class.std::basic_string"* %raw.i)
          to label %55 unwind label %67

; <label>:55                                      ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit
  %56 = bitcast %"class.std::basic_istream"* %54 to i8**
  %57 = load i8** %56, align 8, !tbaa !10
  %58 = getelementptr i8* %57, i64 -24
  %59 = bitcast i8* %58 to i64*
  %60 = load i64* %59, align 8
  %61 = bitcast %"class.std::basic_istream"* %54 to i8*
  %.sum24.i = add i64 %60, 32
  %62 = getelementptr inbounds i8* %61, i64 %.sum24.i
  %63 = bitcast i8* %62 to i32*
  %64 = load i32* %63, align 4, !tbaa !19
  %65 = and i32 %64, 5
  %66 = icmp eq i32 %65, 0
  br i1 %66, label %70, label %154

; <label>:67                                      ; preds = %74, %70, %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit
  %68 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %69 = extractvalue { i8*, i32 } %68, 0
  br label %173

; <label>:70                                      ; preds = %55
  %71 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw.i, i8* getelementptr inbounds ([5 x i8]* @.str8, i64 0, i64 0))
          to label %72 unwind label %67

; <label>:72                                      ; preds = %70
  %73 = icmp eq i32 %71, 0
  br i1 %73, label %154, label %74

; <label>:74                                      ; preds = %72
  %75 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw.i, i8* getelementptr inbounds ([4 x i8]* @.str9, i64 0, i64 0))
          to label %76 unwind label %67

; <label>:76                                      ; preds = %74
  %77 = icmp eq i32 %75, 0
  br i1 %77, label %154, label %78

; <label>:78                                      ; preds = %76
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %9, i8* getelementptr inbounds ([16 x i8]* @.str10, i64 0, i64 0), %"class.std::allocator"* %10)
          to label %79 unwind label %144

; <label>:79                                      ; preds = %78
  call void @_ZNSt8ios_base7failureC1ERKSs(%"class.std::ios_base::failure"* %failz.i, %"class.std::basic_string"* %9) #2
  %80 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %80) #2
  %81 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %82 = load i8** %81, align 8, !tbaa !1
  %83 = getelementptr inbounds i8* %82, i64 -24
  %84 = bitcast i8* %83 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %85 = icmp eq i8* %83, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %85, label %_ZNSsD1Ev.exit.i, label %86, !prof !7

; <label>:86                                      ; preds = %79
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
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:93                                      ; preds = %86
  %94 = load i32* %88, align 4, !tbaa !8
  %95 = add nsw i32 %94, -1
  store i32 %95, i32* %88, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %93, %89
  %.0.i.i.i.i.i = phi i32 [ %92, %89 ], [ %94, %93 ]
  %96 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %96, label %97, label %_ZNSsD1Ev.exit.i

; <label>:97                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %84, %"class.std::allocator"* %8) #2
  br label %_ZNSsD1Ev.exit.i

_ZNSsD1Ev.exit.i:                                 ; preds = %97, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %79
  call void @llvm.lifetime.end(i64 1, i8* %80) #2
  %98 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([35 x i8]* @.str11, i64 0, i64 0), i64 34)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i unwind label %147

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i: ; preds = %_ZNSsD1Ev.exit.i
  %99 = call i8* @_ZNKSt8ios_base7failure4whatEv(%"class.std::ios_base::failure"* %failz.i) #2
  %100 = icmp eq i8* %99, null
  br i1 %100, label %101, label %112

; <label>:101                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i
  %102 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %103 = getelementptr i8* %102, i64 -24
  %104 = bitcast i8* %103 to i64*
  %105 = load i64* %104, align 8
  %106 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %105
  %107 = bitcast i8* %106 to %"class.std::basic_ios"*
  %.sum.i.i = add i64 %105, 32
  %108 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i.i
  %109 = bitcast i8* %108 to i32*
  %110 = load i32* %109, align 4, !tbaa !19
  %111 = or i32 %110, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %107, i32 %111)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i unwind label %147

; <label>:112                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i
  %113 = call i64 @strlen(i8* %99) #2
  %114 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %99, i64 %113)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i unwind label %147

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i: ; preds = %112, %101
  %115 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([5 x i8]* @.str12, i64 0, i64 0), i64 4)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i unwind label %147

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i
  %116 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %117 = getelementptr i8* %116, i64 -24
  %118 = bitcast i8* %117 to i64*
  %119 = load i64* %118, align 8
  %.sum25.i = add i64 %119, 240
  %120 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum25.i
  %121 = bitcast i8* %120 to %"class.std::ctype"**
  %122 = load %"class.std::ctype"** %121, align 8, !tbaa !21
  %123 = icmp eq %"class.std::ctype"* %122, null
  br i1 %123, label %124, label %.noexc18.i

; <label>:124                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc22.i unwind label %147

.noexc22.i:                                       ; preds = %124
  unreachable

.noexc18.i:                                       ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9.i
  %125 = getelementptr inbounds %"class.std::ctype"* %122, i64 0, i32 6
  %126 = load i8* %125, align 1, !tbaa !24
  %127 = icmp eq i8 %126, 0
  br i1 %127, label %131, label %128

; <label>:128                                     ; preds = %.noexc18.i
  %129 = getelementptr inbounds %"class.std::ctype"* %122, i64 0, i32 7, i64 10
  %130 = load i8* %129, align 1, !tbaa !26
  br label %.noexc11.i

; <label>:131                                     ; preds = %.noexc18.i
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %122)
          to label %.noexc20.i unwind label %147

.noexc20.i:                                       ; preds = %131
  %132 = bitcast %"class.std::ctype"* %122 to i8 (%"class.std::ctype"*, i8)***
  %133 = load i8 (%"class.std::ctype"*, i8)*** %132, align 8, !tbaa !10
  %134 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %133, i64 6
  %135 = load i8 (%"class.std::ctype"*, i8)** %134, align 8
  %136 = invoke signext i8 %135(%"class.std::ctype"* %122, i8 signext 10)
          to label %.noexc11.i unwind label %147

.noexc11.i:                                       ; preds = %.noexc20.i, %128
  %.0.i.i = phi i8 [ %130, %128 ], [ %136, %.noexc20.i ]
  %137 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i.i)
          to label %.noexc12.i unwind label %147

.noexc12.i:                                       ; preds = %.noexc11.i
  %138 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %137)
          to label %_ZNSolsEPFRSoS_E.exit.i unwind label %147

_ZNSolsEPFRSoS_E.exit.i:                          ; preds = %.noexc12.i
  %139 = call i8* @__cxa_allocate_exception(i64 16) #2
  %140 = bitcast i8* %139 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVNSt8ios_base7failureE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %140, align 8, !tbaa !10
  %141 = getelementptr inbounds i8* %139, i64 8
  %142 = bitcast i8* %141 to %"class.std::basic_string"*
  %143 = getelementptr inbounds %"class.std::ios_base::failure"* %failz.i, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %142, %"class.std::basic_string"* %143)
          to label %_ZNSt8ios_base7failureC2ERKS0_.exit.i unwind label %.body.i

_ZNSt8ios_base7failureC2ERKS0_.exit.i:            ; preds = %_ZNSolsEPFRSoS_E.exit.i
  invoke void @__cxa_throw(i8* %139, i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*), i8* bitcast (void (%"class.std::ios_base::failure"*)* @_ZNSt8ios_base7failureD1Ev to i8*)) #9
          to label %229 unwind label %147

; <label>:144                                     ; preds = %78
  %145 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %146 = extractvalue { i8*, i32 } %145, 0
  br label %173

; <label>:147                                     ; preds = %_ZNSt8ios_base7failureC2ERKS0_.exit.i, %.noexc12.i, %.noexc11.i, %.noexc20.i, %131, %124, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7.i, %112, %101, %_ZNSsD1Ev.exit.i
  %148 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %149 = extractvalue { i8*, i32 } %148, 0
  br label %153

.body.i:                                          ; preds = %_ZNSolsEPFRSoS_E.exit.i
  %150 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %151 = bitcast i8* %139 to %"class.std::exception"*
  call void @_ZNSt9exceptionD2Ev(%"class.std::exception"* %151) #2
  %152 = extractvalue { i8*, i32 } %150, 0
  call void @__cxa_free_exception(i8* %139) #2
  br label %153

; <label>:153                                     ; preds = %.body.i, %147
  %.01.i = phi i8* [ %149, %147 ], [ %152, %.body.i ]
  call void @_ZNSt8ios_base7failureD1Ev(%"class.std::ios_base::failure"* %failz.i) #2
  br label %173

; <label>:154                                     ; preds = %76, %72, %55
  %155 = phi i32 [ 0, %55 ], [ 0, %72 ], [ 1, %76 ]
  %156 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %156) #2
  %157 = load i8** %53, align 8, !tbaa !1
  %158 = getelementptr inbounds i8* %157, i64 -24
  %159 = bitcast i8* %158 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %160 = icmp eq i8* %158, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %160, label %230, label %161, !prof !7

; <label>:161                                     ; preds = %154
  %162 = getelementptr inbounds i8* %157, i64 -8
  %163 = bitcast i8* %162 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %164, label %168

; <label>:164                                     ; preds = %161
  %165 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %165)
  %166 = atomicrmw volatile add i32* %163, i32 -1 acq_rel
  store i32 %166, i32* %3, align 4
  %167 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %165)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i

; <label>:168                                     ; preds = %161
  %169 = load i32* %163, align 4, !tbaa !8
  %170 = add nsw i32 %169, -1
  store i32 %170, i32* %163, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i: ; preds = %168, %164
  %.0.i.i.i.i15.i = phi i32 [ %167, %164 ], [ %169, %168 ]
  %171 = icmp slt i32 %.0.i.i.i.i15.i, 1
  br i1 %171, label %172, label %230

; <label>:172                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %159, %"class.std::allocator"* %4) #2
  br label %230

; <label>:173                                     ; preds = %153, %144, %67
  %.12.i = phi i8* [ %.01.i, %153 ], [ %146, %144 ], [ %69, %67 ]
  %174 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %174) #2
  %175 = load i8** %53, align 8, !tbaa !1
  %176 = getelementptr inbounds i8* %175, i64 -24
  %177 = bitcast i8* %176 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %178 = icmp eq i8* %176, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %178, label %191, label %179, !prof !7

; <label>:179                                     ; preds = %173
  %180 = getelementptr inbounds i8* %175, i64 -8
  %181 = bitcast i8* %180 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %182, label %186

; <label>:182                                     ; preds = %179
  %183 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %183)
  %184 = atomicrmw volatile add i32* %181, i32 -1 acq_rel
  store i32 %184, i32* %5, align 4
  %185 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %183)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i

; <label>:186                                     ; preds = %179
  %187 = load i32* %181, align 4, !tbaa !8
  %188 = add nsw i32 %187, -1
  store i32 %188, i32* %181, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i: ; preds = %186, %182
  %.0.i.i.i.i3.i = phi i32 [ %185, %182 ], [ %187, %186 ]
  %189 = icmp slt i32 %.0.i.i.i.i3.i, 1
  br i1 %189, label %190, label %191

; <label>:190                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %177, %"class.std::allocator"* %6) #2
  br label %191

; <label>:191                                     ; preds = %190, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4.i, %173
  call void @llvm.lifetime.end(i64 1, i8* %174) #2
  %192 = call i8* @__cxa_begin_catch(i8* %.12.i) #2
  %193 = load i8** %36, align 8, !tbaa !10
  %194 = getelementptr i8* %193, i64 -24
  %195 = bitcast i8* %194 to i64*
  %196 = load i64* %195, align 8
  %197 = getelementptr inbounds i8* %15, i64 %196
  %198 = bitcast i8* %197 to %"class.std::basic_ios"*
  %.sum.i = add i64 %196, 28
  %199 = getelementptr inbounds i8* %15, i64 %.sum.i
  %200 = bitcast i8* %199 to i32*
  %201 = load i32* %200, align 4, !tbaa !12
  %202 = and i32 %201, 4
  %203 = icmp eq i32 %202, 0
  %.sum23.i = add i64 %196, 32
  %204 = getelementptr inbounds i8* %15, i64 %.sum23.i
  %205 = bitcast i8* %204 to i32*
  %206 = load i32* %205, align 4, !tbaa !19
  %207 = or i32 %206, 4
  br i1 %203, label %221, label %208

; <label>:208                                     ; preds = %191
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %198, i32 %207)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i unwind label %213

; <label>:209                                     ; preds = %221, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i, %219
  %210 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %211 = extractvalue { i8*, i32 } %210, 0
  %212 = extractvalue { i8*, i32 } %210, 1
  br label %222

; <label>:213                                     ; preds = %208
  %214 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %215 = extractvalue { i8*, i32 } %214, 0
  %216 = extractvalue { i8*, i32 } %214, 1
  %217 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #2
  %218 = icmp eq i32 %216, %217
  br i1 %218, label %219, label %222

; <label>:219                                     ; preds = %213
  %220 = call i8* @__cxa_begin_catch(i8* %215) #2
  invoke void @__cxa_end_catch()
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i unwind label %209

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i: ; preds = %219, %208
  invoke void @__cxa_rethrow() #9
          to label %229 unwind label %209

; <label>:221                                     ; preds = %191
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %198, i32 %207)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i unwind label %209

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i: ; preds = %221
  invoke void @__cxa_end_catch()
          to label %230 unwind label %292

; <label>:222                                     ; preds = %213, %209
  %.03.i = phi i32 [ %212, %209 ], [ %216, %213 ]
  %.3.i = phi i8* [ %211, %209 ], [ %215, %213 ]
  invoke void @__cxa_end_catch()
          to label %223 unwind label %226

; <label>:223                                     ; preds = %222
  %224 = insertvalue { i8*, i32 } undef, i8* %.3.i, 0
  %225 = insertvalue { i8*, i32 } %224, i32 %.03.i, 1
  br label %.body

; <label>:226                                     ; preds = %222
  %227 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %228 = extractvalue { i8*, i32 } %227, 0
  call void @__clang_call_terminate(i8* %228) #10
  unreachable

; <label>:229                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2.i, %_ZNSt8ios_base7failureC2ERKS0_.exit.i
  unreachable

; <label>:230                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i, %172, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i, %154
  %231 = phi i32 [ %155, %154 ], [ %155, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i16.i ], [ %155, %172 ], [ 0, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i ]
  call void @llvm.lifetime.end(i64 8, i8* %49)
  call void @llvm.lifetime.end(i64 16, i8* %50)
  call void @llvm.lifetime.end(i64 8, i8* %51)
  call void @llvm.lifetime.end(i64 1, i8* %52)
  %232 = load i8** %36, align 8, !tbaa !10
  %233 = getelementptr i8* %232, i64 -24
  %234 = bitcast i8* %233 to i64*
  %235 = load i64* %234, align 8
  %.sum113 = add i64 %235, 32
  %236 = getelementptr inbounds i8* %15, i64 %.sum113
  %237 = bitcast i8* %236 to i32*
  %238 = load i32* %237, align 4, !tbaa !19
  %239 = and i32 %238, 5
  %240 = icmp eq i32 %239, 0
  br i1 %240, label %423, label %241

; <label>:241                                     ; preds = %230
  %242 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([73 x i8]* @.str1, i64 0, i64 0), i64 72)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %292

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %241
  %243 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %244 = getelementptr i8* %243, i64 -24
  %245 = bitcast i8* %244 to i64*
  %246 = load i64* %245, align 8
  %.sum115 = add i64 %246, 240
  %247 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum115
  %248 = bitcast i8* %247 to %"class.std::ctype"**
  %249 = load %"class.std::ctype"** %248, align 8, !tbaa !21
  %250 = icmp eq %"class.std::ctype"* %249, null
  br i1 %250, label %251, label %.noexc68

; <label>:251                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc100 unwind label %292

.noexc100:                                        ; preds = %251
  unreachable

.noexc68:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %252 = getelementptr inbounds %"class.std::ctype"* %249, i64 0, i32 6
  %253 = load i8* %252, align 1, !tbaa !24
  %254 = icmp eq i8 %253, 0
  br i1 %254, label %258, label %255

; <label>:255                                     ; preds = %.noexc68
  %256 = getelementptr inbounds %"class.std::ctype"* %249, i64 0, i32 7, i64 10
  %257 = load i8* %256, align 1, !tbaa !26
  br label %.noexc7

; <label>:258                                     ; preds = %.noexc68
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %249)
          to label %.noexc70 unwind label %292

.noexc70:                                         ; preds = %258
  %259 = bitcast %"class.std::ctype"* %249 to i8 (%"class.std::ctype"*, i8)***
  %260 = load i8 (%"class.std::ctype"*, i8)*** %259, align 8, !tbaa !10
  %261 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %260, i64 6
  %262 = load i8 (%"class.std::ctype"*, i8)** %261, align 8
  %263 = invoke signext i8 %262(%"class.std::ctype"* %249, i8 signext 10)
          to label %.noexc7 unwind label %292

.noexc7:                                          ; preds = %.noexc70, %255
  %.0.i = phi i8 [ %257, %255 ], [ %263, %.noexc70 ]
  %264 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc8 unwind label %292

.noexc8:                                          ; preds = %.noexc7
  %265 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %264)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %292

; <label>:266                                     ; preds = %0
  %267 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %268 = extractvalue { i8*, i32 } %267, 0
  %269 = extractvalue { i8*, i32 } %267, 1
  br label %_ZNSsD1Ev.exit13

; <label>:270                                     ; preds = %16
  %271 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  %272 = extractvalue { i8*, i32 } %271, 0
  %273 = extractvalue { i8*, i32 } %271, 1
  %274 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %274) #2
  %275 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %276 = load i8** %275, align 8, !tbaa !1
  %277 = getelementptr inbounds i8* %276, i64 -24
  %278 = bitcast i8* %277 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %279 = icmp eq i8* %277, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %279, label %_ZNSsD1Ev.exit13, label %280, !prof !7

; <label>:280                                     ; preds = %270
  %281 = getelementptr inbounds i8* %276, i64 -8
  %282 = bitcast i8* %281 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %283, label %287

; <label>:283                                     ; preds = %280
  %284 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %284)
  %285 = atomicrmw volatile add i32* %282, i32 -1 acq_rel
  store i32 %285, i32* %1, align 4
  %286 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %284)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12

; <label>:287                                     ; preds = %280
  %288 = load i32* %282, align 4, !tbaa !8
  %289 = add nsw i32 %288, -1
  store i32 %289, i32* %282, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12: ; preds = %287, %283
  %.0.i.i.i.i11 = phi i32 [ %286, %283 ], [ %288, %287 ]
  %290 = icmp slt i32 %.0.i.i.i.i11, 1
  br i1 %290, label %291, label %_ZNSsD1Ev.exit13

; <label>:291                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %278, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit13

; <label>:292                                     ; preds = %.noexc63, %.noexc62, %.noexc97, %445, %438, %426, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57, %423, %.noexc8, %.noexc7, %.noexc70, %258, %251, %241, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit.i, %_ZNSsD1Ev.exit
  %293 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* null
  br label %.body

.body:                                            ; preds = %292, %223
  %eh.lpad-body = phi { i8*, i32 } [ %293, %292 ], [ %225, %223 ]
  %294 = extractvalue { i8*, i32 } %eh.lpad-body, 0
  %295 = extractvalue { i8*, i32 } %eh.lpad-body, 1
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss) #2
  br label %_ZNSsD1Ev.exit13

_ZNSsD1Ev.exit13:                                 ; preds = %.body, %291, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12, %270, %266
  %.13 = phi i32 [ %295, %.body ], [ %269, %266 ], [ %273, %270 ], [ %273, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12 ], [ %273, %291 ]
  %.1 = phi i8* [ %294, %.body ], [ %268, %266 ], [ %272, %270 ], [ %272, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i12 ], [ %272, %291 ]
  %296 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #2
  %297 = icmp eq i32 %.13, %296
  br i1 %297, label %298, label %347

; <label>:298                                     ; preds = %_ZNSsD1Ev.exit13
  %299 = call i8* @__cxa_begin_catch(i8* %.1) #2
  %300 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([33 x i8]* @.str6, i64 0, i64 0), i64 32)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15 unwind label %461

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15: ; preds = %298
  %301 = bitcast i8* %299 to %"class.std::ios_base::failure"*
  %302 = bitcast i8* %299 to i8* (%"class.std::ios_base::failure"*)***
  %303 = load i8* (%"class.std::ios_base::failure"*)*** %302, align 8, !tbaa !10
  %304 = getelementptr inbounds i8* (%"class.std::ios_base::failure"*)** %303, i64 2
  %305 = load i8* (%"class.std::ios_base::failure"*)** %304, align 8
  %306 = call i8* %305(%"class.std::ios_base::failure"* %301) #2
  %307 = icmp eq i8* %306, null
  br i1 %307, label %308, label %319

; <label>:308                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15
  %309 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %310 = getelementptr i8* %309, i64 -24
  %311 = bitcast i8* %310 to i64*
  %312 = load i64* %311, align 8
  %313 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %312
  %314 = bitcast i8* %313 to %"class.std::basic_ios"*
  %.sum.i16 = add i64 %312, 32
  %315 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i16
  %316 = bitcast i8* %315 to i32*
  %317 = load i32* %316, align 4, !tbaa !19
  %318 = or i32 %317, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %314, i32 %318)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit19 unwind label %461

; <label>:319                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15
  %320 = call i64 @strlen(i8* %306) #2
  %321 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %306, i64 %320)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit19 unwind label %461

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit19: ; preds = %319, %308
  %322 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i64 7)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit21 unwind label %461

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit21: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit19
  %323 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %324 = getelementptr i8* %323, i64 -24
  %325 = bitcast i8* %324 to i64*
  %326 = load i64* %325, align 8
  %.sum110 = add i64 %326, 240
  %327 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum110
  %328 = bitcast i8* %327 to %"class.std::ctype"**
  %329 = load %"class.std::ctype"** %328, align 8, !tbaa !21
  %330 = icmp eq %"class.std::ctype"* %329, null
  br i1 %330, label %331, label %.noexc72

; <label>:331                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit21
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc101 unwind label %461

.noexc101:                                        ; preds = %331
  unreachable

.noexc72:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit21
  %332 = getelementptr inbounds %"class.std::ctype"* %329, i64 0, i32 6
  %333 = load i8* %332, align 1, !tbaa !24
  %334 = icmp eq i8 %333, 0
  br i1 %334, label %338, label %335

; <label>:335                                     ; preds = %.noexc72
  %336 = getelementptr inbounds %"class.std::ctype"* %329, i64 0, i32 7, i64 10
  %337 = load i8* %336, align 1, !tbaa !26
  br label %.noexc24

; <label>:338                                     ; preds = %.noexc72
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %329)
          to label %.noexc76 unwind label %461

.noexc76:                                         ; preds = %338
  %339 = bitcast %"class.std::ctype"* %329 to i8 (%"class.std::ctype"*, i8)***
  %340 = load i8 (%"class.std::ctype"*, i8)*** %339, align 8, !tbaa !10
  %341 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %340, i64 6
  %342 = load i8 (%"class.std::ctype"*, i8)** %341, align 8
  %343 = invoke signext i8 %342(%"class.std::ctype"* %329, i8 signext 10)
          to label %.noexc24 unwind label %461

.noexc24:                                         ; preds = %.noexc76, %335
  %.0.i75 = phi i8 [ %337, %335 ], [ %343, %.noexc76 ]
  %344 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i75)
          to label %.noexc25 unwind label %461

.noexc25:                                         ; preds = %.noexc24
  %345 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %344)
          to label %_ZNSolsEPFRSoS_E.exit23 unwind label %461

_ZNSolsEPFRSoS_E.exit23:                          ; preds = %.noexc25
  call void @__cxa_end_catch()
  br label %346

; <label>:346                                     ; preds = %_ZNSolsEPFRSoS_E.exit, %_ZNSolsEPFRSoS_E.exit49, %_ZNSolsEPFRSoS_E.exit39, %_ZNSolsEPFRSoS_E.exit23
  ret i32 0

; <label>:347                                     ; preds = %_ZNSsD1Ev.exit13
  %348 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #2
  %349 = icmp eq i32 %.13, %348
  %350 = call i8* @__cxa_begin_catch(i8* %.1) #2
  br i1 %349, label %351, label %398

; <label>:351                                     ; preds = %347
  %352 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str5, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit31 unwind label %457

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit31: ; preds = %351
  %353 = bitcast i8* %350 to %"class.std::exception"*
  %354 = bitcast i8* %350 to i8* (%"class.std::exception"*)***
  %355 = load i8* (%"class.std::exception"*)*** %354, align 8, !tbaa !10
  %356 = getelementptr inbounds i8* (%"class.std::exception"*)** %355, i64 2
  %357 = load i8* (%"class.std::exception"*)** %356, align 8
  %358 = call i8* %357(%"class.std::exception"* %353) #2
  %359 = icmp eq i8* %358, null
  br i1 %359, label %360, label %371

; <label>:360                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit31
  %361 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %362 = getelementptr i8* %361, i64 -24
  %363 = bitcast i8* %362 to i64*
  %364 = load i64* %363, align 8
  %365 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %364
  %366 = bitcast i8* %365 to %"class.std::basic_ios"*
  %.sum.i32 = add i64 %364, 32
  %367 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i32
  %368 = bitcast i8* %367 to i32*
  %369 = load i32* %368, align 4, !tbaa !19
  %370 = or i32 %369, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %366, i32 %370)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35 unwind label %457

; <label>:371                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit31
  %372 = call i64 @strlen(i8* %358) #2
  %373 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %358, i64 %372)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35 unwind label %457

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35: ; preds = %371, %360
  %374 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit37 unwind label %457

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit37: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35
  %375 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %376 = getelementptr i8* %375, i64 -24
  %377 = bitcast i8* %376 to i64*
  %378 = load i64* %377, align 8
  %.sum109 = add i64 %378, 240
  %379 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum109
  %380 = bitcast i8* %379 to %"class.std::ctype"**
  %381 = load %"class.std::ctype"** %380, align 8, !tbaa !21
  %382 = icmp eq %"class.std::ctype"* %381, null
  br i1 %382, label %383, label %.noexc79

; <label>:383                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit37
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc103 unwind label %457

.noexc103:                                        ; preds = %383
  unreachable

.noexc79:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit37
  %384 = getelementptr inbounds %"class.std::ctype"* %381, i64 0, i32 6
  %385 = load i8* %384, align 1, !tbaa !24
  %386 = icmp eq i8 %385, 0
  br i1 %386, label %390, label %387

; <label>:387                                     ; preds = %.noexc79
  %388 = getelementptr inbounds %"class.std::ctype"* %381, i64 0, i32 7, i64 10
  %389 = load i8* %388, align 1, !tbaa !26
  br label %.noexc40

; <label>:390                                     ; preds = %.noexc79
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %381)
          to label %.noexc83 unwind label %457

.noexc83:                                         ; preds = %390
  %391 = bitcast %"class.std::ctype"* %381 to i8 (%"class.std::ctype"*, i8)***
  %392 = load i8 (%"class.std::ctype"*, i8)*** %391, align 8, !tbaa !10
  %393 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %392, i64 6
  %394 = load i8 (%"class.std::ctype"*, i8)** %393, align 8
  %395 = invoke signext i8 %394(%"class.std::ctype"* %381, i8 signext 10)
          to label %.noexc40 unwind label %457

.noexc40:                                         ; preds = %.noexc83, %387
  %.0.i82 = phi i8 [ %389, %387 ], [ %395, %.noexc83 ]
  %396 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i82)
          to label %.noexc41 unwind label %457

.noexc41:                                         ; preds = %.noexc40
  %397 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %396)
          to label %_ZNSolsEPFRSoS_E.exit39 unwind label %457

_ZNSolsEPFRSoS_E.exit39:                          ; preds = %.noexc41
  call void @__cxa_end_catch()
  br label %346

; <label>:398                                     ; preds = %347
  %399 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([64 x i8]* @.str4, i64 0, i64 0), i64 63)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit47 unwind label %453

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit47: ; preds = %398
  %400 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !10
  %401 = getelementptr i8* %400, i64 -24
  %402 = bitcast i8* %401 to i64*
  %403 = load i64* %402, align 8
  %.sum = add i64 %403, 240
  %404 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %405 = bitcast i8* %404 to %"class.std::ctype"**
  %406 = load %"class.std::ctype"** %405, align 8, !tbaa !21
  %407 = icmp eq %"class.std::ctype"* %406, null
  br i1 %407, label %408, label %.noexc86

; <label>:408                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit47
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc105 unwind label %453

.noexc105:                                        ; preds = %408
  unreachable

.noexc86:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit47
  %409 = getelementptr inbounds %"class.std::ctype"* %406, i64 0, i32 6
  %410 = load i8* %409, align 1, !tbaa !24
  %411 = icmp eq i8 %410, 0
  br i1 %411, label %415, label %412

; <label>:412                                     ; preds = %.noexc86
  %413 = getelementptr inbounds %"class.std::ctype"* %406, i64 0, i32 7, i64 10
  %414 = load i8* %413, align 1, !tbaa !26
  br label %.noexc50

; <label>:415                                     ; preds = %.noexc86
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %406)
          to label %.noexc90 unwind label %453

.noexc90:                                         ; preds = %415
  %416 = bitcast %"class.std::ctype"* %406 to i8 (%"class.std::ctype"*, i8)***
  %417 = load i8 (%"class.std::ctype"*, i8)*** %416, align 8, !tbaa !10
  %418 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %417, i64 6
  %419 = load i8 (%"class.std::ctype"*, i8)** %418, align 8
  %420 = invoke signext i8 %419(%"class.std::ctype"* %406, i8 signext 10)
          to label %.noexc50 unwind label %453

.noexc50:                                         ; preds = %.noexc90, %412
  %.0.i89 = phi i8 [ %414, %412 ], [ %420, %.noexc90 ]
  %421 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i89)
          to label %.noexc51 unwind label %453

.noexc51:                                         ; preds = %.noexc50
  %422 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %421)
          to label %_ZNSolsEPFRSoS_E.exit49 unwind label %453

_ZNSolsEPFRSoS_E.exit49:                          ; preds = %.noexc51
  call void @__cxa_end_catch()
  br label %346

; <label>:423                                     ; preds = %230
  %424 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([51 x i8]* @.str2, i64 0, i64 0), i64 50)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57 unwind label %292

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57: ; preds = %423
  %425 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %231)
          to label %426 unwind label %292

; <label>:426                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit57
  %427 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %425, i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit59 unwind label %292

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit59: ; preds = %426
  %428 = bitcast %"class.std::basic_ostream"* %425 to i8**
  %429 = load i8** %428, align 8, !tbaa !10
  %430 = getelementptr i8* %429, i64 -24
  %431 = bitcast i8* %430 to i64*
  %432 = load i64* %431, align 8
  %433 = bitcast %"class.std::basic_ostream"* %425 to i8*
  %.sum114 = add i64 %432, 240
  %434 = getelementptr inbounds i8* %433, i64 %.sum114
  %435 = bitcast i8* %434 to %"class.std::ctype"**
  %436 = load %"class.std::ctype"** %435, align 8, !tbaa !21
  %437 = icmp eq %"class.std::ctype"* %436, null
  br i1 %437, label %438, label %.noexc93

; <label>:438                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit59
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc107 unwind label %292

.noexc107:                                        ; preds = %438
  unreachable

.noexc93:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit59
  %439 = getelementptr inbounds %"class.std::ctype"* %436, i64 0, i32 6
  %440 = load i8* %439, align 1, !tbaa !24
  %441 = icmp eq i8 %440, 0
  br i1 %441, label %445, label %442

; <label>:442                                     ; preds = %.noexc93
  %443 = getelementptr inbounds %"class.std::ctype"* %436, i64 0, i32 7, i64 10
  %444 = load i8* %443, align 1, !tbaa !26
  br label %.noexc62

; <label>:445                                     ; preds = %.noexc93
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %436)
          to label %.noexc97 unwind label %292

.noexc97:                                         ; preds = %445
  %446 = bitcast %"class.std::ctype"* %436 to i8 (%"class.std::ctype"*, i8)***
  %447 = load i8 (%"class.std::ctype"*, i8)*** %446, align 8, !tbaa !10
  %448 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %447, i64 6
  %449 = load i8 (%"class.std::ctype"*, i8)** %448, align 8
  %450 = invoke signext i8 %449(%"class.std::ctype"* %436, i8 signext 10)
          to label %.noexc62 unwind label %292

.noexc62:                                         ; preds = %.noexc97, %442
  %.0.i96 = phi i8 [ %444, %442 ], [ %450, %.noexc97 ]
  %451 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %425, i8 signext %.0.i96)
          to label %.noexc63 unwind label %292

.noexc63:                                         ; preds = %.noexc62
  %452 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %451)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %292

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc63, %.noexc8
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss) #2
  call void @llvm.lifetime.end(i64 360, i8* %15) #2
  br label %346

; <label>:453                                     ; preds = %.noexc51, %.noexc50, %.noexc90, %415, %408, %398
  %454 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %455 = extractvalue { i8*, i32 } %454, 0
  %456 = extractvalue { i8*, i32 } %454, 1
  invoke void @__cxa_end_catch()
          to label %465 unwind label %468

; <label>:457                                     ; preds = %.noexc41, %.noexc40, %.noexc83, %390, %383, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit35, %371, %360, %351
  %458 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %459 = extractvalue { i8*, i32 } %458, 0
  %460 = extractvalue { i8*, i32 } %458, 1
  invoke void @__cxa_end_catch()
          to label %465 unwind label %468

; <label>:461                                     ; preds = %.noexc25, %.noexc24, %.noexc76, %338, %331, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit19, %319, %308, %298
  %462 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %463 = extractvalue { i8*, i32 } %462, 0
  %464 = extractvalue { i8*, i32 } %462, 1
  invoke void @__cxa_end_catch()
          to label %465 unwind label %468

; <label>:465                                     ; preds = %461, %457, %453
  %.24 = phi i32 [ %464, %461 ], [ %460, %457 ], [ %456, %453 ]
  %.2 = phi i8* [ %463, %461 ], [ %459, %457 ], [ %455, %453 ]
  %466 = insertvalue { i8*, i32 } undef, i8* %.2, 0
  %467 = insertvalue { i8*, i32 } %466, i32 %.24, 1
  resume { i8*, i32 } %467

; <label>:468                                     ; preds = %461, %457, %453
  %469 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %470 = extractvalue { i8*, i32 } %469, 0
  call void @__clang_call_terminate(i8* %470) #10
  unreachable
}

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
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %7, align 8, !tbaa !27
  %8 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %8, align 1, !tbaa !28
  %9 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %9, align 1, !tbaa !29
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
  call void @llvm.lifetime.start(i64 1, i8* %51) #2
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
  store i64 0, i64* %21, align 8, !tbaa !30
  br label %78

; <label>:78                                      ; preds = %70, %38
  %.12 = phi i8* [ %.01, %70 ], [ %40, %38 ]
  %.1 = phi i32 [ %.0, %70 ], [ %41, %38 ]
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %5) #2
  %79 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %80 = insertvalue { i8*, i32 } %79, i32 %.1, 1
  resume { i8*, i32 } %80
}

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

declare %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"*, i32) #0

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
  %15 = load i8** %14, align 8, !tbaa !1
  %16 = getelementptr inbounds i8* %15, i64 -24
  %17 = bitcast i8* %16 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %18 = icmp eq i8* %16, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %18, label %_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit, label %19, !prof !7

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
  store i64 0, i64* %39, align 8, !tbaa !30
  %40 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %40) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #5

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #6 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #2
  tail call void @_ZSt9terminatev() #10
  unreachable
}

declare void @_ZSt9terminatev()

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

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
  call void @llvm.lifetime.start(i64 1, i8* %30) #2
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

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #7

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #8

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

declare %"class.std::basic_istream"* @_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RSbIS4_S5_T1_E(%"class.std::basic_istream"*, %"class.std::basic_string"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base7failureC1ERKSs(%"class.std::ios_base::failure"*, %"class.std::basic_string"*) #1

; Function Attrs: nounwind
declare i8* @_ZNKSt8ios_base7failure4whatEv(%"class.std::ios_base::failure"*) #1

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_free_exception(i8*)

; Function Attrs: nounwind
declare void @_ZNSt8ios_base7failureD1Ev(%"class.std::ios_base::failure"*) #1

declare void @__cxa_throw(i8*, i8*, i8*)

declare void @__cxa_rethrow()

declare void @_ZNSsC1ERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #0

; Function Attrs: nounwind
declare void @_ZNSt9exceptionD2Ev(%"class.std::exception"*) #1

declare i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"*, i8*) #0

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
attributes #5 = { nounwind readnone }
attributes #6 = { noinline noreturn nounwind }
attributes #7 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { noreturn }
attributes #10 = { noreturn nounwind }

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
