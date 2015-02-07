; ModuleID = 'test_corruption_2.bc'
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
%"class.std::basic_fstream" = type { %"class.std::basic_iostream.base", %"class.std::basic_filebuf", %"class.std::basic_ios" }
%"class.std::basic_iostream.base" = type { %"class.std::basic_istream.base", %"class.std::basic_ostream.base" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_ostream.base" = type { i32 (...)** }
%"class.std::basic_filebuf" = type { %"class.std::basic_streambuf", %union.pthread_mutex_t, %"class.std::__basic_file", i32, %struct.__mbstate_t, %struct.__mbstate_t, %struct.__mbstate_t, i8*, i64, i8, i8, i8, i8, i8*, i8*, i8, %"class.std::codecvt"*, i8*, i64, i8*, i8* }
%union.pthread_mutex_t = type { %"struct.<anonymous union>::__pthread_mutex_s" }
%"struct.<anonymous union>::__pthread_mutex_s" = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.std::__basic_file" = type { %struct._IO_FILE*, i8 }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }
%"class.std::codecvt" = type { %"class.std::__codecvt_abstract_base", %struct.__locale_struct* }
%"class.std::__codecvt_abstract_base" = type { %"class.std::locale::facet" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }
%"class.std::basic_iostream" = type { %"class.std::basic_istream.base", %"class.std::basic_ostream.base", %"class.std::basic_ios" }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str1 = private unnamed_addr constant [18 x i8] c"/Script/WA-KA.txt\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str2 = private unnamed_addr constant [6 x i8] c"open!\00", align 1
@.str3 = private unnamed_addr constant [9 x i8] c"missing!\00", align 1
@_ZTVSt13basic_fstreamIcSt11char_traitsIcEE = external unnamed_addr constant [15 x i8*]
@_ZTTSt13basic_fstreamIcSt11char_traitsIcEE = external unnamed_addr constant [10 x i8*]
@_ZTVSt13basic_filebufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external unnamed_addr constant [4 x i8*]
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]
@str = private unnamed_addr constant [7 x i8] c"all ok\00"

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #1

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: nounwind uwtable
define void @_Z3byev() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  ret void
}

; Function Attrs: uwtable
define i32 @main() #4 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %testPath = alloca %"class.std::basic_string", align 8
  %5 = alloca %"class.std::allocator", align 1
  %str = alloca %"class.std::basic_fstream", align 8
  %6 = call i32 @atexit(void ()* @_Z3byev) #2
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %testPath, i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), %"class.std::allocator"* %5)
          to label %7 unwind label %39

; <label>:7                                       ; preds = %0
  %8 = bitcast %"class.std::basic_fstream"* %str to i8*
  call void @llvm.lifetime.start(i64 528, i8* %8) #2
  %9 = getelementptr inbounds %"class.std::basic_string"* %testPath, i64 0, i32 0, i32 0
  %10 = load i8** %9, align 8, !tbaa !1
  invoke void @_ZNSt13basic_fstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_fstream"* %str, i8* %10, i32 12)
          to label %11 unwind label %43

; <label>:11                                      ; preds = %7
  %12 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 1, i32 2
  %13 = call zeroext i1 @_ZNKSt12__basic_fileIcE7is_openEv(%"class.std::__basic_file"* %12) #7
  br i1 %13, label %14, label %71

; <label>:14                                      ; preds = %11
  %15 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 5)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %47

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %14
  %16 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !7
  %17 = getelementptr i8* %16, i64 -24
  %18 = bitcast i8* %17 to i64*
  %19 = load i64* %18, align 8
  %.sum36 = add i64 %19, 240
  %20 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum36
  %21 = bitcast i8* %20 to %"class.std::ctype"**
  %22 = load %"class.std::ctype"** %21, align 8, !tbaa !9
  %23 = icmp eq %"class.std::ctype"* %22, null
  br i1 %23, label %24, label %.noexc22

; <label>:24                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc33 unwind label %47

.noexc33:                                         ; preds = %24
  unreachable

.noexc22:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %25 = getelementptr inbounds %"class.std::ctype"* %22, i64 0, i32 6
  %26 = load i8* %25, align 1, !tbaa !12
  %27 = icmp eq i8 %26, 0
  br i1 %27, label %31, label %28

