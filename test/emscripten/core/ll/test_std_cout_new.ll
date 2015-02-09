; ModuleID = 'test_std_cout_new.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%struct.NodeInfo = type { float, float, float, float }
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

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@data = global %struct.NodeInfo* null, align 8
@.str = private unnamed_addr constant [21 x i8] c"some string constant\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: nobuiltin
declare noalias i8* @_Znam(i64) #2

; Function Attrs: nounwind uwtable
define i32 @main() #3 {
  tail call void @_Z9printTextILi21EEvRAT__Kc([21 x i8]* @.str)
  ret i32 0
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_Z9printTextILi21EEvRAT__Kc([21 x i8]* %text) #3 {
  %1 = getelementptr inbounds [21 x i8]* %text, i64 0, i64 0
  %2 = icmp eq [21 x i8]* %text, null
  br i1 %2, label %3, label %14

; <label>:3                                       ; preds = %0
  %4 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %5 = getelementptr i8* %4, i64 -24
  %6 = bitcast i8* %5 to i64*
  %7 = load i64* %6, align 8
  %8 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %7
  %9 = bitcast i8* %8 to %"class.std::basic_ios"*
  %.sum.i = add i64 %7, 32
  %10 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %11 = bitcast i8* %10 to i32*
  %12 = load i32* %11, align 4, !tbaa !4
  %13 = or i32 %12, 1
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %9, i32 %13) #1
  br label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit

; <label>:14                                      ; preds = %0
  %15 = tail call i64 @strlen(i8* %1) #1
  %16 = tail call %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %1, i64 %15) #1
  br label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %14, %3
  %17 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %18 = getelementptr i8* %17, i64 -24
  %19 = bitcast i8* %18 to i64*
  %20 = load i64* %19, align 8
  %.sum = add i64 %20, 240
  %21 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %22 = bitcast i8* %21 to %"class.std::ctype"**
  %23 = load %"class.std::ctype"** %22, align 8, !tbaa !14
  %24 = icmp eq %"class.std::ctype"* %23, null
  br i1 %24, label %25, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit

; <label>:25                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  tail call void @_ZSt16__throw_bad_castv() #6
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit:    ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %26 = getelementptr inbounds %"class.std::ctype"* %23, i64 0, i32 6
  %27 = load i8* %26, align 1, !tbaa !17
  %28 = icmp eq i8 %27, 0
  br i1 %28, label %32, label %29

; <label>:29                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit
  %30 = getelementptr inbounds %"class.std::ctype"* %23, i64 0, i32 7, i64 10
  %31 = load i8* %30, align 1, !tbaa !19
  br label %_ZNKSt5ctypeIcE5widenEc.exit

; <label>:32                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit
  tail call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %23) #1
  %33 = bitcast %"class.std::ctype"* %23 to i8 (%"class.std::ctype"*, i8)***
  %34 = load i8 (%"class.std::ctype"*, i8)*** %33, align 8, !tbaa !1
  %35 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %34, i64 6
  %36 = load i8 (%"class.std::ctype"*, i8)** %35, align 8
  %37 = tail call signext i8 %36(%"class.std::ctype"* %23, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit

_ZNKSt5ctypeIcE5widenEc.exit:                     ; preds = %32, %29
  %.0.i = phi i8 [ %31, %29 ], [ %37, %32 ]
  %38 = tail call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i) #1
  %39 = tail call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %38) #1
  ret void
}

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #4

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #5

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

; Function Attrs: nounwind
define internal void @_GLOBAL__I_a() #1 section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit) #1
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #1
  %2 = tail call noalias i8* @_Znam(i64 1600) #7
  %3 = bitcast i8* %2 to %struct.NodeInfo*
  store %struct.NodeInfo* %3, %struct.NodeInfo** @data, align 8, !tbaa !20
  ret void
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn nounwind }
attributes #7 = { builtin nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"vtable pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !9, i64 32}
!5 = metadata !{metadata !"_ZTSSt8ios_base", metadata !6, i64 8, metadata !6, i64 16, metadata !8, i64 24, metadata !9, i64 28, metadata !9, i64 32, metadata !10, i64 40, metadata !11, i64 48, metadata !7, i64 64, metadata !12, i64 192, metadata !10, i64 200, metadata !13, i64 208}
!6 = metadata !{metadata !"long", metadata !7, i64 0}
!7 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!8 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !7, i64 0}
!9 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !7, i64 0}
!10 = metadata !{metadata !"any pointer", metadata !7, i64 0}
!11 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !10, i64 0, metadata !6, i64 8}
!12 = metadata !{metadata !"int", metadata !7, i64 0}
!13 = metadata !{metadata !"_ZTSSt6locale", metadata !10, i64 0}
!14 = metadata !{metadata !15, metadata !10, i64 240}
!15 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !10, i64 216, metadata !7, i64 224, metadata !16, i64 225, metadata !10, i64 232, metadata !10, i64 240, metadata !10, i64 248, metadata !10, i64 256}
!16 = metadata !{metadata !"bool", metadata !7, i64 0}
!17 = metadata !{metadata !18, metadata !7, i64 56}
!18 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !10, i64 16, metadata !16, i64 24, metadata !10, i64 32, metadata !10, i64 40, metadata !10, i64 48, metadata !7, i64 56, metadata !7, i64 57, metadata !7, i64 313, metadata !7, i64 569}
!19 = metadata !{metadata !7, metadata !7, i64 0}
!20 = metadata !{metadata !10, metadata !10, i64 0}
