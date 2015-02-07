; ModuleID = 'test_memset.bc'
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
  %indvars.iv713 = phi i64 [ 0, %0 ], [ %indvars.iv.next714, %2 ]
  %3 = load volatile i32* %seed, align 4
  %4 = trunc i64 %indvars.iv713 to i32
  %5 = mul nsw i32 %3, %4
  %6 = trunc i32 %5 to i8
  %7 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv713
  store i8 %6, i8* %7, align 1, !tbaa !1
  %indvars.iv.next714 = add nuw nsw i64 %indvars.iv713, 1
  %exitcond715 = icmp eq i64 %indvars.iv.next714, 10240
  br i1 %exitcond715, label %vector.ph2024, label %2

vector.ph2024:                                    ; preds = %2
  %8 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 1
  store i8 -91, i8* %8, align 1
  br label %vector.body2025

vector.body2025:                                  ; preds = %vector.body2025, %vector.ph2024
  %index2028 = phi i64 [ 0, %vector.ph2024 ], [ %index.next2032, %vector.body2025 ]
  %vec.phi2037 = phi <4 x i32> [ zeroinitializer, %vector.ph2024 ], [ %15, %vector.body2025 ]
  %vec.phi2038 = phi <4 x i32> [ zeroinitializer, %vector.ph2024 ], [ %16, %vector.body2025 ]
  %9 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index2028
  %10 = bitcast i8* %9 to <4 x i8>*
  %wide.load2039 = load <4 x i8>* %10, align 8
  %.sum2048 = or i64 %index2028, 4
  %11 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2048
  %12 = bitcast i8* %11 to <4 x i8>*
  %wide.load2040 = load <4 x i8>* %12, align 4
  %13 = zext <4 x i8> %wide.load2039 to <4 x i32>
  %14 = zext <4 x i8> %wide.load2040 to <4 x i32>
  %15 = add nsw <4 x i32> %13, %vec.phi2037
  %16 = add nsw <4 x i32> %14, %vec.phi2038
  %index.next2032 = add i64 %index2028, 8
  %17 = icmp eq i64 %index.next2032, 10240
  br i1 %17, label %middle.block2026, label %vector.body2025, !llvm.loop !4

middle.block2026:                                 ; preds = %vector.body2025
  %bin.rdx2043 = add <4 x i32> %16, %15
  %rdx.shuf2044 = shufflevector <4 x i32> %bin.rdx2043, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx2045 = add <4 x i32> %bin.rdx2043, %rdx.shuf2044
  %rdx.shuf2046 = shufflevector <4 x i32> %bin.rdx2045, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx2047 = add <4 x i32> %bin.rdx2045, %rdx.shuf2046
  %18 = extractelement <4 x i32> %bin.rdx2047, i32 0
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %18)
  br label %20

; <label>:20                                      ; preds = %20, %middle.block2026
  %indvars.iv706 = phi i64 [ 0, %middle.block2026 ], [ %indvars.iv.next707, %20 ]
  %21 = load volatile i32* %seed, align 4
  %22 = trunc i64 %indvars.iv706 to i32
  %23 = mul nsw i32 %21, %22
  %24 = trunc i32 %23 to i8
  %25 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv706
  store i8 %24, i8* %25, align 1, !tbaa !1
  %indvars.iv.next707 = add nuw nsw i64 %indvars.iv706, 1
  %exitcond708 = icmp eq i64 %indvars.iv.next707, 10240
  br i1 %exitcond708, label %vector.ph2000, label %20

vector.ph2000:                                    ; preds = %20
  %26 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 2
  %27 = bitcast i8* %26 to i16*
  store i16 -23131, i16* %27, align 2
  br label %vector.body2001

vector.body2001:                                  ; preds = %vector.body2001, %vector.ph2000
  %index2004 = phi i64 [ 0, %vector.ph2000 ], [ %index.next2008, %vector.body2001 ]
  %vec.phi2013 = phi <4 x i32> [ zeroinitializer, %vector.ph2000 ], [ %34, %vector.body2001 ]
  %vec.phi2014 = phi <4 x i32> [ zeroinitializer, %vector.ph2000 ], [ %35, %vector.body2001 ]
  %28 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index2004
  %29 = bitcast i8* %28 to <4 x i8>*
  %wide.load2015 = load <4 x i8>* %29, align 8
  %.sum2049 = or i64 %index2004, 4
  %30 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2049
  %31 = bitcast i8* %30 to <4 x i8>*
  %wide.load2016 = load <4 x i8>* %31, align 4
  %32 = zext <4 x i8> %wide.load2015 to <4 x i32>
  %33 = zext <4 x i8> %wide.load2016 to <4 x i32>
  %34 = add nsw <4 x i32> %32, %vec.phi2013
  %35 = add nsw <4 x i32> %33, %vec.phi2014
  %index.next2008 = add i64 %index2004, 8
  %36 = icmp eq i64 %index.next2008, 10240
  br i1 %36, label %middle.block2002, label %vector.body2001, !llvm.loop !7

middle.block2002:                                 ; preds = %vector.body2001
  %bin.rdx2019 = add <4 x i32> %35, %34
  %rdx.shuf2020 = shufflevector <4 x i32> %bin.rdx2019, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx2021 = add <4 x i32> %bin.rdx2019, %rdx.shuf2020
  %rdx.shuf2022 = shufflevector <4 x i32> %bin.rdx2021, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx2023 = add <4 x i32> %bin.rdx2021, %rdx.shuf2022
  %37 = extractelement <4 x i32> %bin.rdx2023, i32 0
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %37)
  br label %39

; <label>:39                                      ; preds = %39, %middle.block2002
  %indvars.iv699 = phi i64 [ 0, %middle.block2002 ], [ %indvars.iv.next700, %39 ]
  %40 = load volatile i32* %seed, align 4
  %41 = trunc i64 %indvars.iv699 to i32
  %42 = mul nsw i32 %40, %41
  %43 = trunc i32 %42 to i8
  %44 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv699
  store i8 %43, i8* %44, align 1, !tbaa !1
  %indvars.iv.next700 = add nuw nsw i64 %indvars.iv699, 1
  %exitcond701 = icmp eq i64 %indvars.iv.next700, 10240
  br i1 %exitcond701, label %vector.ph1976, label %39

vector.ph1976:                                    ; preds = %39
  %45 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 3
  call void @llvm.memset.p0i8.i64(i8* %45, i8 -91, i64 3, i32 1, i1 false)
  br label %vector.body1977

vector.body1977:                                  ; preds = %vector.body1977, %vector.ph1976
  %index1980 = phi i64 [ 0, %vector.ph1976 ], [ %index.next1984, %vector.body1977 ]
  %vec.phi1989 = phi <4 x i32> [ zeroinitializer, %vector.ph1976 ], [ %52, %vector.body1977 ]
  %vec.phi1990 = phi <4 x i32> [ zeroinitializer, %vector.ph1976 ], [ %53, %vector.body1977 ]
  %46 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1980
  %47 = bitcast i8* %46 to <4 x i8>*
  %wide.load1991 = load <4 x i8>* %47, align 8
  %.sum2050 = or i64 %index1980, 4
  %48 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2050
  %49 = bitcast i8* %48 to <4 x i8>*
  %wide.load1992 = load <4 x i8>* %49, align 4
  %50 = zext <4 x i8> %wide.load1991 to <4 x i32>
  %51 = zext <4 x i8> %wide.load1992 to <4 x i32>
  %52 = add nsw <4 x i32> %50, %vec.phi1989
  %53 = add nsw <4 x i32> %51, %vec.phi1990
  %index.next1984 = add i64 %index1980, 8
  %54 = icmp eq i64 %index.next1984, 10240
  br i1 %54, label %middle.block1978, label %vector.body1977, !llvm.loop !8

middle.block1978:                                 ; preds = %vector.body1977
  %bin.rdx1995 = add <4 x i32> %53, %52
  %rdx.shuf1996 = shufflevector <4 x i32> %bin.rdx1995, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1997 = add <4 x i32> %bin.rdx1995, %rdx.shuf1996
  %rdx.shuf1998 = shufflevector <4 x i32> %bin.rdx1997, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1999 = add <4 x i32> %bin.rdx1997, %rdx.shuf1998
  %55 = extractelement <4 x i32> %bin.rdx1999, i32 0
  %56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %55)
  br label %57

; <label>:57                                      ; preds = %57, %middle.block1978
  %indvars.iv692 = phi i64 [ 0, %middle.block1978 ], [ %indvars.iv.next693, %57 ]
  %58 = load volatile i32* %seed, align 4
  %59 = trunc i64 %indvars.iv692 to i32
  %60 = mul nsw i32 %58, %59
  %61 = trunc i32 %60 to i8
  %62 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv692
  store i8 %61, i8* %62, align 1, !tbaa !1
  %indvars.iv.next693 = add nuw nsw i64 %indvars.iv692, 1
  %exitcond694 = icmp eq i64 %indvars.iv.next693, 10240
  br i1 %exitcond694, label %vector.ph1952, label %57

vector.ph1952:                                    ; preds = %57
  %63 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 4
  %64 = bitcast i8* %63 to i32*
  store i32 -1515870811, i32* %64, align 4
  br label %vector.body1953

vector.body1953:                                  ; preds = %vector.body1953, %vector.ph1952
  %index1956 = phi i64 [ 0, %vector.ph1952 ], [ %index.next1960, %vector.body1953 ]
  %vec.phi1965 = phi <4 x i32> [ zeroinitializer, %vector.ph1952 ], [ %71, %vector.body1953 ]
  %vec.phi1966 = phi <4 x i32> [ zeroinitializer, %vector.ph1952 ], [ %72, %vector.body1953 ]
  %65 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1956
  %66 = bitcast i8* %65 to <4 x i8>*
  %wide.load1967 = load <4 x i8>* %66, align 8
  %.sum2051 = or i64 %index1956, 4
  %67 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2051
  %68 = bitcast i8* %67 to <4 x i8>*
  %wide.load1968 = load <4 x i8>* %68, align 4
  %69 = zext <4 x i8> %wide.load1967 to <4 x i32>
  %70 = zext <4 x i8> %wide.load1968 to <4 x i32>
  %71 = add nsw <4 x i32> %69, %vec.phi1965
  %72 = add nsw <4 x i32> %70, %vec.phi1966
  %index.next1960 = add i64 %index1956, 8
  %73 = icmp eq i64 %index.next1960, 10240
  br i1 %73, label %middle.block1954, label %vector.body1953, !llvm.loop !9

middle.block1954:                                 ; preds = %vector.body1953
  %bin.rdx1971 = add <4 x i32> %72, %71
  %rdx.shuf1972 = shufflevector <4 x i32> %bin.rdx1971, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1973 = add <4 x i32> %bin.rdx1971, %rdx.shuf1972
  %rdx.shuf1974 = shufflevector <4 x i32> %bin.rdx1973, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1975 = add <4 x i32> %bin.rdx1973, %rdx.shuf1974
  %74 = extractelement <4 x i32> %bin.rdx1975, i32 0
  %75 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %74)
  br label %76

; <label>:76                                      ; preds = %76, %middle.block1954
  %indvars.iv685 = phi i64 [ 0, %middle.block1954 ], [ %indvars.iv.next686, %76 ]
  %77 = load volatile i32* %seed, align 4
  %78 = trunc i64 %indvars.iv685 to i32
  %79 = mul nsw i32 %77, %78
  %80 = trunc i32 %79 to i8
  %81 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv685
  store i8 %80, i8* %81, align 1, !tbaa !1
  %indvars.iv.next686 = add nuw nsw i64 %indvars.iv685, 1
  %exitcond687 = icmp eq i64 %indvars.iv.next686, 10240
  br i1 %exitcond687, label %vector.ph1928, label %76

vector.ph1928:                                    ; preds = %76
  %82 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 5
  call void @llvm.memset.p0i8.i64(i8* %82, i8 -91, i64 5, i32 1, i1 false)
  br label %vector.body1929

vector.body1929:                                  ; preds = %vector.body1929, %vector.ph1928
  %index1932 = phi i64 [ 0, %vector.ph1928 ], [ %index.next1936, %vector.body1929 ]
  %vec.phi1941 = phi <4 x i32> [ zeroinitializer, %vector.ph1928 ], [ %89, %vector.body1929 ]
  %vec.phi1942 = phi <4 x i32> [ zeroinitializer, %vector.ph1928 ], [ %90, %vector.body1929 ]
  %83 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1932
  %84 = bitcast i8* %83 to <4 x i8>*
  %wide.load1943 = load <4 x i8>* %84, align 8
  %.sum2052 = or i64 %index1932, 4
  %85 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2052
  %86 = bitcast i8* %85 to <4 x i8>*
  %wide.load1944 = load <4 x i8>* %86, align 4
  %87 = zext <4 x i8> %wide.load1943 to <4 x i32>
  %88 = zext <4 x i8> %wide.load1944 to <4 x i32>
  %89 = add nsw <4 x i32> %87, %vec.phi1941
  %90 = add nsw <4 x i32> %88, %vec.phi1942
  %index.next1936 = add i64 %index1932, 8
  %91 = icmp eq i64 %index.next1936, 10240
  br i1 %91, label %middle.block1930, label %vector.body1929, !llvm.loop !10

middle.block1930:                                 ; preds = %vector.body1929
  %bin.rdx1947 = add <4 x i32> %90, %89
  %rdx.shuf1948 = shufflevector <4 x i32> %bin.rdx1947, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1949 = add <4 x i32> %bin.rdx1947, %rdx.shuf1948
  %rdx.shuf1950 = shufflevector <4 x i32> %bin.rdx1949, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1951 = add <4 x i32> %bin.rdx1949, %rdx.shuf1950
  %92 = extractelement <4 x i32> %bin.rdx1951, i32 0
  %93 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %92)
  br label %94

; <label>:94                                      ; preds = %94, %middle.block1930
  %indvars.iv678 = phi i64 [ 0, %middle.block1930 ], [ %indvars.iv.next679, %94 ]
  %95 = load volatile i32* %seed, align 4
  %96 = trunc i64 %indvars.iv678 to i32
  %97 = mul nsw i32 %95, %96
  %98 = trunc i32 %97 to i8
  %99 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv678
  store i8 %98, i8* %99, align 1, !tbaa !1
  %indvars.iv.next679 = add nuw nsw i64 %indvars.iv678, 1
  %exitcond680 = icmp eq i64 %indvars.iv.next679, 10240
  br i1 %exitcond680, label %vector.ph1904, label %94

vector.ph1904:                                    ; preds = %94
  %100 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 6
  call void @llvm.memset.p0i8.i64(i8* %100, i8 -91, i64 6, i32 2, i1 false)
  br label %vector.body1905

vector.body1905:                                  ; preds = %vector.body1905, %vector.ph1904
  %index1908 = phi i64 [ 0, %vector.ph1904 ], [ %index.next1912, %vector.body1905 ]
  %vec.phi1917 = phi <4 x i32> [ zeroinitializer, %vector.ph1904 ], [ %107, %vector.body1905 ]
  %vec.phi1918 = phi <4 x i32> [ zeroinitializer, %vector.ph1904 ], [ %108, %vector.body1905 ]
  %101 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1908
  %102 = bitcast i8* %101 to <4 x i8>*
  %wide.load1919 = load <4 x i8>* %102, align 8
  %.sum2053 = or i64 %index1908, 4
  %103 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2053
  %104 = bitcast i8* %103 to <4 x i8>*
  %wide.load1920 = load <4 x i8>* %104, align 4
  %105 = zext <4 x i8> %wide.load1919 to <4 x i32>
  %106 = zext <4 x i8> %wide.load1920 to <4 x i32>
  %107 = add nsw <4 x i32> %105, %vec.phi1917
  %108 = add nsw <4 x i32> %106, %vec.phi1918
  %index.next1912 = add i64 %index1908, 8
  %109 = icmp eq i64 %index.next1912, 10240
  br i1 %109, label %middle.block1906, label %vector.body1905, !llvm.loop !11

middle.block1906:                                 ; preds = %vector.body1905
  %bin.rdx1923 = add <4 x i32> %108, %107
  %rdx.shuf1924 = shufflevector <4 x i32> %bin.rdx1923, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1925 = add <4 x i32> %bin.rdx1923, %rdx.shuf1924
  %rdx.shuf1926 = shufflevector <4 x i32> %bin.rdx1925, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1927 = add <4 x i32> %bin.rdx1925, %rdx.shuf1926
  %110 = extractelement <4 x i32> %bin.rdx1927, i32 0
  %111 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %110)
  br label %112

; <label>:112                                     ; preds = %112, %middle.block1906
  %indvars.iv671 = phi i64 [ 0, %middle.block1906 ], [ %indvars.iv.next672, %112 ]
  %113 = load volatile i32* %seed, align 4
  %114 = trunc i64 %indvars.iv671 to i32
  %115 = mul nsw i32 %113, %114
  %116 = trunc i32 %115 to i8
  %117 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv671
  store i8 %116, i8* %117, align 1, !tbaa !1
  %indvars.iv.next672 = add nuw nsw i64 %indvars.iv671, 1
  %exitcond673 = icmp eq i64 %indvars.iv.next672, 10240
  br i1 %exitcond673, label %vector.ph1880, label %112

vector.ph1880:                                    ; preds = %112
  %118 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 7
  call void @llvm.memset.p0i8.i64(i8* %118, i8 -91, i64 7, i32 1, i1 false)
  br label %vector.body1881

vector.body1881:                                  ; preds = %vector.body1881, %vector.ph1880
  %index1884 = phi i64 [ 0, %vector.ph1880 ], [ %index.next1888, %vector.body1881 ]
  %vec.phi1893 = phi <4 x i32> [ zeroinitializer, %vector.ph1880 ], [ %125, %vector.body1881 ]
  %vec.phi1894 = phi <4 x i32> [ zeroinitializer, %vector.ph1880 ], [ %126, %vector.body1881 ]
  %119 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1884
  %120 = bitcast i8* %119 to <4 x i8>*
  %wide.load1895 = load <4 x i8>* %120, align 8
  %.sum2054 = or i64 %index1884, 4
  %121 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2054
  %122 = bitcast i8* %121 to <4 x i8>*
  %wide.load1896 = load <4 x i8>* %122, align 4
  %123 = zext <4 x i8> %wide.load1895 to <4 x i32>
  %124 = zext <4 x i8> %wide.load1896 to <4 x i32>
  %125 = add nsw <4 x i32> %123, %vec.phi1893
  %126 = add nsw <4 x i32> %124, %vec.phi1894
  %index.next1888 = add i64 %index1884, 8
  %127 = icmp eq i64 %index.next1888, 10240
  br i1 %127, label %middle.block1882, label %vector.body1881, !llvm.loop !12