; <label>:28                                      ; preds = %.noexc22
  %29 = getelementptr inbounds %"class.std::ctype"* %22, i64 0, i32 7, i64 10
  %30 = load i8* %29, align 1, !tbaa !14
  br label %.noexc

; <label>:31                                      ; preds = %.noexc22
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %22)
          to label %.noexc24 unwind label %47

.noexc24:                                         ; preds = %31
  %32 = bitcast %"class.std::ctype"* %22 to i8 (%"class.std::ctype"*, i8)***
  %33 = load i8 (%"class.std::ctype"*, i8)*** %32, align 8, !tbaa !7
  %34 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %33, i64 6
  %35 = load i8 (%"class.std::ctype"*, i8)** %34, align 8
  %36 = invoke signext i8 %35(%"class.std::ctype"* %22, i8 signext 10)
          to label %.noexc unwind label %47

.noexc:                                           ; preds = %.noexc24, %28
  %.0.i = phi i8 [ %30, %28 ], [ %36, %.noexc24 ]
  %37 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc6 unwind label %47

.noexc6:                                          ; preds = %.noexc
  %38 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %37)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %47

; <label>:39                                      ; preds = %0
  %40 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %41 = extractvalue { i8*, i32 } %40, 0
  %42 = extractvalue { i8*, i32 } %40, 1
  br label %_ZNSsD1Ev.exit

; <label>:43                                      ; preds = %7
  %44 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %45 = extractvalue { i8*, i32 } %44, 0
  %46 = extractvalue { i8*, i32 } %44, 1
  br label %133

; <label>:47                                      ; preds = %.noexc17, %.noexc16, %.noexc30, %88, %81, %71, %.noexc6, %.noexc, %.noexc24, %31, %24, %14
  %48 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %49 = extractvalue { i8*, i32 } %48, 0
  %50 = extractvalue { i8*, i32 } %48, 1
  %51 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 0), align 8
  %52 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 0, i32 0
  %.c.i.i9 = bitcast i8* %51 to i32 (...)**
  store i32 (...)** %.c.i.i9, i32 (...)*** %52, align 8, !tbaa !7
  %53 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 8), align 8
  %54 = getelementptr i8* %51, i64 -24
  %55 = bitcast i8* %54 to i64*
  %56 = load i64* %55, align 8
  %57 = getelementptr inbounds i8* %8, i64 %56
  %58 = bitcast i8* %57 to i8**
  store i8* %53, i8** %58, align 8, !tbaa !7
  %59 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 9), align 8
  %60 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 1, i32 0
  %.c1.i.i10 = bitcast i8* %59 to i32 (...)**
  store i32 (...)** %.c1.i.i10, i32 (...)*** %60, align 8, !tbaa !7
  %61 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 1
  call void @_ZNSt13basic_filebufIcSt11char_traitsIcEED2Ev(%"class.std::basic_filebuf"* %61) #2
  %62 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 2), align 8
  %.c.i.i.i.i11 = bitcast i8* %62 to i32 (...)**
  store i32 (...)** %.c.i.i.i.i11, i32 (...)*** %52, align 8, !tbaa !7
  %63 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 3), align 8
  %64 = getelementptr i8* %62, i64 -24
  %65 = bitcast i8* %64 to i64*
  %66 = load i64* %65, align 8
  %67 = getelementptr inbounds i8* %8, i64 %66
  %68 = bitcast i8* %67 to i8**
  store i8* %63, i8** %68, align 8, !tbaa !7
  %69 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %69, align 8, !tbaa !15
  %70 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %70) #2
  br label %133

; <label>:71                                      ; preds = %11
  %72 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit13 unwind label %47

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit13: ; preds = %71
  %73 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !7
  %74 = getelementptr i8* %73, i64 -24
  %75 = bitcast i8* %74 to i64*
  %76 = load i64* %75, align 8
  %.sum = add i64 %76, 240
  %77 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %78 = bitcast i8* %77 to %"class.std::ctype"**
  %79 = load %"class.std::ctype"** %78, align 8, !tbaa !9
  %80 = icmp eq %"class.std::ctype"* %79, null
  br i1 %80, label %81, label %.noexc26

; <label>:81                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit13
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc34 unwind label %47

