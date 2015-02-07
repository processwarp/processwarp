; ModuleID = 'test_memcpy3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [13 x i8] c"final %d:%d\0A\00", align 1
@str = private unnamed_addr constant [2 x i8] c"8\00"
@str4 = private unnamed_addr constant [3 x i8] c"16\00"
@str5 = private unnamed_addr constant [3 x i8] c"32\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buffer = alloca [10240 x i8], align 16
  %seed = alloca i32, align 4
  %buffer53 = alloca [10240 x i16], align 16
  %seed54 = alloca i32, align 4
  %buffer110 = alloca [10240 x i32], align 16
  %seed111 = alloca i32, align 4
  %puts = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str, i64 0, i64 0))
  %1 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 0
  call void @llvm.lifetime.start(i64 10240, i8* %1) #2
  store volatile i32 123, i32* %seed, align 4
  br label %2

; <label>:2                                       ; preds = %2, %0
  %indvars.iv716 = phi i64 [ 0, %0 ], [ %indvars.iv.next717, %2 ]
  %3 = load volatile i32* %seed, align 4
  %4 = trunc i64 %indvars.iv716 to i32
  %5 = mul nsw i32 %3, %4
  %6 = trunc i32 %5 to i8
  %7 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv716
  store i8 %6, i8* %7, align 1, !tbaa !1
  %indvars.iv.next717 = add nuw nsw i64 %indvars.iv716, 1
  %exitcond718 = icmp eq i64 %indvars.iv.next717, 10240
  br i1 %exitcond718, label %8, label %2

; <label>:8                                       ; preds = %2
  %9 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 2
  %10 = load i8* %9, align 2
  store i8 %10, i8* %1, align 16
  br label %11

; <label>:11                                      ; preds = %._crit_edge, %8
  %12 = phi i8 [ %10, %8 ], [ %.pre, %._crit_edge ]
  %indvars.iv713 = phi i64 [ 1, %8 ], [ %phitmp, %._crit_edge ]
  %v.0336 = phi i32 [ 0, %8 ], [ %14, %._crit_edge ]
  %13 = zext i8 %12 to i32
  %14 = add nsw i32 %13, %v.0336
  %exitcond715 = icmp eq i64 %indvars.iv713, 10240
  br i1 %exitcond715, label %15, label %._crit_edge

._crit_edge:                                      ; preds = %11
  %.phi.trans.insert = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv713
  %.pre = load i8* %.phi.trans.insert, align 1, !tbaa !1
  %phitmp = add i64 %indvars.iv713, 1
  br label %11

; <label>:15                                      ; preds = %11
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %14)
  br label %17

; <label>:17                                      ; preds = %17, %15
  %indvars.iv709 = phi i64 [ 0, %15 ], [ %indvars.iv.next710, %17 ]
  %18 = load volatile i32* %seed, align 4
  %19 = trunc i64 %indvars.iv709 to i32
  %20 = mul nsw i32 %18, %19
  %21 = trunc i32 %20 to i8
  %22 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv709
  store i8 %21, i8* %22, align 1, !tbaa !1
  %indvars.iv.next710 = add nuw nsw i64 %indvars.iv709, 1
  %exitcond711 = icmp eq i64 %indvars.iv.next710, 10240
  br i1 %exitcond711, label %23, label %17

; <label>:23                                      ; preds = %17
  %24 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 3
  %25 = bitcast i8* %24 to i16*
  %26 = bitcast [10240 x i8]* %buffer to i16*
  %27 = load i16* %25, align 1
  store i16 %27, i16* %26, align 16
  %28 = trunc i16 %27 to i8
  br label %29

; <label>:29                                      ; preds = %._crit_edge719, %23
  %30 = phi i8 [ %28, %23 ], [ %.pre721, %._crit_edge719 ]
  %indvars.iv706 = phi i64 [ 1, %23 ], [ %phitmp743, %._crit_edge719 ]
  %v3.0333 = phi i32 [ 0, %23 ], [ %32, %._crit_edge719 ]
  %31 = zext i8 %30 to i32
  %32 = add nsw i32 %31, %v3.0333
  %exitcond708 = icmp eq i64 %indvars.iv706, 10240
  br i1 %exitcond708, label %33, label %._crit_edge719

._crit_edge719:                                   ; preds = %29
  %.phi.trans.insert720 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv706
  %.pre721 = load i8* %.phi.trans.insert720, align 1, !tbaa !1
  %phitmp743 = add i64 %indvars.iv706, 1
  br label %29

; <label>:33                                      ; preds = %29
  %34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %32)
  br label %35

; <label>:35                                      ; preds = %35, %33
  %indvars.iv702 = phi i64 [ 0, %33 ], [ %indvars.iv.next703, %35 ]
  %36 = load volatile i32* %seed, align 4
  %37 = trunc i64 %indvars.iv702 to i32
  %38 = mul nsw i32 %36, %37
  %39 = trunc i32 %38 to i8
  %40 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv702
  store i8 %39, i8* %40, align 1, !tbaa !1
  %indvars.iv.next703 = add nuw nsw i64 %indvars.iv702, 1
  %exitcond704 = icmp eq i64 %indvars.iv.next703, 10240
  br i1 %exitcond704, label %vector.ph1843, label %35

vector.ph1843:                                    ; preds = %35
  %41 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 4
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %41, i64 3, i32 4, i1 false)
  br label %vector.body1844

vector.body1844:                                  ; preds = %vector.body1844, %vector.ph1843
  %index1847 = phi i64 [ 0, %vector.ph1843 ], [ %index.next1851, %vector.body1844 ]
  %vec.phi1856 = phi <4 x i32> [ zeroinitializer, %vector.ph1843 ], [ %48, %vector.body1844 ]
  %vec.phi1857 = phi <4 x i32> [ zeroinitializer, %vector.ph1843 ], [ %49, %vector.body1844 ]
  %42 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1847
  %43 = bitcast i8* %42 to <4 x i8>*
  %wide.load1858 = load <4 x i8>* %43, align 8
  %.sum1867 = or i64 %index1847, 4
  %44 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1867
  %45 = bitcast i8* %44 to <4 x i8>*
  %wide.load1859 = load <4 x i8>* %45, align 4
  %46 = zext <4 x i8> %wide.load1858 to <4 x i32>
  %47 = zext <4 x i8> %wide.load1859 to <4 x i32>
  %48 = add nsw <4 x i32> %46, %vec.phi1856
  %49 = add nsw <4 x i32> %47, %vec.phi1857
  %index.next1851 = add i64 %index1847, 8
  %50 = icmp eq i64 %index.next1851, 10240
  br i1 %50, label %middle.block1845, label %vector.body1844, !llvm.loop !4

middle.block1845:                                 ; preds = %vector.body1844
  %bin.rdx1862 = add <4 x i32> %49, %48
  %rdx.shuf1863 = shufflevector <4 x i32> %bin.rdx1862, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1864 = add <4 x i32> %bin.rdx1862, %rdx.shuf1863
  %rdx.shuf1865 = shufflevector <4 x i32> %bin.rdx1864, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1866 = add <4 x i32> %bin.rdx1864, %rdx.shuf1865
  %51 = extractelement <4 x i32> %bin.rdx1866, i32 0
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %51)
  br label %53

; <label>:53                                      ; preds = %53, %middle.block1845
  %indvars.iv695 = phi i64 [ 0, %middle.block1845 ], [ %indvars.iv.next696, %53 ]
  %54 = load volatile i32* %seed, align 4
  %55 = trunc i64 %indvars.iv695 to i32
  %56 = mul nsw i32 %54, %55
  %57 = trunc i32 %56 to i8
  %58 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv695
  store i8 %57, i8* %58, align 1, !tbaa !1
  %indvars.iv.next696 = add nuw nsw i64 %indvars.iv695, 1
  %exitcond697 = icmp eq i64 %indvars.iv.next696, 10240
  br i1 %exitcond697, label %59, label %53

; <label>:59                                      ; preds = %53
  %60 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 5
  %61 = bitcast i8* %60 to i32*
  %62 = bitcast [10240 x i8]* %buffer to i32*
  %63 = load i32* %61, align 1
  store i32 %63, i32* %62, align 16
  %64 = trunc i32 %63 to i8
  br label %65

; <label>:65                                      ; preds = %._crit_edge722, %59
  %66 = phi i8 [ %64, %59 ], [ %.pre724, %._crit_edge722 ]
  %indvars.iv692 = phi i64 [ 1, %59 ], [ %phitmp744, %._crit_edge722 ]
  %v9.0327 = phi i32 [ 0, %59 ], [ %68, %._crit_edge722 ]
  %67 = zext i8 %66 to i32
  %68 = add nsw i32 %67, %v9.0327
  %exitcond694 = icmp eq i64 %indvars.iv692, 10240
  br i1 %exitcond694, label %69, label %._crit_edge722

._crit_edge722:                                   ; preds = %65
  %.phi.trans.insert723 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv692
  %.pre724 = load i8* %.phi.trans.insert723, align 1, !tbaa !1
  %phitmp744 = add i64 %indvars.iv692, 1
  br label %65

; <label>:69                                      ; preds = %65
  %70 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %68)
  br label %71

; <label>:71                                      ; preds = %71, %69
  %indvars.iv688 = phi i64 [ 0, %69 ], [ %indvars.iv.next689, %71 ]
  %72 = load volatile i32* %seed, align 4
  %73 = trunc i64 %indvars.iv688 to i32
  %74 = mul nsw i32 %72, %73
  %75 = trunc i32 %74 to i8
  %76 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv688
  store i8 %75, i8* %76, align 1, !tbaa !1
  %indvars.iv.next689 = add nuw nsw i64 %indvars.iv688, 1
  %exitcond690 = icmp eq i64 %indvars.iv.next689, 10240
  br i1 %exitcond690, label %vector.ph1819, label %71

vector.ph1819:                                    ; preds = %71
  %77 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %77, i64 5, i32 2, i1 false)
  br label %vector.body1820

vector.body1820:                                  ; preds = %vector.body1820, %vector.ph1819
  %index1823 = phi i64 [ 0, %vector.ph1819 ], [ %index.next1827, %vector.body1820 ]
  %vec.phi1832 = phi <4 x i32> [ zeroinitializer, %vector.ph1819 ], [ %84, %vector.body1820 ]
  %vec.phi1833 = phi <4 x i32> [ zeroinitializer, %vector.ph1819 ], [ %85, %vector.body1820 ]
  %78 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1823
  %79 = bitcast i8* %78 to <4 x i8>*
  %wide.load1834 = load <4 x i8>* %79, align 8
  %.sum1868 = or i64 %index1823, 4
  %80 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1868
  %81 = bitcast i8* %80 to <4 x i8>*
  %wide.load1835 = load <4 x i8>* %81, align 4
  %82 = zext <4 x i8> %wide.load1834 to <4 x i32>
  %83 = zext <4 x i8> %wide.load1835 to <4 x i32>
  %84 = add nsw <4 x i32> %82, %vec.phi1832
  %85 = add nsw <4 x i32> %83, %vec.phi1833
  %index.next1827 = add i64 %index1823, 8
  %86 = icmp eq i64 %index.next1827, 10240
  br i1 %86, label %middle.block1821, label %vector.body1820, !llvm.loop !7

middle.block1821:                                 ; preds = %vector.body1820
  %bin.rdx1838 = add <4 x i32> %85, %84
  %rdx.shuf1839 = shufflevector <4 x i32> %bin.rdx1838, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1840 = add <4 x i32> %bin.rdx1838, %rdx.shuf1839
  %rdx.shuf1841 = shufflevector <4 x i32> %bin.rdx1840, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1842 = add <4 x i32> %bin.rdx1840, %rdx.shuf1841
  %87 = extractelement <4 x i32> %bin.rdx1842, i32 0
  %88 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %87)
  br label %89

; <label>:89                                      ; preds = %89, %middle.block1821
  %indvars.iv681 = phi i64 [ 0, %middle.block1821 ], [ %indvars.iv.next682, %89 ]
  %90 = load volatile i32* %seed, align 4
  %91 = trunc i64 %indvars.iv681 to i32
  %92 = mul nsw i32 %90, %91
  %93 = trunc i32 %92 to i8
  %94 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv681
  store i8 %93, i8* %94, align 1, !tbaa !1
  %indvars.iv.next682 = add nuw nsw i64 %indvars.iv681, 1
  %exitcond683 = icmp eq i64 %indvars.iv.next682, 10240
  br i1 %exitcond683, label %vector.ph1795, label %89

vector.ph1795:                                    ; preds = %89
  %95 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 7
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %95, i64 6, i32 1, i1 false)
  br label %vector.body1796

vector.body1796:                                  ; preds = %vector.body1796, %vector.ph1795
  %index1799 = phi i64 [ 0, %vector.ph1795 ], [ %index.next1803, %vector.body1796 ]
  %vec.phi1808 = phi <4 x i32> [ zeroinitializer, %vector.ph1795 ], [ %102, %vector.body1796 ]
  %vec.phi1809 = phi <4 x i32> [ zeroinitializer, %vector.ph1795 ], [ %103, %vector.body1796 ]
  %96 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1799
  %97 = bitcast i8* %96 to <4 x i8>*
  %wide.load1810 = load <4 x i8>* %97, align 8
  %.sum1869 = or i64 %index1799, 4
  %98 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1869
  %99 = bitcast i8* %98 to <4 x i8>*
  %wide.load1811 = load <4 x i8>* %99, align 4
  %100 = zext <4 x i8> %wide.load1810 to <4 x i32>
  %101 = zext <4 x i8> %wide.load1811 to <4 x i32>
  %102 = add nsw <4 x i32> %100, %vec.phi1808
  %103 = add nsw <4 x i32> %101, %vec.phi1809
  %index.next1803 = add i64 %index1799, 8
  %104 = icmp eq i64 %index.next1803, 10240
  br i1 %104, label %middle.block1797, label %vector.body1796, !llvm.loop !8

middle.block1797:                                 ; preds = %vector.body1796
  %bin.rdx1814 = add <4 x i32> %103, %102
  %rdx.shuf1815 = shufflevector <4 x i32> %bin.rdx1814, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1816 = add <4 x i32> %bin.rdx1814, %rdx.shuf1815
  %rdx.shuf1817 = shufflevector <4 x i32> %bin.rdx1816, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1818 = add <4 x i32> %bin.rdx1816, %rdx.shuf1817
  %105 = extractelement <4 x i32> %bin.rdx1818, i32 0
  %106 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %105)
  br label %107

; <label>:107                                     ; preds = %107, %middle.block1797
  %indvars.iv674 = phi i64 [ 0, %middle.block1797 ], [ %indvars.iv.next675, %107 ]
  %108 = load volatile i32* %seed, align 4
  %109 = trunc i64 %indvars.iv674 to i32
  %110 = mul nsw i32 %108, %109
  %111 = trunc i32 %110 to i8
  %112 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv674
  store i8 %111, i8* %112, align 1, !tbaa !1
  %indvars.iv.next675 = add nuw nsw i64 %indvars.iv674, 1
  %exitcond676 = icmp eq i64 %indvars.iv.next675, 10240
  br i1 %exitcond676, label %vector.ph1771, label %107

vector.ph1771:                                    ; preds = %107
  %113 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %113, i64 7, i32 8, i1 false)
  br label %vector.body1772

vector.body1772:                                  ; preds = %vector.body1772, %vector.ph1771
  %index1775 = phi i64 [ 0, %vector.ph1771 ], [ %index.next1779, %vector.body1772 ]
  %vec.phi1784 = phi <4 x i32> [ zeroinitializer, %vector.ph1771 ], [ %120, %vector.body1772 ]
  %vec.phi1785 = phi <4 x i32> [ zeroinitializer, %vector.ph1771 ], [ %121, %vector.body1772 ]
  %114 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1775
  %115 = bitcast i8* %114 to <4 x i8>*
  %wide.load1786 = load <4 x i8>* %115, align 8
  %.sum1870 = or i64 %index1775, 4
  %116 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1870
  %117 = bitcast i8* %116 to <4 x i8>*
  %wide.load1787 = load <4 x i8>* %117, align 4
  %118 = zext <4 x i8> %wide.load1786 to <4 x i32>
  %119 = zext <4 x i8> %wide.load1787 to <4 x i32>
  %120 = add nsw <4 x i32> %118, %vec.phi1784
  %121 = add nsw <4 x i32> %119, %vec.phi1785
  %index.next1779 = add i64 %index1775, 8
  %122 = icmp eq i64 %index.next1779, 10240
  br i1 %122, label %middle.block1773, label %vector.body1772, !llvm.loop !9

middle.block1773:                                 ; preds = %vector.body1772
  %bin.rdx1790 = add <4 x i32> %121, %120
  %rdx.shuf1791 = shufflevector <4 x i32> %bin.rdx1790, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1792 = add <4 x i32> %bin.rdx1790, %rdx.shuf1791
  %rdx.shuf1793 = shufflevector <4 x i32> %bin.rdx1792, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1794 = add <4 x i32> %bin.rdx1792, %rdx.shuf1793
  %123 = extractelement <4 x i32> %bin.rdx1794, i32 0
  %124 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %123)
  br label %125

; <label>:125                                     ; preds = %125, %middle.block1773
  %indvars.iv667 = phi i64 [ 0, %middle.block1773 ], [ %indvars.iv.next668, %125 ]
  %126 = load volatile i32* %seed, align 4
  %127 = trunc i64 %indvars.iv667 to i32
  %128 = mul nsw i32 %126, %127
  %129 = trunc i32 %128 to i8
  %130 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv667
  store i8 %129, i8* %130, align 1, !tbaa !1
  %indvars.iv.next668 = add nuw nsw i64 %indvars.iv667, 1
  %exitcond669 = icmp eq i64 %indvars.iv.next668, 10240
  br i1 %exitcond669, label %131, label %125