middle.block1882:                                 ; preds = %vector.body1881
  %bin.rdx1899 = add <4 x i32> %126, %125
  %rdx.shuf1900 = shufflevector <4 x i32> %bin.rdx1899, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1901 = add <4 x i32> %bin.rdx1899, %rdx.shuf1900
  %rdx.shuf1902 = shufflevector <4 x i32> %bin.rdx1901, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1903 = add <4 x i32> %bin.rdx1901, %rdx.shuf1902
  %128 = extractelement <4 x i32> %bin.rdx1903, i32 0
  %129 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %128)
  br label %130

; <label>:130                                     ; preds = %130, %middle.block1882
  %indvars.iv664 = phi i64 [ 0, %middle.block1882 ], [ %indvars.iv.next665, %130 ]
  %131 = load volatile i32* %seed, align 4
  %132 = trunc i64 %indvars.iv664 to i32
  %133 = mul nsw i32 %131, %132
  %134 = trunc i32 %133 to i8
  %135 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv664
  store i8 %134, i8* %135, align 1, !tbaa !1
  %indvars.iv.next665 = add nuw nsw i64 %indvars.iv664, 1
  %exitcond666 = icmp eq i64 %indvars.iv.next665, 10240
  br i1 %exitcond666, label %vector.ph1856, label %130

vector.ph1856:                                    ; preds = %130
  %136 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 8
  %137 = bitcast i8* %136 to i64*
  store i64 -6510615555426900571, i64* %137, align 8
  br label %vector.body1857

vector.body1857:                                  ; preds = %vector.body1857, %vector.ph1856
  %index1860 = phi i64 [ 0, %vector.ph1856 ], [ %index.next1864, %vector.body1857 ]
  %vec.phi1869 = phi <4 x i32> [ zeroinitializer, %vector.ph1856 ], [ %144, %vector.body1857 ]
  %vec.phi1870 = phi <4 x i32> [ zeroinitializer, %vector.ph1856 ], [ %145, %vector.body1857 ]
  %138 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1860
  %139 = bitcast i8* %138 to <4 x i8>*
  %wide.load1871 = load <4 x i8>* %139, align 8
  %.sum2055 = or i64 %index1860, 4
  %140 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2055
  %141 = bitcast i8* %140 to <4 x i8>*
  %wide.load1872 = load <4 x i8>* %141, align 4
  %142 = zext <4 x i8> %wide.load1871 to <4 x i32>
  %143 = zext <4 x i8> %wide.load1872 to <4 x i32>
  %144 = add nsw <4 x i32> %142, %vec.phi1869
  %145 = add nsw <4 x i32> %143, %vec.phi1870
  %index.next1864 = add i64 %index1860, 8
  %146 = icmp eq i64 %index.next1864, 10240
  br i1 %146, label %middle.block1858, label %vector.body1857, !llvm.loop !13

middle.block1858:                                 ; preds = %vector.body1857
  %bin.rdx1875 = add <4 x i32> %145, %144
  %rdx.shuf1876 = shufflevector <4 x i32> %bin.rdx1875, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1877 = add <4 x i32> %bin.rdx1875, %rdx.shuf1876
  %rdx.shuf1878 = shufflevector <4 x i32> %bin.rdx1877, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1879 = add <4 x i32> %bin.rdx1877, %rdx.shuf1878
  %147 = extractelement <4 x i32> %bin.rdx1879, i32 0
  %148 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %147)
  br label %149

; <label>:149                                     ; preds = %149, %middle.block1858
  %indvars.iv657 = phi i64 [ 0, %middle.block1858 ], [ %indvars.iv.next658, %149 ]
  %150 = load volatile i32* %seed, align 4
  %151 = trunc i64 %indvars.iv657 to i32
  %152 = mul nsw i32 %150, %151
  %153 = trunc i32 %152 to i8
  %154 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv657
  store i8 %153, i8* %154, align 1, !tbaa !1
  %indvars.iv.next658 = add nuw nsw i64 %indvars.iv657, 1
  %exitcond659 = icmp eq i64 %indvars.iv.next658, 10240
  br i1 %exitcond659, label %vector.ph1832, label %149

vector.ph1832:                                    ; preds = %149
  %155 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 9
  call void @llvm.memset.p0i8.i64(i8* %155, i8 -91, i64 9, i32 1, i1 false)
  br label %vector.body1833

vector.body1833:                                  ; preds = %vector.body1833, %vector.ph1832
  %index1836 = phi i64 [ 0, %vector.ph1832 ], [ %index.next1840, %vector.body1833 ]
  %vec.phi1845 = phi <4 x i32> [ zeroinitializer, %vector.ph1832 ], [ %162, %vector.body1833 ]
  %vec.phi1846 = phi <4 x i32> [ zeroinitializer, %vector.ph1832 ], [ %163, %vector.body1833 ]
  %156 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1836
  %157 = bitcast i8* %156 to <4 x i8>*
  %wide.load1847 = load <4 x i8>* %157, align 8
  %.sum2056 = or i64 %index1836, 4
  %158 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2056
  %159 = bitcast i8* %158 to <4 x i8>*
  %wide.load1848 = load <4 x i8>* %159, align 4
  %160 = zext <4 x i8> %wide.load1847 to <4 x i32>
  %161 = zext <4 x i8> %wide.load1848 to <4 x i32>
  %162 = add nsw <4 x i32> %160, %vec.phi1845
  %163 = add nsw <4 x i32> %161, %vec.phi1846
  %index.next1840 = add i64 %index1836, 8
  %164 = icmp eq i64 %index.next1840, 10240
  br i1 %164, label %middle.block1834, label %vector.body1833, !llvm.loop !14

middle.block1834:                                 ; preds = %vector.body1833
  %bin.rdx1851 = add <4 x i32> %163, %162
  %rdx.shuf1852 = shufflevector <4 x i32> %bin.rdx1851, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1853 = add <4 x i32> %bin.rdx1851, %rdx.shuf1852
  %rdx.shuf1854 = shufflevector <4 x i32> %bin.rdx1853, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1855 = add <4 x i32> %bin.rdx1853, %rdx.shuf1854
  %165 = extractelement <4 x i32> %bin.rdx1855, i32 0
  %166 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %165)
  br label %167

; <label>:167                                     ; preds = %167, %middle.block1834
  %indvars.iv650 = phi i64 [ 0, %middle.block1834 ], [ %indvars.iv.next651, %167 ]
  %168 = load volatile i32* %seed, align 4
  %169 = trunc i64 %indvars.iv650 to i32
  %170 = mul nsw i32 %168, %169
  %171 = trunc i32 %170 to i8
  %172 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv650
  store i8 %171, i8* %172, align 1, !tbaa !1
  %indvars.iv.next651 = add nuw nsw i64 %indvars.iv650, 1
  %exitcond652 = icmp eq i64 %indvars.iv.next651, 10240
  br i1 %exitcond652, label %vector.ph1808, label %167

vector.ph1808:                                    ; preds = %167
  %173 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 10
  call void @llvm.memset.p0i8.i64(i8* %173, i8 -91, i64 10, i32 2, i1 false)
  br label %vector.body1809

vector.body1809:                                  ; preds = %vector.body1809, %vector.ph1808
  %index1812 = phi i64 [ 0, %vector.ph1808 ], [ %index.next1816, %vector.body1809 ]
  %vec.phi1821 = phi <4 x i32> [ zeroinitializer, %vector.ph1808 ], [ %180, %vector.body1809 ]
  %vec.phi1822 = phi <4 x i32> [ zeroinitializer, %vector.ph1808 ], [ %181, %vector.body1809 ]
  %174 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1812
  %175 = bitcast i8* %174 to <4 x i8>*
  %wide.load1823 = load <4 x i8>* %175, align 8
  %.sum2057 = or i64 %index1812, 4
  %176 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2057
  %177 = bitcast i8* %176 to <4 x i8>*
  %wide.load1824 = load <4 x i8>* %177, align 4
  %178 = zext <4 x i8> %wide.load1823 to <4 x i32>
  %179 = zext <4 x i8> %wide.load1824 to <4 x i32>
  %180 = add nsw <4 x i32> %178, %vec.phi1821
  %181 = add nsw <4 x i32> %179, %vec.phi1822
  %index.next1816 = add i64 %index1812, 8
  %182 = icmp eq i64 %index.next1816, 10240
  br i1 %182, label %middle.block1810, label %vector.body1809, !llvm.loop !15

middle.block1810:                                 ; preds = %vector.body1809
  %bin.rdx1827 = add <4 x i32> %181, %180
  %rdx.shuf1828 = shufflevector <4 x i32> %bin.rdx1827, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1829 = add <4 x i32> %bin.rdx1827, %rdx.shuf1828
  %rdx.shuf1830 = shufflevector <4 x i32> %bin.rdx1829, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1831 = add <4 x i32> %bin.rdx1829, %rdx.shuf1830
  %183 = extractelement <4 x i32> %bin.rdx1831, i32 0
  %184 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %183)
  br label %185

; <label>:185                                     ; preds = %185, %middle.block1810
  %indvars.iv643 = phi i64 [ 0, %middle.block1810 ], [ %indvars.iv.next644, %185 ]
  %186 = load volatile i32* %seed, align 4
  %187 = trunc i64 %indvars.iv643 to i32
  %188 = mul nsw i32 %186, %187
  %189 = trunc i32 %188 to i8
  %190 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv643
  store i8 %189, i8* %190, align 1, !tbaa !1
  %indvars.iv.next644 = add nuw nsw i64 %indvars.iv643, 1
  %exitcond645 = icmp eq i64 %indvars.iv.next644, 10240
  br i1 %exitcond645, label %vector.ph1784, label %185

vector.ph1784:                                    ; preds = %185
  %191 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 16
  call void @llvm.memset.p0i8.i64(i8* %191, i8 -91, i64 16, i32 16, i1 false)
  br label %vector.body1785

vector.body1785:                                  ; preds = %vector.body1785, %vector.ph1784
  %index1788 = phi i64 [ 0, %vector.ph1784 ], [ %index.next1792, %vector.body1785 ]
  %vec.phi1797 = phi <4 x i32> [ zeroinitializer, %vector.ph1784 ], [ %198, %vector.body1785 ]
  %vec.phi1798 = phi <4 x i32> [ zeroinitializer, %vector.ph1784 ], [ %199, %vector.body1785 ]
  %192 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1788
  %193 = bitcast i8* %192 to <4 x i8>*
  %wide.load1799 = load <4 x i8>* %193, align 8
  %.sum2058 = or i64 %index1788, 4
  %194 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2058
  %195 = bitcast i8* %194 to <4 x i8>*
  %wide.load1800 = load <4 x i8>* %195, align 4
  %196 = zext <4 x i8> %wide.load1799 to <4 x i32>
  %197 = zext <4 x i8> %wide.load1800 to <4 x i32>
  %198 = add nsw <4 x i32> %196, %vec.phi1797
  %199 = add nsw <4 x i32> %197, %vec.phi1798
  %index.next1792 = add i64 %index1788, 8
  %200 = icmp eq i64 %index.next1792, 10240
  br i1 %200, label %middle.block1786, label %vector.body1785, !llvm.loop !16

middle.block1786:                                 ; preds = %vector.body1785
  %bin.rdx1803 = add <4 x i32> %199, %198
  %rdx.shuf1804 = shufflevector <4 x i32> %bin.rdx1803, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1805 = add <4 x i32> %bin.rdx1803, %rdx.shuf1804
  %rdx.shuf1806 = shufflevector <4 x i32> %bin.rdx1805, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1807 = add <4 x i32> %bin.rdx1805, %rdx.shuf1806
  %201 = extractelement <4 x i32> %bin.rdx1807, i32 0
  %202 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %201)
  br label %203

; <label>:203                                     ; preds = %203, %middle.block1786
  %indvars.iv636 = phi i64 [ 0, %middle.block1786 ], [ %indvars.iv.next637, %203 ]
  %204 = load volatile i32* %seed, align 4
  %205 = trunc i64 %indvars.iv636 to i32
  %206 = mul nsw i32 %204, %205
  %207 = trunc i32 %206 to i8
  %208 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv636
  store i8 %207, i8* %208, align 1, !tbaa !1
  %indvars.iv.next637 = add nuw nsw i64 %indvars.iv636, 1
  %exitcond638 = icmp eq i64 %indvars.iv.next637, 10240
  br i1 %exitcond638, label %vector.ph1760, label %203

vector.ph1760:                                    ; preds = %203
  %209 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 15
  call void @llvm.memset.p0i8.i64(i8* %209, i8 -91, i64 32, i32 1, i1 false)
  br label %vector.body1761

vector.body1761:                                  ; preds = %vector.body1761, %vector.ph1760
  %index1764 = phi i64 [ 0, %vector.ph1760 ], [ %index.next1768, %vector.body1761 ]
  %vec.phi1773 = phi <4 x i32> [ zeroinitializer, %vector.ph1760 ], [ %216, %vector.body1761 ]
  %vec.phi1774 = phi <4 x i32> [ zeroinitializer, %vector.ph1760 ], [ %217, %vector.body1761 ]
  %210 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1764
  %211 = bitcast i8* %210 to <4 x i8>*
  %wide.load1775 = load <4 x i8>* %211, align 8
  %.sum2059 = or i64 %index1764, 4
  %212 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2059
  %213 = bitcast i8* %212 to <4 x i8>*
  %wide.load1776 = load <4 x i8>* %213, align 4
  %214 = zext <4 x i8> %wide.load1775 to <4 x i32>
  %215 = zext <4 x i8> %wide.load1776 to <4 x i32>
  %216 = add nsw <4 x i32> %214, %vec.phi1773
  %217 = add nsw <4 x i32> %215, %vec.phi1774
  %index.next1768 = add i64 %index1764, 8
  %218 = icmp eq i64 %index.next1768, 10240
  br i1 %218, label %middle.block1762, label %vector.body1761, !llvm.loop !17

middle.block1762:                                 ; preds = %vector.body1761
  %bin.rdx1779 = add <4 x i32> %217, %216
  %rdx.shuf1780 = shufflevector <4 x i32> %bin.rdx1779, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1781 = add <4 x i32> %bin.rdx1779, %rdx.shuf1780
  %rdx.shuf1782 = shufflevector <4 x i32> %bin.rdx1781, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1783 = add <4 x i32> %bin.rdx1781, %rdx.shuf1782
  %219 = extractelement <4 x i32> %bin.rdx1783, i32 0
  %220 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %219)
  br label %221

; <label>:221                                     ; preds = %221, %middle.block1762
  %indvars.iv629 = phi i64 [ 0, %middle.block1762 ], [ %indvars.iv.next630, %221 ]
  %222 = load volatile i32* %seed, align 4
  %223 = trunc i64 %indvars.iv629 to i32
  %224 = mul nsw i32 %222, %223
  %225 = trunc i32 %224 to i8
  %226 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv629
  store i8 %225, i8* %226, align 1, !tbaa !1
  %indvars.iv.next630 = add nuw nsw i64 %indvars.iv629, 1
  %exitcond631 = icmp eq i64 %indvars.iv.next630, 10240
  br i1 %exitcond631, label %vector.ph1736, label %221

vector.ph1736:                                    ; preds = %221
  %227 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 13
  call void @llvm.memset.p0i8.i64(i8* %227, i8 -91, i64 64, i32 1, i1 false)
  br label %vector.body1737

vector.body1737:                                  ; preds = %vector.body1737, %vector.ph1736
  %index1740 = phi i64 [ 0, %vector.ph1736 ], [ %index.next1744, %vector.body1737 ]
  %vec.phi1749 = phi <4 x i32> [ zeroinitializer, %vector.ph1736 ], [ %234, %vector.body1737 ]
  %vec.phi1750 = phi <4 x i32> [ zeroinitializer, %vector.ph1736 ], [ %235, %vector.body1737 ]
  %228 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1740
  %229 = bitcast i8* %228 to <4 x i8>*
  %wide.load1751 = load <4 x i8>* %229, align 8
  %.sum2060 = or i64 %index1740, 4
  %230 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2060
  %231 = bitcast i8* %230 to <4 x i8>*
  %wide.load1752 = load <4 x i8>* %231, align 4
  %232 = zext <4 x i8> %wide.load1751 to <4 x i32>
  %233 = zext <4 x i8> %wide.load1752 to <4 x i32>
  %234 = add nsw <4 x i32> %232, %vec.phi1749
  %235 = add nsw <4 x i32> %233, %vec.phi1750
  %index.next1744 = add i64 %index1740, 8
  %236 = icmp eq i64 %index.next1744, 10240
  br i1 %236, label %middle.block1738, label %vector.body1737, !llvm.loop !18

middle.block1738:                                 ; preds = %vector.body1737
  %bin.rdx1755 = add <4 x i32> %235, %234
  %rdx.shuf1756 = shufflevector <4 x i32> %bin.rdx1755, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1757 = add <4 x i32> %bin.rdx1755, %rdx.shuf1756
  %rdx.shuf1758 = shufflevector <4 x i32> %bin.rdx1757, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1759 = add <4 x i32> %bin.rdx1757, %rdx.shuf1758
  %237 = extractelement <4 x i32> %bin.rdx1759, i32 0
  %238 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %237)
  br label %239

; <label>:239                                     ; preds = %239, %middle.block1738
  %indvars.iv622 = phi i64 [ 0, %middle.block1738 ], [ %indvars.iv.next623, %239 ]
  %240 = load volatile i32* %seed, align 4
  %241 = trunc i64 %indvars.iv622 to i32
  %242 = mul nsw i32 %240, %241
  %243 = trunc i32 %242 to i8
  %244 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv622
  store i8 %243, i8* %244, align 1, !tbaa !1
  %indvars.iv.next623 = add nuw nsw i64 %indvars.iv622, 1
  %exitcond624 = icmp eq i64 %indvars.iv.next623, 10240
  br i1 %exitcond624, label %vector.ph1712, label %239

vector.ph1712:                                    ; preds = %239
  call void @llvm.memset.p0i8.i64(i8* %155, i8 -91, i64 128, i32 1, i1 false)
  br label %vector.body1713

vector.body1713:                                  ; preds = %vector.body1713, %vector.ph1712
  %index1716 = phi i64 [ 0, %vector.ph1712 ], [ %index.next1720, %vector.body1713 ]
  %vec.phi1725 = phi <4 x i32> [ zeroinitializer, %vector.ph1712 ], [ %251, %vector.body1713 ]
  %vec.phi1726 = phi <4 x i32> [ zeroinitializer, %vector.ph1712 ], [ %252, %vector.body1713 ]
  %245 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1716
  %246 = bitcast i8* %245 to <4 x i8>*
  %wide.load1727 = load <4 x i8>* %246, align 8
  %.sum2061 = or i64 %index1716, 4
  %247 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2061
  %248 = bitcast i8* %247 to <4 x i8>*
  %wide.load1728 = load <4 x i8>* %248, align 4
  %249 = zext <4 x i8> %wide.load1727 to <4 x i32>
  %250 = zext <4 x i8> %wide.load1728 to <4 x i32>
  %251 = add nsw <4 x i32> %249, %vec.phi1725
  %252 = add nsw <4 x i32> %250, %vec.phi1726
  %index.next1720 = add i64 %index1716, 8
  %253 = icmp eq i64 %index.next1720, 10240
  br i1 %253, label %middle.block1714, label %vector.body1713, !llvm.loop !19