.noexc34:                                         ; preds = %81
  unreachable

.noexc26:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit13
  %82 = getelementptr inbounds %"class.std::ctype"* %79, i64 0, i32 6
  %83 = load i8* %82, align 1, !tbaa !12
  %84 = icmp eq i8 %83, 0
  br i1 %84, label %88, label %85

; <label>:85                                      ; preds = %.noexc26
  %86 = getelementptr inbounds %"class.std::ctype"* %79, i64 0, i32 7, i64 10
  %87 = load i8* %86, align 1, !tbaa !14
  br label %.noexc16

; <label>:88                                      ; preds = %.noexc26
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %79)
          to label %.noexc30 unwind label %47

.noexc30:                                         ; preds = %88
  %89 = bitcast %"class.std::ctype"* %79 to i8 (%"class.std::ctype"*, i8)***
  %90 = load i8 (%"class.std::ctype"*, i8)*** %89, align 8, !tbaa !7
  %91 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %90, i64 6
  %92 = load i8 (%"class.std::ctype"*, i8)** %91, align 8
  %93 = invoke signext i8 %92(%"class.std::ctype"* %79, i8 signext 10)
          to label %.noexc16 unwind label %47

.noexc16:                                         ; preds = %.noexc30, %85
  %.0.i29 = phi i8 [ %87, %85 ], [ %93, %.noexc30 ]
  %94 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i29)
          to label %.noexc17 unwind label %47

.noexc17:                                         ; preds = %.noexc16
  %95 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %94)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %47

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc17, %.noexc6
  %96 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 0), align 8
  %97 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 0, i32 0
  %.c.i.i = bitcast i8* %96 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %97, align 8, !tbaa !7
  %98 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 8), align 8
  %99 = getelementptr i8* %96, i64 -24
  %100 = bitcast i8* %99 to i64*
  %101 = load i64* %100, align 8
  %102 = getelementptr inbounds i8* %8, i64 %101
  %103 = bitcast i8* %102 to i8**
  store i8* %98, i8** %103, align 8, !tbaa !7
  %104 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 9), align 8
  %105 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 1, i32 0
  %.c1.i.i = bitcast i8* %104 to i32 (...)**
  store i32 (...)** %.c1.i.i, i32 (...)*** %105, align 8, !tbaa !7
  %106 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 1
  call void @_ZNSt13basic_filebufIcSt11char_traitsIcEED2Ev(%"class.std::basic_filebuf"* %106) #2
  %107 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 2), align 8
  %.c.i.i.i.i = bitcast i8* %107 to i32 (...)**
  store i32 (...)** %.c.i.i.i.i, i32 (...)*** %97, align 8, !tbaa !7
  %108 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 3), align 8
  %109 = getelementptr i8* %107, i64 -24
  %110 = bitcast i8* %109 to i64*
  %111 = load i64* %110, align 8
  %112 = getelementptr inbounds i8* %8, i64 %111
  %113 = bitcast i8* %112 to i8**
  store i8* %108, i8** %113, align 8, !tbaa !7
  %114 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %114, align 8, !tbaa !15
  %115 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %115) #2
  call void @llvm.lifetime.end(i64 528, i8* %8) #2
  %116 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %116) #2
  %117 = load i8** %9, align 8, !tbaa !1
  %118 = getelementptr inbounds i8* %117, i64 -24
  %119 = bitcast i8* %118 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %120 = icmp eq i8* %118, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %120, label %_ZNSsD1Ev.exit5, label %121, !prof !18

; <label>:121                                     ; preds = %_ZNSolsEPFRSoS_E.exit
  %122 = getelementptr inbounds i8* %117, i64 -8
  %123 = bitcast i8* %122 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %124, label %128

; <label>:124                                     ; preds = %121
  %125 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %125)
  %126 = atomicrmw volatile add i32* %123, i32 -1 acq_rel
  store i32 %126, i32* %1, align 4
  %127 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %125)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

; <label>:128                                     ; preds = %121
  %129 = load i32* %123, align 4, !tbaa !19
  %130 = add nsw i32 %129, -1
  store i32 %130, i32* %123, align 4, !tbaa !19
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4: ; preds = %128, %124
  %.0.i.i.i.i3 = phi i32 [ %127, %124 ], [ %129, %128 ]
  %131 = icmp slt i32 %.0.i.i.i.i3, 1
  br i1 %131, label %132, label %_ZNSsD1Ev.exit5