; <label>:131                                     ; preds = %125
  %132 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 9
  %133 = bitcast i8* %132 to i64*
  %134 = bitcast [10240 x i8]* %buffer to i64*
  %135 = load i64* %133, align 1
  store i64 %135, i64* %134, align 16
  %136 = trunc i64 %135 to i8
  br label %137

; <label>:137                                     ; preds = %._crit_edge725, %131
  %138 = phi i8 [ %136, %131 ], [ %.pre727, %._crit_edge725 ]
  %indvars.iv664 = phi i64 [ 1, %131 ], [ %phitmp745, %._crit_edge725 ]
  %v21.0315 = phi i32 [ 0, %131 ], [ %140, %._crit_edge725 ]
  %139 = zext i8 %138 to i32
  %140 = add nsw i32 %139, %v21.0315
  %exitcond666 = icmp eq i64 %indvars.iv664, 10240
  br i1 %exitcond666, label %141, label %._crit_edge725

._crit_edge725:                                   ; preds = %137
  %.phi.trans.insert726 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv664
  %.pre727 = load i8* %.phi.trans.insert726, align 1, !tbaa !1
  %phitmp745 = add i64 %indvars.iv664, 1
  br label %137

; <label>:141                                     ; preds = %137
  %142 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %140)
  br label %143

; <label>:143                                     ; preds = %143, %141
  %indvars.iv660 = phi i64 [ 0, %141 ], [ %indvars.iv.next661, %143 ]
  %144 = load volatile i32* %seed, align 4
  %145 = trunc i64 %indvars.iv660 to i32
  %146 = mul nsw i32 %144, %145
  %147 = trunc i32 %146 to i8
  %148 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv660
  store i8 %147, i8* %148, align 1, !tbaa !1
  %indvars.iv.next661 = add nuw nsw i64 %indvars.iv660, 1
  %exitcond662 = icmp eq i64 %indvars.iv.next661, 10240
  br i1 %exitcond662, label %vector.ph1747, label %143

vector.ph1747:                                    ; preds = %143
  %149 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 10
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %149, i64 9, i32 2, i1 false)
  br label %vector.body1748

vector.body1748:                                  ; preds = %vector.body1748, %vector.ph1747
  %index1751 = phi i64 [ 0, %vector.ph1747 ], [ %index.next1755, %vector.body1748 ]
  %vec.phi1760 = phi <4 x i32> [ zeroinitializer, %vector.ph1747 ], [ %156, %vector.body1748 ]
  %vec.phi1761 = phi <4 x i32> [ zeroinitializer, %vector.ph1747 ], [ %157, %vector.body1748 ]
  %150 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1751
  %151 = bitcast i8* %150 to <4 x i8>*
  %wide.load1762 = load <4 x i8>* %151, align 8
  %.sum1871 = or i64 %index1751, 4
  %152 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1871
  %153 = bitcast i8* %152 to <4 x i8>*
  %wide.load1763 = load <4 x i8>* %153, align 4
  %154 = zext <4 x i8> %wide.load1762 to <4 x i32>
  %155 = zext <4 x i8> %wide.load1763 to <4 x i32>
  %156 = add nsw <4 x i32> %154, %vec.phi1760
  %157 = add nsw <4 x i32> %155, %vec.phi1761
  %index.next1755 = add i64 %index1751, 8
  %158 = icmp eq i64 %index.next1755, 10240
  br i1 %158, label %middle.block1749, label %vector.body1748, !llvm.loop !10

middle.block1749:                                 ; preds = %vector.body1748
  %bin.rdx1766 = add <4 x i32> %157, %156
  %rdx.shuf1767 = shufflevector <4 x i32> %bin.rdx1766, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1768 = add <4 x i32> %bin.rdx1766, %rdx.shuf1767
  %rdx.shuf1769 = shufflevector <4 x i32> %bin.rdx1768, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1770 = add <4 x i32> %bin.rdx1768, %rdx.shuf1769
  %159 = extractelement <4 x i32> %bin.rdx1770, i32 0
  %160 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %159)
  br label %161

; <label>:161                                     ; preds = %161, %middle.block1749
  %indvars.iv653 = phi i64 [ 0, %middle.block1749 ], [ %indvars.iv.next654, %161 ]
  %162 = load volatile i32* %seed, align 4
  %163 = trunc i64 %indvars.iv653 to i32
  %164 = mul nsw i32 %162, %163
  %165 = trunc i32 %164 to i8
  %166 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv653
  store i8 %165, i8* %166, align 1, !tbaa !1
  %indvars.iv.next654 = add nuw nsw i64 %indvars.iv653, 1
  %exitcond655 = icmp eq i64 %indvars.iv.next654, 10240
  br i1 %exitcond655, label %vector.ph1723, label %161

vector.ph1723:                                    ; preds = %161
  %167 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 11
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %167, i64 10, i32 1, i1 false)
  br label %vector.body1724

vector.body1724:                                  ; preds = %vector.body1724, %vector.ph1723
  %index1727 = phi i64 [ 0, %vector.ph1723 ], [ %index.next1731, %vector.body1724 ]
  %vec.phi1736 = phi <4 x i32> [ zeroinitializer, %vector.ph1723 ], [ %174, %vector.body1724 ]
  %vec.phi1737 = phi <4 x i32> [ zeroinitializer, %vector.ph1723 ], [ %175, %vector.body1724 ]
  %168 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1727
  %169 = bitcast i8* %168 to <4 x i8>*
  %wide.load1738 = load <4 x i8>* %169, align 8
  %.sum1872 = or i64 %index1727, 4
  %170 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1872
  %171 = bitcast i8* %170 to <4 x i8>*
  %wide.load1739 = load <4 x i8>* %171, align 4
  %172 = zext <4 x i8> %wide.load1738 to <4 x i32>
  %173 = zext <4 x i8> %wide.load1739 to <4 x i32>
  %174 = add nsw <4 x i32> %172, %vec.phi1736
  %175 = add nsw <4 x i32> %173, %vec.phi1737
  %index.next1731 = add i64 %index1727, 8
  %176 = icmp eq i64 %index.next1731, 10240
  br i1 %176, label %middle.block1725, label %vector.body1724, !llvm.loop !11

middle.block1725:                                 ; preds = %vector.body1724
  %bin.rdx1742 = add <4 x i32> %175, %174
  %rdx.shuf1743 = shufflevector <4 x i32> %bin.rdx1742, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1744 = add <4 x i32> %bin.rdx1742, %rdx.shuf1743
  %rdx.shuf1745 = shufflevector <4 x i32> %bin.rdx1744, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1746 = add <4 x i32> %bin.rdx1744, %rdx.shuf1745
  %177 = extractelement <4 x i32> %bin.rdx1746, i32 0
  %178 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %177)
  br label %179

; <label>:179                                     ; preds = %179, %middle.block1725
  %indvars.iv646 = phi i64 [ 0, %middle.block1725 ], [ %indvars.iv.next647, %179 ]
  %180 = load volatile i32* %seed, align 4
  %181 = trunc i64 %indvars.iv646 to i32
  %182 = mul nsw i32 %180, %181
  %183 = trunc i32 %182 to i8
  %184 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv646
  store i8 %183, i8* %184, align 1, !tbaa !1
  %indvars.iv.next647 = add nuw nsw i64 %indvars.iv646, 1
  %exitcond648 = icmp eq i64 %indvars.iv.next647, 10240
  br i1 %exitcond648, label %vector.ph1699, label %179

vector.ph1699:                                    ; preds = %179
  %185 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 17
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %185, i64 16, i32 1, i1 false)
  br label %vector.body1700

vector.body1700:                                  ; preds = %vector.body1700, %vector.ph1699
  %index1703 = phi i64 [ 0, %vector.ph1699 ], [ %index.next1707, %vector.body1700 ]
  %vec.phi1712 = phi <4 x i32> [ zeroinitializer, %vector.ph1699 ], [ %192, %vector.body1700 ]
  %vec.phi1713 = phi <4 x i32> [ zeroinitializer, %vector.ph1699 ], [ %193, %vector.body1700 ]
  %186 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1703
  %187 = bitcast i8* %186 to <4 x i8>*
  %wide.load1714 = load <4 x i8>* %187, align 8
  %.sum1873 = or i64 %index1703, 4
  %188 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1873
  %189 = bitcast i8* %188 to <4 x i8>*
  %wide.load1715 = load <4 x i8>* %189, align 4
  %190 = zext <4 x i8> %wide.load1714 to <4 x i32>
  %191 = zext <4 x i8> %wide.load1715 to <4 x i32>
  %192 = add nsw <4 x i32> %190, %vec.phi1712
  %193 = add nsw <4 x i32> %191, %vec.phi1713
  %index.next1707 = add i64 %index1703, 8
  %194 = icmp eq i64 %index.next1707, 10240
  br i1 %194, label %middle.block1701, label %vector.body1700, !llvm.loop !12

middle.block1701:                                 ; preds = %vector.body1700
  %bin.rdx1718 = add <4 x i32> %193, %192
  %rdx.shuf1719 = shufflevector <4 x i32> %bin.rdx1718, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1720 = add <4 x i32> %bin.rdx1718, %rdx.shuf1719
  %rdx.shuf1721 = shufflevector <4 x i32> %bin.rdx1720, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1722 = add <4 x i32> %bin.rdx1720, %rdx.shuf1721
  %195 = extractelement <4 x i32> %bin.rdx1722, i32 0
  %196 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %195)
  br label %197

; <label>:197                                     ; preds = %197, %middle.block1701
  %indvars.iv639 = phi i64 [ 0, %middle.block1701 ], [ %indvars.iv.next640, %197 ]
  %198 = load volatile i32* %seed, align 4
  %199 = trunc i64 %indvars.iv639 to i32
  %200 = mul nsw i32 %198, %199
  %201 = trunc i32 %200 to i8
  %202 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv639
  store i8 %201, i8* %202, align 1, !tbaa !1
  %indvars.iv.next640 = add nuw nsw i64 %indvars.iv639, 1
  %exitcond641 = icmp eq i64 %indvars.iv.next640, 10240
  br i1 %exitcond641, label %vector.ph1675, label %197

vector.ph1675:                                    ; preds = %197
  %203 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 33
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %203, i64 32, i32 1, i1 false)
  br label %vector.body1676

vector.body1676:                                  ; preds = %vector.body1676, %vector.ph1675
  %index1679 = phi i64 [ 0, %vector.ph1675 ], [ %index.next1683, %vector.body1676 ]
  %vec.phi1688 = phi <4 x i32> [ zeroinitializer, %vector.ph1675 ], [ %210, %vector.body1676 ]
  %vec.phi1689 = phi <4 x i32> [ zeroinitializer, %vector.ph1675 ], [ %211, %vector.body1676 ]
  %204 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1679
  %205 = bitcast i8* %204 to <4 x i8>*
  %wide.load1690 = load <4 x i8>* %205, align 8
  %.sum1874 = or i64 %index1679, 4
  %206 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1874
  %207 = bitcast i8* %206 to <4 x i8>*
  %wide.load1691 = load <4 x i8>* %207, align 4
  %208 = zext <4 x i8> %wide.load1690 to <4 x i32>
  %209 = zext <4 x i8> %wide.load1691 to <4 x i32>
  %210 = add nsw <4 x i32> %208, %vec.phi1688
  %211 = add nsw <4 x i32> %209, %vec.phi1689
  %index.next1683 = add i64 %index1679, 8
  %212 = icmp eq i64 %index.next1683, 10240
  br i1 %212, label %middle.block1677, label %vector.body1676, !llvm.loop !13

middle.block1677:                                 ; preds = %vector.body1676
  %bin.rdx1694 = add <4 x i32> %211, %210
  %rdx.shuf1695 = shufflevector <4 x i32> %bin.rdx1694, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1696 = add <4 x i32> %bin.rdx1694, %rdx.shuf1695
  %rdx.shuf1697 = shufflevector <4 x i32> %bin.rdx1696, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1698 = add <4 x i32> %bin.rdx1696, %rdx.shuf1697
  %213 = extractelement <4 x i32> %bin.rdx1698, i32 0
  %214 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %213)
  br label %215

; <label>:215                                     ; preds = %215, %middle.block1677
  %indvars.iv632 = phi i64 [ 0, %middle.block1677 ], [ %indvars.iv.next633, %215 ]
  %216 = load volatile i32* %seed, align 4
  %217 = trunc i64 %indvars.iv632 to i32
  %218 = mul nsw i32 %216, %217
  %219 = trunc i32 %218 to i8
  %220 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv632
  store i8 %219, i8* %220, align 1, !tbaa !1
  %indvars.iv.next633 = add nuw nsw i64 %indvars.iv632, 1
  %exitcond634 = icmp eq i64 %indvars.iv.next633, 10240
  br i1 %exitcond634, label %vector.ph1651, label %215

vector.ph1651:                                    ; preds = %215
  %221 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 65
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %221, i64 64, i32 1, i1 false)
  br label %vector.body1652

vector.body1652:                                  ; preds = %vector.body1652, %vector.ph1651
  %index1655 = phi i64 [ 0, %vector.ph1651 ], [ %index.next1659, %vector.body1652 ]
  %vec.phi1664 = phi <4 x i32> [ zeroinitializer, %vector.ph1651 ], [ %228, %vector.body1652 ]
  %vec.phi1665 = phi <4 x i32> [ zeroinitializer, %vector.ph1651 ], [ %229, %vector.body1652 ]
  %222 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1655
  %223 = bitcast i8* %222 to <4 x i8>*
  %wide.load1666 = load <4 x i8>* %223, align 8
  %.sum1875 = or i64 %index1655, 4
  %224 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1875
  %225 = bitcast i8* %224 to <4 x i8>*
  %wide.load1667 = load <4 x i8>* %225, align 4
  %226 = zext <4 x i8> %wide.load1666 to <4 x i32>
  %227 = zext <4 x i8> %wide.load1667 to <4 x i32>
  %228 = add nsw <4 x i32> %226, %vec.phi1664
  %229 = add nsw <4 x i32> %227, %vec.phi1665
  %index.next1659 = add i64 %index1655, 8
  %230 = icmp eq i64 %index.next1659, 10240
  br i1 %230, label %middle.block1653, label %vector.body1652, !llvm.loop !14

middle.block1653:                                 ; preds = %vector.body1652
  %bin.rdx1670 = add <4 x i32> %229, %228
  %rdx.shuf1671 = shufflevector <4 x i32> %bin.rdx1670, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1672 = add <4 x i32> %bin.rdx1670, %rdx.shuf1671
  %rdx.shuf1673 = shufflevector <4 x i32> %bin.rdx1672, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1674 = add <4 x i32> %bin.rdx1672, %rdx.shuf1673
  %231 = extractelement <4 x i32> %bin.rdx1674, i32 0
  %232 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %231)
  br label %233

; <label>:233                                     ; preds = %233, %middle.block1653
  %indvars.iv625 = phi i64 [ 0, %middle.block1653 ], [ %indvars.iv.next626, %233 ]
  %234 = load volatile i32* %seed, align 4
  %235 = trunc i64 %indvars.iv625 to i32
  %236 = mul nsw i32 %234, %235
  %237 = trunc i32 %236 to i8
  %238 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv625
  store i8 %237, i8* %238, align 1, !tbaa !1
  %indvars.iv.next626 = add nuw nsw i64 %indvars.iv625, 1
  %exitcond627 = icmp eq i64 %indvars.iv.next626, 10240
  br i1 %exitcond627, label %vector.ph1627, label %233

vector.ph1627:                                    ; preds = %233
  %239 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 129
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %239, i64 128, i32 1, i1 false)
  br label %vector.body1628

vector.body1628:                                  ; preds = %vector.body1628, %vector.ph1627
  %index1631 = phi i64 [ 0, %vector.ph1627 ], [ %index.next1635, %vector.body1628 ]
  %vec.phi1640 = phi <4 x i32> [ zeroinitializer, %vector.ph1627 ], [ %246, %vector.body1628 ]
  %vec.phi1641 = phi <4 x i32> [ zeroinitializer, %vector.ph1627 ], [ %247, %vector.body1628 ]
  %240 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1631
  %241 = bitcast i8* %240 to <4 x i8>*
  %wide.load1642 = load <4 x i8>* %241, align 8
  %.sum1876 = or i64 %index1631, 4
  %242 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1876
  %243 = bitcast i8* %242 to <4 x i8>*
  %wide.load1643 = load <4 x i8>* %243, align 4
  %244 = zext <4 x i8> %wide.load1642 to <4 x i32>
  %245 = zext <4 x i8> %wide.load1643 to <4 x i32>
  %246 = add nsw <4 x i32> %244, %vec.phi1640
  %247 = add nsw <4 x i32> %245, %vec.phi1641
  %index.next1635 = add i64 %index1631, 8
  %248 = icmp eq i64 %index.next1635, 10240
  br i1 %248, label %middle.block1629, label %vector.body1628, !llvm.loop !15

middle.block1629:                                 ; preds = %vector.body1628
  %bin.rdx1646 = add <4 x i32> %247, %246
  %rdx.shuf1647 = shufflevector <4 x i32> %bin.rdx1646, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1648 = add <4 x i32> %bin.rdx1646, %rdx.shuf1647
  %rdx.shuf1649 = shufflevector <4 x i32> %bin.rdx1648, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1650 = add <4 x i32> %bin.rdx1648, %rdx.shuf1649
  %249 = extractelement <4 x i32> %bin.rdx1650, i32 0
  %250 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %249)
  br label %251

