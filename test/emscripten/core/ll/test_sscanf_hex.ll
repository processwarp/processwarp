; ModuleID = 'test_sscanf_hex.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::allocator" = type { i8 }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@.str = private unnamed_addr constant [12 x i8] c"0x12AB 12AB\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"%x %x\00", align 1
@.str2 = private unnamed_addr constant [7 x i8] c"%d %d\0A\00", align 1
@.str3 = private unnamed_addr constant [13 x i8] c"0102037F00FF\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"%2hhx\00", align 1
@.str5 = private unnamed_addr constant [5 x i8] c"%i, \00", align 1
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]

; Function Attrs: uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %hexstr = alloca %"class.std::basic_string", align 8
  %5 = alloca %"class.std::allocator", align 1
  %6 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32* %a, i32* %b) #5
  %7 = load i32* %a, align 4, !tbaa !1
  %8 = load i32* %b, align 4, !tbaa !1
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str2, i64 0, i64 0), i32 %7, i32 %8)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %hexstr, i8* getelementptr inbounds ([13 x i8]* @.str3, i64 0, i64 0), %"class.std::allocator"* %5)
          to label %10 unwind label %26

; <label>:10                                      ; preds = %0
  %11 = getelementptr inbounds %"class.std::basic_string"* %hexstr, i64 0, i32 0, i32 0
  %12 = load i8** %11, align 8, !tbaa !5
  %13 = getelementptr inbounds i8* %12, i64 -24
  %14 = bitcast i8* %13 to i64*
  %15 = load i64* %14, align 8, !tbaa !9
  %16 = lshr i64 %15, 1
  %17 = trunc i64 %16 to i32
  %sext = shl i64 %16, 32
  %18 = ashr exact i64 %sext, 32
  %19 = icmp slt i64 %sext, 0
  %20 = select i1 %19, i64 -1, i64 %18
  %21 = invoke noalias i8* @_Znam(i64 %20) #6
          to label %.preheader6 unwind label %30

.preheader6:                                      ; preds = %10
  %22 = icmp sgt i32 %17, 0
  br i1 %22, label %.lr.ph9, label %._crit_edge

.preheader:                                       ; preds = %.lr.ph9
  br i1 %22, label %.lr.ph, label %._crit_edge

.lr.ph9:                                          ; preds = %.lr.ph9, %.preheader6
  %indvars.iv10 = phi i64 [ %indvars.iv.next11, %.lr.ph9 ], [ 0, %.preheader6 ]
  %cstr.07 = phi i8* [ %25, %.lr.ph9 ], [ %12, %.preheader6 ]
  %23 = getelementptr inbounds i8* %21, i64 %indvars.iv10
  %24 = call i32 (i8*, i8*, ...)* @sscanf(i8* %cstr.07, i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* %23) #5
  %25 = getelementptr inbounds i8* %cstr.07, i64 2
  %indvars.iv.next11 = add nuw nsw i64 %indvars.iv10, 1
  %lftr.wideiv12 = trunc i64 %indvars.iv.next11 to i32
  %exitcond13 = icmp eq i32 %lftr.wideiv12, %17
  br i1 %exitcond13, label %.preheader, label %.lr.ph9

; <label>:26                                      ; preds = %0
  %27 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  %29 = extractvalue { i8*, i32 } %27, 1
  br label %_ZNSsD1Ev.exit4

; <label>:30                                      ; preds = %10
  %31 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %32 = extractvalue { i8*, i32 } %31, 0
  %33 = extractvalue { i8*, i32 } %31, 1
  %34 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %34) #5
  %35 = bitcast i8* %13 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %36 = icmp eq i8* %13, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %36, label %_ZNSsD1Ev.exit4, label %37, !prof !12

; <label>:37                                      ; preds = %30
  %38 = getelementptr inbounds i8* %12, i64 -8
  %39 = bitcast i8* %38 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %40, label %44

; <label>:40                                      ; preds = %37
  %41 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %41)
  %42 = atomicrmw volatile add i32* %39, i32 -1 acq_rel
  store i32 %42, i32* %1, align 4
  %43 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %41)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

; <label>:44                                      ; preds = %37
  %45 = load i32* %39, align 4, !tbaa !1
  %46 = add nsw i32 %45, -1
  store i32 %46, i32* %39, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3: ; preds = %44, %40
  %.0.i.i.i.i2 = phi i32 [ %43, %40 ], [ %45, %44 ]
  %47 = icmp slt i32 %.0.i.i.i.i2, 1
  br i1 %47, label %48, label %_ZNSsD1Ev.exit4

; <label>:48                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %35, %"class.std::allocator"* %2) #5
  br label %_ZNSsD1Ev.exit4

.lr.ph:                                           ; preds = %.lr.ph, %.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %.preheader ]
  %49 = getelementptr inbounds i8* %21, i64 %indvars.iv
  %50 = load i8* %49, align 1, !tbaa !13
  %51 = sext i8 %50 to i32
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i32 %51)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %17
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %.preheader, %.preheader6
  %putchar = call i32 @putchar(i32 10)
  call void @_ZdaPv(i8* %21) #7
  %53 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %53) #5
  %54 = load i8** %11, align 8, !tbaa !5
  %55 = getelementptr inbounds i8* %54, i64 -24
  %56 = bitcast i8* %55 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %57 = icmp eq i8* %55, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %57, label %_ZNSsD1Ev.exit, label %58, !prof !12

; <label>:58                                      ; preds = %._crit_edge
  %59 = getelementptr inbounds i8* %54, i64 -8
  %60 = bitcast i8* %59 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %61, label %65

; <label>:61                                      ; preds = %58
  %62 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %62)
  %63 = atomicrmw volatile add i32* %60, i32 -1 acq_rel
  store i32 %63, i32* %3, align 4
  %64 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %62)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:65                                      ; preds = %58
  %66 = load i32* %60, align 4, !tbaa !1
  %67 = add nsw i32 %66, -1
  store i32 %67, i32* %60, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %65, %61
  %.0.i.i.i.i = phi i32 [ %64, %61 ], [ %66, %65 ]
  %68 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %68, label %69, label %_ZNSsD1Ev.exit

; <label>:69                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %56, %"class.std::allocator"* %4) #5
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %69, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %._crit_edge
  call void @llvm.lifetime.end(i64 1, i8* %53) #5
  ret i32 0

_ZNSsD1Ev.exit4:                                  ; preds = %48, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3, %30, %26
  %.01 = phi i32 [ %29, %26 ], [ %33, %30 ], [ %33, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3 ], [ %33, %48 ]
  %.0 = phi i8* [ %28, %26 ], [ %32, %30 ], [ %32, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3 ], [ %32, %48 ]
  %70 = insertvalue { i8*, i32 } undef, i8* %.0, 0
  %71 = insertvalue { i8*, i32 } %70, i32 %.01, 1
  resume { i8*, i32 } %71
}

; Function Attrs: nounwind
declare i32 @sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #2

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nobuiltin
declare noalias i8* @_Znam(i64) #3

; Function Attrs: nobuiltin nounwind
declare void @_ZdaPv(i8*) #4

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #5

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #5

declare i32 @putchar(i32)

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nobuiltin nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { builtin }
attributes #7 = { builtin nounwind }

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
!9 = metadata !{metadata !10, metadata !11, i64 0}
!10 = metadata !{metadata !"_ZTSNSs9_Rep_baseE", metadata !11, i64 0, metadata !11, i64 8, metadata !2, i64 16}
!11 = metadata !{metadata !"long", metadata !3, i64 0}
!12 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!13 = metadata !{metadata !3, metadata !3, i64 0}