; <label>:132                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %119, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit5

_ZNSsD1Ev.exit5:                                  ; preds = %132, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4, %_ZNSolsEPFRSoS_E.exit
  call void @llvm.lifetime.end(i64 1, i8* %116) #2
  ret i32 1

; <label>:133                                     ; preds = %47, %43
  %.01 = phi i8* [ %49, %47 ], [ %45, %43 ]
  %.0 = phi i32 [ %50, %47 ], [ %46, %43 ]
  %134 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %134) #2
  %135 = load i8** %9, align 8, !tbaa !1
  %136 = getelementptr inbounds i8* %135, i64 -24
  %137 = bitcast i8* %136 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %138 = icmp eq i8* %136, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %138, label %_ZNSsD1Ev.exit, label %139, !prof !18

; <label>:139                                     ; preds = %133
  %140 = getelementptr inbounds i8* %135, i64 -8
  %141 = bitcast i8* %140 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %142, label %146

; <label>:142                                     ; preds = %139
  %143 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %143)
  %144 = atomicrmw volatile add i32* %141, i32 -1 acq_rel
  store i32 %144, i32* %3, align 4
  %145 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %143)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:146                                     ; preds = %139
  %147 = load i32* %141, align 4, !tbaa !19
  %148 = add nsw i32 %147, -1
  store i32 %148, i32* %141, align 4, !tbaa !19
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %146, %142
  %.0.i.i.i.i = phi i32 [ %145, %142 ], [ %147, %146 ]
  %149 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %149, label %150, label %_ZNSsD1Ev.exit

; <label>:150                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %137, %"class.std::allocator"* %4) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %150, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %133, %39
  %.12 = phi i8* [ %41, %39 ], [ %.01, %133 ], [ %.01, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %.01, %150 ]
  %.1 = phi i32 [ %42, %39 ], [ %.0, %133 ], [ %.0, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %.0, %150 ]
  %151 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %152 = insertvalue { i8*, i32 } %151, i32 %.1, 1
  resume { i8*, i32 } %152
}

; Function Attrs: nounwind
declare i32 @atexit(void ()*) #1

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: uwtable
define available_externally void @_ZNSt13basic_fstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_fstream"* %this, i8* %__s, i32 %__mode) unnamed_addr #4 align 2 {
  %1 = bitcast %"class.std::basic_fstream"* %this to i8*
  %2 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2
  %3 = getelementptr inbounds %"class.std::basic_ios"* %2, i64 0, i32 0
  tail call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %3) #2
  %4 = getelementptr inbounds %"class.std::basic_ios"* %2, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !7
  %5 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %5, align 8, !tbaa !21
  %6 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %6, align 1, !tbaa !22
  %7 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %7, align 1, !tbaa !23
  %8 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 4
  %9 = bitcast %"class.std::basic_streambuf"** %8 to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 32, i32 8, i1 false) #2
  %10 = bitcast %"class.std::basic_fstream"* %this to %"class.std::basic_iostream"*
  invoke void @_ZNSdC2EPSt15basic_streambufIcSt11char_traitsIcEE(%"class.std::basic_iostream"* %10, i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 1), %"class.std::basic_streambuf"* null)
          to label %11 unwind label %39

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !7
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 13) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !7
  %13 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 0, i32 1, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %13, align 8, !tbaa !7
  %14 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 1
  invoke void @_ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev(%"class.std::basic_filebuf"* %14)
          to label %15 unwind label %43

; <label>:15                                      ; preds = %11
  %16 = bitcast %"class.std::basic_fstream"* %this to i8**
  %17 = load i8** %16, align 8, !tbaa !7
  %18 = getelementptr i8* %17, i64 -24
  %19 = bitcast i8* %18 to i64*
  %20 = load i64* %19, align 8
  %21 = getelementptr inbounds i8* %1, i64 %20
  %22 = bitcast i8* %21 to %"class.std::basic_ios"*
  %23 = getelementptr inbounds %"class.std::basic_filebuf"* %14, i64 0, i32 0
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %22, %"class.std::basic_streambuf"* %23)
          to label %24 unwind label %47