; <label>:251                                     ; preds = %251, %middle.block1629
  %indvars.iv618 = phi i64 [ 0, %middle.block1629 ], [ %indvars.iv.next619, %251 ]
  %252 = load volatile i32* %seed, align 4
  %253 = trunc i64 %indvars.iv618 to i32
  %254 = mul nsw i32 %252, %253
  %255 = trunc i32 %254 to i8
  %256 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv618
  store i8 %255, i8* %256, align 1, !tbaa !1
  %indvars.iv.next619 = add nuw nsw i64 %indvars.iv618, 1
  %exitcond620 = icmp eq i64 %indvars.iv.next619, 10240
  br i1 %exitcond620, label %vector.ph1603, label %251

vector.ph1603:                                    ; preds = %251
  %257 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 257
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %257, i64 256, i32 1, i1 false)
  br label %vector.body1604

vector.body1604:                                  ; preds = %vector.body1604, %vector.ph1603
  %index1607 = phi i64 [ 0, %vector.ph1603 ], [ %index.next1611, %vector.body1604 ]
  %vec.phi1616 = phi <4 x i32> [ zeroinitializer, %vector.ph1603 ], [ %264, %vector.body1604 ]
  %vec.phi1617 = phi <4 x i32> [ zeroinitializer, %vector.ph1603 ], [ %265, %vector.body1604 ]
  %258 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1607
  %259 = bitcast i8* %258 to <4 x i8>*
  %wide.load1618 = load <4 x i8>* %259, align 8
  %.sum1877 = or i64 %index1607, 4
  %260 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1877
  %261 = bitcast i8* %260 to <4 x i8>*
  %wide.load1619 = load <4 x i8>* %261, align 4
  %262 = zext <4 x i8> %wide.load1618 to <4 x i32>
  %263 = zext <4 x i8> %wide.load1619 to <4 x i32>
  %264 = add nsw <4 x i32> %262, %vec.phi1616
  %265 = add nsw <4 x i32> %263, %vec.phi1617
  %index.next1611 = add i64 %index1607, 8
  %266 = icmp eq i64 %index.next1611, 10240
  br i1 %266, label %middle.block1605, label %vector.body1604, !llvm.loop !16

middle.block1605:                                 ; preds = %vector.body1604
  %bin.rdx1622 = add <4 x i32> %265, %264
  %rdx.shuf1623 = shufflevector <4 x i32> %bin.rdx1622, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1624 = add <4 x i32> %bin.rdx1622, %rdx.shuf1623
  %rdx.shuf1625 = shufflevector <4 x i32> %bin.rdx1624, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1626 = add <4 x i32> %bin.rdx1624, %rdx.shuf1625
  %267 = extractelement <4 x i32> %bin.rdx1626, i32 0
  %268 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %267)
  br label %269

; <label>:269                                     ; preds = %269, %middle.block1605
  %indvars.iv611 = phi i64 [ 0, %middle.block1605 ], [ %indvars.iv.next612, %269 ]
  %270 = load volatile i32* %seed, align 4
  %271 = trunc i64 %indvars.iv611 to i32
  %272 = mul nsw i32 %270, %271
  %273 = trunc i32 %272 to i8
  %274 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv611
  store i8 %273, i8* %274, align 1, !tbaa !1
  %indvars.iv.next612 = add nuw nsw i64 %indvars.iv611, 1
  %exitcond613 = icmp eq i64 %indvars.iv.next612, 10240
  br i1 %exitcond613, label %vector.ph1579, label %269

vector.ph1579:                                    ; preds = %269
  %275 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 513
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %275, i64 512, i32 1, i1 false)
  br label %vector.body1580

vector.body1580:                                  ; preds = %vector.body1580, %vector.ph1579
  %index1583 = phi i64 [ 0, %vector.ph1579 ], [ %index.next1587, %vector.body1580 ]
  %vec.phi1592 = phi <4 x i32> [ zeroinitializer, %vector.ph1579 ], [ %282, %vector.body1580 ]
  %vec.phi1593 = phi <4 x i32> [ zeroinitializer, %vector.ph1579 ], [ %283, %vector.body1580 ]
  %276 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1583
  %277 = bitcast i8* %276 to <4 x i8>*
  %wide.load1594 = load <4 x i8>* %277, align 8
  %.sum1878 = or i64 %index1583, 4
  %278 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1878
  %279 = bitcast i8* %278 to <4 x i8>*
  %wide.load1595 = load <4 x i8>* %279, align 4
  %280 = zext <4 x i8> %wide.load1594 to <4 x i32>
  %281 = zext <4 x i8> %wide.load1595 to <4 x i32>
  %282 = add nsw <4 x i32> %280, %vec.phi1592
  %283 = add nsw <4 x i32> %281, %vec.phi1593
  %index.next1587 = add i64 %index1583, 8
  %284 = icmp eq i64 %index.next1587, 10240
  br i1 %284, label %middle.block1581, label %vector.body1580, !llvm.loop !17

middle.block1581:                                 ; preds = %vector.body1580
  %bin.rdx1598 = add <4 x i32> %283, %282
  %rdx.shuf1599 = shufflevector <4 x i32> %bin.rdx1598, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1600 = add <4 x i32> %bin.rdx1598, %rdx.shuf1599
  %rdx.shuf1601 = shufflevector <4 x i32> %bin.rdx1600, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1602 = add <4 x i32> %bin.rdx1600, %rdx.shuf1601
  %285 = extractelement <4 x i32> %bin.rdx1602, i32 0
  %286 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %285)
  br label %287

; <label>:287                                     ; preds = %287, %middle.block1581
  %indvars.iv604 = phi i64 [ 0, %middle.block1581 ], [ %indvars.iv.next605, %287 ]
  %288 = load volatile i32* %seed, align 4
  %289 = trunc i64 %indvars.iv604 to i32
  %290 = mul nsw i32 %288, %289
  %291 = trunc i32 %290 to i8
  %292 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv604
  store i8 %291, i8* %292, align 1, !tbaa !1
  %indvars.iv.next605 = add nuw nsw i64 %indvars.iv604, 1
  %exitcond606 = icmp eq i64 %indvars.iv.next605, 10240
  br i1 %exitcond606, label %vector.ph1555, label %287

vector.ph1555:                                    ; preds = %287
  %293 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 1025
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %293, i64 1024, i32 1, i1 false)
  br label %vector.body1556

vector.body1556:                                  ; preds = %vector.body1556, %vector.ph1555
  %index1559 = phi i64 [ 0, %vector.ph1555 ], [ %index.next1563, %vector.body1556 ]
  %vec.phi1568 = phi <4 x i32> [ zeroinitializer, %vector.ph1555 ], [ %300, %vector.body1556 ]
  %vec.phi1569 = phi <4 x i32> [ zeroinitializer, %vector.ph1555 ], [ %301, %vector.body1556 ]
  %294 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1559
  %295 = bitcast i8* %294 to <4 x i8>*
  %wide.load1570 = load <4 x i8>* %295, align 8
  %.sum1879 = or i64 %index1559, 4
  %296 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1879
  %297 = bitcast i8* %296 to <4 x i8>*
  %wide.load1571 = load <4 x i8>* %297, align 4
  %298 = zext <4 x i8> %wide.load1570 to <4 x i32>
  %299 = zext <4 x i8> %wide.load1571 to <4 x i32>
  %300 = add nsw <4 x i32> %298, %vec.phi1568
  %301 = add nsw <4 x i32> %299, %vec.phi1569
  %index.next1563 = add i64 %index1559, 8
  %302 = icmp eq i64 %index.next1563, 10240
  br i1 %302, label %middle.block1557, label %vector.body1556, !llvm.loop !18

middle.block1557:                                 ; preds = %vector.body1556
  %bin.rdx1574 = add <4 x i32> %301, %300
  %rdx.shuf1575 = shufflevector <4 x i32> %bin.rdx1574, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1576 = add <4 x i32> %bin.rdx1574, %rdx.shuf1575
  %rdx.shuf1577 = shufflevector <4 x i32> %bin.rdx1576, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1578 = add <4 x i32> %bin.rdx1576, %rdx.shuf1577
  %303 = extractelement <4 x i32> %bin.rdx1578, i32 0
  %304 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %303)
  br label %.preheader283

.preheader283:                                    ; preds = %middle.block1533, %middle.block1557
  %indvars.iv598 = phi i64 [ 10, %middle.block1557 ], [ %indvars.iv.next599, %middle.block1533 ]
  br label %305

; <label>:305                                     ; preds = %305, %.preheader283
  %indvars.iv591 = phi i64 [ 0, %.preheader283 ], [ %indvars.iv.next592, %305 ]
  %306 = load volatile i32* %seed, align 4
  %307 = trunc i64 %indvars.iv591 to i32
  %308 = mul nsw i32 %306, %307
  %309 = trunc i32 %308 to i8
  %310 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv591
  store i8 %309, i8* %310, align 1, !tbaa !1
  %indvars.iv.next592 = add nuw nsw i64 %indvars.iv591, 1
  %exitcond593 = icmp eq i64 %indvars.iv.next592, 10240
  br i1 %exitcond593, label %vector.ph1531, label %305

vector.ph1531:                                    ; preds = %305
  %.sum171 = or i64 %indvars.iv598, 1
  %311 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %.sum171
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %311, i64 %indvars.iv598, i32 1, i1 false)
  br label %vector.body1532

vector.body1532:                                  ; preds = %vector.body1532, %vector.ph1531
  %index1535 = phi i64 [ 0, %vector.ph1531 ], [ %index.next1539, %vector.body1532 ]
  %vec.phi1544 = phi <4 x i32> [ zeroinitializer, %vector.ph1531 ], [ %318, %vector.body1532 ]
  %vec.phi1545 = phi <4 x i32> [ zeroinitializer, %vector.ph1531 ], [ %319, %vector.body1532 ]
  %312 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1535
  %313 = bitcast i8* %312 to <4 x i8>*
  %wide.load1546 = load <4 x i8>* %313, align 8
  %.sum1880 = or i64 %index1535, 4
  %314 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum1880
  %315 = bitcast i8* %314 to <4 x i8>*
  %wide.load1547 = load <4 x i8>* %315, align 4
  %316 = zext <4 x i8> %wide.load1546 to <4 x i32>
  %317 = zext <4 x i8> %wide.load1547 to <4 x i32>
  %318 = add nsw <4 x i32> %316, %vec.phi1544
  %319 = add nsw <4 x i32> %317, %vec.phi1545
  %index.next1539 = add i64 %index1535, 8
  %320 = icmp eq i64 %index.next1539, 10240
  br i1 %320, label %middle.block1533, label %vector.body1532, !llvm.loop !19

middle.block1533:                                 ; preds = %vector.body1532
  %bin.rdx1550 = add <4 x i32> %319, %318
  %rdx.shuf1551 = shufflevector <4 x i32> %bin.rdx1550, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1552 = add <4 x i32> %bin.rdx1550, %rdx.shuf1551
  %rdx.shuf1553 = shufflevector <4 x i32> %bin.rdx1552, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1554 = add <4 x i32> %bin.rdx1552, %rdx.shuf1553
  %321 = extractelement <4 x i32> %bin.rdx1554, i32 0
  %322 = trunc i64 %indvars.iv598 to i32
  %323 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %322, i32 %321)
  %indvars.iv.next599 = add nuw nsw i64 %indvars.iv598, 10
  %324 = trunc i64 %indvars.iv.next599 to i32
  %325 = icmp slt i32 %324, 100
  br i1 %325, label %.preheader283, label %326

; <label>:326                                     ; preds = %middle.block1533
  call void @llvm.lifetime.end(i64 10240, i8* %1) #2
  %puts167 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str4, i64 0, i64 0))
  %327 = bitcast [10240 x i16]* %buffer53 to i8*
  call void @llvm.lifetime.start(i64 20480, i8* %327) #2
  store volatile i32 123, i32* %seed54, align 4
  br label %328

; <label>:328                                     ; preds = %328, %326
  %indvars.iv588 = phi i64 [ 0, %326 ], [ %indvars.iv.next589, %328 ]
  %329 = load volatile i32* %seed54, align 4
  %330 = trunc i64 %indvars.iv588 to i32
  %331 = mul nsw i32 %329, %330
  %332 = trunc i32 %331 to i16
  %333 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv588
  store i16 %332, i16* %333, align 2, !tbaa !20
  %indvars.iv.next589 = add nuw nsw i64 %indvars.iv588, 1
  %exitcond590 = icmp eq i64 %indvars.iv.next589, 10240
  br i1 %exitcond590, label %334, label %328

; <label>:334                                     ; preds = %328
  %335 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 2
  %336 = load i16* %335, align 4
  %337 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 0
  store i16 %336, i16* %337, align 16
  br label %338

; <label>:338                                     ; preds = %._crit_edge728, %334
  %339 = phi i16 [ %336, %334 ], [ %.pre730, %._crit_edge728 ]
  %indvars.iv585 = phi i64 [ 1, %334 ], [ %phitmp746, %._crit_edge728 ]
  %v56.0280 = phi i32 [ 0, %334 ], [ %341, %._crit_edge728 ]
  %340 = zext i16 %339 to i32
  %341 = add nsw i32 %340, %v56.0280
  %exitcond587 = icmp eq i64 %indvars.iv585, 10240
  br i1 %exitcond587, label %342, label %._crit_edge728

._crit_edge728:                                   ; preds = %338
  %.phi.trans.insert729 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv585
  %.pre730 = load i16* %.phi.trans.insert729, align 2, !tbaa !20
  %phitmp746 = add i64 %indvars.iv585, 1
  br label %338

; <label>:342                                     ; preds = %338
  %343 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %341)
  br label %344

; <label>:344                                     ; preds = %344, %342
  %indvars.iv581 = phi i64 [ 0, %342 ], [ %indvars.iv.next582, %344 ]
  %345 = load volatile i32* %seed54, align 4
  %346 = trunc i64 %indvars.iv581 to i32
  %347 = mul nsw i32 %345, %346
  %348 = trunc i32 %347 to i16
  %349 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv581
  store i16 %348, i16* %349, align 2, !tbaa !20
  %indvars.iv.next582 = add nuw nsw i64 %indvars.iv581, 1
  %exitcond583 = icmp eq i64 %indvars.iv.next582, 10240
  br i1 %exitcond583, label %350, label %344

; <label>:350                                     ; preds = %344
  %351 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 3
  %352 = bitcast i16* %351 to i32*
  %353 = bitcast [10240 x i16]* %buffer53 to i32*
  %354 = load i32* %352, align 2
  store i32 %354, i32* %353, align 16
  %355 = trunc i32 %354 to i16
  br label %356

; <label>:356                                     ; preds = %._crit_edge731, %350
  %357 = phi i16 [ %355, %350 ], [ %.pre733, %._crit_edge731 ]
  %indvars.iv578 = phi i64 [ 1, %350 ], [ %phitmp747, %._crit_edge731 ]
  %v59.0277 = phi i32 [ 0, %350 ], [ %359, %._crit_edge731 ]
  %358 = zext i16 %357 to i32
  %359 = add nsw i32 %358, %v59.0277
  %exitcond580 = icmp eq i64 %indvars.iv578, 10240
  br i1 %exitcond580, label %360, label %._crit_edge731

._crit_edge731:                                   ; preds = %356
  %.phi.trans.insert732 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv578
  %.pre733 = load i16* %.phi.trans.insert732, align 2, !tbaa !20
  %phitmp747 = add i64 %indvars.iv578, 1
  br label %356

; <label>:360                                     ; preds = %356
  %361 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %359)
  br label %362

; <label>:362                                     ; preds = %362, %360
  %indvars.iv574 = phi i64 [ 0, %360 ], [ %indvars.iv.next575, %362 ]
  %363 = load volatile i32* %seed54, align 4
  %364 = trunc i64 %indvars.iv574 to i32
  %365 = mul nsw i32 %363, %364
  %366 = trunc i32 %365 to i16
  %367 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv574
  store i16 %366, i16* %367, align 2, !tbaa !20
  %indvars.iv.next575 = add nuw nsw i64 %indvars.iv574, 1
  %exitcond576 = icmp eq i64 %indvars.iv.next575, 10240
  br i1 %exitcond576, label %vector.ph1507, label %362

vector.ph1507:                                    ; preds = %362
  %368 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 4
  %369 = bitcast i16* %368 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %369, i64 6, i32 8, i1 false)
  br label %vector.body1508

vector.body1508:                                  ; preds = %vector.body1508, %vector.ph1507
  %index1511 = phi i64 [ 0, %vector.ph1507 ], [ %index.next1515, %vector.body1508 ]
  %vec.phi1520 = phi <4 x i32> [ zeroinitializer, %vector.ph1507 ], [ %376, %vector.body1508 ]
  %vec.phi1521 = phi <4 x i32> [ zeroinitializer, %vector.ph1507 ], [ %377, %vector.body1508 ]
  %370 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1511
  %371 = bitcast i16* %370 to <4 x i16>*
  %wide.load1522 = load <4 x i16>* %371, align 16
  %.sum1881 = or i64 %index1511, 4
  %372 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1881
  %373 = bitcast i16* %372 to <4 x i16>*
  %wide.load1523 = load <4 x i16>* %373, align 8
  %374 = zext <4 x i16> %wide.load1522 to <4 x i32>
  %375 = zext <4 x i16> %wide.load1523 to <4 x i32>
  %376 = add nsw <4 x i32> %374, %vec.phi1520
  %377 = add nsw <4 x i32> %375, %vec.phi1521
  %index.next1515 = add i64 %index1511, 8
  %378 = icmp eq i64 %index.next1515, 10240
  br i1 %378, label %middle.block1509, label %vector.body1508, !llvm.loop !22