middle.block1714:                                 ; preds = %vector.body1713
  %bin.rdx1731 = add <4 x i32> %252, %251
  %rdx.shuf1732 = shufflevector <4 x i32> %bin.rdx1731, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1733 = add <4 x i32> %bin.rdx1731, %rdx.shuf1732
  %rdx.shuf1734 = shufflevector <4 x i32> %bin.rdx1733, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1735 = add <4 x i32> %bin.rdx1733, %rdx.shuf1734
  %254 = extractelement <4 x i32> %bin.rdx1735, i32 0
  %255 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %254)
  br label %256

; <label>:256                                     ; preds = %256, %middle.block1714
  %indvars.iv615 = phi i64 [ 0, %middle.block1714 ], [ %indvars.iv.next616, %256 ]
  %257 = load volatile i32* %seed, align 4
  %258 = trunc i64 %indvars.iv615 to i32
  %259 = mul nsw i32 %257, %258
  %260 = trunc i32 %259 to i8
  %261 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv615
  store i8 %260, i8* %261, align 1, !tbaa !1
  %indvars.iv.next616 = add nuw nsw i64 %indvars.iv615, 1
  %exitcond617 = icmp eq i64 %indvars.iv.next616, 10240
  br i1 %exitcond617, label %vector.ph1688, label %256

vector.ph1688:                                    ; preds = %256
  call void @llvm.memset.p0i8.i64(i8* %8, i8 -91, i64 256, i32 1, i1 false)
  br label %vector.body1689

vector.body1689:                                  ; preds = %vector.body1689, %vector.ph1688
  %index1692 = phi i64 [ 0, %vector.ph1688 ], [ %index.next1696, %vector.body1689 ]
  %vec.phi1701 = phi <4 x i32> [ zeroinitializer, %vector.ph1688 ], [ %268, %vector.body1689 ]
  %vec.phi1702 = phi <4 x i32> [ zeroinitializer, %vector.ph1688 ], [ %269, %vector.body1689 ]
  %262 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1692
  %263 = bitcast i8* %262 to <4 x i8>*
  %wide.load1703 = load <4 x i8>* %263, align 8
  %.sum2062 = or i64 %index1692, 4
  %264 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2062
  %265 = bitcast i8* %264 to <4 x i8>*
  %wide.load1704 = load <4 x i8>* %265, align 4
  %266 = zext <4 x i8> %wide.load1703 to <4 x i32>
  %267 = zext <4 x i8> %wide.load1704 to <4 x i32>
  %268 = add nsw <4 x i32> %266, %vec.phi1701
  %269 = add nsw <4 x i32> %267, %vec.phi1702
  %index.next1696 = add i64 %index1692, 8
  %270 = icmp eq i64 %index.next1696, 10240
  br i1 %270, label %middle.block1690, label %vector.body1689, !llvm.loop !20

middle.block1690:                                 ; preds = %vector.body1689
  %bin.rdx1707 = add <4 x i32> %269, %268
  %rdx.shuf1708 = shufflevector <4 x i32> %bin.rdx1707, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1709 = add <4 x i32> %bin.rdx1707, %rdx.shuf1708
  %rdx.shuf1710 = shufflevector <4 x i32> %bin.rdx1709, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1711 = add <4 x i32> %bin.rdx1709, %rdx.shuf1710
  %271 = extractelement <4 x i32> %bin.rdx1711, i32 0
  %272 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %271)
  br label %273

; <label>:273                                     ; preds = %273, %middle.block1690
  %indvars.iv608 = phi i64 [ 0, %middle.block1690 ], [ %indvars.iv.next609, %273 ]
  %274 = load volatile i32* %seed, align 4
  %275 = trunc i64 %indvars.iv608 to i32
  %276 = mul nsw i32 %274, %275
  %277 = trunc i32 %276 to i8
  %278 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv608
  store i8 %277, i8* %278, align 1, !tbaa !1
  %indvars.iv.next609 = add nuw nsw i64 %indvars.iv608, 1
  %exitcond610 = icmp eq i64 %indvars.iv.next609, 10240
  br i1 %exitcond610, label %vector.ph1664, label %273

vector.ph1664:                                    ; preds = %273
  call void @llvm.memset.p0i8.i64(i8* %26, i8 -91, i64 512, i32 2, i1 false)
  br label %vector.body1665

vector.body1665:                                  ; preds = %vector.body1665, %vector.ph1664
  %index1668 = phi i64 [ 0, %vector.ph1664 ], [ %index.next1672, %vector.body1665 ]
  %vec.phi1677 = phi <4 x i32> [ zeroinitializer, %vector.ph1664 ], [ %285, %vector.body1665 ]
  %vec.phi1678 = phi <4 x i32> [ zeroinitializer, %vector.ph1664 ], [ %286, %vector.body1665 ]
  %279 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1668
  %280 = bitcast i8* %279 to <4 x i8>*
  %wide.load1679 = load <4 x i8>* %280, align 8
  %.sum2063 = or i64 %index1668, 4
  %281 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2063
  %282 = bitcast i8* %281 to <4 x i8>*
  %wide.load1680 = load <4 x i8>* %282, align 4
  %283 = zext <4 x i8> %wide.load1679 to <4 x i32>
  %284 = zext <4 x i8> %wide.load1680 to <4 x i32>
  %285 = add nsw <4 x i32> %283, %vec.phi1677
  %286 = add nsw <4 x i32> %284, %vec.phi1678
  %index.next1672 = add i64 %index1668, 8
  %287 = icmp eq i64 %index.next1672, 10240
  br i1 %287, label %middle.block1666, label %vector.body1665, !llvm.loop !21

middle.block1666:                                 ; preds = %vector.body1665
  %bin.rdx1683 = add <4 x i32> %286, %285
  %rdx.shuf1684 = shufflevector <4 x i32> %bin.rdx1683, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1685 = add <4 x i32> %bin.rdx1683, %rdx.shuf1684
  %rdx.shuf1686 = shufflevector <4 x i32> %bin.rdx1685, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1687 = add <4 x i32> %bin.rdx1685, %rdx.shuf1686
  %288 = extractelement <4 x i32> %bin.rdx1687, i32 0
  %289 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %288)
  br label %290

; <label>:290                                     ; preds = %290, %middle.block1666
  %indvars.iv601 = phi i64 [ 0, %middle.block1666 ], [ %indvars.iv.next602, %290 ]
  %291 = load volatile i32* %seed, align 4
  %292 = trunc i64 %indvars.iv601 to i32
  %293 = mul nsw i32 %291, %292
  %294 = trunc i32 %293 to i8
  %295 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv601
  store i8 %294, i8* %295, align 1, !tbaa !1
  %indvars.iv.next602 = add nuw nsw i64 %indvars.iv601, 1
  %exitcond603 = icmp eq i64 %indvars.iv.next602, 10240
  br i1 %exitcond603, label %vector.ph1640, label %290

vector.ph1640:                                    ; preds = %290
  call void @llvm.memset.p0i8.i64(i8* %63, i8 -91, i64 1024, i32 4, i1 false)
  br label %vector.body1641

vector.body1641:                                  ; preds = %vector.body1641, %vector.ph1640
  %index1644 = phi i64 [ 0, %vector.ph1640 ], [ %index.next1648, %vector.body1641 ]
  %vec.phi1653 = phi <4 x i32> [ zeroinitializer, %vector.ph1640 ], [ %302, %vector.body1641 ]
  %vec.phi1654 = phi <4 x i32> [ zeroinitializer, %vector.ph1640 ], [ %303, %vector.body1641 ]
  %296 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1644
  %297 = bitcast i8* %296 to <4 x i8>*
  %wide.load1655 = load <4 x i8>* %297, align 8
  %.sum2064 = or i64 %index1644, 4
  %298 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2064
  %299 = bitcast i8* %298 to <4 x i8>*
  %wide.load1656 = load <4 x i8>* %299, align 4
  %300 = zext <4 x i8> %wide.load1655 to <4 x i32>
  %301 = zext <4 x i8> %wide.load1656 to <4 x i32>
  %302 = add nsw <4 x i32> %300, %vec.phi1653
  %303 = add nsw <4 x i32> %301, %vec.phi1654
  %index.next1648 = add i64 %index1644, 8
  %304 = icmp eq i64 %index.next1648, 10240
  br i1 %304, label %middle.block1642, label %vector.body1641, !llvm.loop !22

middle.block1642:                                 ; preds = %vector.body1641
  %bin.rdx1659 = add <4 x i32> %303, %302
  %rdx.shuf1660 = shufflevector <4 x i32> %bin.rdx1659, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1661 = add <4 x i32> %bin.rdx1659, %rdx.shuf1660
  %rdx.shuf1662 = shufflevector <4 x i32> %bin.rdx1661, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1663 = add <4 x i32> %bin.rdx1661, %rdx.shuf1662
  %305 = extractelement <4 x i32> %bin.rdx1663, i32 0
  %306 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %305)
  br label %.preheader280

.preheader280:                                    ; preds = %middle.block1618, %middle.block1642
  %indvars.iv595 = phi i64 [ 10, %middle.block1642 ], [ %indvars.iv.next596, %middle.block1618 ]
  br label %307

; <label>:307                                     ; preds = %307, %.preheader280
  %indvars.iv588 = phi i64 [ 0, %.preheader280 ], [ %indvars.iv.next589, %307 ]
  %308 = load volatile i32* %seed, align 4
  %309 = trunc i64 %indvars.iv588 to i32
  %310 = mul nsw i32 %308, %309
  %311 = trunc i32 %310 to i8
  %312 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv588
  store i8 %311, i8* %312, align 1, !tbaa !1
  %indvars.iv.next589 = add nuw nsw i64 %indvars.iv588, 1
  %exitcond590 = icmp eq i64 %indvars.iv.next589, 10240
  br i1 %exitcond590, label %vector.ph1616, label %307

vector.ph1616:                                    ; preds = %307
  %313 = trunc i64 %indvars.iv595 to i32
  %314 = srem i32 %313, 17
  %315 = sext i32 %314 to i64
  %316 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %315
  call void @llvm.memset.p0i8.i64(i8* %316, i8 -91, i64 %indvars.iv595, i32 1, i1 false)
  br label %vector.body1617

vector.body1617:                                  ; preds = %vector.body1617, %vector.ph1616
  %index1620 = phi i64 [ 0, %vector.ph1616 ], [ %index.next1624, %vector.body1617 ]
  %vec.phi1629 = phi <4 x i32> [ zeroinitializer, %vector.ph1616 ], [ %323, %vector.body1617 ]
  %vec.phi1630 = phi <4 x i32> [ zeroinitializer, %vector.ph1616 ], [ %324, %vector.body1617 ]
  %317 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %index1620
  %318 = bitcast i8* %317 to <4 x i8>*
  %wide.load1631 = load <4 x i8>* %318, align 8
  %.sum2065 = or i64 %index1620, 4
  %319 = getelementptr [10240 x i8]* %buffer, i64 0, i64 %.sum2065
  %320 = bitcast i8* %319 to <4 x i8>*
  %wide.load1632 = load <4 x i8>* %320, align 4
  %321 = zext <4 x i8> %wide.load1631 to <4 x i32>
  %322 = zext <4 x i8> %wide.load1632 to <4 x i32>
  %323 = add nsw <4 x i32> %321, %vec.phi1629
  %324 = add nsw <4 x i32> %322, %vec.phi1630
  %index.next1624 = add i64 %index1620, 8
  %325 = icmp eq i64 %index.next1624, 10240
  br i1 %325, label %middle.block1618, label %vector.body1617, !llvm.loop !23

middle.block1618:                                 ; preds = %vector.body1617
  %bin.rdx1635 = add <4 x i32> %324, %323
  %rdx.shuf1636 = shufflevector <4 x i32> %bin.rdx1635, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1637 = add <4 x i32> %bin.rdx1635, %rdx.shuf1636
  %rdx.shuf1638 = shufflevector <4 x i32> %bin.rdx1637, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1639 = add <4 x i32> %bin.rdx1637, %rdx.shuf1638
  %326 = extractelement <4 x i32> %bin.rdx1639, i32 0
  %327 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %313, i32 %326)
  %indvars.iv.next596 = add nuw nsw i64 %indvars.iv595, 10
  %328 = trunc i64 %indvars.iv.next596 to i32
  %329 = icmp slt i32 %328, 100
  br i1 %329, label %.preheader280, label %330

; <label>:330                                     ; preds = %middle.block1618
  call void @llvm.lifetime.end(i64 10240, i8* %1) #2
  %puts167 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str4, i64 0, i64 0))
  %331 = bitcast [10240 x i16]* %buffer53 to i8*
  call void @llvm.lifetime.start(i64 20480, i8* %331) #2
  store volatile i32 123, i32* %seed54, align 4
  br label %332

; <label>:332                                     ; preds = %332, %330
  %indvars.iv585 = phi i64 [ 0, %330 ], [ %indvars.iv.next586, %332 ]
  %333 = load volatile i32* %seed54, align 4
  %334 = trunc i64 %indvars.iv585 to i32
  %335 = mul nsw i32 %333, %334
  %336 = trunc i32 %335 to i16
  %337 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv585
  store i16 %336, i16* %337, align 2, !tbaa !24
  %indvars.iv.next586 = add nuw nsw i64 %indvars.iv585, 1
  %exitcond587 = icmp eq i64 %indvars.iv.next586, 10240
  br i1 %exitcond587, label %vector.ph1592, label %332

vector.ph1592:                                    ; preds = %332
  %338 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 1
  %339 = bitcast i16* %338 to i8*
  store i8 -91, i8* %339, align 2
  br label %vector.body1593

vector.body1593:                                  ; preds = %vector.body1593, %vector.ph1592
  %index1596 = phi i64 [ 0, %vector.ph1592 ], [ %index.next1600, %vector.body1593 ]
  %vec.phi1605 = phi <4 x i32> [ zeroinitializer, %vector.ph1592 ], [ %346, %vector.body1593 ]
  %vec.phi1606 = phi <4 x i32> [ zeroinitializer, %vector.ph1592 ], [ %347, %vector.body1593 ]
  %340 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1596
  %341 = bitcast i16* %340 to <4 x i16>*
  %wide.load1607 = load <4 x i16>* %341, align 16
  %.sum2066 = or i64 %index1596, 4
  %342 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2066
  %343 = bitcast i16* %342 to <4 x i16>*
  %wide.load1608 = load <4 x i16>* %343, align 8
  %344 = zext <4 x i16> %wide.load1607 to <4 x i32>
  %345 = zext <4 x i16> %wide.load1608 to <4 x i32>
  %346 = add nsw <4 x i32> %344, %vec.phi1605
  %347 = add nsw <4 x i32> %345, %vec.phi1606
  %index.next1600 = add i64 %index1596, 8
  %348 = icmp eq i64 %index.next1600, 10240
  br i1 %348, label %middle.block1594, label %vector.body1593, !llvm.loop !26

middle.block1594:                                 ; preds = %vector.body1593
  %bin.rdx1611 = add <4 x i32> %347, %346
  %rdx.shuf1612 = shufflevector <4 x i32> %bin.rdx1611, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1613 = add <4 x i32> %bin.rdx1611, %rdx.shuf1612
  %rdx.shuf1614 = shufflevector <4 x i32> %bin.rdx1613, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1615 = add <4 x i32> %bin.rdx1613, %rdx.shuf1614
  %349 = extractelement <4 x i32> %bin.rdx1615, i32 0
  %350 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %349)
  br label %351

; <label>:351                                     ; preds = %351, %middle.block1594
  %indvars.iv578 = phi i64 [ 0, %middle.block1594 ], [ %indvars.iv.next579, %351 ]
  %352 = load volatile i32* %seed54, align 4
  %353 = trunc i64 %indvars.iv578 to i32
  %354 = mul nsw i32 %352, %353
  %355 = trunc i32 %354 to i16
  %356 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv578
  store i16 %355, i16* %356, align 2, !tbaa !24
  %indvars.iv.next579 = add nuw nsw i64 %indvars.iv578, 1
  %exitcond580 = icmp eq i64 %indvars.iv.next579, 10240
  br i1 %exitcond580, label %vector.ph1568, label %351

vector.ph1568:                                    ; preds = %351
  %357 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 2
  store i16 -23131, i16* %357, align 4
  br label %vector.body1569

vector.body1569:                                  ; preds = %vector.body1569, %vector.ph1568
  %index1572 = phi i64 [ 0, %vector.ph1568 ], [ %index.next1576, %vector.body1569 ]
  %vec.phi1581 = phi <4 x i32> [ zeroinitializer, %vector.ph1568 ], [ %364, %vector.body1569 ]
  %vec.phi1582 = phi <4 x i32> [ zeroinitializer, %vector.ph1568 ], [ %365, %vector.body1569 ]
  %358 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1572
  %359 = bitcast i16* %358 to <4 x i16>*
  %wide.load1583 = load <4 x i16>* %359, align 16
  %.sum2067 = or i64 %index1572, 4
  %360 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2067
  %361 = bitcast i16* %360 to <4 x i16>*
  %wide.load1584 = load <4 x i16>* %361, align 8
  %362 = zext <4 x i16> %wide.load1583 to <4 x i32>
  %363 = zext <4 x i16> %wide.load1584 to <4 x i32>
  %364 = add nsw <4 x i32> %362, %vec.phi1581
  %365 = add nsw <4 x i32> %363, %vec.phi1582
  %index.next1576 = add i64 %index1572, 8
  %366 = icmp eq i64 %index.next1576, 10240
  br i1 %366, label %middle.block1570, label %vector.body1569, !llvm.loop !27

middle.block1570:                                 ; preds = %vector.body1569
  %bin.rdx1587 = add <4 x i32> %365, %364
  %rdx.shuf1588 = shufflevector <4 x i32> %bin.rdx1587, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1589 = add <4 x i32> %bin.rdx1587, %rdx.shuf1588
  %rdx.shuf1590 = shufflevector <4 x i32> %bin.rdx1589, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1591 = add <4 x i32> %bin.rdx1589, %rdx.shuf1590
  %367 = extractelement <4 x i32> %bin.rdx1591, i32 0
  %368 = bitcast i16* %357 to i8*
  %369 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %367)
  br label %370