; <label>:24                                      ; preds = %15
  %25 = invoke %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(%"class.std::basic_filebuf"* %14, i8* %__s, i32 %__mode)
          to label %.noexc unwind label %47

.noexc:                                           ; preds = %24
  %26 = icmp eq %"class.std::basic_filebuf"* %25, null
  %27 = load i8** %16, align 8, !tbaa !7
  %28 = getelementptr i8* %27, i64 -24
  %29 = bitcast i8* %28 to i64*
  %30 = load i64* %29, align 8
  %31 = getelementptr inbounds i8* %1, i64 %30
  %32 = bitcast i8* %31 to %"class.std::basic_ios"*
  br i1 %26, label %33, label %38

; <label>:33                                      ; preds = %.noexc
  %.sum.i = add i64 %30, 32
  %34 = getelementptr inbounds i8* %1, i64 %.sum.i
  %35 = bitcast i8* %34 to i32*
  %36 = load i32* %35, align 4, !tbaa !24
  %37 = or i32 %36, 4
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %32, i32 %37)
          to label %_ZNSt13basic_fstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode.exit unwind label %47

; <label>:38                                      ; preds = %.noexc
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %32, i32 0)
          to label %_ZNSt13basic_fstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode.exit unwind label %47

_ZNSt13basic_fstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode.exit: ; preds = %38, %33
  ret void

; <label>:39                                      ; preds = %0
  %40 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %41 = extractvalue { i8*, i32 } %40, 0
  %42 = extractvalue { i8*, i32 } %40, 1
  br label %60

; <label>:43                                      ; preds = %11
  %44 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %45 = extractvalue { i8*, i32 } %44, 0
  %46 = extractvalue { i8*, i32 } %44, 1
  br label %51

; <label>:47                                      ; preds = %38, %33, %24, %15
  %48 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %49 = extractvalue { i8*, i32 } %48, 0
  %50 = extractvalue { i8*, i32 } %48, 1
  tail call void @_ZNSt13basic_filebufIcSt11char_traitsIcEED2Ev(%"class.std::basic_filebuf"* %14) #2
  br label %51

; <label>:51                                      ; preds = %47, %43
  %.01 = phi i8* [ %49, %47 ], [ %45, %43 ]
  %.0 = phi i32 [ %50, %47 ], [ %46, %43 ]
  %52 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 2), align 8
  %.c.i.i = bitcast i8* %52 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %12, align 8, !tbaa !7
  %53 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 3), align 8
  %54 = getelementptr i8* %52, i64 -24
  %55 = bitcast i8* %54 to i64*
  %56 = load i64* %55, align 8
  %57 = getelementptr inbounds i8* %1, i64 %56
  %58 = bitcast i8* %57 to i8**
  store i8* %53, i8** %58, align 8, !tbaa !7
  %59 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %59, align 8, !tbaa !15
  br label %60

; <label>:60                                      ; preds = %51, %39
  %.12 = phi i8* [ %.01, %51 ], [ %41, %39 ]
  %.1 = phi i32 [ %.0, %51 ], [ %42, %39 ]
  tail call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %3) #2
  %61 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %62 = insertvalue { i8*, i32 } %61, i32 %.1, 1
  resume { i8*, i32 } %62
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #5

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

; Function Attrs: nounwind readonly
declare zeroext i1 @_ZNKSt12__basic_fileIcE7is_openEv(%"class.std::__basic_file"*) #6

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #1

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt13basic_filebufIcSt11char_traitsIcEED2Ev(%"class.std::basic_filebuf"* %this) unnamed_addr #3 align 2 {
  %1 = getelementptr inbounds %"class.std::basic_filebuf"* %this, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt13basic_filebufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %1, align 8, !tbaa !7
  %2 = invoke %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(%"class.std::basic_filebuf"* %this)
          to label %3 unwind label %6

; <label>:3                                       ; preds = %0
  %4 = getelementptr inbounds %"class.std::basic_filebuf"* %this, i64 0, i32 2
  tail call void @_ZNSt12__basic_fileIcED1Ev(%"class.std::__basic_file"* %4) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %1, align 8, !tbaa !7
  %5 = getelementptr inbounds %"class.std::basic_filebuf"* %this, i64 0, i32 0, i32 7
  tail call void @_ZNSt6localeD1Ev(%"class.std::locale"* %5) #2
  ret void