middle.block1509:                                 ; preds = %vector.body1508
  %bin.rdx1526 = add <4 x i32> %377, %376
  %rdx.shuf1527 = shufflevector <4 x i32> %bin.rdx1526, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1528 = add <4 x i32> %bin.rdx1526, %rdx.shuf1527
  %rdx.shuf1529 = shufflevector <4 x i32> %bin.rdx1528, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1530 = add <4 x i32> %bin.rdx1528, %rdx.shuf1529
  %379 = extractelement <4 x i32> %bin.rdx1530, i32 0
  %380 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %379)
  br label %381

; <label>:381                                     ; preds = %381, %middle.block1509
  %indvars.iv567 = phi i64 [ 0, %middle.block1509 ], [ %indvars.iv.next568, %381 ]
  %382 = load volatile i32* %seed54, align 4
  %383 = trunc i64 %indvars.iv567 to i32
  %384 = mul nsw i32 %382, %383
  %385 = trunc i32 %384 to i16
  %386 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv567
  store i16 %385, i16* %386, align 2, !tbaa !20
  %indvars.iv.next568 = add nuw nsw i64 %indvars.iv567, 1
  %exitcond569 = icmp eq i64 %indvars.iv.next568, 10240
  br i1 %exitcond569, label %387, label %381

; <label>:387                                     ; preds = %381
  %388 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 5
  %389 = bitcast i16* %388 to i64*
  %390 = bitcast [10240 x i16]* %buffer53 to i64*
  %391 = load i64* %389, align 2
  store i64 %391, i64* %390, align 16
  %392 = trunc i64 %391 to i16
  br label %393

; <label>:393                                     ; preds = %._crit_edge734, %387
  %394 = phi i16 [ %392, %387 ], [ %.pre736, %._crit_edge734 ]
  %indvars.iv564 = phi i64 [ 1, %387 ], [ %phitmp748, %._crit_edge734 ]
  %v65.0271 = phi i32 [ 0, %387 ], [ %396, %._crit_edge734 ]
  %395 = zext i16 %394 to i32
  %396 = add nsw i32 %395, %v65.0271
  %exitcond566 = icmp eq i64 %indvars.iv564, 10240
  br i1 %exitcond566, label %397, label %._crit_edge734

._crit_edge734:                                   ; preds = %393
  %.phi.trans.insert735 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv564
  %.pre736 = load i16* %.phi.trans.insert735, align 2, !tbaa !20
  %phitmp748 = add i64 %indvars.iv564, 1
  br label %393

; <label>:397                                     ; preds = %393
  %398 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %396)
  br label %399

; <label>:399                                     ; preds = %399, %397
  %indvars.iv560 = phi i64 [ 0, %397 ], [ %indvars.iv.next561, %399 ]
  %400 = load volatile i32* %seed54, align 4
  %401 = trunc i64 %indvars.iv560 to i32
  %402 = mul nsw i32 %400, %401
  %403 = trunc i32 %402 to i16
  %404 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv560
  store i16 %403, i16* %404, align 2, !tbaa !20
  %indvars.iv.next561 = add nuw nsw i64 %indvars.iv560, 1
  %exitcond562 = icmp eq i64 %indvars.iv.next561, 10240
  br i1 %exitcond562, label %vector.ph1483, label %399

vector.ph1483:                                    ; preds = %399
  %405 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 6
  %406 = bitcast i16* %405 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %406, i64 10, i32 4, i1 false)
  br label %vector.body1484

vector.body1484:                                  ; preds = %vector.body1484, %vector.ph1483
  %index1487 = phi i64 [ 0, %vector.ph1483 ], [ %index.next1491, %vector.body1484 ]
  %vec.phi1496 = phi <4 x i32> [ zeroinitializer, %vector.ph1483 ], [ %413, %vector.body1484 ]
  %vec.phi1497 = phi <4 x i32> [ zeroinitializer, %vector.ph1483 ], [ %414, %vector.body1484 ]
  %407 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1487
  %408 = bitcast i16* %407 to <4 x i16>*
  %wide.load1498 = load <4 x i16>* %408, align 16
  %.sum1882 = or i64 %index1487, 4
  %409 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1882
  %410 = bitcast i16* %409 to <4 x i16>*
  %wide.load1499 = load <4 x i16>* %410, align 8
  %411 = zext <4 x i16> %wide.load1498 to <4 x i32>
  %412 = zext <4 x i16> %wide.load1499 to <4 x i32>
  %413 = add nsw <4 x i32> %411, %vec.phi1496
  %414 = add nsw <4 x i32> %412, %vec.phi1497
  %index.next1491 = add i64 %index1487, 8
  %415 = icmp eq i64 %index.next1491, 10240
  br i1 %415, label %middle.block1485, label %vector.body1484, !llvm.loop !23

middle.block1485:                                 ; preds = %vector.body1484
  %bin.rdx1502 = add <4 x i32> %414, %413
  %rdx.shuf1503 = shufflevector <4 x i32> %bin.rdx1502, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1504 = add <4 x i32> %bin.rdx1502, %rdx.shuf1503
  %rdx.shuf1505 = shufflevector <4 x i32> %bin.rdx1504, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1506 = add <4 x i32> %bin.rdx1504, %rdx.shuf1505
  %416 = extractelement <4 x i32> %bin.rdx1506, i32 0
  %417 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %416)
  br label %418

; <label>:418                                     ; preds = %418, %middle.block1485
  %indvars.iv553 = phi i64 [ 0, %middle.block1485 ], [ %indvars.iv.next554, %418 ]
  %419 = load volatile i32* %seed54, align 4
  %420 = trunc i64 %indvars.iv553 to i32
  %421 = mul nsw i32 %419, %420
  %422 = trunc i32 %421 to i16
  %423 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv553
  store i16 %422, i16* %423, align 2, !tbaa !20
  %indvars.iv.next554 = add nuw nsw i64 %indvars.iv553, 1
  %exitcond555 = icmp eq i64 %indvars.iv.next554, 10240
  br i1 %exitcond555, label %vector.ph1459, label %418

vector.ph1459:                                    ; preds = %418
  %424 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 7
  %425 = bitcast i16* %424 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %425, i64 12, i32 2, i1 false)
  br label %vector.body1460

vector.body1460:                                  ; preds = %vector.body1460, %vector.ph1459
  %index1463 = phi i64 [ 0, %vector.ph1459 ], [ %index.next1467, %vector.body1460 ]
  %vec.phi1472 = phi <4 x i32> [ zeroinitializer, %vector.ph1459 ], [ %432, %vector.body1460 ]
  %vec.phi1473 = phi <4 x i32> [ zeroinitializer, %vector.ph1459 ], [ %433, %vector.body1460 ]
  %426 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1463
  %427 = bitcast i16* %426 to <4 x i16>*
  %wide.load1474 = load <4 x i16>* %427, align 16
  %.sum1883 = or i64 %index1463, 4
  %428 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1883
  %429 = bitcast i16* %428 to <4 x i16>*
  %wide.load1475 = load <4 x i16>* %429, align 8
  %430 = zext <4 x i16> %wide.load1474 to <4 x i32>
  %431 = zext <4 x i16> %wide.load1475 to <4 x i32>
  %432 = add nsw <4 x i32> %430, %vec.phi1472
  %433 = add nsw <4 x i32> %431, %vec.phi1473
  %index.next1467 = add i64 %index1463, 8
  %434 = icmp eq i64 %index.next1467, 10240
  br i1 %434, label %middle.block1461, label %vector.body1460, !llvm.loop !24

middle.block1461:                                 ; preds = %vector.body1460
  %bin.rdx1478 = add <4 x i32> %433, %432
  %rdx.shuf1479 = shufflevector <4 x i32> %bin.rdx1478, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1480 = add <4 x i32> %bin.rdx1478, %rdx.shuf1479
  %rdx.shuf1481 = shufflevector <4 x i32> %bin.rdx1480, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1482 = add <4 x i32> %bin.rdx1480, %rdx.shuf1481
  %435 = extractelement <4 x i32> %bin.rdx1482, i32 0
  %436 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %435)
  br label %437

; <label>:437                                     ; preds = %437, %middle.block1461
  %indvars.iv546 = phi i64 [ 0, %middle.block1461 ], [ %indvars.iv.next547, %437 ]
  %438 = load volatile i32* %seed54, align 4
  %439 = trunc i64 %indvars.iv546 to i32
  %440 = mul nsw i32 %438, %439
  %441 = trunc i32 %440 to i16
  %442 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv546
  store i16 %441, i16* %442, align 2, !tbaa !20
  %indvars.iv.next547 = add nuw nsw i64 %indvars.iv546, 1
  %exitcond548 = icmp eq i64 %indvars.iv.next547, 10240
  br i1 %exitcond548, label %vector.ph1435, label %437

vector.ph1435:                                    ; preds = %437
  %443 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 8
  %444 = bitcast i16* %443 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %444, i64 14, i32 16, i1 false)
  br label %vector.body1436

vector.body1436:                                  ; preds = %vector.body1436, %vector.ph1435
  %index1439 = phi i64 [ 0, %vector.ph1435 ], [ %index.next1443, %vector.body1436 ]
  %vec.phi1448 = phi <4 x i32> [ zeroinitializer, %vector.ph1435 ], [ %451, %vector.body1436 ]
  %vec.phi1449 = phi <4 x i32> [ zeroinitializer, %vector.ph1435 ], [ %452, %vector.body1436 ]
  %445 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1439
  %446 = bitcast i16* %445 to <4 x i16>*
  %wide.load1450 = load <4 x i16>* %446, align 16
  %.sum1884 = or i64 %index1439, 4
  %447 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1884
  %448 = bitcast i16* %447 to <4 x i16>*
  %wide.load1451 = load <4 x i16>* %448, align 8
  %449 = zext <4 x i16> %wide.load1450 to <4 x i32>
  %450 = zext <4 x i16> %wide.load1451 to <4 x i32>
  %451 = add nsw <4 x i32> %449, %vec.phi1448
  %452 = add nsw <4 x i32> %450, %vec.phi1449
  %index.next1443 = add i64 %index1439, 8
  %453 = icmp eq i64 %index.next1443, 10240
  br i1 %453, label %middle.block1437, label %vector.body1436, !llvm.loop !25

middle.block1437:                                 ; preds = %vector.body1436
  %bin.rdx1454 = add <4 x i32> %452, %451
  %rdx.shuf1455 = shufflevector <4 x i32> %bin.rdx1454, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1456 = add <4 x i32> %bin.rdx1454, %rdx.shuf1455
  %rdx.shuf1457 = shufflevector <4 x i32> %bin.rdx1456, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1458 = add <4 x i32> %bin.rdx1456, %rdx.shuf1457
  %454 = extractelement <4 x i32> %bin.rdx1458, i32 0
  %455 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %454)
  br label %456

; <label>:456                                     ; preds = %456, %middle.block1437
  %indvars.iv539 = phi i64 [ 0, %middle.block1437 ], [ %indvars.iv.next540, %456 ]
  %457 = load volatile i32* %seed54, align 4
  %458 = trunc i64 %indvars.iv539 to i32
  %459 = mul nsw i32 %457, %458
  %460 = trunc i32 %459 to i16
  %461 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv539
  store i16 %460, i16* %461, align 2, !tbaa !20
  %indvars.iv.next540 = add nuw nsw i64 %indvars.iv539, 1
  %exitcond541 = icmp eq i64 %indvars.iv.next540, 10240
  br i1 %exitcond541, label %vector.ph1411, label %456

vector.ph1411:                                    ; preds = %456
  %462 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 9
  %463 = bitcast i16* %462 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %463, i64 16, i32 2, i1 false)
  br label %vector.body1412

vector.body1412:                                  ; preds = %vector.body1412, %vector.ph1411
  %index1415 = phi i64 [ 0, %vector.ph1411 ], [ %index.next1419, %vector.body1412 ]
  %vec.phi1424 = phi <4 x i32> [ zeroinitializer, %vector.ph1411 ], [ %470, %vector.body1412 ]
  %vec.phi1425 = phi <4 x i32> [ zeroinitializer, %vector.ph1411 ], [ %471, %vector.body1412 ]
  %464 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1415
  %465 = bitcast i16* %464 to <4 x i16>*
  %wide.load1426 = load <4 x i16>* %465, align 16
  %.sum1885 = or i64 %index1415, 4
  %466 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1885
  %467 = bitcast i16* %466 to <4 x i16>*
  %wide.load1427 = load <4 x i16>* %467, align 8
  %468 = zext <4 x i16> %wide.load1426 to <4 x i32>
  %469 = zext <4 x i16> %wide.load1427 to <4 x i32>
  %470 = add nsw <4 x i32> %468, %vec.phi1424
  %471 = add nsw <4 x i32> %469, %vec.phi1425
  %index.next1419 = add i64 %index1415, 8
  %472 = icmp eq i64 %index.next1419, 10240
  br i1 %472, label %middle.block1413, label %vector.body1412, !llvm.loop !26

middle.block1413:                                 ; preds = %vector.body1412
  %bin.rdx1430 = add <4 x i32> %471, %470
  %rdx.shuf1431 = shufflevector <4 x i32> %bin.rdx1430, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1432 = add <4 x i32> %bin.rdx1430, %rdx.shuf1431
  %rdx.shuf1433 = shufflevector <4 x i32> %bin.rdx1432, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1434 = add <4 x i32> %bin.rdx1432, %rdx.shuf1433
  %473 = extractelement <4 x i32> %bin.rdx1434, i32 0
  %474 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %473)
  br label %475

; <label>:475                                     ; preds = %475, %middle.block1413
  %indvars.iv532 = phi i64 [ 0, %middle.block1413 ], [ %indvars.iv.next533, %475 ]
  %476 = load volatile i32* %seed54, align 4
  %477 = trunc i64 %indvars.iv532 to i32
  %478 = mul nsw i32 %476, %477
  %479 = trunc i32 %478 to i16
  %480 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv532
  store i16 %479, i16* %480, align 2, !tbaa !20
  %indvars.iv.next533 = add nuw nsw i64 %indvars.iv532, 1
  %exitcond534 = icmp eq i64 %indvars.iv.next533, 10240
  br i1 %exitcond534, label %vector.ph1387, label %475

vector.ph1387:                                    ; preds = %475
  %481 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 10
  %482 = bitcast i16* %481 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %482, i64 18, i32 4, i1 false)
  br label %vector.body1388

vector.body1388:                                  ; preds = %vector.body1388, %vector.ph1387
  %index1391 = phi i64 [ 0, %vector.ph1387 ], [ %index.next1395, %vector.body1388 ]
  %vec.phi1400 = phi <4 x i32> [ zeroinitializer, %vector.ph1387 ], [ %489, %vector.body1388 ]
  %vec.phi1401 = phi <4 x i32> [ zeroinitializer, %vector.ph1387 ], [ %490, %vector.body1388 ]
  %483 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1391
  %484 = bitcast i16* %483 to <4 x i16>*
  %wide.load1402 = load <4 x i16>* %484, align 16
  %.sum1886 = or i64 %index1391, 4
  %485 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1886
  %486 = bitcast i16* %485 to <4 x i16>*
  %wide.load1403 = load <4 x i16>* %486, align 8
  %487 = zext <4 x i16> %wide.load1402 to <4 x i32>
  %488 = zext <4 x i16> %wide.load1403 to <4 x i32>
  %489 = add nsw <4 x i32> %487, %vec.phi1400
  %490 = add nsw <4 x i32> %488, %vec.phi1401
  %index.next1395 = add i64 %index1391, 8
  %491 = icmp eq i64 %index.next1395, 10240
  br i1 %491, label %middle.block1389, label %vector.body1388, !llvm.loop !27

middle.block1389:                                 ; preds = %vector.body1388
  %bin.rdx1406 = add <4 x i32> %490, %489
  %rdx.shuf1407 = shufflevector <4 x i32> %bin.rdx1406, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1408 = add <4 x i32> %bin.rdx1406, %rdx.shuf1407
  %rdx.shuf1409 = shufflevector <4 x i32> %bin.rdx1408, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1410 = add <4 x i32> %bin.rdx1408, %rdx.shuf1409
  %492 = extractelement <4 x i32> %bin.rdx1410, i32 0
  %493 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %492)
  br label %494

; <label>:494                                     ; preds = %494, %middle.block1389
  %indvars.iv525 = phi i64 [ 0, %middle.block1389 ], [ %indvars.iv.next526, %494 ]
  %495 = load volatile i32* %seed54, align 4
  %496 = trunc i64 %indvars.iv525 to i32
  %497 = mul nsw i32 %495, %496
  %498 = trunc i32 %497 to i16
  %499 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv525
  store i16 %498, i16* %499, align 2, !tbaa !20
  %indvars.iv.next526 = add nuw nsw i64 %indvars.iv525, 1
  %exitcond527 = icmp eq i64 %indvars.iv.next526, 10240
  br i1 %exitcond527, label %vector.ph1363, label %494

vector.ph1363:                                    ; preds = %494
  %500 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 11
  %501 = bitcast i16* %500 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %501, i64 20, i32 2, i1 false)
  br label %vector.body1364

vector.body1364:                                  ; preds = %vector.body1364, %vector.ph1363
  %index1367 = phi i64 [ 0, %vector.ph1363 ], [ %index.next1371, %vector.body1364 ]
  %vec.phi1376 = phi <4 x i32> [ zeroinitializer, %vector.ph1363 ], [ %508, %vector.body1364 ]
  %vec.phi1377 = phi <4 x i32> [ zeroinitializer, %vector.ph1363 ], [ %509, %vector.body1364 ]
  %502 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1367
  %503 = bitcast i16* %502 to <4 x i16>*
  %wide.load1378 = load <4 x i16>* %503, align 16
  %.sum1887 = or i64 %index1367, 4
  %504 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1887
  %505 = bitcast i16* %504 to <4 x i16>*
  %wide.load1379 = load <4 x i16>* %505, align 8
  %506 = zext <4 x i16> %wide.load1378 to <4 x i32>
  %507 = zext <4 x i16> %wide.load1379 to <4 x i32>
  %508 = add nsw <4 x i32> %506, %vec.phi1376
  %509 = add nsw <4 x i32> %507, %vec.phi1377
  %index.next1371 = add i64 %index1367, 8
  %510 = icmp eq i64 %index.next1371, 10240
  br i1 %510, label %middle.block1365, label %vector.body1364, !llvm.loop !28