; <label>:370                                     ; preds = %370, %middle.block1570
  %indvars.iv571 = phi i64 [ 0, %middle.block1570 ], [ %indvars.iv.next572, %370 ]
  %371 = load volatile i32* %seed54, align 4
  %372 = trunc i64 %indvars.iv571 to i32
  %373 = mul nsw i32 %371, %372
  %374 = trunc i32 %373 to i16
  %375 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv571
  store i16 %374, i16* %375, align 2, !tbaa !24
  %indvars.iv.next572 = add nuw nsw i64 %indvars.iv571, 1
  %exitcond573 = icmp eq i64 %indvars.iv.next572, 10240
  br i1 %exitcond573, label %vector.ph1544, label %370

vector.ph1544:                                    ; preds = %370
  %376 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 3
  %377 = bitcast i16* %376 to i8*
  call void @llvm.memset.p0i8.i64(i8* %377, i8 -91, i64 3, i32 2, i1 false)
  br label %vector.body1545

vector.body1545:                                  ; preds = %vector.body1545, %vector.ph1544
  %index1548 = phi i64 [ 0, %vector.ph1544 ], [ %index.next1552, %vector.body1545 ]
  %vec.phi1557 = phi <4 x i32> [ zeroinitializer, %vector.ph1544 ], [ %384, %vector.body1545 ]
  %vec.phi1558 = phi <4 x i32> [ zeroinitializer, %vector.ph1544 ], [ %385, %vector.body1545 ]
  %378 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1548
  %379 = bitcast i16* %378 to <4 x i16>*
  %wide.load1559 = load <4 x i16>* %379, align 16
  %.sum2068 = or i64 %index1548, 4
  %380 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2068
  %381 = bitcast i16* %380 to <4 x i16>*
  %wide.load1560 = load <4 x i16>* %381, align 8
  %382 = zext <4 x i16> %wide.load1559 to <4 x i32>
  %383 = zext <4 x i16> %wide.load1560 to <4 x i32>
  %384 = add nsw <4 x i32> %382, %vec.phi1557
  %385 = add nsw <4 x i32> %383, %vec.phi1558
  %index.next1552 = add i64 %index1548, 8
  %386 = icmp eq i64 %index.next1552, 10240
  br i1 %386, label %middle.block1546, label %vector.body1545, !llvm.loop !28

middle.block1546:                                 ; preds = %vector.body1545
  %bin.rdx1563 = add <4 x i32> %385, %384
  %rdx.shuf1564 = shufflevector <4 x i32> %bin.rdx1563, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1565 = add <4 x i32> %bin.rdx1563, %rdx.shuf1564
  %rdx.shuf1566 = shufflevector <4 x i32> %bin.rdx1565, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1567 = add <4 x i32> %bin.rdx1565, %rdx.shuf1566
  %387 = extractelement <4 x i32> %bin.rdx1567, i32 0
  %388 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %387)
  br label %389

; <label>:389                                     ; preds = %389, %middle.block1546
  %indvars.iv564 = phi i64 [ 0, %middle.block1546 ], [ %indvars.iv.next565, %389 ]
  %390 = load volatile i32* %seed54, align 4
  %391 = trunc i64 %indvars.iv564 to i32
  %392 = mul nsw i32 %390, %391
  %393 = trunc i32 %392 to i16
  %394 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv564
  store i16 %393, i16* %394, align 2, !tbaa !24
  %indvars.iv.next565 = add nuw nsw i64 %indvars.iv564, 1
  %exitcond566 = icmp eq i64 %indvars.iv.next565, 10240
  br i1 %exitcond566, label %vector.ph1520, label %389

vector.ph1520:                                    ; preds = %389
  %395 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 4
  %396 = bitcast i16* %395 to i32*
  store i32 -1515870811, i32* %396, align 8
  br label %vector.body1521

vector.body1521:                                  ; preds = %vector.body1521, %vector.ph1520
  %index1524 = phi i64 [ 0, %vector.ph1520 ], [ %index.next1528, %vector.body1521 ]
  %vec.phi1533 = phi <4 x i32> [ zeroinitializer, %vector.ph1520 ], [ %403, %vector.body1521 ]
  %vec.phi1534 = phi <4 x i32> [ zeroinitializer, %vector.ph1520 ], [ %404, %vector.body1521 ]
  %397 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1524
  %398 = bitcast i16* %397 to <4 x i16>*
  %wide.load1535 = load <4 x i16>* %398, align 16
  %.sum2069 = or i64 %index1524, 4
  %399 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2069
  %400 = bitcast i16* %399 to <4 x i16>*
  %wide.load1536 = load <4 x i16>* %400, align 8
  %401 = zext <4 x i16> %wide.load1535 to <4 x i32>
  %402 = zext <4 x i16> %wide.load1536 to <4 x i32>
  %403 = add nsw <4 x i32> %401, %vec.phi1533
  %404 = add nsw <4 x i32> %402, %vec.phi1534
  %index.next1528 = add i64 %index1524, 8
  %405 = icmp eq i64 %index.next1528, 10240
  br i1 %405, label %middle.block1522, label %vector.body1521, !llvm.loop !29

middle.block1522:                                 ; preds = %vector.body1521
  %bin.rdx1539 = add <4 x i32> %404, %403
  %rdx.shuf1540 = shufflevector <4 x i32> %bin.rdx1539, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1541 = add <4 x i32> %bin.rdx1539, %rdx.shuf1540
  %rdx.shuf1542 = shufflevector <4 x i32> %bin.rdx1541, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1543 = add <4 x i32> %bin.rdx1541, %rdx.shuf1542
  %406 = extractelement <4 x i32> %bin.rdx1543, i32 0
  %407 = bitcast i16* %395 to i8*
  %408 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %406)
  br label %409

; <label>:409                                     ; preds = %409, %middle.block1522
  %indvars.iv557 = phi i64 [ 0, %middle.block1522 ], [ %indvars.iv.next558, %409 ]
  %410 = load volatile i32* %seed54, align 4
  %411 = trunc i64 %indvars.iv557 to i32
  %412 = mul nsw i32 %410, %411
  %413 = trunc i32 %412 to i16
  %414 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv557
  store i16 %413, i16* %414, align 2, !tbaa !24
  %indvars.iv.next558 = add nuw nsw i64 %indvars.iv557, 1
  %exitcond559 = icmp eq i64 %indvars.iv.next558, 10240
  br i1 %exitcond559, label %vector.ph1496, label %409

vector.ph1496:                                    ; preds = %409
  %415 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 5
  %416 = bitcast i16* %415 to i8*
  call void @llvm.memset.p0i8.i64(i8* %416, i8 -91, i64 5, i32 2, i1 false)
  br label %vector.body1497

vector.body1497:                                  ; preds = %vector.body1497, %vector.ph1496
  %index1500 = phi i64 [ 0, %vector.ph1496 ], [ %index.next1504, %vector.body1497 ]
  %vec.phi1509 = phi <4 x i32> [ zeroinitializer, %vector.ph1496 ], [ %423, %vector.body1497 ]
  %vec.phi1510 = phi <4 x i32> [ zeroinitializer, %vector.ph1496 ], [ %424, %vector.body1497 ]
  %417 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1500
  %418 = bitcast i16* %417 to <4 x i16>*
  %wide.load1511 = load <4 x i16>* %418, align 16
  %.sum2070 = or i64 %index1500, 4
  %419 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2070
  %420 = bitcast i16* %419 to <4 x i16>*
  %wide.load1512 = load <4 x i16>* %420, align 8
  %421 = zext <4 x i16> %wide.load1511 to <4 x i32>
  %422 = zext <4 x i16> %wide.load1512 to <4 x i32>
  %423 = add nsw <4 x i32> %421, %vec.phi1509
  %424 = add nsw <4 x i32> %422, %vec.phi1510
  %index.next1504 = add i64 %index1500, 8
  %425 = icmp eq i64 %index.next1504, 10240
  br i1 %425, label %middle.block1498, label %vector.body1497, !llvm.loop !30

middle.block1498:                                 ; preds = %vector.body1497
  %bin.rdx1515 = add <4 x i32> %424, %423
  %rdx.shuf1516 = shufflevector <4 x i32> %bin.rdx1515, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1517 = add <4 x i32> %bin.rdx1515, %rdx.shuf1516
  %rdx.shuf1518 = shufflevector <4 x i32> %bin.rdx1517, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1519 = add <4 x i32> %bin.rdx1517, %rdx.shuf1518
  %426 = extractelement <4 x i32> %bin.rdx1519, i32 0
  %427 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %426)
  br label %428

; <label>:428                                     ; preds = %428, %middle.block1498
  %indvars.iv550 = phi i64 [ 0, %middle.block1498 ], [ %indvars.iv.next551, %428 ]
  %429 = load volatile i32* %seed54, align 4
  %430 = trunc i64 %indvars.iv550 to i32
  %431 = mul nsw i32 %429, %430
  %432 = trunc i32 %431 to i16
  %433 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv550
  store i16 %432, i16* %433, align 2, !tbaa !24
  %indvars.iv.next551 = add nuw nsw i64 %indvars.iv550, 1
  %exitcond552 = icmp eq i64 %indvars.iv.next551, 10240
  br i1 %exitcond552, label %vector.ph1472, label %428

vector.ph1472:                                    ; preds = %428
  %434 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 6
  %435 = bitcast i16* %434 to i8*
  call void @llvm.memset.p0i8.i64(i8* %435, i8 -91, i64 6, i32 4, i1 false)
  br label %vector.body1473

vector.body1473:                                  ; preds = %vector.body1473, %vector.ph1472
  %index1476 = phi i64 [ 0, %vector.ph1472 ], [ %index.next1480, %vector.body1473 ]
  %vec.phi1485 = phi <4 x i32> [ zeroinitializer, %vector.ph1472 ], [ %442, %vector.body1473 ]
  %vec.phi1486 = phi <4 x i32> [ zeroinitializer, %vector.ph1472 ], [ %443, %vector.body1473 ]
  %436 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1476
  %437 = bitcast i16* %436 to <4 x i16>*
  %wide.load1487 = load <4 x i16>* %437, align 16
  %.sum2071 = or i64 %index1476, 4
  %438 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2071
  %439 = bitcast i16* %438 to <4 x i16>*
  %wide.load1488 = load <4 x i16>* %439, align 8
  %440 = zext <4 x i16> %wide.load1487 to <4 x i32>
  %441 = zext <4 x i16> %wide.load1488 to <4 x i32>
  %442 = add nsw <4 x i32> %440, %vec.phi1485
  %443 = add nsw <4 x i32> %441, %vec.phi1486
  %index.next1480 = add i64 %index1476, 8
  %444 = icmp eq i64 %index.next1480, 10240
  br i1 %444, label %middle.block1474, label %vector.body1473, !llvm.loop !31

middle.block1474:                                 ; preds = %vector.body1473
  %bin.rdx1491 = add <4 x i32> %443, %442
  %rdx.shuf1492 = shufflevector <4 x i32> %bin.rdx1491, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1493 = add <4 x i32> %bin.rdx1491, %rdx.shuf1492
  %rdx.shuf1494 = shufflevector <4 x i32> %bin.rdx1493, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1495 = add <4 x i32> %bin.rdx1493, %rdx.shuf1494
  %445 = extractelement <4 x i32> %bin.rdx1495, i32 0
  %446 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %445)
  br label %447

; <label>:447                                     ; preds = %447, %middle.block1474
  %indvars.iv543 = phi i64 [ 0, %middle.block1474 ], [ %indvars.iv.next544, %447 ]
  %448 = load volatile i32* %seed54, align 4
  %449 = trunc i64 %indvars.iv543 to i32
  %450 = mul nsw i32 %448, %449
  %451 = trunc i32 %450 to i16
  %452 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv543
  store i16 %451, i16* %452, align 2, !tbaa !24
  %indvars.iv.next544 = add nuw nsw i64 %indvars.iv543, 1
  %exitcond545 = icmp eq i64 %indvars.iv.next544, 10240
  br i1 %exitcond545, label %vector.ph1448, label %447

vector.ph1448:                                    ; preds = %447
  %453 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 7
  %454 = bitcast i16* %453 to i8*
  call void @llvm.memset.p0i8.i64(i8* %454, i8 -91, i64 7, i32 2, i1 false)
  br label %vector.body1449

vector.body1449:                                  ; preds = %vector.body1449, %vector.ph1448
  %index1452 = phi i64 [ 0, %vector.ph1448 ], [ %index.next1456, %vector.body1449 ]
  %vec.phi1461 = phi <4 x i32> [ zeroinitializer, %vector.ph1448 ], [ %461, %vector.body1449 ]
  %vec.phi1462 = phi <4 x i32> [ zeroinitializer, %vector.ph1448 ], [ %462, %vector.body1449 ]
  %455 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1452
  %456 = bitcast i16* %455 to <4 x i16>*
  %wide.load1463 = load <4 x i16>* %456, align 16
  %.sum2072 = or i64 %index1452, 4
  %457 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2072
  %458 = bitcast i16* %457 to <4 x i16>*
  %wide.load1464 = load <4 x i16>* %458, align 8
  %459 = zext <4 x i16> %wide.load1463 to <4 x i32>
  %460 = zext <4 x i16> %wide.load1464 to <4 x i32>
  %461 = add nsw <4 x i32> %459, %vec.phi1461
  %462 = add nsw <4 x i32> %460, %vec.phi1462
  %index.next1456 = add i64 %index1452, 8
  %463 = icmp eq i64 %index.next1456, 10240
  br i1 %463, label %middle.block1450, label %vector.body1449, !llvm.loop !32

middle.block1450:                                 ; preds = %vector.body1449
  %bin.rdx1467 = add <4 x i32> %462, %461
  %rdx.shuf1468 = shufflevector <4 x i32> %bin.rdx1467, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1469 = add <4 x i32> %bin.rdx1467, %rdx.shuf1468
  %rdx.shuf1470 = shufflevector <4 x i32> %bin.rdx1469, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1471 = add <4 x i32> %bin.rdx1469, %rdx.shuf1470
  %464 = extractelement <4 x i32> %bin.rdx1471, i32 0
  %465 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %464)
  br label %466

; <label>:466                                     ; preds = %466, %middle.block1450
  %indvars.iv536 = phi i64 [ 0, %middle.block1450 ], [ %indvars.iv.next537, %466 ]
  %467 = load volatile i32* %seed54, align 4
  %468 = trunc i64 %indvars.iv536 to i32
  %469 = mul nsw i32 %467, %468
  %470 = trunc i32 %469 to i16
  %471 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv536
  store i16 %470, i16* %471, align 2, !tbaa !24
  %indvars.iv.next537 = add nuw nsw i64 %indvars.iv536, 1
  %exitcond538 = icmp eq i64 %indvars.iv.next537, 10240
  br i1 %exitcond538, label %vector.ph1424, label %466

vector.ph1424:                                    ; preds = %466
  %472 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 8
  %473 = bitcast i16* %472 to i64*
  store i64 -6510615555426900571, i64* %473, align 16
  br label %vector.body1425

vector.body1425:                                  ; preds = %vector.body1425, %vector.ph1424
  %index1428 = phi i64 [ 0, %vector.ph1424 ], [ %index.next1432, %vector.body1425 ]
  %vec.phi1437 = phi <4 x i32> [ zeroinitializer, %vector.ph1424 ], [ %480, %vector.body1425 ]
  %vec.phi1438 = phi <4 x i32> [ zeroinitializer, %vector.ph1424 ], [ %481, %vector.body1425 ]
  %474 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1428
  %475 = bitcast i16* %474 to <4 x i16>*
  %wide.load1439 = load <4 x i16>* %475, align 16
  %.sum2073 = or i64 %index1428, 4
  %476 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2073
  %477 = bitcast i16* %476 to <4 x i16>*
  %wide.load1440 = load <4 x i16>* %477, align 8
  %478 = zext <4 x i16> %wide.load1439 to <4 x i32>
  %479 = zext <4 x i16> %wide.load1440 to <4 x i32>
  %480 = add nsw <4 x i32> %478, %vec.phi1437
  %481 = add nsw <4 x i32> %479, %vec.phi1438
  %index.next1432 = add i64 %index1428, 8
  %482 = icmp eq i64 %index.next1432, 10240
  br i1 %482, label %middle.block1426, label %vector.body1425, !llvm.loop !33

middle.block1426:                                 ; preds = %vector.body1425
  %bin.rdx1443 = add <4 x i32> %481, %480
  %rdx.shuf1444 = shufflevector <4 x i32> %bin.rdx1443, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1445 = add <4 x i32> %bin.rdx1443, %rdx.shuf1444
  %rdx.shuf1446 = shufflevector <4 x i32> %bin.rdx1445, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1447 = add <4 x i32> %bin.rdx1445, %rdx.shuf1446
  %483 = extractelement <4 x i32> %bin.rdx1447, i32 0
  %484 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %483)
  br label %485

; <label>:485                                     ; preds = %485, %middle.block1426
  %indvars.iv529 = phi i64 [ 0, %middle.block1426 ], [ %indvars.iv.next530, %485 ]
  %486 = load volatile i32* %seed54, align 4
  %487 = trunc i64 %indvars.iv529 to i32
  %488 = mul nsw i32 %486, %487
  %489 = trunc i32 %488 to i16
  %490 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv529
  store i16 %489, i16* %490, align 2, !tbaa !24
  %indvars.iv.next530 = add nuw nsw i64 %indvars.iv529, 1
  %exitcond531 = icmp eq i64 %indvars.iv.next530, 10240
  br i1 %exitcond531, label %vector.ph1400, label %485

vector.ph1400:                                    ; preds = %485
  %491 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 9
  %492 = bitcast i16* %491 to i8*
  call void @llvm.memset.p0i8.i64(i8* %492, i8 -91, i64 9, i32 2, i1 false)
  br label %vector.body1401

vector.body1401:                                  ; preds = %vector.body1401, %vector.ph1400
  %index1404 = phi i64 [ 0, %vector.ph1400 ], [ %index.next1408, %vector.body1401 ]
  %vec.phi1413 = phi <4 x i32> [ zeroinitializer, %vector.ph1400 ], [ %499, %vector.body1401 ]
  %vec.phi1414 = phi <4 x i32> [ zeroinitializer, %vector.ph1400 ], [ %500, %vector.body1401 ]
  %493 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1404
  %494 = bitcast i16* %493 to <4 x i16>*
  %wide.load1415 = load <4 x i16>* %494, align 16
  %.sum2074 = or i64 %index1404, 4
  %495 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2074
  %496 = bitcast i16* %495 to <4 x i16>*
  %wide.load1416 = load <4 x i16>* %496, align 8
  %497 = zext <4 x i16> %wide.load1415 to <4 x i32>
  %498 = zext <4 x i16> %wide.load1416 to <4 x i32>
  %499 = add nsw <4 x i32> %497, %vec.phi1413
  %500 = add nsw <4 x i32> %498, %vec.phi1414
  %index.next1408 = add i64 %index1404, 8
  %501 = icmp eq i64 %index.next1408, 10240
  br i1 %501, label %middle.block1402, label %vector.body1401, !llvm.loop !34