; <label>:6                                       ; preds = %0
  %7 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          filter [0 x i8*] zeroinitializer
  %8 = extractvalue { i8*, i32 } %7, 0
  %9 = getelementptr inbounds %"class.std::basic_filebuf"* %this, i64 0, i32 2
  tail call void @_ZNSt12__basic_fileIcED1Ev(%"class.std::__basic_file"* %9) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %1, align 8, !tbaa !7
  %10 = getelementptr inbounds %"class.std::basic_filebuf"* %this, i64 0, i32 0, i32 7
  tail call void @_ZNSt6localeD1Ev(%"class.std::locale"* %10) #2
  tail call void @__cxa_call_unexpected(i8* %8) #9
  unreachable
}

declare %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(%"class.std::basic_filebuf"*) #0

; Function Attrs: nounwind
declare void @_ZNSt12__basic_fileIcED1Ev(%"class.std::__basic_file"*) #1

declare void @__cxa_call_unexpected(i8*)

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #1

; Function Attrs: uwtable
define available_externally void @_ZNSdC2EPSt15basic_streambufIcSt11char_traitsIcEE(%"class.std::basic_iostream"* %this, i8** nocapture readonly %vtt, %"class.std::basic_streambuf"* %__sb) unnamed_addr #4 align 2 {
  %1 = getelementptr inbounds i8** %vtt, i64 1
  %2 = load i8** %1, align 8
  %3 = bitcast %"class.std::basic_iostream"* %this to i8**
  %4 = getelementptr inbounds %"class.std::basic_iostream"* %this, i64 0, i32 0, i32 0
  %.c.i = bitcast i8* %2 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %4, align 8, !tbaa !7
  %5 = getelementptr inbounds i8** %vtt, i64 2
  %6 = load i8** %5, align 8
  %7 = getelementptr i8* %2, i64 -24
  %8 = bitcast i8* %7 to i64*
  %9 = load i64* %8, align 8
  %10 = bitcast %"class.std::basic_iostream"* %this to i8*
  %11 = getelementptr inbounds i8* %10, i64 %9
  %12 = bitcast i8* %11 to i8**
  store i8* %6, i8** %12, align 8, !tbaa !7
  %13 = getelementptr inbounds %"class.std::basic_iostream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %13, align 8, !tbaa !15
  %14 = load i8** %3, align 8, !tbaa !7
  %15 = getelementptr i8* %14, i64 -24
  %16 = bitcast i8* %15 to i64*
  %17 = load i64* %16, align 8
  %18 = getelementptr inbounds i8* %10, i64 %17
  %19 = bitcast i8* %18 to %"class.std::basic_ios"*
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %19, %"class.std::basic_streambuf"* %__sb)
  %20 = getelementptr inbounds %"class.std::basic_iostream"* %this, i64 0, i32 1
  %21 = getelementptr inbounds i8** %vtt, i64 3
  %22 = load i8** %21, align 8
  %23 = bitcast %"class.std::basic_ostream.base"* %20 to i8**
  %24 = getelementptr inbounds %"class.std::basic_ostream.base"* %20, i64 0, i32 0
  %.c.i2 = bitcast i8* %22 to i32 (...)**
  store i32 (...)** %.c.i2, i32 (...)*** %24, align 8, !tbaa !7
  %25 = getelementptr inbounds i8** %vtt, i64 4
  %26 = load i8** %25, align 8
  %27 = getelementptr i8* %22, i64 -24
  %28 = bitcast i8* %27 to i64*
  %29 = load i64* %28, align 8
  %30 = bitcast %"class.std::basic_ostream.base"* %20 to i8*
  %31 = getelementptr inbounds i8* %30, i64 %29
  %32 = bitcast i8* %31 to i8**
  store i8* %26, i8** %32, align 8, !tbaa !7
  %33 = load i8** %23, align 8, !tbaa !7
  %34 = getelementptr i8* %33, i64 -24
  %35 = bitcast i8* %34 to i64*
  %36 = load i64* %35, align 8
  %37 = getelementptr inbounds i8* %30, i64 %36
  %38 = bitcast i8* %37 to %"class.std::basic_ios"*
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %38, %"class.std::basic_streambuf"* %__sb)
          to label %_ZNSoC2EPSt15basic_streambufIcSt11char_traitsIcEE.exit unwind label %49