middle.block1365:                                 ; preds = %vector.body1364
  %bin.rdx1382 = add <4 x i32> %509, %508
  %rdx.shuf1383 = shufflevector <4 x i32> %bin.rdx1382, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1384 = add <4 x i32> %bin.rdx1382, %rdx.shuf1383
  %rdx.shuf1385 = shufflevector <4 x i32> %bin.rdx1384, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1386 = add <4 x i32> %bin.rdx1384, %rdx.shuf1385
  %511 = extractelement <4 x i32> %bin.rdx1386, i32 0
  %512 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %511)
  br label %513

; <label>:513                                     ; preds = %513, %middle.block1365
  %indvars.iv518 = phi i64 [ 0, %middle.block1365 ], [ %indvars.iv.next519, %513 ]
  %514 = load volatile i32* %seed54, align 4
  %515 = trunc i64 %indvars.iv518 to i32
  %516 = mul nsw i32 %514, %515
  %517 = trunc i32 %516 to i16
  %518 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv518
  store i16 %517, i16* %518, align 2, !tbaa !20
  %indvars.iv.next519 = add nuw nsw i64 %indvars.iv518, 1
  %exitcond520 = icmp eq i64 %indvars.iv.next519, 10240
  br i1 %exitcond520, label %vector.ph1339, label %513

vector.ph1339:                                    ; preds = %513
  %519 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 17
  %520 = bitcast i16* %519 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %520, i64 32, i32 2, i1 false)
  br label %vector.body1340

vector.body1340:                                  ; preds = %vector.body1340, %vector.ph1339
  %index1343 = phi i64 [ 0, %vector.ph1339 ], [ %index.next1347, %vector.body1340 ]
  %vec.phi1352 = phi <4 x i32> [ zeroinitializer, %vector.ph1339 ], [ %527, %vector.body1340 ]
  %vec.phi1353 = phi <4 x i32> [ zeroinitializer, %vector.ph1339 ], [ %528, %vector.body1340 ]
  %521 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1343
  %522 = bitcast i16* %521 to <4 x i16>*
  %wide.load1354 = load <4 x i16>* %522, align 16
  %.sum1888 = or i64 %index1343, 4
  %523 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1888
  %524 = bitcast i16* %523 to <4 x i16>*
  %wide.load1355 = load <4 x i16>* %524, align 8
  %525 = zext <4 x i16> %wide.load1354 to <4 x i32>
  %526 = zext <4 x i16> %wide.load1355 to <4 x i32>
  %527 = add nsw <4 x i32> %525, %vec.phi1352
  %528 = add nsw <4 x i32> %526, %vec.phi1353
  %index.next1347 = add i64 %index1343, 8
  %529 = icmp eq i64 %index.next1347, 10240
  br i1 %529, label %middle.block1341, label %vector.body1340, !llvm.loop !29

middle.block1341:                                 ; preds = %vector.body1340
  %bin.rdx1358 = add <4 x i32> %528, %527
  %rdx.shuf1359 = shufflevector <4 x i32> %bin.rdx1358, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1360 = add <4 x i32> %bin.rdx1358, %rdx.shuf1359
  %rdx.shuf1361 = shufflevector <4 x i32> %bin.rdx1360, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1362 = add <4 x i32> %bin.rdx1360, %rdx.shuf1361
  %530 = extractelement <4 x i32> %bin.rdx1362, i32 0
  %531 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %530)
  br label %532

; <label>:532                                     ; preds = %532, %middle.block1341
  %indvars.iv511 = phi i64 [ 0, %middle.block1341 ], [ %indvars.iv.next512, %532 ]
  %533 = load volatile i32* %seed54, align 4
  %534 = trunc i64 %indvars.iv511 to i32
  %535 = mul nsw i32 %533, %534
  %536 = trunc i32 %535 to i16
  %537 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv511
  store i16 %536, i16* %537, align 2, !tbaa !20
  %indvars.iv.next512 = add nuw nsw i64 %indvars.iv511, 1
  %exitcond513 = icmp eq i64 %indvars.iv.next512, 10240
  br i1 %exitcond513, label %vector.ph1315, label %532

vector.ph1315:                                    ; preds = %532
  %538 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 33
  %539 = bitcast i16* %538 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %539, i64 64, i32 2, i1 false)
  br label %vector.body1316

vector.body1316:                                  ; preds = %vector.body1316, %vector.ph1315
  %index1319 = phi i64 [ 0, %vector.ph1315 ], [ %index.next1323, %vector.body1316 ]
  %vec.phi1328 = phi <4 x i32> [ zeroinitializer, %vector.ph1315 ], [ %546, %vector.body1316 ]
  %vec.phi1329 = phi <4 x i32> [ zeroinitializer, %vector.ph1315 ], [ %547, %vector.body1316 ]
  %540 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1319
  %541 = bitcast i16* %540 to <4 x i16>*
  %wide.load1330 = load <4 x i16>* %541, align 16
  %.sum1889 = or i64 %index1319, 4
  %542 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1889
  %543 = bitcast i16* %542 to <4 x i16>*
  %wide.load1331 = load <4 x i16>* %543, align 8
  %544 = zext <4 x i16> %wide.load1330 to <4 x i32>
  %545 = zext <4 x i16> %wide.load1331 to <4 x i32>
  %546 = add nsw <4 x i32> %544, %vec.phi1328
  %547 = add nsw <4 x i32> %545, %vec.phi1329
  %index.next1323 = add i64 %index1319, 8
  %548 = icmp eq i64 %index.next1323, 10240
  br i1 %548, label %middle.block1317, label %vector.body1316, !llvm.loop !30

middle.block1317:                                 ; preds = %vector.body1316
  %bin.rdx1334 = add <4 x i32> %547, %546
  %rdx.shuf1335 = shufflevector <4 x i32> %bin.rdx1334, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1336 = add <4 x i32> %bin.rdx1334, %rdx.shuf1335
  %rdx.shuf1337 = shufflevector <4 x i32> %bin.rdx1336, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1338 = add <4 x i32> %bin.rdx1336, %rdx.shuf1337
  %549 = extractelement <4 x i32> %bin.rdx1338, i32 0
  %550 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %549)
  br label %551

; <label>:551                                     ; preds = %551, %middle.block1317
  %indvars.iv504 = phi i64 [ 0, %middle.block1317 ], [ %indvars.iv.next505, %551 ]
  %552 = load volatile i32* %seed54, align 4
  %553 = trunc i64 %indvars.iv504 to i32
  %554 = mul nsw i32 %552, %553
  %555 = trunc i32 %554 to i16
  %556 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv504
  store i16 %555, i16* %556, align 2, !tbaa !20
  %indvars.iv.next505 = add nuw nsw i64 %indvars.iv504, 1
  %exitcond506 = icmp eq i64 %indvars.iv.next505, 10240
  br i1 %exitcond506, label %vector.ph1291, label %551

vector.ph1291:                                    ; preds = %551
  %557 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 65
  %558 = bitcast i16* %557 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %558, i64 128, i32 2, i1 false)
  br label %vector.body1292

vector.body1292:                                  ; preds = %vector.body1292, %vector.ph1291
  %index1295 = phi i64 [ 0, %vector.ph1291 ], [ %index.next1299, %vector.body1292 ]
  %vec.phi1304 = phi <4 x i32> [ zeroinitializer, %vector.ph1291 ], [ %565, %vector.body1292 ]
  %vec.phi1305 = phi <4 x i32> [ zeroinitializer, %vector.ph1291 ], [ %566, %vector.body1292 ]
  %559 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1295
  %560 = bitcast i16* %559 to <4 x i16>*
  %wide.load1306 = load <4 x i16>* %560, align 16
  %.sum1890 = or i64 %index1295, 4
  %561 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1890
  %562 = bitcast i16* %561 to <4 x i16>*
  %wide.load1307 = load <4 x i16>* %562, align 8
  %563 = zext <4 x i16> %wide.load1306 to <4 x i32>
  %564 = zext <4 x i16> %wide.load1307 to <4 x i32>
  %565 = add nsw <4 x i32> %563, %vec.phi1304
  %566 = add nsw <4 x i32> %564, %vec.phi1305
  %index.next1299 = add i64 %index1295, 8
  %567 = icmp eq i64 %index.next1299, 10240
  br i1 %567, label %middle.block1293, label %vector.body1292, !llvm.loop !31

middle.block1293:                                 ; preds = %vector.body1292
  %bin.rdx1310 = add <4 x i32> %566, %565
  %rdx.shuf1311 = shufflevector <4 x i32> %bin.rdx1310, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1312 = add <4 x i32> %bin.rdx1310, %rdx.shuf1311
  %rdx.shuf1313 = shufflevector <4 x i32> %bin.rdx1312, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1314 = add <4 x i32> %bin.rdx1312, %rdx.shuf1313
  %568 = extractelement <4 x i32> %bin.rdx1314, i32 0
  %569 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %568)
  br label %570

; <label>:570                                     ; preds = %570, %middle.block1293
  %indvars.iv497 = phi i64 [ 0, %middle.block1293 ], [ %indvars.iv.next498, %570 ]
  %571 = load volatile i32* %seed54, align 4
  %572 = trunc i64 %indvars.iv497 to i32
  %573 = mul nsw i32 %571, %572
  %574 = trunc i32 %573 to i16
  %575 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv497
  store i16 %574, i16* %575, align 2, !tbaa !20
  %indvars.iv.next498 = add nuw nsw i64 %indvars.iv497, 1
  %exitcond499 = icmp eq i64 %indvars.iv.next498, 10240
  br i1 %exitcond499, label %vector.ph1267, label %570

vector.ph1267:                                    ; preds = %570
  %576 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 129
  %577 = bitcast i16* %576 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %577, i64 256, i32 2, i1 false)
  br label %vector.body1268

vector.body1268:                                  ; preds = %vector.body1268, %vector.ph1267
  %index1271 = phi i64 [ 0, %vector.ph1267 ], [ %index.next1275, %vector.body1268 ]
  %vec.phi1280 = phi <4 x i32> [ zeroinitializer, %vector.ph1267 ], [ %584, %vector.body1268 ]
  %vec.phi1281 = phi <4 x i32> [ zeroinitializer, %vector.ph1267 ], [ %585, %vector.body1268 ]
  %578 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1271
  %579 = bitcast i16* %578 to <4 x i16>*
  %wide.load1282 = load <4 x i16>* %579, align 16
  %.sum1891 = or i64 %index1271, 4
  %580 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1891
  %581 = bitcast i16* %580 to <4 x i16>*
  %wide.load1283 = load <4 x i16>* %581, align 8
  %582 = zext <4 x i16> %wide.load1282 to <4 x i32>
  %583 = zext <4 x i16> %wide.load1283 to <4 x i32>
  %584 = add nsw <4 x i32> %582, %vec.phi1280
  %585 = add nsw <4 x i32> %583, %vec.phi1281
  %index.next1275 = add i64 %index1271, 8
  %586 = icmp eq i64 %index.next1275, 10240
  br i1 %586, label %middle.block1269, label %vector.body1268, !llvm.loop !32

middle.block1269:                                 ; preds = %vector.body1268
  %bin.rdx1286 = add <4 x i32> %585, %584
  %rdx.shuf1287 = shufflevector <4 x i32> %bin.rdx1286, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1288 = add <4 x i32> %bin.rdx1286, %rdx.shuf1287
  %rdx.shuf1289 = shufflevector <4 x i32> %bin.rdx1288, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1290 = add <4 x i32> %bin.rdx1288, %rdx.shuf1289
  %587 = extractelement <4 x i32> %bin.rdx1290, i32 0
  %588 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %587)
  br label %589

; <label>:589                                     ; preds = %589, %middle.block1269
  %indvars.iv490 = phi i64 [ 0, %middle.block1269 ], [ %indvars.iv.next491, %589 ]
  %590 = load volatile i32* %seed54, align 4
  %591 = trunc i64 %indvars.iv490 to i32
  %592 = mul nsw i32 %590, %591
  %593 = trunc i32 %592 to i16
  %594 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv490
  store i16 %593, i16* %594, align 2, !tbaa !20
  %indvars.iv.next491 = add nuw nsw i64 %indvars.iv490, 1
  %exitcond492 = icmp eq i64 %indvars.iv.next491, 10240
  br i1 %exitcond492, label %vector.ph1243, label %589

vector.ph1243:                                    ; preds = %589
  %595 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 257
  %596 = bitcast i16* %595 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %596, i64 512, i32 2, i1 false)
  br label %vector.body1244

vector.body1244:                                  ; preds = %vector.body1244, %vector.ph1243
  %index1247 = phi i64 [ 0, %vector.ph1243 ], [ %index.next1251, %vector.body1244 ]
  %vec.phi1256 = phi <4 x i32> [ zeroinitializer, %vector.ph1243 ], [ %603, %vector.body1244 ]
  %vec.phi1257 = phi <4 x i32> [ zeroinitializer, %vector.ph1243 ], [ %604, %vector.body1244 ]
  %597 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1247
  %598 = bitcast i16* %597 to <4 x i16>*
  %wide.load1258 = load <4 x i16>* %598, align 16
  %.sum1892 = or i64 %index1247, 4
  %599 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1892
  %600 = bitcast i16* %599 to <4 x i16>*
  %wide.load1259 = load <4 x i16>* %600, align 8
  %601 = zext <4 x i16> %wide.load1258 to <4 x i32>
  %602 = zext <4 x i16> %wide.load1259 to <4 x i32>
  %603 = add nsw <4 x i32> %601, %vec.phi1256
  %604 = add nsw <4 x i32> %602, %vec.phi1257
  %index.next1251 = add i64 %index1247, 8
  %605 = icmp eq i64 %index.next1251, 10240
  br i1 %605, label %middle.block1245, label %vector.body1244, !llvm.loop !33

middle.block1245:                                 ; preds = %vector.body1244
  %bin.rdx1262 = add <4 x i32> %604, %603
  %rdx.shuf1263 = shufflevector <4 x i32> %bin.rdx1262, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1264 = add <4 x i32> %bin.rdx1262, %rdx.shuf1263
  %rdx.shuf1265 = shufflevector <4 x i32> %bin.rdx1264, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1266 = add <4 x i32> %bin.rdx1264, %rdx.shuf1265
  %606 = extractelement <4 x i32> %bin.rdx1266, i32 0
  %607 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %606)
  br label %608

; <label>:608                                     ; preds = %608, %middle.block1245
  %indvars.iv483 = phi i64 [ 0, %middle.block1245 ], [ %indvars.iv.next484, %608 ]
  %609 = load volatile i32* %seed54, align 4
  %610 = trunc i64 %indvars.iv483 to i32
  %611 = mul nsw i32 %609, %610
  %612 = trunc i32 %611 to i16
  %613 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv483
  store i16 %612, i16* %613, align 2, !tbaa !20
  %indvars.iv.next484 = add nuw nsw i64 %indvars.iv483, 1
  %exitcond485 = icmp eq i64 %indvars.iv.next484, 10240
  br i1 %exitcond485, label %vector.ph1219, label %608

vector.ph1219:                                    ; preds = %608
  %614 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 513
  %615 = bitcast i16* %614 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %615, i64 1024, i32 2, i1 false)
  br label %vector.body1220

vector.body1220:                                  ; preds = %vector.body1220, %vector.ph1219
  %index1223 = phi i64 [ 0, %vector.ph1219 ], [ %index.next1227, %vector.body1220 ]
  %vec.phi1232 = phi <4 x i32> [ zeroinitializer, %vector.ph1219 ], [ %622, %vector.body1220 ]
  %vec.phi1233 = phi <4 x i32> [ zeroinitializer, %vector.ph1219 ], [ %623, %vector.body1220 ]
  %616 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1223
  %617 = bitcast i16* %616 to <4 x i16>*
  %wide.load1234 = load <4 x i16>* %617, align 16
  %.sum1893 = or i64 %index1223, 4
  %618 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1893
  %619 = bitcast i16* %618 to <4 x i16>*
  %wide.load1235 = load <4 x i16>* %619, align 8
  %620 = zext <4 x i16> %wide.load1234 to <4 x i32>
  %621 = zext <4 x i16> %wide.load1235 to <4 x i32>
  %622 = add nsw <4 x i32> %620, %vec.phi1232
  %623 = add nsw <4 x i32> %621, %vec.phi1233
  %index.next1227 = add i64 %index1223, 8
  %624 = icmp eq i64 %index.next1227, 10240
  br i1 %624, label %middle.block1221, label %vector.body1220, !llvm.loop !34

middle.block1221:                                 ; preds = %vector.body1220
  %bin.rdx1238 = add <4 x i32> %623, %622
  %rdx.shuf1239 = shufflevector <4 x i32> %bin.rdx1238, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1240 = add <4 x i32> %bin.rdx1238, %rdx.shuf1239
  %rdx.shuf1241 = shufflevector <4 x i32> %bin.rdx1240, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1242 = add <4 x i32> %bin.rdx1240, %rdx.shuf1241
  %625 = extractelement <4 x i32> %bin.rdx1242, i32 0
  %626 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %625)
  br label %627