middle.block1402:                                 ; preds = %vector.body1401
  %bin.rdx1419 = add <4 x i32> %500, %499
  %rdx.shuf1420 = shufflevector <4 x i32> %bin.rdx1419, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1421 = add <4 x i32> %bin.rdx1419, %rdx.shuf1420
  %rdx.shuf1422 = shufflevector <4 x i32> %bin.rdx1421, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1423 = add <4 x i32> %bin.rdx1421, %rdx.shuf1422
  %502 = extractelement <4 x i32> %bin.rdx1423, i32 0
  %503 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %502)
  br label %504

; <label>:504                                     ; preds = %504, %middle.block1402
  %indvars.iv522 = phi i64 [ 0, %middle.block1402 ], [ %indvars.iv.next523, %504 ]
  %505 = load volatile i32* %seed54, align 4
  %506 = trunc i64 %indvars.iv522 to i32
  %507 = mul nsw i32 %505, %506
  %508 = trunc i32 %507 to i16
  %509 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv522
  store i16 %508, i16* %509, align 2, !tbaa !24
  %indvars.iv.next523 = add nuw nsw i64 %indvars.iv522, 1
  %exitcond524 = icmp eq i64 %indvars.iv.next523, 10240
  br i1 %exitcond524, label %vector.ph1376, label %504

vector.ph1376:                                    ; preds = %504
  %510 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 10
  %511 = bitcast i16* %510 to i8*
  call void @llvm.memset.p0i8.i64(i8* %511, i8 -91, i64 10, i32 4, i1 false)
  br label %vector.body1377

vector.body1377:                                  ; preds = %vector.body1377, %vector.ph1376
  %index1380 = phi i64 [ 0, %vector.ph1376 ], [ %index.next1384, %vector.body1377 ]
  %vec.phi1389 = phi <4 x i32> [ zeroinitializer, %vector.ph1376 ], [ %518, %vector.body1377 ]
  %vec.phi1390 = phi <4 x i32> [ zeroinitializer, %vector.ph1376 ], [ %519, %vector.body1377 ]
  %512 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1380
  %513 = bitcast i16* %512 to <4 x i16>*
  %wide.load1391 = load <4 x i16>* %513, align 16
  %.sum2075 = or i64 %index1380, 4
  %514 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2075
  %515 = bitcast i16* %514 to <4 x i16>*
  %wide.load1392 = load <4 x i16>* %515, align 8
  %516 = zext <4 x i16> %wide.load1391 to <4 x i32>
  %517 = zext <4 x i16> %wide.load1392 to <4 x i32>
  %518 = add nsw <4 x i32> %516, %vec.phi1389
  %519 = add nsw <4 x i32> %517, %vec.phi1390
  %index.next1384 = add i64 %index1380, 8
  %520 = icmp eq i64 %index.next1384, 10240
  br i1 %520, label %middle.block1378, label %vector.body1377, !llvm.loop !35

middle.block1378:                                 ; preds = %vector.body1377
  %bin.rdx1395 = add <4 x i32> %519, %518
  %rdx.shuf1396 = shufflevector <4 x i32> %bin.rdx1395, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1397 = add <4 x i32> %bin.rdx1395, %rdx.shuf1396
  %rdx.shuf1398 = shufflevector <4 x i32> %bin.rdx1397, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1399 = add <4 x i32> %bin.rdx1397, %rdx.shuf1398
  %521 = extractelement <4 x i32> %bin.rdx1399, i32 0
  %522 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %521)
  br label %523

; <label>:523                                     ; preds = %523, %middle.block1378
  %indvars.iv515 = phi i64 [ 0, %middle.block1378 ], [ %indvars.iv.next516, %523 ]
  %524 = load volatile i32* %seed54, align 4
  %525 = trunc i64 %indvars.iv515 to i32
  %526 = mul nsw i32 %524, %525
  %527 = trunc i32 %526 to i16
  %528 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv515
  store i16 %527, i16* %528, align 2, !tbaa !24
  %indvars.iv.next516 = add nuw nsw i64 %indvars.iv515, 1
  %exitcond517 = icmp eq i64 %indvars.iv.next516, 10240
  br i1 %exitcond517, label %vector.ph1352, label %523

vector.ph1352:                                    ; preds = %523
  %529 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 16
  %530 = bitcast i16* %529 to i8*
  call void @llvm.memset.p0i8.i64(i8* %530, i8 -91, i64 16, i32 16, i1 false)
  br label %vector.body1353

vector.body1353:                                  ; preds = %vector.body1353, %vector.ph1352
  %index1356 = phi i64 [ 0, %vector.ph1352 ], [ %index.next1360, %vector.body1353 ]
  %vec.phi1365 = phi <4 x i32> [ zeroinitializer, %vector.ph1352 ], [ %537, %vector.body1353 ]
  %vec.phi1366 = phi <4 x i32> [ zeroinitializer, %vector.ph1352 ], [ %538, %vector.body1353 ]
  %531 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1356
  %532 = bitcast i16* %531 to <4 x i16>*
  %wide.load1367 = load <4 x i16>* %532, align 16
  %.sum2076 = or i64 %index1356, 4
  %533 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2076
  %534 = bitcast i16* %533 to <4 x i16>*
  %wide.load1368 = load <4 x i16>* %534, align 8
  %535 = zext <4 x i16> %wide.load1367 to <4 x i32>
  %536 = zext <4 x i16> %wide.load1368 to <4 x i32>
  %537 = add nsw <4 x i32> %535, %vec.phi1365
  %538 = add nsw <4 x i32> %536, %vec.phi1366
  %index.next1360 = add i64 %index1356, 8
  %539 = icmp eq i64 %index.next1360, 10240
  br i1 %539, label %middle.block1354, label %vector.body1353, !llvm.loop !36

middle.block1354:                                 ; preds = %vector.body1353
  %bin.rdx1371 = add <4 x i32> %538, %537
  %rdx.shuf1372 = shufflevector <4 x i32> %bin.rdx1371, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1373 = add <4 x i32> %bin.rdx1371, %rdx.shuf1372
  %rdx.shuf1374 = shufflevector <4 x i32> %bin.rdx1373, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1375 = add <4 x i32> %bin.rdx1373, %rdx.shuf1374
  %540 = extractelement <4 x i32> %bin.rdx1375, i32 0
  %541 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %540)
  br label %542

; <label>:542                                     ; preds = %542, %middle.block1354
  %indvars.iv508 = phi i64 [ 0, %middle.block1354 ], [ %indvars.iv.next509, %542 ]
  %543 = load volatile i32* %seed54, align 4
  %544 = trunc i64 %indvars.iv508 to i32
  %545 = mul nsw i32 %543, %544
  %546 = trunc i32 %545 to i16
  %547 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv508
  store i16 %546, i16* %547, align 2, !tbaa !24
  %indvars.iv.next509 = add nuw nsw i64 %indvars.iv508, 1
  %exitcond510 = icmp eq i64 %indvars.iv.next509, 10240
  br i1 %exitcond510, label %vector.ph1328, label %542

vector.ph1328:                                    ; preds = %542
  %548 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 15
  %549 = bitcast i16* %548 to i8*
  call void @llvm.memset.p0i8.i64(i8* %549, i8 -91, i64 32, i32 2, i1 false)
  br label %vector.body1329

vector.body1329:                                  ; preds = %vector.body1329, %vector.ph1328
  %index1332 = phi i64 [ 0, %vector.ph1328 ], [ %index.next1336, %vector.body1329 ]
  %vec.phi1341 = phi <4 x i32> [ zeroinitializer, %vector.ph1328 ], [ %556, %vector.body1329 ]
  %vec.phi1342 = phi <4 x i32> [ zeroinitializer, %vector.ph1328 ], [ %557, %vector.body1329 ]
  %550 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1332
  %551 = bitcast i16* %550 to <4 x i16>*
  %wide.load1343 = load <4 x i16>* %551, align 16
  %.sum2077 = or i64 %index1332, 4
  %552 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2077
  %553 = bitcast i16* %552 to <4 x i16>*
  %wide.load1344 = load <4 x i16>* %553, align 8
  %554 = zext <4 x i16> %wide.load1343 to <4 x i32>
  %555 = zext <4 x i16> %wide.load1344 to <4 x i32>
  %556 = add nsw <4 x i32> %554, %vec.phi1341
  %557 = add nsw <4 x i32> %555, %vec.phi1342
  %index.next1336 = add i64 %index1332, 8
  %558 = icmp eq i64 %index.next1336, 10240
  br i1 %558, label %middle.block1330, label %vector.body1329, !llvm.loop !37

middle.block1330:                                 ; preds = %vector.body1329
  %bin.rdx1347 = add <4 x i32> %557, %556
  %rdx.shuf1348 = shufflevector <4 x i32> %bin.rdx1347, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1349 = add <4 x i32> %bin.rdx1347, %rdx.shuf1348
  %rdx.shuf1350 = shufflevector <4 x i32> %bin.rdx1349, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1351 = add <4 x i32> %bin.rdx1349, %rdx.shuf1350
  %559 = extractelement <4 x i32> %bin.rdx1351, i32 0
  %560 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %559)
  br label %561

; <label>:561                                     ; preds = %561, %middle.block1330
  %indvars.iv501 = phi i64 [ 0, %middle.block1330 ], [ %indvars.iv.next502, %561 ]
  %562 = load volatile i32* %seed54, align 4
  %563 = trunc i64 %indvars.iv501 to i32
  %564 = mul nsw i32 %562, %563
  %565 = trunc i32 %564 to i16
  %566 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv501
  store i16 %565, i16* %566, align 2, !tbaa !24
  %indvars.iv.next502 = add nuw nsw i64 %indvars.iv501, 1
  %exitcond503 = icmp eq i64 %indvars.iv.next502, 10240
  br i1 %exitcond503, label %vector.ph1304, label %561

vector.ph1304:                                    ; preds = %561
  %567 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 13
  %568 = bitcast i16* %567 to i8*
  call void @llvm.memset.p0i8.i64(i8* %568, i8 -91, i64 64, i32 2, i1 false)
  br label %vector.body1305

vector.body1305:                                  ; preds = %vector.body1305, %vector.ph1304
  %index1308 = phi i64 [ 0, %vector.ph1304 ], [ %index.next1312, %vector.body1305 ]
  %vec.phi1317 = phi <4 x i32> [ zeroinitializer, %vector.ph1304 ], [ %575, %vector.body1305 ]
  %vec.phi1318 = phi <4 x i32> [ zeroinitializer, %vector.ph1304 ], [ %576, %vector.body1305 ]
  %569 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1308
  %570 = bitcast i16* %569 to <4 x i16>*
  %wide.load1319 = load <4 x i16>* %570, align 16
  %.sum2078 = or i64 %index1308, 4
  %571 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2078
  %572 = bitcast i16* %571 to <4 x i16>*
  %wide.load1320 = load <4 x i16>* %572, align 8
  %573 = zext <4 x i16> %wide.load1319 to <4 x i32>
  %574 = zext <4 x i16> %wide.load1320 to <4 x i32>
  %575 = add nsw <4 x i32> %573, %vec.phi1317
  %576 = add nsw <4 x i32> %574, %vec.phi1318
  %index.next1312 = add i64 %index1308, 8
  %577 = icmp eq i64 %index.next1312, 10240
  br i1 %577, label %middle.block1306, label %vector.body1305, !llvm.loop !38

middle.block1306:                                 ; preds = %vector.body1305
  %bin.rdx1323 = add <4 x i32> %576, %575
  %rdx.shuf1324 = shufflevector <4 x i32> %bin.rdx1323, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1325 = add <4 x i32> %bin.rdx1323, %rdx.shuf1324
  %rdx.shuf1326 = shufflevector <4 x i32> %bin.rdx1325, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1327 = add <4 x i32> %bin.rdx1325, %rdx.shuf1326
  %578 = extractelement <4 x i32> %bin.rdx1327, i32 0
  %579 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %578)
  br label %580

; <label>:580                                     ; preds = %580, %middle.block1306
  %indvars.iv494 = phi i64 [ 0, %middle.block1306 ], [ %indvars.iv.next495, %580 ]
  %581 = load volatile i32* %seed54, align 4
  %582 = trunc i64 %indvars.iv494 to i32
  %583 = mul nsw i32 %581, %582
  %584 = trunc i32 %583 to i16
  %585 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv494
  store i16 %584, i16* %585, align 2, !tbaa !24
  %indvars.iv.next495 = add nuw nsw i64 %indvars.iv494, 1
  %exitcond496 = icmp eq i64 %indvars.iv.next495, 10240
  br i1 %exitcond496, label %vector.ph1280, label %580

vector.ph1280:                                    ; preds = %580
  call void @llvm.memset.p0i8.i64(i8* %492, i8 -91, i64 128, i32 2, i1 false)
  br label %vector.body1281

vector.body1281:                                  ; preds = %vector.body1281, %vector.ph1280
  %index1284 = phi i64 [ 0, %vector.ph1280 ], [ %index.next1288, %vector.body1281 ]
  %vec.phi1293 = phi <4 x i32> [ zeroinitializer, %vector.ph1280 ], [ %592, %vector.body1281 ]
  %vec.phi1294 = phi <4 x i32> [ zeroinitializer, %vector.ph1280 ], [ %593, %vector.body1281 ]
  %586 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1284
  %587 = bitcast i16* %586 to <4 x i16>*
  %wide.load1295 = load <4 x i16>* %587, align 16
  %.sum2079 = or i64 %index1284, 4
  %588 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2079
  %589 = bitcast i16* %588 to <4 x i16>*
  %wide.load1296 = load <4 x i16>* %589, align 8
  %590 = zext <4 x i16> %wide.load1295 to <4 x i32>
  %591 = zext <4 x i16> %wide.load1296 to <4 x i32>
  %592 = add nsw <4 x i32> %590, %vec.phi1293
  %593 = add nsw <4 x i32> %591, %vec.phi1294
  %index.next1288 = add i64 %index1284, 8
  %594 = icmp eq i64 %index.next1288, 10240
  br i1 %594, label %middle.block1282, label %vector.body1281, !llvm.loop !39

middle.block1282:                                 ; preds = %vector.body1281
  %bin.rdx1299 = add <4 x i32> %593, %592
  %rdx.shuf1300 = shufflevector <4 x i32> %bin.rdx1299, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1301 = add <4 x i32> %bin.rdx1299, %rdx.shuf1300
  %rdx.shuf1302 = shufflevector <4 x i32> %bin.rdx1301, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1303 = add <4 x i32> %bin.rdx1301, %rdx.shuf1302
  %595 = extractelement <4 x i32> %bin.rdx1303, i32 0
  %596 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %595)
  br label %597

; <label>:597                                     ; preds = %597, %middle.block1282
  %indvars.iv487 = phi i64 [ 0, %middle.block1282 ], [ %indvars.iv.next488, %597 ]
  %598 = load volatile i32* %seed54, align 4
  %599 = trunc i64 %indvars.iv487 to i32
  %600 = mul nsw i32 %598, %599
  %601 = trunc i32 %600 to i16
  %602 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv487
  store i16 %601, i16* %602, align 2, !tbaa !24
  %indvars.iv.next488 = add nuw nsw i64 %indvars.iv487, 1
  %exitcond489 = icmp eq i64 %indvars.iv.next488, 10240
  br i1 %exitcond489, label %vector.ph1256, label %597

vector.ph1256:                                    ; preds = %597
  call void @llvm.memset.p0i8.i64(i8* %339, i8 -91, i64 256, i32 2, i1 false)
  br label %vector.body1257

vector.body1257:                                  ; preds = %vector.body1257, %vector.ph1256
  %index1260 = phi i64 [ 0, %vector.ph1256 ], [ %index.next1264, %vector.body1257 ]
  %vec.phi1269 = phi <4 x i32> [ zeroinitializer, %vector.ph1256 ], [ %609, %vector.body1257 ]
  %vec.phi1270 = phi <4 x i32> [ zeroinitializer, %vector.ph1256 ], [ %610, %vector.body1257 ]
  %603 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1260
  %604 = bitcast i16* %603 to <4 x i16>*
  %wide.load1271 = load <4 x i16>* %604, align 16
  %.sum2080 = or i64 %index1260, 4
  %605 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2080
  %606 = bitcast i16* %605 to <4 x i16>*
  %wide.load1272 = load <4 x i16>* %606, align 8
  %607 = zext <4 x i16> %wide.load1271 to <4 x i32>
  %608 = zext <4 x i16> %wide.load1272 to <4 x i32>
  %609 = add nsw <4 x i32> %607, %vec.phi1269
  %610 = add nsw <4 x i32> %608, %vec.phi1270
  %index.next1264 = add i64 %index1260, 8
  %611 = icmp eq i64 %index.next1264, 10240
  br i1 %611, label %middle.block1258, label %vector.body1257, !llvm.loop !40

middle.block1258:                                 ; preds = %vector.body1257
  %bin.rdx1275 = add <4 x i32> %610, %609
  %rdx.shuf1276 = shufflevector <4 x i32> %bin.rdx1275, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1277 = add <4 x i32> %bin.rdx1275, %rdx.shuf1276
  %rdx.shuf1278 = shufflevector <4 x i32> %bin.rdx1277, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1279 = add <4 x i32> %bin.rdx1277, %rdx.shuf1278
  %612 = extractelement <4 x i32> %bin.rdx1279, i32 0
  %613 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %612)
  br label %614

; <label>:614                                     ; preds = %614, %middle.block1258
  %indvars.iv480 = phi i64 [ 0, %middle.block1258 ], [ %indvars.iv.next481, %614 ]
  %615 = load volatile i32* %seed54, align 4
  %616 = trunc i64 %indvars.iv480 to i32
  %617 = mul nsw i32 %615, %616
  %618 = trunc i32 %617 to i16
  %619 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv480
  store i16 %618, i16* %619, align 2, !tbaa !24
  %indvars.iv.next481 = add nuw nsw i64 %indvars.iv480, 1
  %exitcond482 = icmp eq i64 %indvars.iv.next481, 10240
  br i1 %exitcond482, label %vector.ph1232, label %614

vector.ph1232:                                    ; preds = %614
  call void @llvm.memset.p0i8.i64(i8* %368, i8 -91, i64 512, i32 4, i1 false)
  br label %vector.body1233

