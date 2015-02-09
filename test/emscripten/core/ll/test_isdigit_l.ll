; ModuleID = 'test_isdigit_l.bc'
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

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@_ZSt4cout = external global %"class.std::basic_ostream"
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
  %1 = alloca %"class.std::locale", align 8
  %2 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %3 = getelementptr i8* %2, i64 -24
  %4 = bitcast i8* %3 to i64*
  %5 = load i64* %4, align 8
  %.sum = add i64 %5, 208
  %6 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %7 = bitcast i8* %6 to %"class.std::locale"*
  call void @_ZNSt6localeC1ERKS_(%"class.std::locale"* %1, %"class.std::locale"* %7) #1
  %8 = call %"class.std::num_put"* @_ZSt9use_facetISt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEEERKT_RKSt6locale(%"class.std::locale"* %1) #1
  %9 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %10 = getelementptr i8* %9, i64 -24
  %11 = bitcast i8* %10 to i64*
  %12 = load i64* %11, align 8
  %.sum.i = add i64 %12, 232
  %13 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %14 = bitcast i8* %13 to %"class.std::basic_streambuf"**
  %15 = load %"class.std::basic_streambuf"** %14, align 8, !tbaa !4
  %16 = icmp eq %"class.std::basic_streambuf"* %15, null
  %17 = zext i1 %16 to i8
  %18 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %12
  %19 = bitcast i8* %18 to %"class.std::ios_base"*
  %20 = bitcast %"class.std::num_put"* %8 to { %"class.std::basic_streambuf"*, i8 } (%"class.std::num_put"*, %"class.std::basic_streambuf"*, i8, %"class.std::ios_base"*, i8, double)***
  %21 = load { %"class.std::basic_streambuf"*, i8 } (%"class.std::num_put"*, %"class.std::basic_streambuf"*, i8, %"class.std::ios_base"*, i8, double)*** %20, align 8, !tbaa !1
  %22 = getelementptr inbounds { %"class.std::basic_streambuf"*, i8 } (%"class.std::num_put"*, %"class.std::basic_streambuf"*, i8, %"class.std::ios_base"*, i8, double)** %21, i64 7
  %23 = load { %"class.std::basic_streambuf"*, i8 } (%"class.std::num_put"*, %"class.std::basic_streambuf"*, i8, %"class.std::ios_base"*, i8, double)** %22, align 8
  %24 = call { %"class.std::basic_streambuf"*, i8 } %23(%"class.std::num_put"* %8, %"class.std::basic_streambuf"* %15, i8 %17, %"class.std::ios_base"* %19, i8 signext 48, double 0x400921FB53C8D4F1) #1
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %1) #1
  ret i32 0
}

declare %"class.std::num_put"* @_ZSt9use_facetISt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEEERKT_RKSt6locale(%"class.std::locale"*) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #3

; Function Attrs: nounwind
declare void @_ZNSt6localeC1ERKS_(%"class.std::locale"*, %"class.std::locale"*) #3

; Function Attrs: nounwind
define internal void @_GLOBAL__I_a() #1 section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit) #1
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #1
  ret void
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"vtable pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !6, i64 232}
!5 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !6, i64 216, metadata !7, i64 224, metadata !8, i64 225, metadata !6, i64 232, metadata !6, i64 240, metadata !6, i64 248, metadata !6, i64 256}
!6 = metadata !{metadata !"any pointer", metadata !7, i64 0}
!7 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!8 = metadata !{metadata !"bool", metadata !7, i64 0}