; <label>:627                                     ; preds = %627, %middle.block1221
  %indvars.iv476 = phi i64 [ 0, %middle.block1221 ], [ %indvars.iv.next477, %627 ]
  %628 = load volatile i32* %seed54, align 4
  %629 = trunc i64 %indvars.iv476 to i32
  %630 = mul nsw i32 %628, %629
  %631 = trunc i32 %630 to i16
  %632 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv476
  store i16 %631, i16* %632, align 2, !tbaa !20
  %indvars.iv.next477 = add nuw nsw i64 %indvars.iv476, 1
  %exitcond478 = icmp eq i64 %indvars.iv.next477, 10240
  br i1 %exitcond478, label %vector.ph1195, label %627

vector.ph1195:                                    ; preds = %627
  %633 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 1025
  %634 = bitcast i16* %633 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %634, i64 2048, i32 2, i1 false)
  br label %vector.body1196

vector.body1196:                                  ; preds = %vector.body1196, %vector.ph1195
  %index1199 = phi i64 [ 0, %vector.ph1195 ], [ %index.next1203, %vector.body1196 ]
  %vec.phi1208 = phi <4 x i32> [ zeroinitializer, %vector.ph1195 ], [ %641, %vector.body1196 ]
  %vec.phi1209 = phi <4 x i32> [ zeroinitializer, %vector.ph1195 ], [ %642, %vector.body1196 ]
  %635 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1199
  %636 = bitcast i16* %635 to <4 x i16>*
  %wide.load1210 = load <4 x i16>* %636, align 16
  %.sum1894 = or i64 %index1199, 4
  %637 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1894
  %638 = bitcast i16* %637 to <4 x i16>*
  %wide.load1211 = load <4 x i16>* %638, align 8
  %639 = zext <4 x i16> %wide.load1210 to <4 x i32>
  %640 = zext <4 x i16> %wide.load1211 to <4 x i32>
  %641 = add nsw <4 x i32> %639, %vec.phi1208
  %642 = add nsw <4 x i32> %640, %vec.phi1209
  %index.next1203 = add i64 %index1199, 8
  %643 = icmp eq i64 %index.next1203, 10240
  br i1 %643, label %middle.block1197, label %vector.body1196, !llvm.loop !35

middle.block1197:                                 ; preds = %vector.body1196
  %bin.rdx1214 = add <4 x i32> %642, %641
  %rdx.shuf1215 = shufflevector <4 x i32> %bin.rdx1214, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1216 = add <4 x i32> %bin.rdx1214, %rdx.shuf1215
  %rdx.shuf1217 = shufflevector <4 x i32> %bin.rdx1216, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1218 = add <4 x i32> %bin.rdx1216, %rdx.shuf1217
  %644 = extractelement <4 x i32> %bin.rdx1218, i32 0
  %645 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %644)
  br label %.preheader227

.preheader227:                                    ; preds = %middle.block1173, %middle.block1197
  %indvars.iv470 = phi i64 [ 10, %middle.block1197 ], [ %indvars.iv.next471, %middle.block1173 ]
  br label %646

; <label>:646                                     ; preds = %646, %.preheader227
  %indvars.iv463 = phi i64 [ 0, %.preheader227 ], [ %indvars.iv.next464, %646 ]
  %647 = load volatile i32* %seed54, align 4
  %648 = trunc i64 %indvars.iv463 to i32
  %649 = mul nsw i32 %647, %648
  %650 = trunc i32 %649 to i16
  %651 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv463
  store i16 %650, i16* %651, align 2, !tbaa !20
  %indvars.iv.next464 = add nuw nsw i64 %indvars.iv463, 1
  %exitcond465 = icmp eq i64 %indvars.iv.next464, 10240
  br i1 %exitcond465, label %vector.ph1171, label %646

vector.ph1171:                                    ; preds = %646
  %.sum170 = or i64 %indvars.iv470, 1
  %652 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %.sum170
  %653 = bitcast i16* %652 to i8*
  %654 = shl nsw i64 %indvars.iv470, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %327, i8* %653, i64 %654, i32 2, i1 false)
  br label %vector.body1172

vector.body1172:                                  ; preds = %vector.body1172, %vector.ph1171
  %index1175 = phi i64 [ 0, %vector.ph1171 ], [ %index.next1179, %vector.body1172 ]
  %vec.phi1184 = phi <4 x i32> [ zeroinitializer, %vector.ph1171 ], [ %661, %vector.body1172 ]
  %vec.phi1185 = phi <4 x i32> [ zeroinitializer, %vector.ph1171 ], [ %662, %vector.body1172 ]
  %655 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1175
  %656 = bitcast i16* %655 to <4 x i16>*
  %wide.load1186 = load <4 x i16>* %656, align 16
  %.sum1895 = or i64 %index1175, 4
  %657 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum1895
  %658 = bitcast i16* %657 to <4 x i16>*
  %wide.load1187 = load <4 x i16>* %658, align 8
  %659 = zext <4 x i16> %wide.load1186 to <4 x i32>
  %660 = zext <4 x i16> %wide.load1187 to <4 x i32>
  %661 = add nsw <4 x i32> %659, %vec.phi1184
  %662 = add nsw <4 x i32> %660, %vec.phi1185
  %index.next1179 = add i64 %index1175, 8
  %663 = icmp eq i64 %index.next1179, 10240
  br i1 %663, label %middle.block1173, label %vector.body1172, !llvm.loop !36

middle.block1173:                                 ; preds = %vector.body1172
  %bin.rdx1190 = add <4 x i32> %662, %661
  %rdx.shuf1191 = shufflevector <4 x i32> %bin.rdx1190, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1192 = add <4 x i32> %bin.rdx1190, %rdx.shuf1191
  %rdx.shuf1193 = shufflevector <4 x i32> %bin.rdx1192, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1194 = add <4 x i32> %bin.rdx1192, %rdx.shuf1193
  %664 = extractelement <4 x i32> %bin.rdx1194, i32 0
  %665 = trunc i64 %indvars.iv470 to i32
  %666 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %665, i32 %664)
  %indvars.iv.next471 = add nuw nsw i64 %indvars.iv470, 10
  %667 = trunc i64 %indvars.iv.next471 to i32
  %668 = icmp slt i32 %667, 100
  br i1 %668, label %.preheader227, label %669

; <label>:669                                     ; preds = %middle.block1173
  call void @llvm.lifetime.end(i64 20480, i8* %327) #2
  %puts168 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str5, i64 0, i64 0))
  %670 = bitcast [10240 x i32]* %buffer110 to i8*
  call void @llvm.lifetime.start(i64 40960, i8* %670) #2
  store volatile i32 123, i32* %seed111, align 4
  br label %671

; <label>:671                                     ; preds = %671, %669
  %indvars.iv460 = phi i64 [ 0, %669 ], [ %indvars.iv.next461, %671 ]
  %672 = load volatile i32* %seed111, align 4
  %673 = trunc i64 %indvars.iv460 to i32
  %674 = mul nsw i32 %672, %673
  %675 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv460
  store i32 %674, i32* %675, align 4, !tbaa !37
  %indvars.iv.next461 = add nuw nsw i64 %indvars.iv460, 1
  %exitcond462 = icmp eq i64 %indvars.iv.next461, 10240
  br i1 %exitcond462, label %676, label %671

; <label>:676                                     ; preds = %671
  %677 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 2
  %678 = load i32* %677, align 8
  %679 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 0
  store i32 %678, i32* %679, align 16
  br label %680

; <label>:680                                     ; preds = %._crit_edge737, %676
  %681 = phi i32 [ %678, %676 ], [ %.pre739, %._crit_edge737 ]
  %indvars.iv457 = phi i64 [ 1, %676 ], [ %phitmp749, %._crit_edge737 ]
  %v113.0224 = phi i32 [ 0, %676 ], [ %682, %._crit_edge737 ]
  %682 = add i32 %681, %v113.0224
  %exitcond459 = icmp eq i64 %indvars.iv457, 10240
  br i1 %exitcond459, label %683, label %._crit_edge737

._crit_edge737:                                   ; preds = %680
  %.phi.trans.insert738 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv457
  %.pre739 = load i32* %.phi.trans.insert738, align 4, !tbaa !37
  %phitmp749 = add i64 %indvars.iv457, 1
  br label %680

; <label>:683                                     ; preds = %680
  %684 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %682)
  br label %685

; <label>:685                                     ; preds = %685, %683
  %indvars.iv453 = phi i64 [ 0, %683 ], [ %indvars.iv.next454, %685 ]
  %686 = load volatile i32* %seed111, align 4
  %687 = trunc i64 %indvars.iv453 to i32
  %688 = mul nsw i32 %686, %687
  %689 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv453
  store i32 %688, i32* %689, align 4, !tbaa !37
  %indvars.iv.next454 = add nuw nsw i64 %indvars.iv453, 1
  %exitcond455 = icmp eq i64 %indvars.iv.next454, 10240
  br i1 %exitcond455, label %690, label %685

; <label>:690                                     ; preds = %685
  %691 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 3
  %692 = bitcast i32* %691 to i64*
  %693 = bitcast [10240 x i32]* %buffer110 to i64*
  %694 = load i64* %692, align 4
  store i64 %694, i64* %693, align 16
  %695 = trunc i64 %694 to i32
  br label %696

; <label>:696                                     ; preds = %._crit_edge740, %690
  %697 = phi i32 [ %695, %690 ], [ %.pre742, %._crit_edge740 ]
  %indvars.iv450 = phi i64 [ 1, %690 ], [ %phitmp750, %._crit_edge740 ]
  %v116.0221 = phi i32 [ 0, %690 ], [ %698, %._crit_edge740 ]
  %698 = add i32 %697, %v116.0221
  %exitcond452 = icmp eq i64 %indvars.iv450, 10240
  br i1 %exitcond452, label %699, label %._crit_edge740

._crit_edge740:                                   ; preds = %696
  %.phi.trans.insert741 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv450
  %.pre742 = load i32* %.phi.trans.insert741, align 4, !tbaa !37
  %phitmp750 = add i64 %indvars.iv450, 1
  br label %696

; <label>:699                                     ; preds = %696
  %700 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %698)
  br label %701

; <label>:701                                     ; preds = %701, %699
  %indvars.iv446 = phi i64 [ 0, %699 ], [ %indvars.iv.next447, %701 ]
  %702 = load volatile i32* %seed111, align 4
  %703 = trunc i64 %indvars.iv446 to i32
  %704 = mul nsw i32 %702, %703
  %705 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv446
  store i32 %704, i32* %705, align 4, !tbaa !37
  %indvars.iv.next447 = add nuw nsw i64 %indvars.iv446, 1
  %exitcond448 = icmp eq i64 %indvars.iv.next447, 10240
  br i1 %exitcond448, label %vector.ph1147, label %701

vector.ph1147:                                    ; preds = %701
  %706 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 4
  %707 = bitcast i32* %706 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %707, i64 12, i32 16, i1 false)
  br label %vector.body1148

vector.body1148:                                  ; preds = %vector.body1148, %vector.ph1147
  %index1151 = phi i64 [ 0, %vector.ph1147 ], [ %index.next1155, %vector.body1148 ]
  %vec.phi1160 = phi <4 x i32> [ zeroinitializer, %vector.ph1147 ], [ %712, %vector.body1148 ]
  %vec.phi1161 = phi <4 x i32> [ zeroinitializer, %vector.ph1147 ], [ %713, %vector.body1148 ]
  %708 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1151
  %709 = bitcast i32* %708 to <4 x i32>*
  %wide.load1162 = load <4 x i32>* %709, align 16
  %.sum1896 = or i64 %index1151, 4
  %710 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1896
  %711 = bitcast i32* %710 to <4 x i32>*
  %wide.load1163 = load <4 x i32>* %711, align 16
  %712 = add <4 x i32> %wide.load1162, %vec.phi1160
  %713 = add <4 x i32> %wide.load1163, %vec.phi1161
  %index.next1155 = add i64 %index1151, 8
  %714 = icmp eq i64 %index.next1155, 10240
  br i1 %714, label %middle.block1149, label %vector.body1148, !llvm.loop !39

middle.block1149:                                 ; preds = %vector.body1148
  %bin.rdx1166 = add <4 x i32> %713, %712
  %rdx.shuf1167 = shufflevector <4 x i32> %bin.rdx1166, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1168 = add <4 x i32> %bin.rdx1166, %rdx.shuf1167
  %rdx.shuf1169 = shufflevector <4 x i32> %bin.rdx1168, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1170 = add <4 x i32> %bin.rdx1168, %rdx.shuf1169
  %715 = extractelement <4 x i32> %bin.rdx1170, i32 0
  %716 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %715)
  br label %717

; <label>:717                                     ; preds = %717, %middle.block1149
  %indvars.iv439 = phi i64 [ 0, %middle.block1149 ], [ %indvars.iv.next440, %717 ]
  %718 = load volatile i32* %seed111, align 4
  %719 = trunc i64 %indvars.iv439 to i32
  %720 = mul nsw i32 %718, %719
  %721 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv439
  store i32 %720, i32* %721, align 4, !tbaa !37
  %indvars.iv.next440 = add nuw nsw i64 %indvars.iv439, 1
  %exitcond441 = icmp eq i64 %indvars.iv.next440, 10240
  br i1 %exitcond441, label %vector.ph1123, label %717

vector.ph1123:                                    ; preds = %717
  %722 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 5
  %723 = bitcast i32* %722 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %723, i64 16, i32 4, i1 false)
  br label %vector.body1124

vector.body1124:                                  ; preds = %vector.body1124, %vector.ph1123
  %index1127 = phi i64 [ 0, %vector.ph1123 ], [ %index.next1131, %vector.body1124 ]
  %vec.phi1136 = phi <4 x i32> [ zeroinitializer, %vector.ph1123 ], [ %728, %vector.body1124 ]
  %vec.phi1137 = phi <4 x i32> [ zeroinitializer, %vector.ph1123 ], [ %729, %vector.body1124 ]
  %724 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1127
  %725 = bitcast i32* %724 to <4 x i32>*
  %wide.load1138 = load <4 x i32>* %725, align 16
  %.sum1897 = or i64 %index1127, 4
  %726 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1897
  %727 = bitcast i32* %726 to <4 x i32>*
  %wide.load1139 = load <4 x i32>* %727, align 16
  %728 = add <4 x i32> %wide.load1138, %vec.phi1136
  %729 = add <4 x i32> %wide.load1139, %vec.phi1137
  %index.next1131 = add i64 %index1127, 8
  %730 = icmp eq i64 %index.next1131, 10240
  br i1 %730, label %middle.block1125, label %vector.body1124, !llvm.loop !40

middle.block1125:                                 ; preds = %vector.body1124
  %bin.rdx1142 = add <4 x i32> %729, %728
  %rdx.shuf1143 = shufflevector <4 x i32> %bin.rdx1142, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1144 = add <4 x i32> %bin.rdx1142, %rdx.shuf1143
  %rdx.shuf1145 = shufflevector <4 x i32> %bin.rdx1144, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1146 = add <4 x i32> %bin.rdx1144, %rdx.shuf1145
  %731 = extractelement <4 x i32> %bin.rdx1146, i32 0
  %732 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %731)
  br label %733

; <label>:733                                     ; preds = %733, %middle.block1125
  %indvars.iv432 = phi i64 [ 0, %middle.block1125 ], [ %indvars.iv.next433, %733 ]
  %734 = load volatile i32* %seed111, align 4
  %735 = trunc i64 %indvars.iv432 to i32
  %736 = mul nsw i32 %734, %735
  %737 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv432
  store i32 %736, i32* %737, align 4, !tbaa !37
  %indvars.iv.next433 = add nuw nsw i64 %indvars.iv432, 1
  %exitcond434 = icmp eq i64 %indvars.iv.next433, 10240
  br i1 %exitcond434, label %vector.ph1099, label %733

vector.ph1099:                                    ; preds = %733
  %738 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 6
  %739 = bitcast i32* %738 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %739, i64 20, i32 8, i1 false)
  br label %vector.body1100

vector.body1100:                                  ; preds = %vector.body1100, %vector.ph1099
  %index1103 = phi i64 [ 0, %vector.ph1099 ], [ %index.next1107, %vector.body1100 ]
  %vec.phi1112 = phi <4 x i32> [ zeroinitializer, %vector.ph1099 ], [ %744, %vector.body1100 ]
  %vec.phi1113 = phi <4 x i32> [ zeroinitializer, %vector.ph1099 ], [ %745, %vector.body1100 ]
  %740 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1103
  %741 = bitcast i32* %740 to <4 x i32>*
  %wide.load1114 = load <4 x i32>* %741, align 16
  %.sum1898 = or i64 %index1103, 4
  %742 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1898
  %743 = bitcast i32* %742 to <4 x i32>*
  %wide.load1115 = load <4 x i32>* %743, align 16
  %744 = add <4 x i32> %wide.load1114, %vec.phi1112
  %745 = add <4 x i32> %wide.load1115, %vec.phi1113
  %index.next1107 = add i64 %index1103, 8
  %746 = icmp eq i64 %index.next1107, 10240
  br i1 %746, label %middle.block1101, label %vector.body1100, !llvm.loop !41

middle.block1101:                                 ; preds = %vector.body1100
  %bin.rdx1118 = add <4 x i32> %745, %744
  %rdx.shuf1119 = shufflevector <4 x i32> %bin.rdx1118, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1120 = add <4 x i32> %bin.rdx1118, %rdx.shuf1119
  %rdx.shuf1121 = shufflevector <4 x i32> %bin.rdx1120, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1122 = add <4 x i32> %bin.rdx1120, %rdx.shuf1121
  %747 = extractelement <4 x i32> %bin.rdx1122, i32 0
  %748 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %747)
  br label %749