vector.body1233:                                  ; preds = %vector.body1233, %vector.ph1232
  %index1236 = phi i64 [ 0, %vector.ph1232 ], [ %index.next1240, %vector.body1233 ]
  %vec.phi1245 = phi <4 x i32> [ zeroinitializer, %vector.ph1232 ], [ %626, %vector.body1233 ]
  %vec.phi1246 = phi <4 x i32> [ zeroinitializer, %vector.ph1232 ], [ %627, %vector.body1233 ]
  %620 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1236
  %621 = bitcast i16* %620 to <4 x i16>*
  %wide.load1247 = load <4 x i16>* %621, align 16
  %.sum2081 = or i64 %index1236, 4
  %622 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2081
  %623 = bitcast i16* %622 to <4 x i16>*
  %wide.load1248 = load <4 x i16>* %623, align 8
  %624 = zext <4 x i16> %wide.load1247 to <4 x i32>
  %625 = zext <4 x i16> %wide.load1248 to <4 x i32>
  %626 = add nsw <4 x i32> %624, %vec.phi1245
  %627 = add nsw <4 x i32> %625, %vec.phi1246
  %index.next1240 = add i64 %index1236, 8
  %628 = icmp eq i64 %index.next1240, 10240
  br i1 %628, label %middle.block1234, label %vector.body1233, !llvm.loop !41

middle.block1234:                                 ; preds = %vector.body1233
  %bin.rdx1251 = add <4 x i32> %627, %626
  %rdx.shuf1252 = shufflevector <4 x i32> %bin.rdx1251, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1253 = add <4 x i32> %bin.rdx1251, %rdx.shuf1252
  %rdx.shuf1254 = shufflevector <4 x i32> %bin.rdx1253, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1255 = add <4 x i32> %bin.rdx1253, %rdx.shuf1254
  %629 = extractelement <4 x i32> %bin.rdx1255, i32 0
  %630 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %629)
  br label %631

; <label>:631                                     ; preds = %631, %middle.block1234
  %indvars.iv473 = phi i64 [ 0, %middle.block1234 ], [ %indvars.iv.next474, %631 ]
  %632 = load volatile i32* %seed54, align 4
  %633 = trunc i64 %indvars.iv473 to i32
  %634 = mul nsw i32 %632, %633
  %635 = trunc i32 %634 to i16
  %636 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv473
  store i16 %635, i16* %636, align 2, !tbaa !24
  %indvars.iv.next474 = add nuw nsw i64 %indvars.iv473, 1
  %exitcond475 = icmp eq i64 %indvars.iv.next474, 10240
  br i1 %exitcond475, label %vector.ph1208, label %631

vector.ph1208:                                    ; preds = %631
  call void @llvm.memset.p0i8.i64(i8* %407, i8 -91, i64 1024, i32 8, i1 false)
  br label %vector.body1209

vector.body1209:                                  ; preds = %vector.body1209, %vector.ph1208
  %index1212 = phi i64 [ 0, %vector.ph1208 ], [ %index.next1216, %vector.body1209 ]
  %vec.phi1221 = phi <4 x i32> [ zeroinitializer, %vector.ph1208 ], [ %643, %vector.body1209 ]
  %vec.phi1222 = phi <4 x i32> [ zeroinitializer, %vector.ph1208 ], [ %644, %vector.body1209 ]
  %637 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1212
  %638 = bitcast i16* %637 to <4 x i16>*
  %wide.load1223 = load <4 x i16>* %638, align 16
  %.sum2082 = or i64 %index1212, 4
  %639 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2082
  %640 = bitcast i16* %639 to <4 x i16>*
  %wide.load1224 = load <4 x i16>* %640, align 8
  %641 = zext <4 x i16> %wide.load1223 to <4 x i32>
  %642 = zext <4 x i16> %wide.load1224 to <4 x i32>
  %643 = add nsw <4 x i32> %641, %vec.phi1221
  %644 = add nsw <4 x i32> %642, %vec.phi1222
  %index.next1216 = add i64 %index1212, 8
  %645 = icmp eq i64 %index.next1216, 10240
  br i1 %645, label %middle.block1210, label %vector.body1209, !llvm.loop !42

middle.block1210:                                 ; preds = %vector.body1209
  %bin.rdx1227 = add <4 x i32> %644, %643
  %rdx.shuf1228 = shufflevector <4 x i32> %bin.rdx1227, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1229 = add <4 x i32> %bin.rdx1227, %rdx.shuf1228
  %rdx.shuf1230 = shufflevector <4 x i32> %bin.rdx1229, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1231 = add <4 x i32> %bin.rdx1229, %rdx.shuf1230
  %646 = extractelement <4 x i32> %bin.rdx1231, i32 0
  %647 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %646)
  br label %.preheader224

.preheader224:                                    ; preds = %middle.block1186, %middle.block1210
  %indvars.iv467 = phi i64 [ 10, %middle.block1210 ], [ %indvars.iv.next468, %middle.block1186 ]
  br label %648

; <label>:648                                     ; preds = %648, %.preheader224
  %indvars.iv460 = phi i64 [ 0, %.preheader224 ], [ %indvars.iv.next461, %648 ]
  %649 = load volatile i32* %seed54, align 4
  %650 = trunc i64 %indvars.iv460 to i32
  %651 = mul nsw i32 %649, %650
  %652 = trunc i32 %651 to i16
  %653 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv460
  store i16 %652, i16* %653, align 2, !tbaa !24
  %indvars.iv.next461 = add nuw nsw i64 %indvars.iv460, 1
  %exitcond462 = icmp eq i64 %indvars.iv.next461, 10240
  br i1 %exitcond462, label %vector.ph1184, label %648

vector.ph1184:                                    ; preds = %648
  %654 = trunc i64 %indvars.iv467 to i32
  %655 = srem i32 %654, 17
  %656 = sext i32 %655 to i64
  %657 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %656
  %658 = bitcast i16* %657 to i8*
  call void @llvm.memset.p0i8.i64(i8* %658, i8 -91, i64 %indvars.iv467, i32 2, i1 false)
  br label %vector.body1185

vector.body1185:                                  ; preds = %vector.body1185, %vector.ph1184
  %index1188 = phi i64 [ 0, %vector.ph1184 ], [ %index.next1192, %vector.body1185 ]
  %vec.phi1197 = phi <4 x i32> [ zeroinitializer, %vector.ph1184 ], [ %665, %vector.body1185 ]
  %vec.phi1198 = phi <4 x i32> [ zeroinitializer, %vector.ph1184 ], [ %666, %vector.body1185 ]
  %659 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %index1188
  %660 = bitcast i16* %659 to <4 x i16>*
  %wide.load1199 = load <4 x i16>* %660, align 16
  %.sum2083 = or i64 %index1188, 4
  %661 = getelementptr [10240 x i16]* %buffer53, i64 0, i64 %.sum2083
  %662 = bitcast i16* %661 to <4 x i16>*
  %wide.load1200 = load <4 x i16>* %662, align 8
  %663 = zext <4 x i16> %wide.load1199 to <4 x i32>
  %664 = zext <4 x i16> %wide.load1200 to <4 x i32>
  %665 = add nsw <4 x i32> %663, %vec.phi1197
  %666 = add nsw <4 x i32> %664, %vec.phi1198
  %index.next1192 = add i64 %index1188, 8
  %667 = icmp eq i64 %index.next1192, 10240
  br i1 %667, label %middle.block1186, label %vector.body1185, !llvm.loop !43

middle.block1186:                                 ; preds = %vector.body1185
  %bin.rdx1203 = add <4 x i32> %666, %665
  %rdx.shuf1204 = shufflevector <4 x i32> %bin.rdx1203, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1205 = add <4 x i32> %bin.rdx1203, %rdx.shuf1204
  %rdx.shuf1206 = shufflevector <4 x i32> %bin.rdx1205, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1207 = add <4 x i32> %bin.rdx1205, %rdx.shuf1206
  %668 = extractelement <4 x i32> %bin.rdx1207, i32 0
  %669 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %654, i32 %668)
  %indvars.iv.next468 = add nuw nsw i64 %indvars.iv467, 10
  %670 = trunc i64 %indvars.iv.next468 to i32
  %671 = icmp slt i32 %670, 100
  br i1 %671, label %.preheader224, label %672

; <label>:672                                     ; preds = %middle.block1186
  call void @llvm.lifetime.end(i64 20480, i8* %331) #2
  %puts168 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str5, i64 0, i64 0))
  %673 = bitcast [10240 x i32]* %buffer110 to i8*
  call void @llvm.lifetime.start(i64 40960, i8* %673) #2
  store volatile i32 123, i32* %seed111, align 4
  br label %674

; <label>:674                                     ; preds = %674, %672
  %indvars.iv457 = phi i64 [ 0, %672 ], [ %indvars.iv.next458, %674 ]
  %675 = load volatile i32* %seed111, align 4
  %676 = trunc i64 %indvars.iv457 to i32
  %677 = mul nsw i32 %675, %676
  %678 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv457
  store i32 %677, i32* %678, align 4, !tbaa !44
  %indvars.iv.next458 = add nuw nsw i64 %indvars.iv457, 1
  %exitcond459 = icmp eq i64 %indvars.iv.next458, 10240
  br i1 %exitcond459, label %vector.ph1160, label %674

vector.ph1160:                                    ; preds = %674
  %679 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 1
  %680 = bitcast i32* %679 to i8*
  store i8 -91, i8* %680, align 4
  br label %vector.body1161

vector.body1161:                                  ; preds = %vector.body1161, %vector.ph1160
  %index1164 = phi i64 [ 0, %vector.ph1160 ], [ %index.next1168, %vector.body1161 ]
  %vec.phi1173 = phi <4 x i32> [ zeroinitializer, %vector.ph1160 ], [ %685, %vector.body1161 ]
  %vec.phi1174 = phi <4 x i32> [ zeroinitializer, %vector.ph1160 ], [ %686, %vector.body1161 ]
  %681 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1164
  %682 = bitcast i32* %681 to <4 x i32>*
  %wide.load1175 = load <4 x i32>* %682, align 16
  %.sum2084 = or i64 %index1164, 4
  %683 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2084
  %684 = bitcast i32* %683 to <4 x i32>*
  %wide.load1176 = load <4 x i32>* %684, align 16
  %685 = add <4 x i32> %wide.load1175, %vec.phi1173
  %686 = add <4 x i32> %wide.load1176, %vec.phi1174
  %index.next1168 = add i64 %index1164, 8
  %687 = icmp eq i64 %index.next1168, 10240
  br i1 %687, label %middle.block1162, label %vector.body1161, !llvm.loop !46

middle.block1162:                                 ; preds = %vector.body1161
  %bin.rdx1179 = add <4 x i32> %686, %685
  %rdx.shuf1180 = shufflevector <4 x i32> %bin.rdx1179, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1181 = add <4 x i32> %bin.rdx1179, %rdx.shuf1180
  %rdx.shuf1182 = shufflevector <4 x i32> %bin.rdx1181, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1183 = add <4 x i32> %bin.rdx1181, %rdx.shuf1182
  %688 = extractelement <4 x i32> %bin.rdx1183, i32 0
  %689 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %688)
  br label %690

; <label>:690                                     ; preds = %690, %middle.block1162
  %indvars.iv450 = phi i64 [ 0, %middle.block1162 ], [ %indvars.iv.next451, %690 ]
  %691 = load volatile i32* %seed111, align 4
  %692 = trunc i64 %indvars.iv450 to i32
  %693 = mul nsw i32 %691, %692
  %694 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv450
  store i32 %693, i32* %694, align 4, !tbaa !44
  %indvars.iv.next451 = add nuw nsw i64 %indvars.iv450, 1
  %exitcond452 = icmp eq i64 %indvars.iv.next451, 10240
  br i1 %exitcond452, label %vector.ph1136, label %690

vector.ph1136:                                    ; preds = %690
  %695 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 2
  %696 = bitcast i32* %695 to i16*
  store i16 -23131, i16* %696, align 8
  br label %vector.body1137

vector.body1137:                                  ; preds = %vector.body1137, %vector.ph1136
  %index1140 = phi i64 [ 0, %vector.ph1136 ], [ %index.next1144, %vector.body1137 ]
  %vec.phi1149 = phi <4 x i32> [ zeroinitializer, %vector.ph1136 ], [ %701, %vector.body1137 ]
  %vec.phi1150 = phi <4 x i32> [ zeroinitializer, %vector.ph1136 ], [ %702, %vector.body1137 ]
  %697 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1140
  %698 = bitcast i32* %697 to <4 x i32>*
  %wide.load1151 = load <4 x i32>* %698, align 16
  %.sum2085 = or i64 %index1140, 4
  %699 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2085
  %700 = bitcast i32* %699 to <4 x i32>*
  %wide.load1152 = load <4 x i32>* %700, align 16
  %701 = add <4 x i32> %wide.load1151, %vec.phi1149
  %702 = add <4 x i32> %wide.load1152, %vec.phi1150
  %index.next1144 = add i64 %index1140, 8
  %703 = icmp eq i64 %index.next1144, 10240
  br i1 %703, label %middle.block1138, label %vector.body1137, !llvm.loop !47

middle.block1138:                                 ; preds = %vector.body1137
  %bin.rdx1155 = add <4 x i32> %702, %701
  %rdx.shuf1156 = shufflevector <4 x i32> %bin.rdx1155, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1157 = add <4 x i32> %bin.rdx1155, %rdx.shuf1156
  %rdx.shuf1158 = shufflevector <4 x i32> %bin.rdx1157, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1159 = add <4 x i32> %bin.rdx1157, %rdx.shuf1158
  %704 = extractelement <4 x i32> %bin.rdx1159, i32 0
  %705 = bitcast i32* %695 to i8*
  %706 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %704)
  br label %707

; <label>:707                                     ; preds = %707, %middle.block1138
  %indvars.iv443 = phi i64 [ 0, %middle.block1138 ], [ %indvars.iv.next444, %707 ]
  %708 = load volatile i32* %seed111, align 4
  %709 = trunc i64 %indvars.iv443 to i32
  %710 = mul nsw i32 %708, %709
  %711 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv443
  store i32 %710, i32* %711, align 4, !tbaa !44
  %indvars.iv.next444 = add nuw nsw i64 %indvars.iv443, 1
  %exitcond445 = icmp eq i64 %indvars.iv.next444, 10240
  br i1 %exitcond445, label %vector.ph1112, label %707

vector.ph1112:                                    ; preds = %707
  %712 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 3
  %713 = bitcast i32* %712 to i8*
  call void @llvm.memset.p0i8.i64(i8* %713, i8 -91, i64 3, i32 4, i1 false)
  br label %vector.body1113

vector.body1113:                                  ; preds = %vector.body1113, %vector.ph1112
  %index1116 = phi i64 [ 0, %vector.ph1112 ], [ %index.next1120, %vector.body1113 ]
  %vec.phi1125 = phi <4 x i32> [ zeroinitializer, %vector.ph1112 ], [ %718, %vector.body1113 ]
  %vec.phi1126 = phi <4 x i32> [ zeroinitializer, %vector.ph1112 ], [ %719, %vector.body1113 ]
  %714 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1116
  %715 = bitcast i32* %714 to <4 x i32>*
  %wide.load1127 = load <4 x i32>* %715, align 16
  %.sum2086 = or i64 %index1116, 4
  %716 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2086
  %717 = bitcast i32* %716 to <4 x i32>*
  %wide.load1128 = load <4 x i32>* %717, align 16
  %718 = add <4 x i32> %wide.load1127, %vec.phi1125
  %719 = add <4 x i32> %wide.load1128, %vec.phi1126
  %index.next1120 = add i64 %index1116, 8
  %720 = icmp eq i64 %index.next1120, 10240
  br i1 %720, label %middle.block1114, label %vector.body1113, !llvm.loop !48

middle.block1114:                                 ; preds = %vector.body1113
  %bin.rdx1131 = add <4 x i32> %719, %718
  %rdx.shuf1132 = shufflevector <4 x i32> %bin.rdx1131, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1133 = add <4 x i32> %bin.rdx1131, %rdx.shuf1132
  %rdx.shuf1134 = shufflevector <4 x i32> %bin.rdx1133, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1135 = add <4 x i32> %bin.rdx1133, %rdx.shuf1134
  %721 = extractelement <4 x i32> %bin.rdx1135, i32 0
  %722 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %721)
  br label %723

; <label>:723                                     ; preds = %723, %middle.block1114
  %indvars.iv436 = phi i64 [ 0, %middle.block1114 ], [ %indvars.iv.next437, %723 ]
  %724 = load volatile i32* %seed111, align 4
  %725 = trunc i64 %indvars.iv436 to i32
  %726 = mul nsw i32 %724, %725
  %727 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv436
  store i32 %726, i32* %727, align 4, !tbaa !44
  %indvars.iv.next437 = add nuw nsw i64 %indvars.iv436, 1
  %exitcond438 = icmp eq i64 %indvars.iv.next437, 10240
  br i1 %exitcond438, label %vector.ph1088, label %723

vector.ph1088:                                    ; preds = %723
  %728 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 4
  store i32 -1515870811, i32* %728, align 16
  br label %vector.body1089

vector.body1089:                                  ; preds = %vector.body1089, %vector.ph1088
  %index1092 = phi i64 [ 0, %vector.ph1088 ], [ %index.next1096, %vector.body1089 ]
  %vec.phi1101 = phi <4 x i32> [ zeroinitializer, %vector.ph1088 ], [ %733, %vector.body1089 ]
  %vec.phi1102 = phi <4 x i32> [ zeroinitializer, %vector.ph1088 ], [ %734, %vector.body1089 ]
  %729 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1092
  %730 = bitcast i32* %729 to <4 x i32>*
  %wide.load1103 = load <4 x i32>* %730, align 16
  %.sum2087 = or i64 %index1092, 4
  %731 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2087
  %732 = bitcast i32* %731 to <4 x i32>*
  %wide.load1104 = load <4 x i32>* %732, align 16
  %733 = add <4 x i32> %wide.load1103, %vec.phi1101
  %734 = add <4 x i32> %wide.load1104, %vec.phi1102
  %index.next1096 = add i64 %index1092, 8
  %735 = icmp eq i64 %index.next1096, 10240
  br i1 %735, label %middle.block1090, label %vector.body1089, !llvm.loop !49

middle.block1090:                                 ; preds = %vector.body1089
  %bin.rdx1107 = add <4 x i32> %734, %733
  %rdx.shuf1108 = shufflevector <4 x i32> %bin.rdx1107, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1109 = add <4 x i32> %bin.rdx1107, %rdx.shuf1108
  %rdx.shuf1110 = shufflevector <4 x i32> %bin.rdx1109, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1111 = add <4 x i32> %bin.rdx1109, %rdx.shuf1110
  %736 = extractelement <4 x i32> %bin.rdx1111, i32 0
  %737 = bitcast i32* %728 to i8*
  %738 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %736)
  br label %739

