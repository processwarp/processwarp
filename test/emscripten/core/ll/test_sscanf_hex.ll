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

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %hexstr = alloca %"class.std::basic_string", align 8
  %3 = alloca %"class.std::allocator", align 1
  %4 = call i32 (i8*, i8*, ...)* @sscanf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32* %a, i32* %b) #5
  %5 = load i32* %a, align 4, !tbaa !1
  %6 = load i32* %b, align 4, !tbaa !1
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str2, i64 0, i64 0), i32 %5, i32 %6) #5
  call void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %hexstr, i8* getelementptr inbounds ([13 x i8]* @.str3, i64 0, i64 0), %"class.std::allocator"* %3) #5
  %8 = getelementptr inbounds %"class.std::basic_string"* %hexstr, i64 0, i32 0, i32 0
  %9 = load i8** %8, align 8, !tbaa !5
  %10 = getelementptr inbounds i8* %9, i64 -24
  %11 = bitcast i8* %10 to i64*
  %12 = load i64* %11, align 8, !tbaa !9
  %13 = lshr i64 %12, 1
  %14 = trunc i64 %13 to i32
  %sext = shl i64 %13, 32
  %15 = ashr exact i64 %sext, 32
  %16 = icmp slt i64 %sext, 0
  %17 = select i1 %16, i64 -1, i64 %15
  %18 = call noalias i8* @_Znam(i64 %17) #6
  %19 = icmp sgt i32 %14, 0
  br i1 %19, label %.lr.ph5, label %._crit_edge

.preheader:                                       ; preds = %.lr.ph5
  br i1 %19, label %.lr.ph, label %._crit_edge

.lr.ph5:                                          ; preds = %.lr.ph5, %0
  %indvars.iv6 = phi i64 [ %indvars.iv.next7, %.lr.ph5 ], [ 0, %0 ]
  %cstr.02 = phi i8* [ %22, %.lr.ph5 ], [ %9, %0 ]
  %20 = getelementptr inbounds i8* %18, i64 %indvars.iv6
  %21 = call i32 (i8*, i8*, ...)* @sscanf(i8* %cstr.02, i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* %20) #5
  %22 = getelementptr inbounds i8* %cstr.02, i64 2
  %indvars.iv.next7 = add nuw nsw i64 %indvars.iv6, 1
  %lftr.wideiv8 = trunc i64 %indvars.iv.next7 to i32
  %exitcond9 = icmp eq i32 %lftr.wideiv8, %14
  br i1 %exitcond9, label %.preheader, label %.lr.ph5

.lr.ph:                                           ; preds = %.lr.ph, %.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %.preheader ]
  %23 = getelementptr inbounds i8* %18, i64 %indvars.iv
  %24 = load i8* %23, align 1, !tbaa !12
  %25 = sext i8 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i32 %25) #5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %14
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %.preheader, %0
  %putchar = call i32 @putchar(i32 10) #5
  call void @_ZdaPv(i8* %18) #6
  %27 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %27) #5
  %28 = load i8** %8, align 8, !tbaa !5
  %29 = getelementptr inbounds i8* %28, i64 -24
  %30 = bitcast i8* %29 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %31 = icmp eq i8* %29, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %31, label %_ZNSsD1Ev.exit, label %32, !prof !13

; <label>:32                                      ; preds = %._crit_edge
  %33 = getelementptr inbounds i8* %28, i64 -8
  %34 = bitcast i8* %33 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %35, label %39

; <label>:35                                      ; preds = %32
  %36 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %36)
  %37 = atomicrmw volatile add i32* %34, i32 -1 acq_rel
  store i32 %37, i32* %1, align 4
  %38 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %36)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:39                                      ; preds = %32
  %40 = load i32* %34, align 4, !tbaa !1
  %41 = add nsw i32 %40, -1
  store i32 %41, i32* %34, align 4, !tbaa !1
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %39, %35
  %.0.i.i.i.i = phi i32 [ %38, %35 ], [ %40, %39 ]
  %42 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %42, label %43, label %_ZNSsD1Ev.exit

; <label>:43                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %30, %"class.std::allocator"* %2) #5
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %43, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %._crit_edge
  call void @llvm.lifetime.end(i64 1, i8* %27) #5
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #2

; Function Attrs: nobuiltin
declare noalias i8* @_Znam(i64) #3

; Function Attrs: nobuiltin nounwind
declare void @_ZdaPv(i8*) #4

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

; Function Attrs: nounwind
declare i32 @putchar(i32) #5

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #5

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #5

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nobuiltin nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { builtin nounwind }

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
!12 = metadata !{metadata !3, metadata !3, i64 0}
!13 = metadata !{metadata !"branch_weights", i32 64, i32 4}