; <label>:749                                     ; preds = %749, %middle.block1101
  %indvars.iv425 = phi i64 [ 0, %middle.block1101 ], [ %indvars.iv.next426, %749 ]
  %750 = load volatile i32* %seed111, align 4
  %751 = trunc i64 %indvars.iv425 to i32
  %752 = mul nsw i32 %750, %751
  %753 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv425
  store i32 %752, i32* %753, align 4, !tbaa !37
  %indvars.iv.next426 = add nuw nsw i64 %indvars.iv425, 1
  %exitcond427 = icmp eq i64 %indvars.iv.next426, 10240
  br i1 %exitcond427, label %vector.ph1075, label %749

vector.ph1075:                                    ; preds = %749
  %754 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 7
  %755 = bitcast i32* %754 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %755, i64 24, i32 4, i1 false)
  br label %vector.body1076

vector.body1076:                                  ; preds = %vector.body1076, %vector.ph1075
  %index1079 = phi i64 [ 0, %vector.ph1075 ], [ %index.next1083, %vector.body1076 ]
  %vec.phi1088 = phi <4 x i32> [ zeroinitializer, %vector.ph1075 ], [ %760, %vector.body1076 ]
  %vec.phi1089 = phi <4 x i32> [ zeroinitializer, %vector.ph1075 ], [ %761, %vector.body1076 ]
  %756 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1079
  %757 = bitcast i32* %756 to <4 x i32>*
  %wide.load1090 = load <4 x i32>* %757, align 16
  %.sum1899 = or i64 %index1079, 4
  %758 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1899
  %759 = bitcast i32* %758 to <4 x i32>*
  %wide.load1091 = load <4 x i32>* %759, align 16
  %760 = add <4 x i32> %wide.load1090, %vec.phi1088
  %761 = add <4 x i32> %wide.load1091, %vec.phi1089
  %index.next1083 = add i64 %index1079, 8
  %762 = icmp eq i64 %index.next1083, 10240
  br i1 %762, label %middle.block1077, label %vector.body1076, !llvm.loop !42

middle.block1077:                                 ; preds = %vector.body1076
  %bin.rdx1094 = add <4 x i32> %761, %760
  %rdx.shuf1095 = shufflevector <4 x i32> %bin.rdx1094, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1096 = add <4 x i32> %bin.rdx1094, %rdx.shuf1095
  %rdx.shuf1097 = shufflevector <4 x i32> %bin.rdx1096, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1098 = add <4 x i32> %bin.rdx1096, %rdx.shuf1097
  %763 = extractelement <4 x i32> %bin.rdx1098, i32 0
  %764 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %763)
  br label %765

; <label>:765                                     ; preds = %765, %middle.block1077
  %indvars.iv418 = phi i64 [ 0, %middle.block1077 ], [ %indvars.iv.next419, %765 ]
  %766 = load volatile i32* %seed111, align 4
  %767 = trunc i64 %indvars.iv418 to i32
  %768 = mul nsw i32 %766, %767
  %769 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv418
  store i32 %768, i32* %769, align 4, !tbaa !37
  %indvars.iv.next419 = add nuw nsw i64 %indvars.iv418, 1
  %exitcond420 = icmp eq i64 %indvars.iv.next419, 10240
  br i1 %exitcond420, label %vector.ph1051, label %765

vector.ph1051:                                    ; preds = %765
  %770 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 8
  %771 = bitcast i32* %770 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %771, i64 28, i32 16, i1 false)
  br label %vector.body1052

vector.body1052:                                  ; preds = %vector.body1052, %vector.ph1051
  %index1055 = phi i64 [ 0, %vector.ph1051 ], [ %index.next1059, %vector.body1052 ]
  %vec.phi1064 = phi <4 x i32> [ zeroinitializer, %vector.ph1051 ], [ %776, %vector.body1052 ]
  %vec.phi1065 = phi <4 x i32> [ zeroinitializer, %vector.ph1051 ], [ %777, %vector.body1052 ]
  %772 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1055
  %773 = bitcast i32* %772 to <4 x i32>*
  %wide.load1066 = load <4 x i32>* %773, align 16
  %.sum1900 = or i64 %index1055, 4
  %774 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1900
  %775 = bitcast i32* %774 to <4 x i32>*
  %wide.load1067 = load <4 x i32>* %775, align 16
  %776 = add <4 x i32> %wide.load1066, %vec.phi1064
  %777 = add <4 x i32> %wide.load1067, %vec.phi1065
  %index.next1059 = add i64 %index1055, 8
  %778 = icmp eq i64 %index.next1059, 10240
  br i1 %778, label %middle.block1053, label %vector.body1052, !llvm.loop !43

middle.block1053:                                 ; preds = %vector.body1052
  %bin.rdx1070 = add <4 x i32> %777, %776
  %rdx.shuf1071 = shufflevector <4 x i32> %bin.rdx1070, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1072 = add <4 x i32> %bin.rdx1070, %rdx.shuf1071
  %rdx.shuf1073 = shufflevector <4 x i32> %bin.rdx1072, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1074 = add <4 x i32> %bin.rdx1072, %rdx.shuf1073
  %779 = extractelement <4 x i32> %bin.rdx1074, i32 0
  %780 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %779)
  br label %781

; <label>:781                                     ; preds = %781, %middle.block1053
  %indvars.iv411 = phi i64 [ 0, %middle.block1053 ], [ %indvars.iv.next412, %781 ]
  %782 = load volatile i32* %seed111, align 4
  %783 = trunc i64 %indvars.iv411 to i32
  %784 = mul nsw i32 %782, %783
  %785 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv411
  store i32 %784, i32* %785, align 4, !tbaa !37
  %indvars.iv.next412 = add nuw nsw i64 %indvars.iv411, 1
  %exitcond413 = icmp eq i64 %indvars.iv.next412, 10240
  br i1 %exitcond413, label %vector.ph1027, label %781

vector.ph1027:                                    ; preds = %781
  %786 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 9
  %787 = bitcast i32* %786 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %787, i64 32, i32 4, i1 false)
  br label %vector.body1028

vector.body1028:                                  ; preds = %vector.body1028, %vector.ph1027
  %index1031 = phi i64 [ 0, %vector.ph1027 ], [ %index.next1035, %vector.body1028 ]
  %vec.phi1040 = phi <4 x i32> [ zeroinitializer, %vector.ph1027 ], [ %792, %vector.body1028 ]
  %vec.phi1041 = phi <4 x i32> [ zeroinitializer, %vector.ph1027 ], [ %793, %vector.body1028 ]
  %788 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1031
  %789 = bitcast i32* %788 to <4 x i32>*
  %wide.load1042 = load <4 x i32>* %789, align 16
  %.sum1901 = or i64 %index1031, 4
  %790 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1901
  %791 = bitcast i32* %790 to <4 x i32>*
  %wide.load1043 = load <4 x i32>* %791, align 16
  %792 = add <4 x i32> %wide.load1042, %vec.phi1040
  %793 = add <4 x i32> %wide.load1043, %vec.phi1041
  %index.next1035 = add i64 %index1031, 8
  %794 = icmp eq i64 %index.next1035, 10240
  br i1 %794, label %middle.block1029, label %vector.body1028, !llvm.loop !44

middle.block1029:                                 ; preds = %vector.body1028
  %bin.rdx1046 = add <4 x i32> %793, %792
  %rdx.shuf1047 = shufflevector <4 x i32> %bin.rdx1046, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1048 = add <4 x i32> %bin.rdx1046, %rdx.shuf1047
  %rdx.shuf1049 = shufflevector <4 x i32> %bin.rdx1048, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1050 = add <4 x i32> %bin.rdx1048, %rdx.shuf1049
  %795 = extractelement <4 x i32> %bin.rdx1050, i32 0
  %796 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %795)
  br label %797

; <label>:797                                     ; preds = %797, %middle.block1029
  %indvars.iv404 = phi i64 [ 0, %middle.block1029 ], [ %indvars.iv.next405, %797 ]
  %798 = load volatile i32* %seed111, align 4
  %799 = trunc i64 %indvars.iv404 to i32
  %800 = mul nsw i32 %798, %799
  %801 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv404
  store i32 %800, i32* %801, align 4, !tbaa !37
  %indvars.iv.next405 = add nuw nsw i64 %indvars.iv404, 1
  %exitcond406 = icmp eq i64 %indvars.iv.next405, 10240
  br i1 %exitcond406, label %vector.ph1003, label %797

vector.ph1003:                                    ; preds = %797
  %802 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 10
  %803 = bitcast i32* %802 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %803, i64 36, i32 8, i1 false)
  br label %vector.body1004

vector.body1004:                                  ; preds = %vector.body1004, %vector.ph1003
  %index1007 = phi i64 [ 0, %vector.ph1003 ], [ %index.next1011, %vector.body1004 ]
  %vec.phi1016 = phi <4 x i32> [ zeroinitializer, %vector.ph1003 ], [ %808, %vector.body1004 ]
  %vec.phi1017 = phi <4 x i32> [ zeroinitializer, %vector.ph1003 ], [ %809, %vector.body1004 ]
  %804 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1007
  %805 = bitcast i32* %804 to <4 x i32>*
  %wide.load1018 = load <4 x i32>* %805, align 16
  %.sum1902 = or i64 %index1007, 4
  %806 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1902
  %807 = bitcast i32* %806 to <4 x i32>*
  %wide.load1019 = load <4 x i32>* %807, align 16
  %808 = add <4 x i32> %wide.load1018, %vec.phi1016
  %809 = add <4 x i32> %wide.load1019, %vec.phi1017
  %index.next1011 = add i64 %index1007, 8
  %810 = icmp eq i64 %index.next1011, 10240
  br i1 %810, label %middle.block1005, label %vector.body1004, !llvm.loop !45

middle.block1005:                                 ; preds = %vector.body1004
  %bin.rdx1022 = add <4 x i32> %809, %808
  %rdx.shuf1023 = shufflevector <4 x i32> %bin.rdx1022, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1024 = add <4 x i32> %bin.rdx1022, %rdx.shuf1023
  %rdx.shuf1025 = shufflevector <4 x i32> %bin.rdx1024, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1026 = add <4 x i32> %bin.rdx1024, %rdx.shuf1025
  %811 = extractelement <4 x i32> %bin.rdx1026, i32 0
  %812 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %811)
  br label %813

; <label>:813                                     ; preds = %813, %middle.block1005
  %indvars.iv397 = phi i64 [ 0, %middle.block1005 ], [ %indvars.iv.next398, %813 ]
  %814 = load volatile i32* %seed111, align 4
  %815 = trunc i64 %indvars.iv397 to i32
  %816 = mul nsw i32 %814, %815
  %817 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv397
  store i32 %816, i32* %817, align 4, !tbaa !37
  %indvars.iv.next398 = add nuw nsw i64 %indvars.iv397, 1
  %exitcond399 = icmp eq i64 %indvars.iv.next398, 10240
  br i1 %exitcond399, label %vector.ph979, label %813

vector.ph979:                                     ; preds = %813
  %818 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 11
  %819 = bitcast i32* %818 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %819, i64 40, i32 4, i1 false)
  br label %vector.body980

vector.body980:                                   ; preds = %vector.body980, %vector.ph979
  %index983 = phi i64 [ 0, %vector.ph979 ], [ %index.next987, %vector.body980 ]
  %vec.phi992 = phi <4 x i32> [ zeroinitializer, %vector.ph979 ], [ %824, %vector.body980 ]
  %vec.phi993 = phi <4 x i32> [ zeroinitializer, %vector.ph979 ], [ %825, %vector.body980 ]
  %820 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index983
  %821 = bitcast i32* %820 to <4 x i32>*
  %wide.load994 = load <4 x i32>* %821, align 16
  %.sum1903 = or i64 %index983, 4
  %822 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1903
  %823 = bitcast i32* %822 to <4 x i32>*
  %wide.load995 = load <4 x i32>* %823, align 16
  %824 = add <4 x i32> %wide.load994, %vec.phi992
  %825 = add <4 x i32> %wide.load995, %vec.phi993
  %index.next987 = add i64 %index983, 8
  %826 = icmp eq i64 %index.next987, 10240
  br i1 %826, label %middle.block981, label %vector.body980, !llvm.loop !46

middle.block981:                                  ; preds = %vector.body980
  %bin.rdx998 = add <4 x i32> %825, %824
  %rdx.shuf999 = shufflevector <4 x i32> %bin.rdx998, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1000 = add <4 x i32> %bin.rdx998, %rdx.shuf999
  %rdx.shuf1001 = shufflevector <4 x i32> %bin.rdx1000, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1002 = add <4 x i32> %bin.rdx1000, %rdx.shuf1001
  %827 = extractelement <4 x i32> %bin.rdx1002, i32 0
  %828 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %827)
  br label %829

; <label>:829                                     ; preds = %829, %middle.block981
  %indvars.iv390 = phi i64 [ 0, %middle.block981 ], [ %indvars.iv.next391, %829 ]
  %830 = load volatile i32* %seed111, align 4
  %831 = trunc i64 %indvars.iv390 to i32
  %832 = mul nsw i32 %830, %831
  %833 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv390
  store i32 %832, i32* %833, align 4, !tbaa !37
  %indvars.iv.next391 = add nuw nsw i64 %indvars.iv390, 1
  %exitcond392 = icmp eq i64 %indvars.iv.next391, 10240
  br i1 %exitcond392, label %vector.ph955, label %829

vector.ph955:                                     ; preds = %829
  %834 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 17
  %835 = bitcast i32* %834 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %835, i64 64, i32 4, i1 false)
  br label %vector.body956

vector.body956:                                   ; preds = %vector.body956, %vector.ph955
  %index959 = phi i64 [ 0, %vector.ph955 ], [ %index.next963, %vector.body956 ]
  %vec.phi968 = phi <4 x i32> [ zeroinitializer, %vector.ph955 ], [ %840, %vector.body956 ]
  %vec.phi969 = phi <4 x i32> [ zeroinitializer, %vector.ph955 ], [ %841, %vector.body956 ]
  %836 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index959
  %837 = bitcast i32* %836 to <4 x i32>*
  %wide.load970 = load <4 x i32>* %837, align 16
  %.sum1904 = or i64 %index959, 4
  %838 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1904
  %839 = bitcast i32* %838 to <4 x i32>*
  %wide.load971 = load <4 x i32>* %839, align 16
  %840 = add <4 x i32> %wide.load970, %vec.phi968
  %841 = add <4 x i32> %wide.load971, %vec.phi969
  %index.next963 = add i64 %index959, 8
  %842 = icmp eq i64 %index.next963, 10240
  br i1 %842, label %middle.block957, label %vector.body956, !llvm.loop !47

middle.block957:                                  ; preds = %vector.body956
  %bin.rdx974 = add <4 x i32> %841, %840
  %rdx.shuf975 = shufflevector <4 x i32> %bin.rdx974, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx976 = add <4 x i32> %bin.rdx974, %rdx.shuf975
  %rdx.shuf977 = shufflevector <4 x i32> %bin.rdx976, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx978 = add <4 x i32> %bin.rdx976, %rdx.shuf977
  %843 = extractelement <4 x i32> %bin.rdx978, i32 0
  %844 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %843)
  br label %845

; <label>:845                                     ; preds = %845, %middle.block957
  %indvars.iv383 = phi i64 [ 0, %middle.block957 ], [ %indvars.iv.next384, %845 ]
  %846 = load volatile i32* %seed111, align 4
  %847 = trunc i64 %indvars.iv383 to i32
  %848 = mul nsw i32 %846, %847
  %849 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv383
  store i32 %848, i32* %849, align 4, !tbaa !37
  %indvars.iv.next384 = add nuw nsw i64 %indvars.iv383, 1
  %exitcond385 = icmp eq i64 %indvars.iv.next384, 10240
  br i1 %exitcond385, label %vector.ph931, label %845

vector.ph931:                                     ; preds = %845
  %850 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 33
  %851 = bitcast i32* %850 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %851, i64 128, i32 4, i1 false)
  br label %vector.body932

vector.body932:                                   ; preds = %vector.body932, %vector.ph931
  %index935 = phi i64 [ 0, %vector.ph931 ], [ %index.next939, %vector.body932 ]
  %vec.phi944 = phi <4 x i32> [ zeroinitializer, %vector.ph931 ], [ %856, %vector.body932 ]
  %vec.phi945 = phi <4 x i32> [ zeroinitializer, %vector.ph931 ], [ %857, %vector.body932 ]
  %852 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index935
  %853 = bitcast i32* %852 to <4 x i32>*
  %wide.load946 = load <4 x i32>* %853, align 16
  %.sum1905 = or i64 %index935, 4
  %854 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1905
  %855 = bitcast i32* %854 to <4 x i32>*
  %wide.load947 = load <4 x i32>* %855, align 16
  %856 = add <4 x i32> %wide.load946, %vec.phi944
  %857 = add <4 x i32> %wide.load947, %vec.phi945
  %index.next939 = add i64 %index935, 8
  %858 = icmp eq i64 %index.next939, 10240
  br i1 %858, label %middle.block933, label %vector.body932, !llvm.loop !48

middle.block933:                                  ; preds = %vector.body932
  %bin.rdx950 = add <4 x i32> %857, %856
  %rdx.shuf951 = shufflevector <4 x i32> %bin.rdx950, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx952 = add <4 x i32> %bin.rdx950, %rdx.shuf951
  %rdx.shuf953 = shufflevector <4 x i32> %bin.rdx952, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx954 = add <4 x i32> %bin.rdx952, %rdx.shuf953
  %859 = extractelement <4 x i32> %bin.rdx954, i32 0
  %860 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %859)
  br label %861

; <label>:861                                     ; preds = %861, %middle.block933
  %indvars.iv376 = phi i64 [ 0, %middle.block933 ], [ %indvars.iv.next377, %861 ]
  %862 = load volatile i32* %seed111, align 4
  %863 = trunc i64 %indvars.iv376 to i32
  %864 = mul nsw i32 %862, %863
  %865 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv376
  store i32 %864, i32* %865, align 4, !tbaa !37
  %indvars.iv.next377 = add nuw nsw i64 %indvars.iv376, 1
  %exitcond378 = icmp eq i64 %indvars.iv.next377, 10240
  br i1 %exitcond378, label %vector.ph907, label %861