; <label>:739                                     ; preds = %739, %middle.block1090
  %indvars.iv429 = phi i64 [ 0, %middle.block1090 ], [ %indvars.iv.next430, %739 ]
  %740 = load volatile i32* %seed111, align 4
  %741 = trunc i64 %indvars.iv429 to i32
  %742 = mul nsw i32 %740, %741
  %743 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv429
  store i32 %742, i32* %743, align 4, !tbaa !44
  %indvars.iv.next430 = add nuw nsw i64 %indvars.iv429, 1
  %exitcond431 = icmp eq i64 %indvars.iv.next430, 10240
  br i1 %exitcond431, label %vector.ph1064, label %739

vector.ph1064:                                    ; preds = %739
  %744 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 5
  %745 = bitcast i32* %744 to i8*
  call void @llvm.memset.p0i8.i64(i8* %745, i8 -91, i64 5, i32 4, i1 false)
  br label %vector.body1065

vector.body1065:                                  ; preds = %vector.body1065, %vector.ph1064
  %index1068 = phi i64 [ 0, %vector.ph1064 ], [ %index.next1072, %vector.body1065 ]
  %vec.phi1077 = phi <4 x i32> [ zeroinitializer, %vector.ph1064 ], [ %750, %vector.body1065 ]
  %vec.phi1078 = phi <4 x i32> [ zeroinitializer, %vector.ph1064 ], [ %751, %vector.body1065 ]
  %746 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1068
  %747 = bitcast i32* %746 to <4 x i32>*
  %wide.load1079 = load <4 x i32>* %747, align 16
  %.sum2088 = or i64 %index1068, 4
  %748 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2088
  %749 = bitcast i32* %748 to <4 x i32>*
  %wide.load1080 = load <4 x i32>* %749, align 16
  %750 = add <4 x i32> %wide.load1079, %vec.phi1077
  %751 = add <4 x i32> %wide.load1080, %vec.phi1078
  %index.next1072 = add i64 %index1068, 8
  %752 = icmp eq i64 %index.next1072, 10240
  br i1 %752, label %middle.block1066, label %vector.body1065, !llvm.loop !50

middle.block1066:                                 ; preds = %vector.body1065
  %bin.rdx1083 = add <4 x i32> %751, %750
  %rdx.shuf1084 = shufflevector <4 x i32> %bin.rdx1083, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1085 = add <4 x i32> %bin.rdx1083, %rdx.shuf1084
  %rdx.shuf1086 = shufflevector <4 x i32> %bin.rdx1085, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1087 = add <4 x i32> %bin.rdx1085, %rdx.shuf1086
  %753 = extractelement <4 x i32> %bin.rdx1087, i32 0
  %754 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %753)
  br label %755

; <label>:755                                     ; preds = %755, %middle.block1066
  %indvars.iv422 = phi i64 [ 0, %middle.block1066 ], [ %indvars.iv.next423, %755 ]
  %756 = load volatile i32* %seed111, align 4
  %757 = trunc i64 %indvars.iv422 to i32
  %758 = mul nsw i32 %756, %757
  %759 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv422
  store i32 %758, i32* %759, align 4, !tbaa !44
  %indvars.iv.next423 = add nuw nsw i64 %indvars.iv422, 1
  %exitcond424 = icmp eq i64 %indvars.iv.next423, 10240
  br i1 %exitcond424, label %vector.ph1040, label %755

vector.ph1040:                                    ; preds = %755
  %760 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 6
  %761 = bitcast i32* %760 to i8*
  call void @llvm.memset.p0i8.i64(i8* %761, i8 -91, i64 6, i32 8, i1 false)
  br label %vector.body1041

vector.body1041:                                  ; preds = %vector.body1041, %vector.ph1040
  %index1044 = phi i64 [ 0, %vector.ph1040 ], [ %index.next1048, %vector.body1041 ]
  %vec.phi1053 = phi <4 x i32> [ zeroinitializer, %vector.ph1040 ], [ %766, %vector.body1041 ]
  %vec.phi1054 = phi <4 x i32> [ zeroinitializer, %vector.ph1040 ], [ %767, %vector.body1041 ]
  %762 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1044
  %763 = bitcast i32* %762 to <4 x i32>*
  %wide.load1055 = load <4 x i32>* %763, align 16
  %.sum2089 = or i64 %index1044, 4
  %764 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2089
  %765 = bitcast i32* %764 to <4 x i32>*
  %wide.load1056 = load <4 x i32>* %765, align 16
  %766 = add <4 x i32> %wide.load1055, %vec.phi1053
  %767 = add <4 x i32> %wide.load1056, %vec.phi1054
  %index.next1048 = add i64 %index1044, 8
  %768 = icmp eq i64 %index.next1048, 10240
  br i1 %768, label %middle.block1042, label %vector.body1041, !llvm.loop !51

middle.block1042:                                 ; preds = %vector.body1041
  %bin.rdx1059 = add <4 x i32> %767, %766
  %rdx.shuf1060 = shufflevector <4 x i32> %bin.rdx1059, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1061 = add <4 x i32> %bin.rdx1059, %rdx.shuf1060
  %rdx.shuf1062 = shufflevector <4 x i32> %bin.rdx1061, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1063 = add <4 x i32> %bin.rdx1061, %rdx.shuf1062
  %769 = extractelement <4 x i32> %bin.rdx1063, i32 0
  %770 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %769)
  br label %771

; <label>:771                                     ; preds = %771, %middle.block1042
  %indvars.iv415 = phi i64 [ 0, %middle.block1042 ], [ %indvars.iv.next416, %771 ]
  %772 = load volatile i32* %seed111, align 4
  %773 = trunc i64 %indvars.iv415 to i32
  %774 = mul nsw i32 %772, %773
  %775 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv415
  store i32 %774, i32* %775, align 4, !tbaa !44
  %indvars.iv.next416 = add nuw nsw i64 %indvars.iv415, 1
  %exitcond417 = icmp eq i64 %indvars.iv.next416, 10240
  br i1 %exitcond417, label %vector.ph1016, label %771

vector.ph1016:                                    ; preds = %771
  %776 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 7
  %777 = bitcast i32* %776 to i8*
  call void @llvm.memset.p0i8.i64(i8* %777, i8 -91, i64 7, i32 4, i1 false)
  br label %vector.body1017

vector.body1017:                                  ; preds = %vector.body1017, %vector.ph1016
  %index1020 = phi i64 [ 0, %vector.ph1016 ], [ %index.next1024, %vector.body1017 ]
  %vec.phi1029 = phi <4 x i32> [ zeroinitializer, %vector.ph1016 ], [ %782, %vector.body1017 ]
  %vec.phi1030 = phi <4 x i32> [ zeroinitializer, %vector.ph1016 ], [ %783, %vector.body1017 ]
  %778 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index1020
  %779 = bitcast i32* %778 to <4 x i32>*
  %wide.load1031 = load <4 x i32>* %779, align 16
  %.sum2090 = or i64 %index1020, 4
  %780 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2090
  %781 = bitcast i32* %780 to <4 x i32>*
  %wide.load1032 = load <4 x i32>* %781, align 16
  %782 = add <4 x i32> %wide.load1031, %vec.phi1029
  %783 = add <4 x i32> %wide.load1032, %vec.phi1030
  %index.next1024 = add i64 %index1020, 8
  %784 = icmp eq i64 %index.next1024, 10240
  br i1 %784, label %middle.block1018, label %vector.body1017, !llvm.loop !52

middle.block1018:                                 ; preds = %vector.body1017
  %bin.rdx1035 = add <4 x i32> %783, %782
  %rdx.shuf1036 = shufflevector <4 x i32> %bin.rdx1035, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1037 = add <4 x i32> %bin.rdx1035, %rdx.shuf1036
  %rdx.shuf1038 = shufflevector <4 x i32> %bin.rdx1037, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1039 = add <4 x i32> %bin.rdx1037, %rdx.shuf1038
  %785 = extractelement <4 x i32> %bin.rdx1039, i32 0
  %786 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %785)
  br label %787

; <label>:787                                     ; preds = %787, %middle.block1018
  %indvars.iv408 = phi i64 [ 0, %middle.block1018 ], [ %indvars.iv.next409, %787 ]
  %788 = load volatile i32* %seed111, align 4
  %789 = trunc i64 %indvars.iv408 to i32
  %790 = mul nsw i32 %788, %789
  %791 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv408
  store i32 %790, i32* %791, align 4, !tbaa !44
  %indvars.iv.next409 = add nuw nsw i64 %indvars.iv408, 1
  %exitcond410 = icmp eq i64 %indvars.iv.next409, 10240
  br i1 %exitcond410, label %vector.ph992, label %787

vector.ph992:                                     ; preds = %787
  %792 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 8
  %793 = bitcast i32* %792 to i64*
  store i64 -6510615555426900571, i64* %793, align 16
  br label %vector.body993

vector.body993:                                   ; preds = %vector.body993, %vector.ph992
  %index996 = phi i64 [ 0, %vector.ph992 ], [ %index.next1000, %vector.body993 ]
  %vec.phi1005 = phi <4 x i32> [ zeroinitializer, %vector.ph992 ], [ %798, %vector.body993 ]
  %vec.phi1006 = phi <4 x i32> [ zeroinitializer, %vector.ph992 ], [ %799, %vector.body993 ]
  %794 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index996
  %795 = bitcast i32* %794 to <4 x i32>*
  %wide.load1007 = load <4 x i32>* %795, align 16
  %.sum2091 = or i64 %index996, 4
  %796 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2091
  %797 = bitcast i32* %796 to <4 x i32>*
  %wide.load1008 = load <4 x i32>* %797, align 16
  %798 = add <4 x i32> %wide.load1007, %vec.phi1005
  %799 = add <4 x i32> %wide.load1008, %vec.phi1006
  %index.next1000 = add i64 %index996, 8
  %800 = icmp eq i64 %index.next1000, 10240
  br i1 %800, label %middle.block994, label %vector.body993, !llvm.loop !53

middle.block994:                                  ; preds = %vector.body993
  %bin.rdx1011 = add <4 x i32> %799, %798
  %rdx.shuf1012 = shufflevector <4 x i32> %bin.rdx1011, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx1013 = add <4 x i32> %bin.rdx1011, %rdx.shuf1012
  %rdx.shuf1014 = shufflevector <4 x i32> %bin.rdx1013, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx1015 = add <4 x i32> %bin.rdx1013, %rdx.shuf1014
  %801 = extractelement <4 x i32> %bin.rdx1015, i32 0
  %802 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %801)
  br label %803

; <label>:803                                     ; preds = %803, %middle.block994
  %indvars.iv401 = phi i64 [ 0, %middle.block994 ], [ %indvars.iv.next402, %803 ]
  %804 = load volatile i32* %seed111, align 4
  %805 = trunc i64 %indvars.iv401 to i32
  %806 = mul nsw i32 %804, %805
  %807 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv401
  store i32 %806, i32* %807, align 4, !tbaa !44
  %indvars.iv.next402 = add nuw nsw i64 %indvars.iv401, 1
  %exitcond403 = icmp eq i64 %indvars.iv.next402, 10240
  br i1 %exitcond403, label %vector.ph968, label %803

vector.ph968:                                     ; preds = %803
  %808 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 9
  %809 = bitcast i32* %808 to i8*
  call void @llvm.memset.p0i8.i64(i8* %809, i8 -91, i64 9, i32 4, i1 false)
  br label %vector.body969

vector.body969:                                   ; preds = %vector.body969, %vector.ph968
  %index972 = phi i64 [ 0, %vector.ph968 ], [ %index.next976, %vector.body969 ]
  %vec.phi981 = phi <4 x i32> [ zeroinitializer, %vector.ph968 ], [ %814, %vector.body969 ]
  %vec.phi982 = phi <4 x i32> [ zeroinitializer, %vector.ph968 ], [ %815, %vector.body969 ]
  %810 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index972
  %811 = bitcast i32* %810 to <4 x i32>*
  %wide.load983 = load <4 x i32>* %811, align 16
  %.sum2092 = or i64 %index972, 4
  %812 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2092
  %813 = bitcast i32* %812 to <4 x i32>*
  %wide.load984 = load <4 x i32>* %813, align 16
  %814 = add <4 x i32> %wide.load983, %vec.phi981
  %815 = add <4 x i32> %wide.load984, %vec.phi982
  %index.next976 = add i64 %index972, 8
  %816 = icmp eq i64 %index.next976, 10240
  br i1 %816, label %middle.block970, label %vector.body969, !llvm.loop !54

middle.block970:                                  ; preds = %vector.body969
  %bin.rdx987 = add <4 x i32> %815, %814
  %rdx.shuf988 = shufflevector <4 x i32> %bin.rdx987, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx989 = add <4 x i32> %bin.rdx987, %rdx.shuf988
  %rdx.shuf990 = shufflevector <4 x i32> %bin.rdx989, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx991 = add <4 x i32> %bin.rdx989, %rdx.shuf990
  %817 = extractelement <4 x i32> %bin.rdx991, i32 0
  %818 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %817)
  br label %819

; <label>:819                                     ; preds = %819, %middle.block970
  %indvars.iv394 = phi i64 [ 0, %middle.block970 ], [ %indvars.iv.next395, %819 ]
  %820 = load volatile i32* %seed111, align 4
  %821 = trunc i64 %indvars.iv394 to i32
  %822 = mul nsw i32 %820, %821
  %823 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv394
  store i32 %822, i32* %823, align 4, !tbaa !44
  %indvars.iv.next395 = add nuw nsw i64 %indvars.iv394, 1
  %exitcond396 = icmp eq i64 %indvars.iv.next395, 10240
  br i1 %exitcond396, label %vector.ph944, label %819

vector.ph944:                                     ; preds = %819
  %824 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 10
  %825 = bitcast i32* %824 to i8*
  call void @llvm.memset.p0i8.i64(i8* %825, i8 -91, i64 10, i32 8, i1 false)
  br label %vector.body945

vector.body945:                                   ; preds = %vector.body945, %vector.ph944
  %index948 = phi i64 [ 0, %vector.ph944 ], [ %index.next952, %vector.body945 ]
  %vec.phi957 = phi <4 x i32> [ zeroinitializer, %vector.ph944 ], [ %830, %vector.body945 ]
  %vec.phi958 = phi <4 x i32> [ zeroinitializer, %vector.ph944 ], [ %831, %vector.body945 ]
  %826 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index948
  %827 = bitcast i32* %826 to <4 x i32>*
  %wide.load959 = load <4 x i32>* %827, align 16
  %.sum2093 = or i64 %index948, 4
  %828 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2093
  %829 = bitcast i32* %828 to <4 x i32>*
  %wide.load960 = load <4 x i32>* %829, align 16
  %830 = add <4 x i32> %wide.load959, %vec.phi957
  %831 = add <4 x i32> %wide.load960, %vec.phi958
  %index.next952 = add i64 %index948, 8
  %832 = icmp eq i64 %index.next952, 10240
  br i1 %832, label %middle.block946, label %vector.body945, !llvm.loop !55

middle.block946:                                  ; preds = %vector.body945
  %bin.rdx963 = add <4 x i32> %831, %830
  %rdx.shuf964 = shufflevector <4 x i32> %bin.rdx963, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx965 = add <4 x i32> %bin.rdx963, %rdx.shuf964
  %rdx.shuf966 = shufflevector <4 x i32> %bin.rdx965, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx967 = add <4 x i32> %bin.rdx965, %rdx.shuf966
  %833 = extractelement <4 x i32> %bin.rdx967, i32 0
  %834 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %833)
  br label %835

; <label>:835                                     ; preds = %835, %middle.block946
  %indvars.iv387 = phi i64 [ 0, %middle.block946 ], [ %indvars.iv.next388, %835 ]
  %836 = load volatile i32* %seed111, align 4
  %837 = trunc i64 %indvars.iv387 to i32
  %838 = mul nsw i32 %836, %837
  %839 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv387
  store i32 %838, i32* %839, align 4, !tbaa !44
  %indvars.iv.next388 = add nuw nsw i64 %indvars.iv387, 1
  %exitcond389 = icmp eq i64 %indvars.iv.next388, 10240
  br i1 %exitcond389, label %vector.ph920, label %835

vector.ph920:                                     ; preds = %835
  %840 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 16
  %841 = bitcast i32* %840 to i8*
  call void @llvm.memset.p0i8.i64(i8* %841, i8 -91, i64 16, i32 16, i1 false)
  br label %vector.body921

vector.body921:                                   ; preds = %vector.body921, %vector.ph920
  %index924 = phi i64 [ 0, %vector.ph920 ], [ %index.next928, %vector.body921 ]
  %vec.phi933 = phi <4 x i32> [ zeroinitializer, %vector.ph920 ], [ %846, %vector.body921 ]
  %vec.phi934 = phi <4 x i32> [ zeroinitializer, %vector.ph920 ], [ %847, %vector.body921 ]
  %842 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index924
  %843 = bitcast i32* %842 to <4 x i32>*
  %wide.load935 = load <4 x i32>* %843, align 16
  %.sum2094 = or i64 %index924, 4
  %844 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2094
  %845 = bitcast i32* %844 to <4 x i32>*
  %wide.load936 = load <4 x i32>* %845, align 16
  %846 = add <4 x i32> %wide.load935, %vec.phi933
  %847 = add <4 x i32> %wide.load936, %vec.phi934
  %index.next928 = add i64 %index924, 8
  %848 = icmp eq i64 %index.next928, 10240
  br i1 %848, label %middle.block922, label %vector.body921, !llvm.loop !56

middle.block922:                                  ; preds = %vector.body921
  %bin.rdx939 = add <4 x i32> %847, %846
  %rdx.shuf940 = shufflevector <4 x i32> %bin.rdx939, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx941 = add <4 x i32> %bin.rdx939, %rdx.shuf940
  %rdx.shuf942 = shufflevector <4 x i32> %bin.rdx941, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx943 = add <4 x i32> %bin.rdx941, %rdx.shuf942
  %849 = extractelement <4 x i32> %bin.rdx943, i32 0
  %850 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %849)
  br label %851

; <label>:851                                     ; preds = %851, %middle.block922
  %indvars.iv380 = phi i64 [ 0, %middle.block922 ], [ %indvars.iv.next381, %851 ]
  %852 = load volatile i32* %seed111, align 4
  %853 = trunc i64 %indvars.iv380 to i32
  %854 = mul nsw i32 %852, %853
  %855 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv380
  store i32 %854, i32* %855, align 4, !tbaa !44
  %indvars.iv.next381 = add nuw nsw i64 %indvars.iv380, 1
  %exitcond382 = icmp eq i64 %indvars.iv.next381, 10240
  br i1 %exitcond382, label %vector.ph896, label %851

vector.ph896:                                     ; preds = %851
  %856 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 15
  %857 = bitcast i32* %856 to i8*
  call void @llvm.memset.p0i8.i64(i8* %857, i8 -91, i64 32, i32 4, i1 false)
  br label %vector.body897