_ZNSoC2EPSt15basic_streambufIcSt11char_traitsIcEE.exit: ; preds = %0
  %39 = load i8** %vtt, align 8
  %.c = bitcast i8* %39 to i32 (...)**
  store i32 (...)** %.c, i32 (...)*** %4, align 8, !tbaa !7
  %40 = getelementptr inbounds i8** %vtt, i64 5
  %41 = load i8** %40, align 8
  %42 = getelementptr i8* %39, i64 -24
  %43 = bitcast i8* %42 to i64*
  %44 = load i64* %43, align 8
  %45 = getelementptr inbounds i8* %10, i64 %44
  %46 = bitcast i8* %45 to i8**
  store i8* %41, i8** %46, align 8, !tbaa !7
  %47 = getelementptr inbounds i8** %vtt, i64 6
  %48 = load i8** %47, align 8
  %.c1 = bitcast i8* %48 to i32 (...)**
  store i32 (...)** %.c1, i32 (...)*** %24, align 8, !tbaa !7
  ret void

; <label>:49                                      ; preds = %0
  %50 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %51 = load i8** %1, align 8
  %.c.i3 = bitcast i8* %51 to i32 (...)**
  store i32 (...)** %.c.i3, i32 (...)*** %4, align 8, !tbaa !7
  %52 = load i8** %5, align 8
  %53 = getelementptr i8* %51, i64 -24
  %54 = bitcast i8* %53 to i64*
  %55 = load i64* %54, align 8
  %56 = getelementptr inbounds i8* %10, i64 %55
  %57 = bitcast i8* %56 to i8**
  store i8* %52, i8** %57, align 8, !tbaa !7
  store i64 0, i64* %13, align 8, !tbaa !15
  resume { i8*, i32 } %50
}

declare void @_ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev(%"class.std::basic_filebuf"*) #0

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

declare %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(%"class.std::basic_filebuf"*, i8*, i32) #0

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
declare i32 @puts(i8* nocapture readonly) #2

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readonly }
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
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"vtable pointer", metadata !6, i64 0}
!9 = metadata !{metadata !10, metadata !4, i64 240}
!10 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !4, i64 216, metadata !5, i64 224, metadata !11, i64 225, metadata !4, i64 232, metadata !4, i64 240, metadata !4, i64 248, metadata !4, i64 256}
!11 = metadata !{metadata !"bool", metadata !5, i64 0}
!12 = metadata !{metadata !13, metadata !5, i64 56}
!13 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !4, i64 16, metadata !11, i64 24, metadata !4, i64 32, metadata !4, i64 40, metadata !4, i64 48, metadata !5, i64 56, metadata !5, i64 57, metadata !5, i64 313, metadata !5, i64 569}
!14 = metadata !{metadata !5, metadata !5, i64 0}
!15 = metadata !{metadata !16, metadata !17, i64 8}
!16 = metadata !{metadata !"_ZTSSi", metadata !17, i64 8}
!17 = metadata !{metadata !"long", metadata !5, i64 0}
!18 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!19 = metadata !{metadata !20, metadata !20, i64 0}
!20 = metadata !{metadata !"int", metadata !5, i64 0}
!21 = metadata !{metadata !10, metadata !4, i64 216}
!22 = metadata !{metadata !10, metadata !5, i64 224}
!23 = metadata !{metadata !10, metadata !11, i64 225}
!24 = metadata !{metadata !25, metadata !27, i64 32}
!25 = metadata !{metadata !"_ZTSSt8ios_base", metadata !17, i64 8, metadata !17, i64 16, metadata !26, i64 24, metadata !27, i64 28, metadata !27, i64 32, metadata !4, i64 40, metadata !28, i64 48, metadata !5, i64 64, metadata !20, i64 192, metadata !4, i64 200, metadata !29, i64 208}
!26 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !5, i64 0}
!27 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !5, i64 0}
!28 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !4, i64 0, metadata !17, i64 8}
!29 = metadata !{metadata !"_ZTSSt6locale", metadata !4, i64 0}