vector.ph907:                                     ; preds = %861
  %866 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 65
  %867 = bitcast i32* %866 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %867, i64 256, i32 4, i1 false)
  br label %vector.body908

vector.body908:                                   ; preds = %vector.body908, %vector.ph907
  %index911 = phi i64 [ 0, %vector.ph907 ], [ %index.next915, %vector.body908 ]
  %vec.phi920 = phi <4 x i32> [ zeroinitializer, %vector.ph907 ], [ %872, %vector.body908 ]
  %vec.phi921 = phi <4 x i32> [ zeroinitializer, %vector.ph907 ], [ %873, %vector.body908 ]
  %868 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index911
  %869 = bitcast i32* %868 to <4 x i32>*
  %wide.load922 = load <4 x i32>* %869, align 16
  %.sum1906 = or i64 %index911, 4
  %870 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1906
  %871 = bitcast i32* %870 to <4 x i32>*
  %wide.load923 = load <4 x i32>* %871, align 16
  %872 = add <4 x i32> %wide.load922, %vec.phi920
  %873 = add <4 x i32> %wide.load923, %vec.phi921
  %index.next915 = add i64 %index911, 8
  %874 = icmp eq i64 %index.next915, 10240
  br i1 %874, label %middle.block909, label %vector.body908, !llvm.loop !49

middle.block909:                                  ; preds = %vector.body908
  %bin.rdx926 = add <4 x i32> %873, %872
  %rdx.shuf927 = shufflevector <4 x i32> %bin.rdx926, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx928 = add <4 x i32> %bin.rdx926, %rdx.shuf927
  %rdx.shuf929 = shufflevector <4 x i32> %bin.rdx928, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx930 = add <4 x i32> %bin.rdx928, %rdx.shuf929
  %875 = extractelement <4 x i32> %bin.rdx930, i32 0
  %876 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %875)
  br label %877

; <label>:877                                     ; preds = %877, %middle.block909
  %indvars.iv369 = phi i64 [ 0, %middle.block909 ], [ %indvars.iv.next370, %877 ]
  %878 = load volatile i32* %seed111, align 4
  %879 = trunc i64 %indvars.iv369 to i32
  %880 = mul nsw i32 %878, %879
  %881 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv369
  store i32 %880, i32* %881, align 4, !tbaa !37
  %indvars.iv.next370 = add nuw nsw i64 %indvars.iv369, 1
  %exitcond371 = icmp eq i64 %indvars.iv.next370, 10240
  br i1 %exitcond371, label %vector.ph883, label %877

vector.ph883:                                     ; preds = %877
  %882 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 129
  %883 = bitcast i32* %882 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %883, i64 512, i32 4, i1 false)
  br label %vector.body884

vector.body884:                                   ; preds = %vector.body884, %vector.ph883
  %index887 = phi i64 [ 0, %vector.ph883 ], [ %index.next891, %vector.body884 ]
  %vec.phi896 = phi <4 x i32> [ zeroinitializer, %vector.ph883 ], [ %888, %vector.body884 ]
  %vec.phi897 = phi <4 x i32> [ zeroinitializer, %vector.ph883 ], [ %889, %vector.body884 ]
  %884 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index887
  %885 = bitcast i32* %884 to <4 x i32>*
  %wide.load898 = load <4 x i32>* %885, align 16
  %.sum1907 = or i64 %index887, 4
  %886 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1907
  %887 = bitcast i32* %886 to <4 x i32>*
  %wide.load899 = load <4 x i32>* %887, align 16
  %888 = add <4 x i32> %wide.load898, %vec.phi896
  %889 = add <4 x i32> %wide.load899, %vec.phi897
  %index.next891 = add i64 %index887, 8
  %890 = icmp eq i64 %index.next891, 10240
  br i1 %890, label %middle.block885, label %vector.body884, !llvm.loop !50

middle.block885:                                  ; preds = %vector.body884
  %bin.rdx902 = add <4 x i32> %889, %888
  %rdx.shuf903 = shufflevector <4 x i32> %bin.rdx902, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx904 = add <4 x i32> %bin.rdx902, %rdx.shuf903
  %rdx.shuf905 = shufflevector <4 x i32> %bin.rdx904, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx906 = add <4 x i32> %bin.rdx904, %rdx.shuf905
  %891 = extractelement <4 x i32> %bin.rdx906, i32 0
  %892 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %891)
  br label %893

; <label>:893                                     ; preds = %893, %middle.block885
  %indvars.iv362 = phi i64 [ 0, %middle.block885 ], [ %indvars.iv.next363, %893 ]
  %894 = load volatile i32* %seed111, align 4
  %895 = trunc i64 %indvars.iv362 to i32
  %896 = mul nsw i32 %894, %895
  %897 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv362
  store i32 %896, i32* %897, align 4, !tbaa !37
  %indvars.iv.next363 = add nuw nsw i64 %indvars.iv362, 1
  %exitcond364 = icmp eq i64 %indvars.iv.next363, 10240
  br i1 %exitcond364, label %vector.ph859, label %893

vector.ph859:                                     ; preds = %893
  %898 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 257
  %899 = bitcast i32* %898 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %899, i64 1024, i32 4, i1 false)
  br label %vector.body860

vector.body860:                                   ; preds = %vector.body860, %vector.ph859
  %index863 = phi i64 [ 0, %vector.ph859 ], [ %index.next867, %vector.body860 ]
  %vec.phi872 = phi <4 x i32> [ zeroinitializer, %vector.ph859 ], [ %904, %vector.body860 ]
  %vec.phi873 = phi <4 x i32> [ zeroinitializer, %vector.ph859 ], [ %905, %vector.body860 ]
  %900 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index863
  %901 = bitcast i32* %900 to <4 x i32>*
  %wide.load874 = load <4 x i32>* %901, align 16
  %.sum1908 = or i64 %index863, 4
  %902 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1908
  %903 = bitcast i32* %902 to <4 x i32>*
  %wide.load875 = load <4 x i32>* %903, align 16
  %904 = add <4 x i32> %wide.load874, %vec.phi872
  %905 = add <4 x i32> %wide.load875, %vec.phi873
  %index.next867 = add i64 %index863, 8
  %906 = icmp eq i64 %index.next867, 10240
  br i1 %906, label %middle.block861, label %vector.body860, !llvm.loop !51

middle.block861:                                  ; preds = %vector.body860
  %bin.rdx878 = add <4 x i32> %905, %904
  %rdx.shuf879 = shufflevector <4 x i32> %bin.rdx878, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx880 = add <4 x i32> %bin.rdx878, %rdx.shuf879
  %rdx.shuf881 = shufflevector <4 x i32> %bin.rdx880, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx882 = add <4 x i32> %bin.rdx880, %rdx.shuf881
  %907 = extractelement <4 x i32> %bin.rdx882, i32 0
  %908 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %907)
  br label %909

; <label>:909                                     ; preds = %909, %middle.block861
  %indvars.iv355 = phi i64 [ 0, %middle.block861 ], [ %indvars.iv.next356, %909 ]
  %910 = load volatile i32* %seed111, align 4
  %911 = trunc i64 %indvars.iv355 to i32
  %912 = mul nsw i32 %910, %911
  %913 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv355
  store i32 %912, i32* %913, align 4, !tbaa !37
  %indvars.iv.next356 = add nuw nsw i64 %indvars.iv355, 1
  %exitcond357 = icmp eq i64 %indvars.iv.next356, 10240
  br i1 %exitcond357, label %vector.ph835, label %909

vector.ph835:                                     ; preds = %909
  %914 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 513
  %915 = bitcast i32* %914 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %915, i64 2048, i32 4, i1 false)
  br label %vector.body836

vector.body836:                                   ; preds = %vector.body836, %vector.ph835
  %index839 = phi i64 [ 0, %vector.ph835 ], [ %index.next843, %vector.body836 ]
  %vec.phi848 = phi <4 x i32> [ zeroinitializer, %vector.ph835 ], [ %920, %vector.body836 ]
  %vec.phi849 = phi <4 x i32> [ zeroinitializer, %vector.ph835 ], [ %921, %vector.body836 ]
  %916 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index839
  %917 = bitcast i32* %916 to <4 x i32>*
  %wide.load850 = load <4 x i32>* %917, align 16
  %.sum1909 = or i64 %index839, 4
  %918 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1909
  %919 = bitcast i32* %918 to <4 x i32>*
  %wide.load851 = load <4 x i32>* %919, align 16
  %920 = add <4 x i32> %wide.load850, %vec.phi848
  %921 = add <4 x i32> %wide.load851, %vec.phi849
  %index.next843 = add i64 %index839, 8
  %922 = icmp eq i64 %index.next843, 10240
  br i1 %922, label %middle.block837, label %vector.body836, !llvm.loop !52

middle.block837:                                  ; preds = %vector.body836
  %bin.rdx854 = add <4 x i32> %921, %920
  %rdx.shuf855 = shufflevector <4 x i32> %bin.rdx854, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx856 = add <4 x i32> %bin.rdx854, %rdx.shuf855
  %rdx.shuf857 = shufflevector <4 x i32> %bin.rdx856, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx858 = add <4 x i32> %bin.rdx856, %rdx.shuf857
  %923 = extractelement <4 x i32> %bin.rdx858, i32 0
  %924 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %923)
  br label %925

; <label>:925                                     ; preds = %925, %middle.block837
  %indvars.iv348 = phi i64 [ 0, %middle.block837 ], [ %indvars.iv.next349, %925 ]
  %926 = load volatile i32* %seed111, align 4
  %927 = trunc i64 %indvars.iv348 to i32
  %928 = mul nsw i32 %926, %927
  %929 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv348
  store i32 %928, i32* %929, align 4, !tbaa !37
  %indvars.iv.next349 = add nuw nsw i64 %indvars.iv348, 1
  %exitcond350 = icmp eq i64 %indvars.iv.next349, 10240
  br i1 %exitcond350, label %vector.ph811, label %925

vector.ph811:                                     ; preds = %925
  %930 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 1025
  %931 = bitcast i32* %930 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %931, i64 4096, i32 4, i1 false)
  br label %vector.body812

vector.body812:                                   ; preds = %vector.body812, %vector.ph811
  %index815 = phi i64 [ 0, %vector.ph811 ], [ %index.next819, %vector.body812 ]
  %vec.phi824 = phi <4 x i32> [ zeroinitializer, %vector.ph811 ], [ %936, %vector.body812 ]
  %vec.phi825 = phi <4 x i32> [ zeroinitializer, %vector.ph811 ], [ %937, %vector.body812 ]
  %932 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index815
  %933 = bitcast i32* %932 to <4 x i32>*
  %wide.load826 = load <4 x i32>* %933, align 16
  %.sum1910 = or i64 %index815, 4
  %934 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1910
  %935 = bitcast i32* %934 to <4 x i32>*
  %wide.load827 = load <4 x i32>* %935, align 16
  %936 = add <4 x i32> %wide.load826, %vec.phi824
  %937 = add <4 x i32> %wide.load827, %vec.phi825
  %index.next819 = add i64 %index815, 8
  %938 = icmp eq i64 %index.next819, 10240
  br i1 %938, label %middle.block813, label %vector.body812, !llvm.loop !53

middle.block813:                                  ; preds = %vector.body812
  %bin.rdx830 = add <4 x i32> %937, %936
  %rdx.shuf831 = shufflevector <4 x i32> %bin.rdx830, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx832 = add <4 x i32> %bin.rdx830, %rdx.shuf831
  %rdx.shuf833 = shufflevector <4 x i32> %bin.rdx832, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx834 = add <4 x i32> %bin.rdx832, %rdx.shuf833
  %939 = extractelement <4 x i32> %bin.rdx834, i32 0
  %940 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %939)
  br label %.preheader

.preheader:                                       ; preds = %middle.block, %middle.block813
  %indvars.iv342 = phi i64 [ 10, %middle.block813 ], [ %indvars.iv.next343, %middle.block ]
  br label %941

; <label>:941                                     ; preds = %941, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %941 ]
  %942 = load volatile i32* %seed111, align 4
  %943 = trunc i64 %indvars.iv to i32
  %944 = mul nsw i32 %942, %943
  %945 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv
  store i32 %944, i32* %945, align 4, !tbaa !37
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 10240
  br i1 %exitcond, label %vector.ph, label %941

vector.ph:                                        ; preds = %941
  %.sum169 = or i64 %indvars.iv342, 1
  %946 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %.sum169
  %947 = bitcast i32* %946 to i8*
  %948 = shl nsw i64 %indvars.iv342, 2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %670, i8* %947, i64 %948, i32 4, i1 false)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %953, %vector.body ]
  %vec.phi805 = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %954, %vector.body ]
  %949 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index
  %950 = bitcast i32* %949 to <4 x i32>*
  %wide.load = load <4 x i32>* %950, align 16
  %.sum1911 = or i64 %index, 4
  %951 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum1911
  %952 = bitcast i32* %951 to <4 x i32>*
  %wide.load806 = load <4 x i32>* %952, align 16
  %953 = add <4 x i32> %wide.load, %vec.phi
  %954 = add <4 x i32> %wide.load806, %vec.phi805
  %index.next = add i64 %index, 8
  %955 = icmp eq i64 %index.next, 10240
  br i1 %955, label %middle.block, label %vector.body, !llvm.loop !54

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <4 x i32> %954, %953
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx808 = add <4 x i32> %bin.rdx, %rdx.shuf
  %rdx.shuf809 = shufflevector <4 x i32> %bin.rdx808, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx810 = add <4 x i32> %bin.rdx808, %rdx.shuf809
  %956 = extractelement <4 x i32> %bin.rdx810, i32 0
  %957 = trunc i64 %indvars.iv342 to i32
  %958 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %957, i32 %956)
  %indvars.iv.next343 = add nuw nsw i64 %indvars.iv342, 10
  %959 = trunc i64 %indvars.iv.next343 to i32
  %960 = icmp slt i32 %959, 100
  br i1 %960, label %.preheader, label %961

; <label>:961                                     ; preds = %middle.block
  call void @llvm.lifetime.end(i64 40960, i8* %670) #2
  ret i32 1
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !4, metadata !5, metadata !6}
!5 = metadata !{metadata !"llvm.loop.vectorize.width", i32 1}
!6 = metadata !{metadata !"llvm.loop.interleave.count", i32 1}
!7 = metadata !{metadata !7, metadata !5, metadata !6}
!8 = metadata !{metadata !8, metadata !5, metadata !6}
!9 = metadata !{metadata !9, metadata !5, metadata !6}
!10 = metadata !{metadata !10, metadata !5, metadata !6}
!11 = metadata !{metadata !11, metadata !5, metadata !6}
!12 = metadata !{metadata !12, metadata !5, metadata !6}
!13 = metadata !{metadata !13, metadata !5, metadata !6}
!14 = metadata !{metadata !14, metadata !5, metadata !6}
!15 = metadata !{metadata !15, metadata !5, metadata !6}
!16 = metadata !{metadata !16, metadata !5, metadata !6}
!17 = metadata !{metadata !17, metadata !5, metadata !6}
!18 = metadata !{metadata !18, metadata !5, metadata !6}
!19 = metadata !{metadata !19, metadata !5, metadata !6}
!20 = metadata !{metadata !21, metadata !21, i64 0}
!21 = metadata !{metadata !"short", metadata !2, i64 0}
!22 = metadata !{metadata !22, metadata !5, metadata !6}
!23 = metadata !{metadata !23, metadata !5, metadata !6}
!24 = metadata !{metadata !24, metadata !5, metadata !6}
!25 = metadata !{metadata !25, metadata !5, metadata !6}
!26 = metadata !{metadata !26, metadata !5, metadata !6}
!27 = metadata !{metadata !27, metadata !5, metadata !6}
!28 = metadata !{metadata !28, metadata !5, metadata !6}
!29 = metadata !{metadata !29, metadata !5, metadata !6}
!30 = metadata !{metadata !30, metadata !5, metadata !6}
!31 = metadata !{metadata !31, metadata !5, metadata !6}
!32 = metadata !{metadata !32, metadata !5, metadata !6}
!33 = metadata !{metadata !33, metadata !5, metadata !6}
!34 = metadata !{metadata !34, metadata !5, metadata !6}
!35 = metadata !{metadata !35, metadata !5, metadata !6}
!36 = metadata !{metadata !36, metadata !5, metadata !6}
!37 = metadata !{metadata !38, metadata !38, i64 0}
!38 = metadata !{metadata !"int", metadata !2, i64 0}
!39 = metadata !{metadata !39, metadata !5, metadata !6}
!40 = metadata !{metadata !40, metadata !5, metadata !6}
!41 = metadata !{metadata !41, metadata !5, metadata !6}
!42 = metadata !{metadata !42, metadata !5, metadata !6}
!43 = metadata !{metadata !43, metadata !5, metadata !6}
!44 = metadata !{metadata !44, metadata !5, metadata !6}
!45 = metadata !{metadata !45, metadata !5, metadata !6}
!46 = metadata !{metadata !46, metadata !5, metadata !6}
!47 = metadata !{metadata !47, metadata !5, metadata !6}
!48 = metadata !{metadata !48, metadata !5, metadata !6}
!49 = metadata !{metadata !49, metadata !5, metadata !6}
!50 = metadata !{metadata !50, metadata !5, metadata !6}
!51 = metadata !{metadata !51, metadata !5, metadata !6}
!52 = metadata !{metadata !52, metadata !5, metadata !6}
!53 = metadata !{metadata !53, metadata !5, metadata !6}
!54 = metadata !{metadata !54, metadata !5, metadata !6}