vector.body897:                                   ; preds = %vector.body897, %vector.ph896
  %index900 = phi i64 [ 0, %vector.ph896 ], [ %index.next904, %vector.body897 ]
  %vec.phi909 = phi <4 x i32> [ zeroinitializer, %vector.ph896 ], [ %862, %vector.body897 ]
  %vec.phi910 = phi <4 x i32> [ zeroinitializer, %vector.ph896 ], [ %863, %vector.body897 ]
  %858 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index900
  %859 = bitcast i32* %858 to <4 x i32>*
  %wide.load911 = load <4 x i32>* %859, align 16
  %.sum2095 = or i64 %index900, 4
  %860 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2095
  %861 = bitcast i32* %860 to <4 x i32>*
  %wide.load912 = load <4 x i32>* %861, align 16
  %862 = add <4 x i32> %wide.load911, %vec.phi909
  %863 = add <4 x i32> %wide.load912, %vec.phi910
  %index.next904 = add i64 %index900, 8
  %864 = icmp eq i64 %index.next904, 10240
  br i1 %864, label %middle.block898, label %vector.body897, !llvm.loop !57

middle.block898:                                  ; preds = %vector.body897
  %bin.rdx915 = add <4 x i32> %863, %862
  %rdx.shuf916 = shufflevector <4 x i32> %bin.rdx915, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx917 = add <4 x i32> %bin.rdx915, %rdx.shuf916
  %rdx.shuf918 = shufflevector <4 x i32> %bin.rdx917, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx919 = add <4 x i32> %bin.rdx917, %rdx.shuf918
  %865 = extractelement <4 x i32> %bin.rdx919, i32 0
  %866 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %865)
  br label %867

; <label>:867                                     ; preds = %867, %middle.block898
  %indvars.iv373 = phi i64 [ 0, %middle.block898 ], [ %indvars.iv.next374, %867 ]
  %868 = load volatile i32* %seed111, align 4
  %869 = trunc i64 %indvars.iv373 to i32
  %870 = mul nsw i32 %868, %869
  %871 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv373
  store i32 %870, i32* %871, align 4, !tbaa !44
  %indvars.iv.next374 = add nuw nsw i64 %indvars.iv373, 1
  %exitcond375 = icmp eq i64 %indvars.iv.next374, 10240
  br i1 %exitcond375, label %vector.ph872, label %867

vector.ph872:                                     ; preds = %867
  %872 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 13
  %873 = bitcast i32* %872 to i8*
  call void @llvm.memset.p0i8.i64(i8* %873, i8 -91, i64 64, i32 4, i1 false)
  br label %vector.body873

vector.body873:                                   ; preds = %vector.body873, %vector.ph872
  %index876 = phi i64 [ 0, %vector.ph872 ], [ %index.next880, %vector.body873 ]
  %vec.phi885 = phi <4 x i32> [ zeroinitializer, %vector.ph872 ], [ %878, %vector.body873 ]
  %vec.phi886 = phi <4 x i32> [ zeroinitializer, %vector.ph872 ], [ %879, %vector.body873 ]
  %874 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index876
  %875 = bitcast i32* %874 to <4 x i32>*
  %wide.load887 = load <4 x i32>* %875, align 16
  %.sum2096 = or i64 %index876, 4
  %876 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2096
  %877 = bitcast i32* %876 to <4 x i32>*
  %wide.load888 = load <4 x i32>* %877, align 16
  %878 = add <4 x i32> %wide.load887, %vec.phi885
  %879 = add <4 x i32> %wide.load888, %vec.phi886
  %index.next880 = add i64 %index876, 8
  %880 = icmp eq i64 %index.next880, 10240
  br i1 %880, label %middle.block874, label %vector.body873, !llvm.loop !58

middle.block874:                                  ; preds = %vector.body873
  %bin.rdx891 = add <4 x i32> %879, %878
  %rdx.shuf892 = shufflevector <4 x i32> %bin.rdx891, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx893 = add <4 x i32> %bin.rdx891, %rdx.shuf892
  %rdx.shuf894 = shufflevector <4 x i32> %bin.rdx893, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx895 = add <4 x i32> %bin.rdx893, %rdx.shuf894
  %881 = extractelement <4 x i32> %bin.rdx895, i32 0
  %882 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %881)
  br label %883

; <label>:883                                     ; preds = %883, %middle.block874
  %indvars.iv366 = phi i64 [ 0, %middle.block874 ], [ %indvars.iv.next367, %883 ]
  %884 = load volatile i32* %seed111, align 4
  %885 = trunc i64 %indvars.iv366 to i32
  %886 = mul nsw i32 %884, %885
  %887 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv366
  store i32 %886, i32* %887, align 4, !tbaa !44
  %indvars.iv.next367 = add nuw nsw i64 %indvars.iv366, 1
  %exitcond368 = icmp eq i64 %indvars.iv.next367, 10240
  br i1 %exitcond368, label %vector.ph848, label %883

vector.ph848:                                     ; preds = %883
  call void @llvm.memset.p0i8.i64(i8* %809, i8 -91, i64 128, i32 4, i1 false)
  br label %vector.body849

vector.body849:                                   ; preds = %vector.body849, %vector.ph848
  %index852 = phi i64 [ 0, %vector.ph848 ], [ %index.next856, %vector.body849 ]
  %vec.phi861 = phi <4 x i32> [ zeroinitializer, %vector.ph848 ], [ %892, %vector.body849 ]
  %vec.phi862 = phi <4 x i32> [ zeroinitializer, %vector.ph848 ], [ %893, %vector.body849 ]
  %888 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index852
  %889 = bitcast i32* %888 to <4 x i32>*
  %wide.load863 = load <4 x i32>* %889, align 16
  %.sum2097 = or i64 %index852, 4
  %890 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2097
  %891 = bitcast i32* %890 to <4 x i32>*
  %wide.load864 = load <4 x i32>* %891, align 16
  %892 = add <4 x i32> %wide.load863, %vec.phi861
  %893 = add <4 x i32> %wide.load864, %vec.phi862
  %index.next856 = add i64 %index852, 8
  %894 = icmp eq i64 %index.next856, 10240
  br i1 %894, label %middle.block850, label %vector.body849, !llvm.loop !59

middle.block850:                                  ; preds = %vector.body849
  %bin.rdx867 = add <4 x i32> %893, %892
  %rdx.shuf868 = shufflevector <4 x i32> %bin.rdx867, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx869 = add <4 x i32> %bin.rdx867, %rdx.shuf868
  %rdx.shuf870 = shufflevector <4 x i32> %bin.rdx869, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx871 = add <4 x i32> %bin.rdx869, %rdx.shuf870
  %895 = extractelement <4 x i32> %bin.rdx871, i32 0
  %896 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %895)
  br label %897

; <label>:897                                     ; preds = %897, %middle.block850
  %indvars.iv359 = phi i64 [ 0, %middle.block850 ], [ %indvars.iv.next360, %897 ]
  %898 = load volatile i32* %seed111, align 4
  %899 = trunc i64 %indvars.iv359 to i32
  %900 = mul nsw i32 %898, %899
  %901 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv359
  store i32 %900, i32* %901, align 4, !tbaa !44
  %indvars.iv.next360 = add nuw nsw i64 %indvars.iv359, 1
  %exitcond361 = icmp eq i64 %indvars.iv.next360, 10240
  br i1 %exitcond361, label %vector.ph824, label %897

vector.ph824:                                     ; preds = %897
  call void @llvm.memset.p0i8.i64(i8* %680, i8 -91, i64 256, i32 4, i1 false)
  br label %vector.body825

vector.body825:                                   ; preds = %vector.body825, %vector.ph824
  %index828 = phi i64 [ 0, %vector.ph824 ], [ %index.next832, %vector.body825 ]
  %vec.phi837 = phi <4 x i32> [ zeroinitializer, %vector.ph824 ], [ %906, %vector.body825 ]
  %vec.phi838 = phi <4 x i32> [ zeroinitializer, %vector.ph824 ], [ %907, %vector.body825 ]
  %902 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index828
  %903 = bitcast i32* %902 to <4 x i32>*
  %wide.load839 = load <4 x i32>* %903, align 16
  %.sum2098 = or i64 %index828, 4
  %904 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2098
  %905 = bitcast i32* %904 to <4 x i32>*
  %wide.load840 = load <4 x i32>* %905, align 16
  %906 = add <4 x i32> %wide.load839, %vec.phi837
  %907 = add <4 x i32> %wide.load840, %vec.phi838
  %index.next832 = add i64 %index828, 8
  %908 = icmp eq i64 %index.next832, 10240
  br i1 %908, label %middle.block826, label %vector.body825, !llvm.loop !60

middle.block826:                                  ; preds = %vector.body825
  %bin.rdx843 = add <4 x i32> %907, %906
  %rdx.shuf844 = shufflevector <4 x i32> %bin.rdx843, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx845 = add <4 x i32> %bin.rdx843, %rdx.shuf844
  %rdx.shuf846 = shufflevector <4 x i32> %bin.rdx845, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx847 = add <4 x i32> %bin.rdx845, %rdx.shuf846
  %909 = extractelement <4 x i32> %bin.rdx847, i32 0
  %910 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %909)
  br label %911

; <label>:911                                     ; preds = %911, %middle.block826
  %indvars.iv352 = phi i64 [ 0, %middle.block826 ], [ %indvars.iv.next353, %911 ]
  %912 = load volatile i32* %seed111, align 4
  %913 = trunc i64 %indvars.iv352 to i32
  %914 = mul nsw i32 %912, %913
  %915 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv352
  store i32 %914, i32* %915, align 4, !tbaa !44
  %indvars.iv.next353 = add nuw nsw i64 %indvars.iv352, 1
  %exitcond354 = icmp eq i64 %indvars.iv.next353, 10240
  br i1 %exitcond354, label %vector.ph800, label %911

vector.ph800:                                     ; preds = %911
  call void @llvm.memset.p0i8.i64(i8* %705, i8 -91, i64 512, i32 8, i1 false)
  br label %vector.body801

vector.body801:                                   ; preds = %vector.body801, %vector.ph800
  %index804 = phi i64 [ 0, %vector.ph800 ], [ %index.next808, %vector.body801 ]
  %vec.phi813 = phi <4 x i32> [ zeroinitializer, %vector.ph800 ], [ %920, %vector.body801 ]
  %vec.phi814 = phi <4 x i32> [ zeroinitializer, %vector.ph800 ], [ %921, %vector.body801 ]
  %916 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index804
  %917 = bitcast i32* %916 to <4 x i32>*
  %wide.load815 = load <4 x i32>* %917, align 16
  %.sum2099 = or i64 %index804, 4
  %918 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2099
  %919 = bitcast i32* %918 to <4 x i32>*
  %wide.load816 = load <4 x i32>* %919, align 16
  %920 = add <4 x i32> %wide.load815, %vec.phi813
  %921 = add <4 x i32> %wide.load816, %vec.phi814
  %index.next808 = add i64 %index804, 8
  %922 = icmp eq i64 %index.next808, 10240
  br i1 %922, label %middle.block802, label %vector.body801, !llvm.loop !61

middle.block802:                                  ; preds = %vector.body801
  %bin.rdx819 = add <4 x i32> %921, %920
  %rdx.shuf820 = shufflevector <4 x i32> %bin.rdx819, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx821 = add <4 x i32> %bin.rdx819, %rdx.shuf820
  %rdx.shuf822 = shufflevector <4 x i32> %bin.rdx821, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx823 = add <4 x i32> %bin.rdx821, %rdx.shuf822
  %923 = extractelement <4 x i32> %bin.rdx823, i32 0
  %924 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %923)
  br label %925

; <label>:925                                     ; preds = %925, %middle.block802
  %indvars.iv345 = phi i64 [ 0, %middle.block802 ], [ %indvars.iv.next346, %925 ]
  %926 = load volatile i32* %seed111, align 4
  %927 = trunc i64 %indvars.iv345 to i32
  %928 = mul nsw i32 %926, %927
  %929 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv345
  store i32 %928, i32* %929, align 4, !tbaa !44
  %indvars.iv.next346 = add nuw nsw i64 %indvars.iv345, 1
  %exitcond347 = icmp eq i64 %indvars.iv.next346, 10240
  br i1 %exitcond347, label %vector.ph776, label %925

vector.ph776:                                     ; preds = %925
  call void @llvm.memset.p0i8.i64(i8* %737, i8 -91, i64 1024, i32 16, i1 false)
  br label %vector.body777

vector.body777:                                   ; preds = %vector.body777, %vector.ph776
  %index780 = phi i64 [ 0, %vector.ph776 ], [ %index.next784, %vector.body777 ]
  %vec.phi789 = phi <4 x i32> [ zeroinitializer, %vector.ph776 ], [ %934, %vector.body777 ]
  %vec.phi790 = phi <4 x i32> [ zeroinitializer, %vector.ph776 ], [ %935, %vector.body777 ]
  %930 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index780
  %931 = bitcast i32* %930 to <4 x i32>*
  %wide.load791 = load <4 x i32>* %931, align 16
  %.sum2100 = or i64 %index780, 4
  %932 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2100
  %933 = bitcast i32* %932 to <4 x i32>*
  %wide.load792 = load <4 x i32>* %933, align 16
  %934 = add <4 x i32> %wide.load791, %vec.phi789
  %935 = add <4 x i32> %wide.load792, %vec.phi790
  %index.next784 = add i64 %index780, 8
  %936 = icmp eq i64 %index.next784, 10240
  br i1 %936, label %middle.block778, label %vector.body777, !llvm.loop !62

middle.block778:                                  ; preds = %vector.body777
  %bin.rdx795 = add <4 x i32> %935, %934
  %rdx.shuf796 = shufflevector <4 x i32> %bin.rdx795, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx797 = add <4 x i32> %bin.rdx795, %rdx.shuf796
  %rdx.shuf798 = shufflevector <4 x i32> %bin.rdx797, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx799 = add <4 x i32> %bin.rdx797, %rdx.shuf798
  %937 = extractelement <4 x i32> %bin.rdx799, i32 0
  %938 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %937)
  br label %.preheader

.preheader:                                       ; preds = %middle.block, %middle.block778
  %indvars.iv339 = phi i64 [ 10, %middle.block778 ], [ %indvars.iv.next340, %middle.block ]
  br label %939

; <label>:939                                     ; preds = %939, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %939 ]
  %940 = load volatile i32* %seed111, align 4
  %941 = trunc i64 %indvars.iv to i32
  %942 = mul nsw i32 %940, %941
  %943 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv
  store i32 %942, i32* %943, align 4, !tbaa !44
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 10240
  br i1 %exitcond, label %vector.ph, label %939

vector.ph:                                        ; preds = %939
  %944 = trunc i64 %indvars.iv339 to i32
  %945 = srem i32 %944, 17
  %946 = sext i32 %945 to i64
  %947 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %946
  %948 = bitcast i32* %947 to i8*
  call void @llvm.memset.p0i8.i64(i8* %948, i8 -91, i64 %indvars.iv339, i32 4, i1 false)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %953, %vector.body ]
  %vec.phi770 = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %954, %vector.body ]
  %949 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %index
  %950 = bitcast i32* %949 to <4 x i32>*
  %wide.load = load <4 x i32>* %950, align 16
  %.sum2101 = or i64 %index, 4
  %951 = getelementptr [10240 x i32]* %buffer110, i64 0, i64 %.sum2101
  %952 = bitcast i32* %951 to <4 x i32>*
  %wide.load771 = load <4 x i32>* %952, align 16
  %953 = add <4 x i32> %wide.load, %vec.phi
  %954 = add <4 x i32> %wide.load771, %vec.phi770
  %index.next = add i64 %index, 8
  %955 = icmp eq i64 %index.next, 10240
  br i1 %955, label %middle.block, label %vector.body, !llvm.loop !63

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <4 x i32> %954, %953
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx773 = add <4 x i32> %bin.rdx, %rdx.shuf
  %rdx.shuf774 = shufflevector <4 x i32> %bin.rdx773, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx775 = add <4 x i32> %bin.rdx773, %rdx.shuf774
  %956 = extractelement <4 x i32> %bin.rdx775, i32 0
  %957 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %944, i32 %956)
  %indvars.iv.next340 = add nuw nsw i64 %indvars.iv339, 10
  %958 = trunc i64 %indvars.iv.next340 to i32
  %959 = icmp slt i32 %958, 100
  br i1 %959, label %.preheader, label %960

; <label>:960                                     ; preds = %middle.block
  call void @llvm.lifetime.end(i64 40960, i8* %673) #2
  ret i32 1
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

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
!20 = metadata !{metadata !20, metadata !5, metadata !6}
!21 = metadata !{metadata !21, metadata !5, metadata !6}
!22 = metadata !{metadata !22, metadata !5, metadata !6}
!23 = metadata !{metadata !23, metadata !5, metadata !6}
!24 = metadata !{metadata !25, metadata !25, i64 0}
!25 = metadata !{metadata !"short", metadata !2, i64 0}
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
!37 = metadata !{metadata !37, metadata !5, metadata !6}
!38 = metadata !{metadata !38, metadata !5, metadata !6}
!39 = metadata !{metadata !39, metadata !5, metadata !6}
!40 = metadata !{metadata !40, metadata !5, metadata !6}
!41 = metadata !{metadata !41, metadata !5, metadata !6}
!42 = metadata !{metadata !42, metadata !5, metadata !6}
!43 = metadata !{metadata !43, metadata !5, metadata !6}
!44 = metadata !{metadata !45, metadata !45, i64 0}
!45 = metadata !{metadata !"int", metadata !2, i64 0}
!46 = metadata !{metadata !46, metadata !5, metadata !6}
!47 = metadata !{metadata !47, metadata !5, metadata !6}
!48 = metadata !{metadata !48, metadata !5, metadata !6}
!49 = metadata !{metadata !49, metadata !5, metadata !6}
!50 = metadata !{metadata !50, metadata !5, metadata !6}
!51 = metadata !{metadata !51, metadata !5, metadata !6}
!52 = metadata !{metadata !52, metadata !5, metadata !6}
!53 = metadata !{metadata !53, metadata !5, metadata !6}
!54 = metadata !{metadata !54, metadata !5, metadata !6}
!55 = metadata !{metadata !55, metadata !5, metadata !6}
!56 = metadata !{metadata !56, metadata !5, metadata !6}
!57 = metadata !{metadata !57, metadata !5, metadata !6}
!58 = metadata !{metadata !58, metadata !5, metadata !6}
!59 = metadata !{metadata !59, metadata !5, metadata !6}
!60 = metadata !{metadata !60, metadata !5, metadata !6}
!61 = metadata !{metadata !61, metadata !5, metadata !6}
!62 = metadata !{metadata !62, metadata !5, metadata !6}
!63 = metadata !{metadata !63, metadata !5, metadata !6}
