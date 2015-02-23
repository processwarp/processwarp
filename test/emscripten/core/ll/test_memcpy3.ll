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
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %14) #2
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
  %34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %32) #2
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
  br i1 %exitcond704, label %41, label %35

; <label>:41                                      ; preds = %35
  %42 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 4
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %42, i64 3, i32 4, i1 false)
  br label %43

; <label>:43                                      ; preds = %43, %41
  %indvars.iv699 = phi i64 [ 0, %41 ], [ %indvars.iv.next700, %43 ]
  %v6.0330 = phi i32 [ 0, %41 ], [ %47, %43 ]
  %44 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv699
  %45 = load i8* %44, align 1, !tbaa !1
  %46 = zext i8 %45 to i32
  %47 = add nsw i32 %46, %v6.0330
  %indvars.iv.next700 = add nuw nsw i64 %indvars.iv699, 1
  %exitcond701 = icmp eq i64 %indvars.iv.next700, 10240
  br i1 %exitcond701, label %48, label %43

; <label>:48                                      ; preds = %43
  %49 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %47) #2
  br label %50

; <label>:50                                      ; preds = %50, %48
  %indvars.iv695 = phi i64 [ 0, %48 ], [ %indvars.iv.next696, %50 ]
  %51 = load volatile i32* %seed, align 4
  %52 = trunc i64 %indvars.iv695 to i32
  %53 = mul nsw i32 %51, %52
  %54 = trunc i32 %53 to i8
  %55 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv695
  store i8 %54, i8* %55, align 1, !tbaa !1
  %indvars.iv.next696 = add nuw nsw i64 %indvars.iv695, 1
  %exitcond697 = icmp eq i64 %indvars.iv.next696, 10240
  br i1 %exitcond697, label %56, label %50

; <label>:56                                      ; preds = %50
  %57 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 5
  %58 = bitcast i8* %57 to i32*
  %59 = bitcast [10240 x i8]* %buffer to i32*
  %60 = load i32* %58, align 1
  store i32 %60, i32* %59, align 16
  %61 = trunc i32 %60 to i8
  br label %62

; <label>:62                                      ; preds = %._crit_edge722, %56
  %63 = phi i8 [ %61, %56 ], [ %.pre724, %._crit_edge722 ]
  %indvars.iv692 = phi i64 [ 1, %56 ], [ %phitmp744, %._crit_edge722 ]
  %v9.0327 = phi i32 [ 0, %56 ], [ %65, %._crit_edge722 ]
  %64 = zext i8 %63 to i32
  %65 = add nsw i32 %64, %v9.0327
  %exitcond694 = icmp eq i64 %indvars.iv692, 10240
  br i1 %exitcond694, label %66, label %._crit_edge722

._crit_edge722:                                   ; preds = %62
  %.phi.trans.insert723 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv692
  %.pre724 = load i8* %.phi.trans.insert723, align 1, !tbaa !1
  %phitmp744 = add i64 %indvars.iv692, 1
  br label %62

; <label>:66                                      ; preds = %62
  %67 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %65) #2
  br label %68

; <label>:68                                      ; preds = %68, %66
  %indvars.iv688 = phi i64 [ 0, %66 ], [ %indvars.iv.next689, %68 ]
  %69 = load volatile i32* %seed, align 4
  %70 = trunc i64 %indvars.iv688 to i32
  %71 = mul nsw i32 %69, %70
  %72 = trunc i32 %71 to i8
  %73 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv688
  store i8 %72, i8* %73, align 1, !tbaa !1
  %indvars.iv.next689 = add nuw nsw i64 %indvars.iv688, 1
  %exitcond690 = icmp eq i64 %indvars.iv.next689, 10240
  br i1 %exitcond690, label %74, label %68

; <label>:74                                      ; preds = %68
  %75 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %75, i64 5, i32 2, i1 false)
  br label %76

; <label>:76                                      ; preds = %76, %74
  %indvars.iv685 = phi i64 [ 0, %74 ], [ %indvars.iv.next686, %76 ]
  %v12.0324 = phi i32 [ 0, %74 ], [ %80, %76 ]
  %77 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv685
  %78 = load i8* %77, align 1, !tbaa !1
  %79 = zext i8 %78 to i32
  %80 = add nsw i32 %79, %v12.0324
  %indvars.iv.next686 = add nuw nsw i64 %indvars.iv685, 1
  %exitcond687 = icmp eq i64 %indvars.iv.next686, 10240
  br i1 %exitcond687, label %81, label %76

; <label>:81                                      ; preds = %76
  %82 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %80) #2
  br label %83

; <label>:83                                      ; preds = %83, %81
  %indvars.iv681 = phi i64 [ 0, %81 ], [ %indvars.iv.next682, %83 ]
  %84 = load volatile i32* %seed, align 4
  %85 = trunc i64 %indvars.iv681 to i32
  %86 = mul nsw i32 %84, %85
  %87 = trunc i32 %86 to i8
  %88 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv681
  store i8 %87, i8* %88, align 1, !tbaa !1
  %indvars.iv.next682 = add nuw nsw i64 %indvars.iv681, 1
  %exitcond683 = icmp eq i64 %indvars.iv.next682, 10240
  br i1 %exitcond683, label %89, label %83

; <label>:89                                      ; preds = %83
  %90 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 7
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %90, i64 6, i32 1, i1 false)
  br label %91

; <label>:91                                      ; preds = %91, %89
  %indvars.iv678 = phi i64 [ 0, %89 ], [ %indvars.iv.next679, %91 ]
  %v15.0321 = phi i32 [ 0, %89 ], [ %95, %91 ]
  %92 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv678
  %93 = load i8* %92, align 1, !tbaa !1
  %94 = zext i8 %93 to i32
  %95 = add nsw i32 %94, %v15.0321
  %indvars.iv.next679 = add nuw nsw i64 %indvars.iv678, 1
  %exitcond680 = icmp eq i64 %indvars.iv.next679, 10240
  br i1 %exitcond680, label %96, label %91

; <label>:96                                      ; preds = %91
  %97 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %95) #2
  br label %98

; <label>:98                                      ; preds = %98, %96
  %indvars.iv674 = phi i64 [ 0, %96 ], [ %indvars.iv.next675, %98 ]
  %99 = load volatile i32* %seed, align 4
  %100 = trunc i64 %indvars.iv674 to i32
  %101 = mul nsw i32 %99, %100
  %102 = trunc i32 %101 to i8
  %103 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv674
  store i8 %102, i8* %103, align 1, !tbaa !1
  %indvars.iv.next675 = add nuw nsw i64 %indvars.iv674, 1
  %exitcond676 = icmp eq i64 %indvars.iv.next675, 10240
  br i1 %exitcond676, label %104, label %98

; <label>:104                                     ; preds = %98
  %105 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %105, i64 7, i32 8, i1 false)
  br label %106

; <label>:106                                     ; preds = %106, %104
  %indvars.iv671 = phi i64 [ 0, %104 ], [ %indvars.iv.next672, %106 ]
  %v18.0318 = phi i32 [ 0, %104 ], [ %110, %106 ]
  %107 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv671
  %108 = load i8* %107, align 1, !tbaa !1
  %109 = zext i8 %108 to i32
  %110 = add nsw i32 %109, %v18.0318
  %indvars.iv.next672 = add nuw nsw i64 %indvars.iv671, 1
  %exitcond673 = icmp eq i64 %indvars.iv.next672, 10240
  br i1 %exitcond673, label %111, label %106

; <label>:111                                     ; preds = %106
  %112 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %110) #2
  br label %113

; <label>:113                                     ; preds = %113, %111
  %indvars.iv667 = phi i64 [ 0, %111 ], [ %indvars.iv.next668, %113 ]
  %114 = load volatile i32* %seed, align 4
  %115 = trunc i64 %indvars.iv667 to i32
  %116 = mul nsw i32 %114, %115
  %117 = trunc i32 %116 to i8
  %118 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv667
  store i8 %117, i8* %118, align 1, !tbaa !1
  %indvars.iv.next668 = add nuw nsw i64 %indvars.iv667, 1
  %exitcond669 = icmp eq i64 %indvars.iv.next668, 10240
  br i1 %exitcond669, label %119, label %113

; <label>:119                                     ; preds = %113
  %120 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 9
  %121 = bitcast i8* %120 to i64*
  %122 = bitcast [10240 x i8]* %buffer to i64*
  %123 = load i64* %121, align 1
  store i64 %123, i64* %122, align 16
  %124 = trunc i64 %123 to i8
  br label %125

; <label>:125                                     ; preds = %._crit_edge725, %119
  %126 = phi i8 [ %124, %119 ], [ %.pre727, %._crit_edge725 ]
  %indvars.iv664 = phi i64 [ 1, %119 ], [ %phitmp745, %._crit_edge725 ]
  %v21.0315 = phi i32 [ 0, %119 ], [ %128, %._crit_edge725 ]
  %127 = zext i8 %126 to i32
  %128 = add nsw i32 %127, %v21.0315
  %exitcond666 = icmp eq i64 %indvars.iv664, 10240
  br i1 %exitcond666, label %129, label %._crit_edge725

._crit_edge725:                                   ; preds = %125
  %.phi.trans.insert726 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv664
  %.pre727 = load i8* %.phi.trans.insert726, align 1, !tbaa !1
  %phitmp745 = add i64 %indvars.iv664, 1
  br label %125

; <label>:129                                     ; preds = %125
  %130 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %128) #2
  br label %131

; <label>:131                                     ; preds = %131, %129
  %indvars.iv660 = phi i64 [ 0, %129 ], [ %indvars.iv.next661, %131 ]
  %132 = load volatile i32* %seed, align 4
  %133 = trunc i64 %indvars.iv660 to i32
  %134 = mul nsw i32 %132, %133
  %135 = trunc i32 %134 to i8
  %136 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv660
  store i8 %135, i8* %136, align 1, !tbaa !1
  %indvars.iv.next661 = add nuw nsw i64 %indvars.iv660, 1
  %exitcond662 = icmp eq i64 %indvars.iv.next661, 10240
  br i1 %exitcond662, label %137, label %131

; <label>:137                                     ; preds = %131
  %138 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 10
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %138, i64 9, i32 2, i1 false)
  br label %139

; <label>:139                                     ; preds = %139, %137
  %indvars.iv657 = phi i64 [ 0, %137 ], [ %indvars.iv.next658, %139 ]
  %v24.0312 = phi i32 [ 0, %137 ], [ %143, %139 ]
  %140 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv657
  %141 = load i8* %140, align 1, !tbaa !1
  %142 = zext i8 %141 to i32
  %143 = add nsw i32 %142, %v24.0312
  %indvars.iv.next658 = add nuw nsw i64 %indvars.iv657, 1
  %exitcond659 = icmp eq i64 %indvars.iv.next658, 10240
  br i1 %exitcond659, label %144, label %139

; <label>:144                                     ; preds = %139
  %145 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %143) #2
  br label %146

; <label>:146                                     ; preds = %146, %144
  %indvars.iv653 = phi i64 [ 0, %144 ], [ %indvars.iv.next654, %146 ]
  %147 = load volatile i32* %seed, align 4
  %148 = trunc i64 %indvars.iv653 to i32
  %149 = mul nsw i32 %147, %148
  %150 = trunc i32 %149 to i8
  %151 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv653
  store i8 %150, i8* %151, align 1, !tbaa !1
  %indvars.iv.next654 = add nuw nsw i64 %indvars.iv653, 1
  %exitcond655 = icmp eq i64 %indvars.iv.next654, 10240
  br i1 %exitcond655, label %152, label %146

; <label>:152                                     ; preds = %146
  %153 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 11
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %153, i64 10, i32 1, i1 false)
  br label %154

; <label>:154                                     ; preds = %154, %152
  %indvars.iv650 = phi i64 [ 0, %152 ], [ %indvars.iv.next651, %154 ]
  %v27.0309 = phi i32 [ 0, %152 ], [ %158, %154 ]
  %155 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv650
  %156 = load i8* %155, align 1, !tbaa !1
  %157 = zext i8 %156 to i32
  %158 = add nsw i32 %157, %v27.0309
  %indvars.iv.next651 = add nuw nsw i64 %indvars.iv650, 1
  %exitcond652 = icmp eq i64 %indvars.iv.next651, 10240
  br i1 %exitcond652, label %159, label %154

; <label>:159                                     ; preds = %154
  %160 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %158) #2
  br label %161

; <label>:161                                     ; preds = %161, %159
  %indvars.iv646 = phi i64 [ 0, %159 ], [ %indvars.iv.next647, %161 ]
  %162 = load volatile i32* %seed, align 4
  %163 = trunc i64 %indvars.iv646 to i32
  %164 = mul nsw i32 %162, %163
  %165 = trunc i32 %164 to i8
  %166 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv646
  store i8 %165, i8* %166, align 1, !tbaa !1
  %indvars.iv.next647 = add nuw nsw i64 %indvars.iv646, 1
  %exitcond648 = icmp eq i64 %indvars.iv.next647, 10240
  br i1 %exitcond648, label %167, label %161

; <label>:167                                     ; preds = %161
  %168 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 17
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %168, i64 16, i32 1, i1 false)
  br label %169

; <label>:169                                     ; preds = %169, %167
  %indvars.iv643 = phi i64 [ 0, %167 ], [ %indvars.iv.next644, %169 ]
  %v30.0306 = phi i32 [ 0, %167 ], [ %173, %169 ]
  %170 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv643
  %171 = load i8* %170, align 1, !tbaa !1
  %172 = zext i8 %171 to i32
  %173 = add nsw i32 %172, %v30.0306
  %indvars.iv.next644 = add nuw nsw i64 %indvars.iv643, 1
  %exitcond645 = icmp eq i64 %indvars.iv.next644, 10240
  br i1 %exitcond645, label %174, label %169

; <label>:174                                     ; preds = %169
  %175 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %173) #2
  br label %176

; <label>:176                                     ; preds = %176, %174
  %indvars.iv639 = phi i64 [ 0, %174 ], [ %indvars.iv.next640, %176 ]
  %177 = load volatile i32* %seed, align 4
  %178 = trunc i64 %indvars.iv639 to i32
  %179 = mul nsw i32 %177, %178
  %180 = trunc i32 %179 to i8
  %181 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv639
  store i8 %180, i8* %181, align 1, !tbaa !1
  %indvars.iv.next640 = add nuw nsw i64 %indvars.iv639, 1
  %exitcond641 = icmp eq i64 %indvars.iv.next640, 10240
  br i1 %exitcond641, label %182, label %176

; <label>:182                                     ; preds = %176
  %183 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 33
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %183, i64 32, i32 1, i1 false)
  br label %184

; <label>:184                                     ; preds = %184, %182
  %indvars.iv636 = phi i64 [ 0, %182 ], [ %indvars.iv.next637, %184 ]
  %v33.0303 = phi i32 [ 0, %182 ], [ %188, %184 ]
  %185 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv636
  %186 = load i8* %185, align 1, !tbaa !1
  %187 = zext i8 %186 to i32
  %188 = add nsw i32 %187, %v33.0303
  %indvars.iv.next637 = add nuw nsw i64 %indvars.iv636, 1
  %exitcond638 = icmp eq i64 %indvars.iv.next637, 10240
  br i1 %exitcond638, label %189, label %184

; <label>:189                                     ; preds = %184
  %190 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %188) #2
  br label %191

; <label>:191                                     ; preds = %191, %189
  %indvars.iv632 = phi i64 [ 0, %189 ], [ %indvars.iv.next633, %191 ]
  %192 = load volatile i32* %seed, align 4
  %193 = trunc i64 %indvars.iv632 to i32
  %194 = mul nsw i32 %192, %193
  %195 = trunc i32 %194 to i8
  %196 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv632
  store i8 %195, i8* %196, align 1, !tbaa !1
  %indvars.iv.next633 = add nuw nsw i64 %indvars.iv632, 1
  %exitcond634 = icmp eq i64 %indvars.iv.next633, 10240
  br i1 %exitcond634, label %197, label %191

; <label>:197                                     ; preds = %191
  %198 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 65
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %198, i64 64, i32 1, i1 false)
  br label %199

; <label>:199                                     ; preds = %199, %197
  %indvars.iv629 = phi i64 [ 0, %197 ], [ %indvars.iv.next630, %199 ]
  %v36.0300 = phi i32 [ 0, %197 ], [ %203, %199 ]
  %200 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv629
  %201 = load i8* %200, align 1, !tbaa !1
  %202 = zext i8 %201 to i32
  %203 = add nsw i32 %202, %v36.0300
  %indvars.iv.next630 = add nuw nsw i64 %indvars.iv629, 1
  %exitcond631 = icmp eq i64 %indvars.iv.next630, 10240
  br i1 %exitcond631, label %204, label %199

; <label>:204                                     ; preds = %199
  %205 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %203) #2
  br label %206

; <label>:206                                     ; preds = %206, %204
  %indvars.iv625 = phi i64 [ 0, %204 ], [ %indvars.iv.next626, %206 ]
  %207 = load volatile i32* %seed, align 4
  %208 = trunc i64 %indvars.iv625 to i32
  %209 = mul nsw i32 %207, %208
  %210 = trunc i32 %209 to i8
  %211 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv625
  store i8 %210, i8* %211, align 1, !tbaa !1
  %indvars.iv.next626 = add nuw nsw i64 %indvars.iv625, 1
  %exitcond627 = icmp eq i64 %indvars.iv.next626, 10240
  br i1 %exitcond627, label %212, label %206

; <label>:212                                     ; preds = %206
  %213 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 129
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %213, i64 128, i32 1, i1 false)
  br label %214

; <label>:214                                     ; preds = %214, %212
  %indvars.iv622 = phi i64 [ 0, %212 ], [ %indvars.iv.next623, %214 ]
  %v39.0297 = phi i32 [ 0, %212 ], [ %218, %214 ]
  %215 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv622
  %216 = load i8* %215, align 1, !tbaa !1
  %217 = zext i8 %216 to i32
  %218 = add nsw i32 %217, %v39.0297
  %indvars.iv.next623 = add nuw nsw i64 %indvars.iv622, 1
  %exitcond624 = icmp eq i64 %indvars.iv.next623, 10240
  br i1 %exitcond624, label %219, label %214

; <label>:219                                     ; preds = %214
  %220 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %218) #2
  br label %221

; <label>:221                                     ; preds = %221, %219
  %indvars.iv618 = phi i64 [ 0, %219 ], [ %indvars.iv.next619, %221 ]
  %222 = load volatile i32* %seed, align 4
  %223 = trunc i64 %indvars.iv618 to i32
  %224 = mul nsw i32 %222, %223
  %225 = trunc i32 %224 to i8
  %226 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv618
  store i8 %225, i8* %226, align 1, !tbaa !1
  %indvars.iv.next619 = add nuw nsw i64 %indvars.iv618, 1
  %exitcond620 = icmp eq i64 %indvars.iv.next619, 10240
  br i1 %exitcond620, label %227, label %221

; <label>:227                                     ; preds = %221
  %228 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 257
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %228, i64 256, i32 1, i1 false)
  br label %229

; <label>:229                                     ; preds = %229, %227
  %indvars.iv615 = phi i64 [ 0, %227 ], [ %indvars.iv.next616, %229 ]
  %v42.0294 = phi i32 [ 0, %227 ], [ %233, %229 ]
  %230 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv615
  %231 = load i8* %230, align 1, !tbaa !1
  %232 = zext i8 %231 to i32
  %233 = add nsw i32 %232, %v42.0294
  %indvars.iv.next616 = add nuw nsw i64 %indvars.iv615, 1
  %exitcond617 = icmp eq i64 %indvars.iv.next616, 10240
  br i1 %exitcond617, label %234, label %229

; <label>:234                                     ; preds = %229
  %235 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %233) #2
  br label %236

; <label>:236                                     ; preds = %236, %234
  %indvars.iv611 = phi i64 [ 0, %234 ], [ %indvars.iv.next612, %236 ]
  %237 = load volatile i32* %seed, align 4
  %238 = trunc i64 %indvars.iv611 to i32
  %239 = mul nsw i32 %237, %238
  %240 = trunc i32 %239 to i8
  %241 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv611
  store i8 %240, i8* %241, align 1, !tbaa !1
  %indvars.iv.next612 = add nuw nsw i64 %indvars.iv611, 1
  %exitcond613 = icmp eq i64 %indvars.iv.next612, 10240
  br i1 %exitcond613, label %242, label %236

; <label>:242                                     ; preds = %236
  %243 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 513
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %243, i64 512, i32 1, i1 false)
  br label %244

; <label>:244                                     ; preds = %244, %242
  %indvars.iv608 = phi i64 [ 0, %242 ], [ %indvars.iv.next609, %244 ]
  %v45.0291 = phi i32 [ 0, %242 ], [ %248, %244 ]
  %245 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv608
  %246 = load i8* %245, align 1, !tbaa !1
  %247 = zext i8 %246 to i32
  %248 = add nsw i32 %247, %v45.0291
  %indvars.iv.next609 = add nuw nsw i64 %indvars.iv608, 1
  %exitcond610 = icmp eq i64 %indvars.iv.next609, 10240
  br i1 %exitcond610, label %249, label %244

; <label>:249                                     ; preds = %244
  %250 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %248) #2
  br label %251

; <label>:251                                     ; preds = %251, %249
  %indvars.iv604 = phi i64 [ 0, %249 ], [ %indvars.iv.next605, %251 ]
  %252 = load volatile i32* %seed, align 4
  %253 = trunc i64 %indvars.iv604 to i32
  %254 = mul nsw i32 %252, %253
  %255 = trunc i32 %254 to i8
  %256 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv604
  store i8 %255, i8* %256, align 1, !tbaa !1
  %indvars.iv.next605 = add nuw nsw i64 %indvars.iv604, 1
  %exitcond606 = icmp eq i64 %indvars.iv.next605, 10240
  br i1 %exitcond606, label %257, label %251

; <label>:257                                     ; preds = %251
  %258 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 1025
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %258, i64 1024, i32 1, i1 false)
  br label %259

; <label>:259                                     ; preds = %259, %257
  %indvars.iv601 = phi i64 [ 0, %257 ], [ %indvars.iv.next602, %259 ]
  %v48.0288 = phi i32 [ 0, %257 ], [ %263, %259 ]
  %260 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv601
  %261 = load i8* %260, align 1, !tbaa !1
  %262 = zext i8 %261 to i32
  %263 = add nsw i32 %262, %v48.0288
  %indvars.iv.next602 = add nuw nsw i64 %indvars.iv601, 1
  %exitcond603 = icmp eq i64 %indvars.iv.next602, 10240
  br i1 %exitcond603, label %264, label %259

; <label>:264                                     ; preds = %259
  %265 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %263) #2
  br label %.preheader283

.preheader283:                                    ; preds = %279, %264
  %indvars.iv598 = phi i64 [ 10, %264 ], [ %indvars.iv.next599, %279 ]
  br label %266

; <label>:266                                     ; preds = %266, %.preheader283
  %indvars.iv591 = phi i64 [ 0, %.preheader283 ], [ %indvars.iv.next592, %266 ]
  %267 = load volatile i32* %seed, align 4
  %268 = trunc i64 %indvars.iv591 to i32
  %269 = mul nsw i32 %267, %268
  %270 = trunc i32 %269 to i8
  %271 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv591
  store i8 %270, i8* %271, align 1, !tbaa !1
  %indvars.iv.next592 = add nuw nsw i64 %indvars.iv591, 1
  %exitcond593 = icmp eq i64 %indvars.iv.next592, 10240
  br i1 %exitcond593, label %272, label %266

; <label>:272                                     ; preds = %266
  %.sum171 = or i64 %indvars.iv598, 1
  %273 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %.sum171
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %273, i64 %indvars.iv598, i32 1, i1 false)
  br label %274

; <label>:274                                     ; preds = %274, %272
  %indvars.iv595 = phi i64 [ 0, %272 ], [ %indvars.iv.next596, %274 ]
  %v51.0285 = phi i32 [ 0, %272 ], [ %278, %274 ]
  %275 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv595
  %276 = load i8* %275, align 1, !tbaa !1
  %277 = zext i8 %276 to i32
  %278 = add nsw i32 %277, %v51.0285
  %indvars.iv.next596 = add nuw nsw i64 %indvars.iv595, 1
  %exitcond597 = icmp eq i64 %indvars.iv.next596, 10240
  br i1 %exitcond597, label %279, label %274

; <label>:279                                     ; preds = %274
  %280 = trunc i64 %indvars.iv598 to i32
  %281 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %280, i32 %278) #2
  %indvars.iv.next599 = add nuw nsw i64 %indvars.iv598, 10
  %282 = trunc i64 %indvars.iv.next599 to i32
  %283 = icmp slt i32 %282, 100
  br i1 %283, label %.preheader283, label %284

; <label>:284                                     ; preds = %279
  call void @llvm.lifetime.end(i64 10240, i8* %1) #2
  %puts167 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str4, i64 0, i64 0))
  %285 = bitcast [10240 x i16]* %buffer53 to i8*
  call void @llvm.lifetime.start(i64 20480, i8* %285) #2
  store volatile i32 123, i32* %seed54, align 4
  br label %286

; <label>:286                                     ; preds = %286, %284
  %indvars.iv588 = phi i64 [ 0, %284 ], [ %indvars.iv.next589, %286 ]
  %287 = load volatile i32* %seed54, align 4
  %288 = trunc i64 %indvars.iv588 to i32
  %289 = mul nsw i32 %287, %288
  %290 = trunc i32 %289 to i16
  %291 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv588
  store i16 %290, i16* %291, align 2, !tbaa !4
  %indvars.iv.next589 = add nuw nsw i64 %indvars.iv588, 1
  %exitcond590 = icmp eq i64 %indvars.iv.next589, 10240
  br i1 %exitcond590, label %292, label %286

; <label>:292                                     ; preds = %286
  %293 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 2
  %294 = load i16* %293, align 4
  %295 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 0
  store i16 %294, i16* %295, align 16
  br label %296

; <label>:296                                     ; preds = %._crit_edge728, %292
  %297 = phi i16 [ %294, %292 ], [ %.pre730, %._crit_edge728 ]
  %indvars.iv585 = phi i64 [ 1, %292 ], [ %phitmp746, %._crit_edge728 ]
  %v56.0280 = phi i32 [ 0, %292 ], [ %299, %._crit_edge728 ]
  %298 = zext i16 %297 to i32
  %299 = add nsw i32 %298, %v56.0280
  %exitcond587 = icmp eq i64 %indvars.iv585, 10240
  br i1 %exitcond587, label %300, label %._crit_edge728

._crit_edge728:                                   ; preds = %296
  %.phi.trans.insert729 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv585
  %.pre730 = load i16* %.phi.trans.insert729, align 2, !tbaa !4
  %phitmp746 = add i64 %indvars.iv585, 1
  br label %296

; <label>:300                                     ; preds = %296
  %301 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %299) #2
  br label %302

; <label>:302                                     ; preds = %302, %300
  %indvars.iv581 = phi i64 [ 0, %300 ], [ %indvars.iv.next582, %302 ]
  %303 = load volatile i32* %seed54, align 4
  %304 = trunc i64 %indvars.iv581 to i32
  %305 = mul nsw i32 %303, %304
  %306 = trunc i32 %305 to i16
  %307 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv581
  store i16 %306, i16* %307, align 2, !tbaa !4
  %indvars.iv.next582 = add nuw nsw i64 %indvars.iv581, 1
  %exitcond583 = icmp eq i64 %indvars.iv.next582, 10240
  br i1 %exitcond583, label %308, label %302

; <label>:308                                     ; preds = %302
  %309 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 3
  %310 = bitcast i16* %309 to i32*
  %311 = bitcast [10240 x i16]* %buffer53 to i32*
  %312 = load i32* %310, align 2
  store i32 %312, i32* %311, align 16
  %313 = trunc i32 %312 to i16
  br label %314

; <label>:314                                     ; preds = %._crit_edge731, %308
  %315 = phi i16 [ %313, %308 ], [ %.pre733, %._crit_edge731 ]
  %indvars.iv578 = phi i64 [ 1, %308 ], [ %phitmp747, %._crit_edge731 ]
  %v59.0277 = phi i32 [ 0, %308 ], [ %317, %._crit_edge731 ]
  %316 = zext i16 %315 to i32
  %317 = add nsw i32 %316, %v59.0277
  %exitcond580 = icmp eq i64 %indvars.iv578, 10240
  br i1 %exitcond580, label %318, label %._crit_edge731

._crit_edge731:                                   ; preds = %314
  %.phi.trans.insert732 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv578
  %.pre733 = load i16* %.phi.trans.insert732, align 2, !tbaa !4
  %phitmp747 = add i64 %indvars.iv578, 1
  br label %314

; <label>:318                                     ; preds = %314
  %319 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %317) #2
  br label %320

; <label>:320                                     ; preds = %320, %318
  %indvars.iv574 = phi i64 [ 0, %318 ], [ %indvars.iv.next575, %320 ]
  %321 = load volatile i32* %seed54, align 4
  %322 = trunc i64 %indvars.iv574 to i32
  %323 = mul nsw i32 %321, %322
  %324 = trunc i32 %323 to i16
  %325 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv574
  store i16 %324, i16* %325, align 2, !tbaa !4
  %indvars.iv.next575 = add nuw nsw i64 %indvars.iv574, 1
  %exitcond576 = icmp eq i64 %indvars.iv.next575, 10240
  br i1 %exitcond576, label %326, label %320

; <label>:326                                     ; preds = %320
  %327 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 4
  %328 = bitcast i16* %327 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %328, i64 6, i32 8, i1 false)
  br label %329

; <label>:329                                     ; preds = %329, %326
  %indvars.iv571 = phi i64 [ 0, %326 ], [ %indvars.iv.next572, %329 ]
  %v62.0274 = phi i32 [ 0, %326 ], [ %333, %329 ]
  %330 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv571
  %331 = load i16* %330, align 2, !tbaa !4
  %332 = zext i16 %331 to i32
  %333 = add nsw i32 %332, %v62.0274
  %indvars.iv.next572 = add nuw nsw i64 %indvars.iv571, 1
  %exitcond573 = icmp eq i64 %indvars.iv.next572, 10240
  br i1 %exitcond573, label %334, label %329

; <label>:334                                     ; preds = %329
  %335 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %333) #2
  br label %336

; <label>:336                                     ; preds = %336, %334
  %indvars.iv567 = phi i64 [ 0, %334 ], [ %indvars.iv.next568, %336 ]
  %337 = load volatile i32* %seed54, align 4
  %338 = trunc i64 %indvars.iv567 to i32
  %339 = mul nsw i32 %337, %338
  %340 = trunc i32 %339 to i16
  %341 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv567
  store i16 %340, i16* %341, align 2, !tbaa !4
  %indvars.iv.next568 = add nuw nsw i64 %indvars.iv567, 1
  %exitcond569 = icmp eq i64 %indvars.iv.next568, 10240
  br i1 %exitcond569, label %342, label %336

; <label>:342                                     ; preds = %336
  %343 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 5
  %344 = bitcast i16* %343 to i64*
  %345 = bitcast [10240 x i16]* %buffer53 to i64*
  %346 = load i64* %344, align 2
  store i64 %346, i64* %345, align 16
  %347 = trunc i64 %346 to i16
  br label %348

; <label>:348                                     ; preds = %._crit_edge734, %342
  %349 = phi i16 [ %347, %342 ], [ %.pre736, %._crit_edge734 ]
  %indvars.iv564 = phi i64 [ 1, %342 ], [ %phitmp748, %._crit_edge734 ]
  %v65.0271 = phi i32 [ 0, %342 ], [ %351, %._crit_edge734 ]
  %350 = zext i16 %349 to i32
  %351 = add nsw i32 %350, %v65.0271
  %exitcond566 = icmp eq i64 %indvars.iv564, 10240
  br i1 %exitcond566, label %352, label %._crit_edge734

._crit_edge734:                                   ; preds = %348
  %.phi.trans.insert735 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv564
  %.pre736 = load i16* %.phi.trans.insert735, align 2, !tbaa !4
  %phitmp748 = add i64 %indvars.iv564, 1
  br label %348

; <label>:352                                     ; preds = %348
  %353 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %351) #2
  br label %354

; <label>:354                                     ; preds = %354, %352
  %indvars.iv560 = phi i64 [ 0, %352 ], [ %indvars.iv.next561, %354 ]
  %355 = load volatile i32* %seed54, align 4
  %356 = trunc i64 %indvars.iv560 to i32
  %357 = mul nsw i32 %355, %356
  %358 = trunc i32 %357 to i16
  %359 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv560
  store i16 %358, i16* %359, align 2, !tbaa !4
  %indvars.iv.next561 = add nuw nsw i64 %indvars.iv560, 1
  %exitcond562 = icmp eq i64 %indvars.iv.next561, 10240
  br i1 %exitcond562, label %360, label %354

; <label>:360                                     ; preds = %354
  %361 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 6
  %362 = bitcast i16* %361 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %362, i64 10, i32 4, i1 false)
  br label %363

; <label>:363                                     ; preds = %363, %360
  %indvars.iv557 = phi i64 [ 0, %360 ], [ %indvars.iv.next558, %363 ]
  %v68.0268 = phi i32 [ 0, %360 ], [ %367, %363 ]
  %364 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv557
  %365 = load i16* %364, align 2, !tbaa !4
  %366 = zext i16 %365 to i32
  %367 = add nsw i32 %366, %v68.0268
  %indvars.iv.next558 = add nuw nsw i64 %indvars.iv557, 1
  %exitcond559 = icmp eq i64 %indvars.iv.next558, 10240
  br i1 %exitcond559, label %368, label %363

; <label>:368                                     ; preds = %363
  %369 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %367) #2
  br label %370

; <label>:370                                     ; preds = %370, %368
  %indvars.iv553 = phi i64 [ 0, %368 ], [ %indvars.iv.next554, %370 ]
  %371 = load volatile i32* %seed54, align 4
  %372 = trunc i64 %indvars.iv553 to i32
  %373 = mul nsw i32 %371, %372
  %374 = trunc i32 %373 to i16
  %375 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv553
  store i16 %374, i16* %375, align 2, !tbaa !4
  %indvars.iv.next554 = add nuw nsw i64 %indvars.iv553, 1
  %exitcond555 = icmp eq i64 %indvars.iv.next554, 10240
  br i1 %exitcond555, label %376, label %370

; <label>:376                                     ; preds = %370
  %377 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 7
  %378 = bitcast i16* %377 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %378, i64 12, i32 2, i1 false)
  br label %379

; <label>:379                                     ; preds = %379, %376
  %indvars.iv550 = phi i64 [ 0, %376 ], [ %indvars.iv.next551, %379 ]
  %v71.0265 = phi i32 [ 0, %376 ], [ %383, %379 ]
  %380 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv550
  %381 = load i16* %380, align 2, !tbaa !4
  %382 = zext i16 %381 to i32
  %383 = add nsw i32 %382, %v71.0265
  %indvars.iv.next551 = add nuw nsw i64 %indvars.iv550, 1
  %exitcond552 = icmp eq i64 %indvars.iv.next551, 10240
  br i1 %exitcond552, label %384, label %379

; <label>:384                                     ; preds = %379
  %385 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %383) #2
  br label %386

; <label>:386                                     ; preds = %386, %384
  %indvars.iv546 = phi i64 [ 0, %384 ], [ %indvars.iv.next547, %386 ]
  %387 = load volatile i32* %seed54, align 4
  %388 = trunc i64 %indvars.iv546 to i32
  %389 = mul nsw i32 %387, %388
  %390 = trunc i32 %389 to i16
  %391 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv546
  store i16 %390, i16* %391, align 2, !tbaa !4
  %indvars.iv.next547 = add nuw nsw i64 %indvars.iv546, 1
  %exitcond548 = icmp eq i64 %indvars.iv.next547, 10240
  br i1 %exitcond548, label %392, label %386

; <label>:392                                     ; preds = %386
  %393 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 8
  %394 = bitcast i16* %393 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %394, i64 14, i32 16, i1 false)
  br label %395

; <label>:395                                     ; preds = %395, %392
  %indvars.iv543 = phi i64 [ 0, %392 ], [ %indvars.iv.next544, %395 ]
  %v74.0262 = phi i32 [ 0, %392 ], [ %399, %395 ]
  %396 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv543
  %397 = load i16* %396, align 2, !tbaa !4
  %398 = zext i16 %397 to i32
  %399 = add nsw i32 %398, %v74.0262
  %indvars.iv.next544 = add nuw nsw i64 %indvars.iv543, 1
  %exitcond545 = icmp eq i64 %indvars.iv.next544, 10240
  br i1 %exitcond545, label %400, label %395

; <label>:400                                     ; preds = %395
  %401 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %399) #2
  br label %402

; <label>:402                                     ; preds = %402, %400
  %indvars.iv539 = phi i64 [ 0, %400 ], [ %indvars.iv.next540, %402 ]
  %403 = load volatile i32* %seed54, align 4
  %404 = trunc i64 %indvars.iv539 to i32
  %405 = mul nsw i32 %403, %404
  %406 = trunc i32 %405 to i16
  %407 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv539
  store i16 %406, i16* %407, align 2, !tbaa !4
  %indvars.iv.next540 = add nuw nsw i64 %indvars.iv539, 1
  %exitcond541 = icmp eq i64 %indvars.iv.next540, 10240
  br i1 %exitcond541, label %408, label %402

; <label>:408                                     ; preds = %402
  %409 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 9
  %410 = bitcast i16* %409 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %410, i64 16, i32 2, i1 false)
  br label %411

; <label>:411                                     ; preds = %411, %408
  %indvars.iv536 = phi i64 [ 0, %408 ], [ %indvars.iv.next537, %411 ]
  %v77.0259 = phi i32 [ 0, %408 ], [ %415, %411 ]
  %412 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv536
  %413 = load i16* %412, align 2, !tbaa !4
  %414 = zext i16 %413 to i32
  %415 = add nsw i32 %414, %v77.0259
  %indvars.iv.next537 = add nuw nsw i64 %indvars.iv536, 1
  %exitcond538 = icmp eq i64 %indvars.iv.next537, 10240
  br i1 %exitcond538, label %416, label %411

; <label>:416                                     ; preds = %411
  %417 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %415) #2
  br label %418

; <label>:418                                     ; preds = %418, %416
  %indvars.iv532 = phi i64 [ 0, %416 ], [ %indvars.iv.next533, %418 ]
  %419 = load volatile i32* %seed54, align 4
  %420 = trunc i64 %indvars.iv532 to i32
  %421 = mul nsw i32 %419, %420
  %422 = trunc i32 %421 to i16
  %423 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv532
  store i16 %422, i16* %423, align 2, !tbaa !4
  %indvars.iv.next533 = add nuw nsw i64 %indvars.iv532, 1
  %exitcond534 = icmp eq i64 %indvars.iv.next533, 10240
  br i1 %exitcond534, label %424, label %418

; <label>:424                                     ; preds = %418
  %425 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 10
  %426 = bitcast i16* %425 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %426, i64 18, i32 4, i1 false)
  br label %427

; <label>:427                                     ; preds = %427, %424
  %indvars.iv529 = phi i64 [ 0, %424 ], [ %indvars.iv.next530, %427 ]
  %v80.0256 = phi i32 [ 0, %424 ], [ %431, %427 ]
  %428 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv529
  %429 = load i16* %428, align 2, !tbaa !4
  %430 = zext i16 %429 to i32
  %431 = add nsw i32 %430, %v80.0256
  %indvars.iv.next530 = add nuw nsw i64 %indvars.iv529, 1
  %exitcond531 = icmp eq i64 %indvars.iv.next530, 10240
  br i1 %exitcond531, label %432, label %427

; <label>:432                                     ; preds = %427
  %433 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %431) #2
  br label %434

; <label>:434                                     ; preds = %434, %432
  %indvars.iv525 = phi i64 [ 0, %432 ], [ %indvars.iv.next526, %434 ]
  %435 = load volatile i32* %seed54, align 4
  %436 = trunc i64 %indvars.iv525 to i32
  %437 = mul nsw i32 %435, %436
  %438 = trunc i32 %437 to i16
  %439 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv525
  store i16 %438, i16* %439, align 2, !tbaa !4
  %indvars.iv.next526 = add nuw nsw i64 %indvars.iv525, 1
  %exitcond527 = icmp eq i64 %indvars.iv.next526, 10240
  br i1 %exitcond527, label %440, label %434

; <label>:440                                     ; preds = %434
  %441 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 11
  %442 = bitcast i16* %441 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %442, i64 20, i32 2, i1 false)
  br label %443

; <label>:443                                     ; preds = %443, %440
  %indvars.iv522 = phi i64 [ 0, %440 ], [ %indvars.iv.next523, %443 ]
  %v83.0253 = phi i32 [ 0, %440 ], [ %447, %443 ]
  %444 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv522
  %445 = load i16* %444, align 2, !tbaa !4
  %446 = zext i16 %445 to i32
  %447 = add nsw i32 %446, %v83.0253
  %indvars.iv.next523 = add nuw nsw i64 %indvars.iv522, 1
  %exitcond524 = icmp eq i64 %indvars.iv.next523, 10240
  br i1 %exitcond524, label %448, label %443

; <label>:448                                     ; preds = %443
  %449 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %447) #2
  br label %450

; <label>:450                                     ; preds = %450, %448
  %indvars.iv518 = phi i64 [ 0, %448 ], [ %indvars.iv.next519, %450 ]
  %451 = load volatile i32* %seed54, align 4
  %452 = trunc i64 %indvars.iv518 to i32
  %453 = mul nsw i32 %451, %452
  %454 = trunc i32 %453 to i16
  %455 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv518
  store i16 %454, i16* %455, align 2, !tbaa !4
  %indvars.iv.next519 = add nuw nsw i64 %indvars.iv518, 1
  %exitcond520 = icmp eq i64 %indvars.iv.next519, 10240
  br i1 %exitcond520, label %456, label %450

; <label>:456                                     ; preds = %450
  %457 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 17
  %458 = bitcast i16* %457 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %458, i64 32, i32 2, i1 false)
  br label %459

; <label>:459                                     ; preds = %459, %456
  %indvars.iv515 = phi i64 [ 0, %456 ], [ %indvars.iv.next516, %459 ]
  %v86.0250 = phi i32 [ 0, %456 ], [ %463, %459 ]
  %460 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv515
  %461 = load i16* %460, align 2, !tbaa !4
  %462 = zext i16 %461 to i32
  %463 = add nsw i32 %462, %v86.0250
  %indvars.iv.next516 = add nuw nsw i64 %indvars.iv515, 1
  %exitcond517 = icmp eq i64 %indvars.iv.next516, 10240
  br i1 %exitcond517, label %464, label %459

; <label>:464                                     ; preds = %459
  %465 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %463) #2
  br label %466

; <label>:466                                     ; preds = %466, %464
  %indvars.iv511 = phi i64 [ 0, %464 ], [ %indvars.iv.next512, %466 ]
  %467 = load volatile i32* %seed54, align 4
  %468 = trunc i64 %indvars.iv511 to i32
  %469 = mul nsw i32 %467, %468
  %470 = trunc i32 %469 to i16
  %471 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv511
  store i16 %470, i16* %471, align 2, !tbaa !4
  %indvars.iv.next512 = add nuw nsw i64 %indvars.iv511, 1
  %exitcond513 = icmp eq i64 %indvars.iv.next512, 10240
  br i1 %exitcond513, label %472, label %466

; <label>:472                                     ; preds = %466
  %473 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 33
  %474 = bitcast i16* %473 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %474, i64 64, i32 2, i1 false)
  br label %475

; <label>:475                                     ; preds = %475, %472
  %indvars.iv508 = phi i64 [ 0, %472 ], [ %indvars.iv.next509, %475 ]
  %v89.0247 = phi i32 [ 0, %472 ], [ %479, %475 ]
  %476 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv508
  %477 = load i16* %476, align 2, !tbaa !4
  %478 = zext i16 %477 to i32
  %479 = add nsw i32 %478, %v89.0247
  %indvars.iv.next509 = add nuw nsw i64 %indvars.iv508, 1
  %exitcond510 = icmp eq i64 %indvars.iv.next509, 10240
  br i1 %exitcond510, label %480, label %475

; <label>:480                                     ; preds = %475
  %481 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %479) #2
  br label %482

; <label>:482                                     ; preds = %482, %480
  %indvars.iv504 = phi i64 [ 0, %480 ], [ %indvars.iv.next505, %482 ]
  %483 = load volatile i32* %seed54, align 4
  %484 = trunc i64 %indvars.iv504 to i32
  %485 = mul nsw i32 %483, %484
  %486 = trunc i32 %485 to i16
  %487 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv504
  store i16 %486, i16* %487, align 2, !tbaa !4
  %indvars.iv.next505 = add nuw nsw i64 %indvars.iv504, 1
  %exitcond506 = icmp eq i64 %indvars.iv.next505, 10240
  br i1 %exitcond506, label %488, label %482

; <label>:488                                     ; preds = %482
  %489 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 65
  %490 = bitcast i16* %489 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %490, i64 128, i32 2, i1 false)
  br label %491

; <label>:491                                     ; preds = %491, %488
  %indvars.iv501 = phi i64 [ 0, %488 ], [ %indvars.iv.next502, %491 ]
  %v92.0244 = phi i32 [ 0, %488 ], [ %495, %491 ]
  %492 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv501
  %493 = load i16* %492, align 2, !tbaa !4
  %494 = zext i16 %493 to i32
  %495 = add nsw i32 %494, %v92.0244
  %indvars.iv.next502 = add nuw nsw i64 %indvars.iv501, 1
  %exitcond503 = icmp eq i64 %indvars.iv.next502, 10240
  br i1 %exitcond503, label %496, label %491

; <label>:496                                     ; preds = %491
  %497 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %495) #2
  br label %498

; <label>:498                                     ; preds = %498, %496
  %indvars.iv497 = phi i64 [ 0, %496 ], [ %indvars.iv.next498, %498 ]
  %499 = load volatile i32* %seed54, align 4
  %500 = trunc i64 %indvars.iv497 to i32
  %501 = mul nsw i32 %499, %500
  %502 = trunc i32 %501 to i16
  %503 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv497
  store i16 %502, i16* %503, align 2, !tbaa !4
  %indvars.iv.next498 = add nuw nsw i64 %indvars.iv497, 1
  %exitcond499 = icmp eq i64 %indvars.iv.next498, 10240
  br i1 %exitcond499, label %504, label %498

; <label>:504                                     ; preds = %498
  %505 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 129
  %506 = bitcast i16* %505 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %506, i64 256, i32 2, i1 false)
  br label %507

; <label>:507                                     ; preds = %507, %504
  %indvars.iv494 = phi i64 [ 0, %504 ], [ %indvars.iv.next495, %507 ]
  %v95.0241 = phi i32 [ 0, %504 ], [ %511, %507 ]
  %508 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv494
  %509 = load i16* %508, align 2, !tbaa !4
  %510 = zext i16 %509 to i32
  %511 = add nsw i32 %510, %v95.0241
  %indvars.iv.next495 = add nuw nsw i64 %indvars.iv494, 1
  %exitcond496 = icmp eq i64 %indvars.iv.next495, 10240
  br i1 %exitcond496, label %512, label %507

; <label>:512                                     ; preds = %507
  %513 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %511) #2
  br label %514

; <label>:514                                     ; preds = %514, %512
  %indvars.iv490 = phi i64 [ 0, %512 ], [ %indvars.iv.next491, %514 ]
  %515 = load volatile i32* %seed54, align 4
  %516 = trunc i64 %indvars.iv490 to i32
  %517 = mul nsw i32 %515, %516
  %518 = trunc i32 %517 to i16
  %519 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv490
  store i16 %518, i16* %519, align 2, !tbaa !4
  %indvars.iv.next491 = add nuw nsw i64 %indvars.iv490, 1
  %exitcond492 = icmp eq i64 %indvars.iv.next491, 10240
  br i1 %exitcond492, label %520, label %514

; <label>:520                                     ; preds = %514
  %521 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 257
  %522 = bitcast i16* %521 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %522, i64 512, i32 2, i1 false)
  br label %523

; <label>:523                                     ; preds = %523, %520
  %indvars.iv487 = phi i64 [ 0, %520 ], [ %indvars.iv.next488, %523 ]
  %v98.0238 = phi i32 [ 0, %520 ], [ %527, %523 ]
  %524 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv487
  %525 = load i16* %524, align 2, !tbaa !4
  %526 = zext i16 %525 to i32
  %527 = add nsw i32 %526, %v98.0238
  %indvars.iv.next488 = add nuw nsw i64 %indvars.iv487, 1
  %exitcond489 = icmp eq i64 %indvars.iv.next488, 10240
  br i1 %exitcond489, label %528, label %523

; <label>:528                                     ; preds = %523
  %529 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %527) #2
  br label %530

; <label>:530                                     ; preds = %530, %528
  %indvars.iv483 = phi i64 [ 0, %528 ], [ %indvars.iv.next484, %530 ]
  %531 = load volatile i32* %seed54, align 4
  %532 = trunc i64 %indvars.iv483 to i32
  %533 = mul nsw i32 %531, %532
  %534 = trunc i32 %533 to i16
  %535 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv483
  store i16 %534, i16* %535, align 2, !tbaa !4
  %indvars.iv.next484 = add nuw nsw i64 %indvars.iv483, 1
  %exitcond485 = icmp eq i64 %indvars.iv.next484, 10240
  br i1 %exitcond485, label %536, label %530

; <label>:536                                     ; preds = %530
  %537 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 513
  %538 = bitcast i16* %537 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %538, i64 1024, i32 2, i1 false)
  br label %539

; <label>:539                                     ; preds = %539, %536
  %indvars.iv480 = phi i64 [ 0, %536 ], [ %indvars.iv.next481, %539 ]
  %v101.0235 = phi i32 [ 0, %536 ], [ %543, %539 ]
  %540 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv480
  %541 = load i16* %540, align 2, !tbaa !4
  %542 = zext i16 %541 to i32
  %543 = add nsw i32 %542, %v101.0235
  %indvars.iv.next481 = add nuw nsw i64 %indvars.iv480, 1
  %exitcond482 = icmp eq i64 %indvars.iv.next481, 10240
  br i1 %exitcond482, label %544, label %539

; <label>:544                                     ; preds = %539
  %545 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %543) #2
  br label %546

; <label>:546                                     ; preds = %546, %544
  %indvars.iv476 = phi i64 [ 0, %544 ], [ %indvars.iv.next477, %546 ]
  %547 = load volatile i32* %seed54, align 4
  %548 = trunc i64 %indvars.iv476 to i32
  %549 = mul nsw i32 %547, %548
  %550 = trunc i32 %549 to i16
  %551 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv476
  store i16 %550, i16* %551, align 2, !tbaa !4
  %indvars.iv.next477 = add nuw nsw i64 %indvars.iv476, 1
  %exitcond478 = icmp eq i64 %indvars.iv.next477, 10240
  br i1 %exitcond478, label %552, label %546

; <label>:552                                     ; preds = %546
  %553 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 1025
  %554 = bitcast i16* %553 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %554, i64 2048, i32 2, i1 false)
  br label %555

; <label>:555                                     ; preds = %555, %552
  %indvars.iv473 = phi i64 [ 0, %552 ], [ %indvars.iv.next474, %555 ]
  %v104.0232 = phi i32 [ 0, %552 ], [ %559, %555 ]
  %556 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv473
  %557 = load i16* %556, align 2, !tbaa !4
  %558 = zext i16 %557 to i32
  %559 = add nsw i32 %558, %v104.0232
  %indvars.iv.next474 = add nuw nsw i64 %indvars.iv473, 1
  %exitcond475 = icmp eq i64 %indvars.iv.next474, 10240
  br i1 %exitcond475, label %560, label %555

; <label>:560                                     ; preds = %555
  %561 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %559) #2
  br label %.preheader227

.preheader227:                                    ; preds = %577, %560
  %indvars.iv470 = phi i64 [ 10, %560 ], [ %indvars.iv.next471, %577 ]
  br label %562

; <label>:562                                     ; preds = %562, %.preheader227
  %indvars.iv463 = phi i64 [ 0, %.preheader227 ], [ %indvars.iv.next464, %562 ]
  %563 = load volatile i32* %seed54, align 4
  %564 = trunc i64 %indvars.iv463 to i32
  %565 = mul nsw i32 %563, %564
  %566 = trunc i32 %565 to i16
  %567 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv463
  store i16 %566, i16* %567, align 2, !tbaa !4
  %indvars.iv.next464 = add nuw nsw i64 %indvars.iv463, 1
  %exitcond465 = icmp eq i64 %indvars.iv.next464, 10240
  br i1 %exitcond465, label %568, label %562

; <label>:568                                     ; preds = %562
  %.sum170 = or i64 %indvars.iv470, 1
  %569 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %.sum170
  %570 = bitcast i16* %569 to i8*
  %571 = shl nsw i64 %indvars.iv470, 1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %285, i8* %570, i64 %571, i32 2, i1 false)
  br label %572

; <label>:572                                     ; preds = %572, %568
  %indvars.iv467 = phi i64 [ 0, %568 ], [ %indvars.iv.next468, %572 ]
  %v108.0229 = phi i32 [ 0, %568 ], [ %576, %572 ]
  %573 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv467
  %574 = load i16* %573, align 2, !tbaa !4
  %575 = zext i16 %574 to i32
  %576 = add nsw i32 %575, %v108.0229
  %indvars.iv.next468 = add nuw nsw i64 %indvars.iv467, 1
  %exitcond469 = icmp eq i64 %indvars.iv.next468, 10240
  br i1 %exitcond469, label %577, label %572

; <label>:577                                     ; preds = %572
  %578 = trunc i64 %indvars.iv470 to i32
  %579 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %578, i32 %576) #2
  %indvars.iv.next471 = add nuw nsw i64 %indvars.iv470, 10
  %580 = trunc i64 %indvars.iv.next471 to i32
  %581 = icmp slt i32 %580, 100
  br i1 %581, label %.preheader227, label %582

; <label>:582                                     ; preds = %577
  call void @llvm.lifetime.end(i64 20480, i8* %285) #2
  %puts168 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str5, i64 0, i64 0))
  %583 = bitcast [10240 x i32]* %buffer110 to i8*
  call void @llvm.lifetime.start(i64 40960, i8* %583) #2
  store volatile i32 123, i32* %seed111, align 4
  br label %584

; <label>:584                                     ; preds = %584, %582
  %indvars.iv460 = phi i64 [ 0, %582 ], [ %indvars.iv.next461, %584 ]
  %585 = load volatile i32* %seed111, align 4
  %586 = trunc i64 %indvars.iv460 to i32
  %587 = mul nsw i32 %585, %586
  %588 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv460
  store i32 %587, i32* %588, align 4, !tbaa !6
  %indvars.iv.next461 = add nuw nsw i64 %indvars.iv460, 1
  %exitcond462 = icmp eq i64 %indvars.iv.next461, 10240
  br i1 %exitcond462, label %589, label %584

; <label>:589                                     ; preds = %584
  %590 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 2
  %591 = load i32* %590, align 8
  %592 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 0
  store i32 %591, i32* %592, align 16
  br label %593

; <label>:593                                     ; preds = %._crit_edge737, %589
  %594 = phi i32 [ %591, %589 ], [ %.pre739, %._crit_edge737 ]
  %indvars.iv457 = phi i64 [ 1, %589 ], [ %phitmp749, %._crit_edge737 ]
  %v113.0224 = phi i32 [ 0, %589 ], [ %595, %._crit_edge737 ]
  %595 = add i32 %594, %v113.0224
  %exitcond459 = icmp eq i64 %indvars.iv457, 10240
  br i1 %exitcond459, label %596, label %._crit_edge737

._crit_edge737:                                   ; preds = %593
  %.phi.trans.insert738 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv457
  %.pre739 = load i32* %.phi.trans.insert738, align 4, !tbaa !6
  %phitmp749 = add i64 %indvars.iv457, 1
  br label %593

; <label>:596                                     ; preds = %593
  %597 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %595) #2
  br label %598

; <label>:598                                     ; preds = %598, %596
  %indvars.iv453 = phi i64 [ 0, %596 ], [ %indvars.iv.next454, %598 ]
  %599 = load volatile i32* %seed111, align 4
  %600 = trunc i64 %indvars.iv453 to i32
  %601 = mul nsw i32 %599, %600
  %602 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv453
  store i32 %601, i32* %602, align 4, !tbaa !6
  %indvars.iv.next454 = add nuw nsw i64 %indvars.iv453, 1
  %exitcond455 = icmp eq i64 %indvars.iv.next454, 10240
  br i1 %exitcond455, label %603, label %598

; <label>:603                                     ; preds = %598
  %604 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 3
  %605 = bitcast i32* %604 to i64*
  %606 = bitcast [10240 x i32]* %buffer110 to i64*
  %607 = load i64* %605, align 4
  store i64 %607, i64* %606, align 16
  %608 = trunc i64 %607 to i32
  br label %609

; <label>:609                                     ; preds = %._crit_edge740, %603
  %610 = phi i32 [ %608, %603 ], [ %.pre742, %._crit_edge740 ]
  %indvars.iv450 = phi i64 [ 1, %603 ], [ %phitmp750, %._crit_edge740 ]
  %v116.0221 = phi i32 [ 0, %603 ], [ %611, %._crit_edge740 ]
  %611 = add i32 %610, %v116.0221
  %exitcond452 = icmp eq i64 %indvars.iv450, 10240
  br i1 %exitcond452, label %612, label %._crit_edge740

._crit_edge740:                                   ; preds = %609
  %.phi.trans.insert741 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv450
  %.pre742 = load i32* %.phi.trans.insert741, align 4, !tbaa !6
  %phitmp750 = add i64 %indvars.iv450, 1
  br label %609

; <label>:612                                     ; preds = %609
  %613 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %611) #2
  br label %614

; <label>:614                                     ; preds = %614, %612
  %indvars.iv446 = phi i64 [ 0, %612 ], [ %indvars.iv.next447, %614 ]
  %615 = load volatile i32* %seed111, align 4
  %616 = trunc i64 %indvars.iv446 to i32
  %617 = mul nsw i32 %615, %616
  %618 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv446
  store i32 %617, i32* %618, align 4, !tbaa !6
  %indvars.iv.next447 = add nuw nsw i64 %indvars.iv446, 1
  %exitcond448 = icmp eq i64 %indvars.iv.next447, 10240
  br i1 %exitcond448, label %619, label %614

; <label>:619                                     ; preds = %614
  %620 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 4
  %621 = bitcast i32* %620 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %621, i64 12, i32 16, i1 false)
  br label %622

; <label>:622                                     ; preds = %622, %619
  %indvars.iv443 = phi i64 [ 0, %619 ], [ %indvars.iv.next444, %622 ]
  %v119.0218 = phi i32 [ 0, %619 ], [ %625, %622 ]
  %623 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv443
  %624 = load i32* %623, align 4, !tbaa !6
  %625 = add i32 %624, %v119.0218
  %indvars.iv.next444 = add nuw nsw i64 %indvars.iv443, 1
  %exitcond445 = icmp eq i64 %indvars.iv.next444, 10240
  br i1 %exitcond445, label %626, label %622

; <label>:626                                     ; preds = %622
  %627 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %625) #2
  br label %628

; <label>:628                                     ; preds = %628, %626
  %indvars.iv439 = phi i64 [ 0, %626 ], [ %indvars.iv.next440, %628 ]
  %629 = load volatile i32* %seed111, align 4
  %630 = trunc i64 %indvars.iv439 to i32
  %631 = mul nsw i32 %629, %630
  %632 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv439
  store i32 %631, i32* %632, align 4, !tbaa !6
  %indvars.iv.next440 = add nuw nsw i64 %indvars.iv439, 1
  %exitcond441 = icmp eq i64 %indvars.iv.next440, 10240
  br i1 %exitcond441, label %633, label %628

; <label>:633                                     ; preds = %628
  %634 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 5
  %635 = bitcast i32* %634 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %635, i64 16, i32 4, i1 false)
  br label %636

; <label>:636                                     ; preds = %636, %633
  %indvars.iv436 = phi i64 [ 0, %633 ], [ %indvars.iv.next437, %636 ]
  %v122.0215 = phi i32 [ 0, %633 ], [ %639, %636 ]
  %637 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv436
  %638 = load i32* %637, align 4, !tbaa !6
  %639 = add i32 %638, %v122.0215
  %indvars.iv.next437 = add nuw nsw i64 %indvars.iv436, 1
  %exitcond438 = icmp eq i64 %indvars.iv.next437, 10240
  br i1 %exitcond438, label %640, label %636

; <label>:640                                     ; preds = %636
  %641 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %639) #2
  br label %642

; <label>:642                                     ; preds = %642, %640
  %indvars.iv432 = phi i64 [ 0, %640 ], [ %indvars.iv.next433, %642 ]
  %643 = load volatile i32* %seed111, align 4
  %644 = trunc i64 %indvars.iv432 to i32
  %645 = mul nsw i32 %643, %644
  %646 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv432
  store i32 %645, i32* %646, align 4, !tbaa !6
  %indvars.iv.next433 = add nuw nsw i64 %indvars.iv432, 1
  %exitcond434 = icmp eq i64 %indvars.iv.next433, 10240
  br i1 %exitcond434, label %647, label %642

; <label>:647                                     ; preds = %642
  %648 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 6
  %649 = bitcast i32* %648 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %649, i64 20, i32 8, i1 false)
  br label %650

; <label>:650                                     ; preds = %650, %647
  %indvars.iv429 = phi i64 [ 0, %647 ], [ %indvars.iv.next430, %650 ]
  %v125.0212 = phi i32 [ 0, %647 ], [ %653, %650 ]
  %651 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv429
  %652 = load i32* %651, align 4, !tbaa !6
  %653 = add i32 %652, %v125.0212
  %indvars.iv.next430 = add nuw nsw i64 %indvars.iv429, 1
  %exitcond431 = icmp eq i64 %indvars.iv.next430, 10240
  br i1 %exitcond431, label %654, label %650

; <label>:654                                     ; preds = %650
  %655 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %653) #2
  br label %656

; <label>:656                                     ; preds = %656, %654
  %indvars.iv425 = phi i64 [ 0, %654 ], [ %indvars.iv.next426, %656 ]
  %657 = load volatile i32* %seed111, align 4
  %658 = trunc i64 %indvars.iv425 to i32
  %659 = mul nsw i32 %657, %658
  %660 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv425
  store i32 %659, i32* %660, align 4, !tbaa !6
  %indvars.iv.next426 = add nuw nsw i64 %indvars.iv425, 1
  %exitcond427 = icmp eq i64 %indvars.iv.next426, 10240
  br i1 %exitcond427, label %661, label %656

; <label>:661                                     ; preds = %656
  %662 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 7
  %663 = bitcast i32* %662 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %663, i64 24, i32 4, i1 false)
  br label %664

; <label>:664                                     ; preds = %664, %661
  %indvars.iv422 = phi i64 [ 0, %661 ], [ %indvars.iv.next423, %664 ]
  %v128.0209 = phi i32 [ 0, %661 ], [ %667, %664 ]
  %665 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv422
  %666 = load i32* %665, align 4, !tbaa !6
  %667 = add i32 %666, %v128.0209
  %indvars.iv.next423 = add nuw nsw i64 %indvars.iv422, 1
  %exitcond424 = icmp eq i64 %indvars.iv.next423, 10240
  br i1 %exitcond424, label %668, label %664

; <label>:668                                     ; preds = %664
  %669 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %667) #2
  br label %670

; <label>:670                                     ; preds = %670, %668
  %indvars.iv418 = phi i64 [ 0, %668 ], [ %indvars.iv.next419, %670 ]
  %671 = load volatile i32* %seed111, align 4
  %672 = trunc i64 %indvars.iv418 to i32
  %673 = mul nsw i32 %671, %672
  %674 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv418
  store i32 %673, i32* %674, align 4, !tbaa !6
  %indvars.iv.next419 = add nuw nsw i64 %indvars.iv418, 1
  %exitcond420 = icmp eq i64 %indvars.iv.next419, 10240
  br i1 %exitcond420, label %675, label %670

; <label>:675                                     ; preds = %670
  %676 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 8
  %677 = bitcast i32* %676 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %677, i64 28, i32 16, i1 false)
  br label %678

; <label>:678                                     ; preds = %678, %675
  %indvars.iv415 = phi i64 [ 0, %675 ], [ %indvars.iv.next416, %678 ]
  %v131.0206 = phi i32 [ 0, %675 ], [ %681, %678 ]
  %679 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv415
  %680 = load i32* %679, align 4, !tbaa !6
  %681 = add i32 %680, %v131.0206
  %indvars.iv.next416 = add nuw nsw i64 %indvars.iv415, 1
  %exitcond417 = icmp eq i64 %indvars.iv.next416, 10240
  br i1 %exitcond417, label %682, label %678

; <label>:682                                     ; preds = %678
  %683 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %681) #2
  br label %684

; <label>:684                                     ; preds = %684, %682
  %indvars.iv411 = phi i64 [ 0, %682 ], [ %indvars.iv.next412, %684 ]
  %685 = load volatile i32* %seed111, align 4
  %686 = trunc i64 %indvars.iv411 to i32
  %687 = mul nsw i32 %685, %686
  %688 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv411
  store i32 %687, i32* %688, align 4, !tbaa !6
  %indvars.iv.next412 = add nuw nsw i64 %indvars.iv411, 1
  %exitcond413 = icmp eq i64 %indvars.iv.next412, 10240
  br i1 %exitcond413, label %689, label %684

; <label>:689                                     ; preds = %684
  %690 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 9
  %691 = bitcast i32* %690 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %691, i64 32, i32 4, i1 false)
  br label %692

; <label>:692                                     ; preds = %692, %689
  %indvars.iv408 = phi i64 [ 0, %689 ], [ %indvars.iv.next409, %692 ]
  %v134.0203 = phi i32 [ 0, %689 ], [ %695, %692 ]
  %693 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv408
  %694 = load i32* %693, align 4, !tbaa !6
  %695 = add i32 %694, %v134.0203
  %indvars.iv.next409 = add nuw nsw i64 %indvars.iv408, 1
  %exitcond410 = icmp eq i64 %indvars.iv.next409, 10240
  br i1 %exitcond410, label %696, label %692

; <label>:696                                     ; preds = %692
  %697 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %695) #2
  br label %698

; <label>:698                                     ; preds = %698, %696
  %indvars.iv404 = phi i64 [ 0, %696 ], [ %indvars.iv.next405, %698 ]
  %699 = load volatile i32* %seed111, align 4
  %700 = trunc i64 %indvars.iv404 to i32
  %701 = mul nsw i32 %699, %700
  %702 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv404
  store i32 %701, i32* %702, align 4, !tbaa !6
  %indvars.iv.next405 = add nuw nsw i64 %indvars.iv404, 1
  %exitcond406 = icmp eq i64 %indvars.iv.next405, 10240
  br i1 %exitcond406, label %703, label %698

; <label>:703                                     ; preds = %698
  %704 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 10
  %705 = bitcast i32* %704 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %705, i64 36, i32 8, i1 false)
  br label %706

; <label>:706                                     ; preds = %706, %703
  %indvars.iv401 = phi i64 [ 0, %703 ], [ %indvars.iv.next402, %706 ]
  %v137.0200 = phi i32 [ 0, %703 ], [ %709, %706 ]
  %707 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv401
  %708 = load i32* %707, align 4, !tbaa !6
  %709 = add i32 %708, %v137.0200
  %indvars.iv.next402 = add nuw nsw i64 %indvars.iv401, 1
  %exitcond403 = icmp eq i64 %indvars.iv.next402, 10240
  br i1 %exitcond403, label %710, label %706

; <label>:710                                     ; preds = %706
  %711 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %709) #2
  br label %712

; <label>:712                                     ; preds = %712, %710
  %indvars.iv397 = phi i64 [ 0, %710 ], [ %indvars.iv.next398, %712 ]
  %713 = load volatile i32* %seed111, align 4
  %714 = trunc i64 %indvars.iv397 to i32
  %715 = mul nsw i32 %713, %714
  %716 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv397
  store i32 %715, i32* %716, align 4, !tbaa !6
  %indvars.iv.next398 = add nuw nsw i64 %indvars.iv397, 1
  %exitcond399 = icmp eq i64 %indvars.iv.next398, 10240
  br i1 %exitcond399, label %717, label %712

; <label>:717                                     ; preds = %712
  %718 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 11
  %719 = bitcast i32* %718 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %719, i64 40, i32 4, i1 false)
  br label %720

; <label>:720                                     ; preds = %720, %717
  %indvars.iv394 = phi i64 [ 0, %717 ], [ %indvars.iv.next395, %720 ]
  %v140.0197 = phi i32 [ 0, %717 ], [ %723, %720 ]
  %721 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv394
  %722 = load i32* %721, align 4, !tbaa !6
  %723 = add i32 %722, %v140.0197
  %indvars.iv.next395 = add nuw nsw i64 %indvars.iv394, 1
  %exitcond396 = icmp eq i64 %indvars.iv.next395, 10240
  br i1 %exitcond396, label %724, label %720

; <label>:724                                     ; preds = %720
  %725 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %723) #2
  br label %726

; <label>:726                                     ; preds = %726, %724
  %indvars.iv390 = phi i64 [ 0, %724 ], [ %indvars.iv.next391, %726 ]
  %727 = load volatile i32* %seed111, align 4
  %728 = trunc i64 %indvars.iv390 to i32
  %729 = mul nsw i32 %727, %728
  %730 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv390
  store i32 %729, i32* %730, align 4, !tbaa !6
  %indvars.iv.next391 = add nuw nsw i64 %indvars.iv390, 1
  %exitcond392 = icmp eq i64 %indvars.iv.next391, 10240
  br i1 %exitcond392, label %731, label %726

; <label>:731                                     ; preds = %726
  %732 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 17
  %733 = bitcast i32* %732 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %733, i64 64, i32 4, i1 false)
  br label %734

; <label>:734                                     ; preds = %734, %731
  %indvars.iv387 = phi i64 [ 0, %731 ], [ %indvars.iv.next388, %734 ]
  %v143.0194 = phi i32 [ 0, %731 ], [ %737, %734 ]
  %735 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv387
  %736 = load i32* %735, align 4, !tbaa !6
  %737 = add i32 %736, %v143.0194
  %indvars.iv.next388 = add nuw nsw i64 %indvars.iv387, 1
  %exitcond389 = icmp eq i64 %indvars.iv.next388, 10240
  br i1 %exitcond389, label %738, label %734

; <label>:738                                     ; preds = %734
  %739 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %737) #2
  br label %740

; <label>:740                                     ; preds = %740, %738
  %indvars.iv383 = phi i64 [ 0, %738 ], [ %indvars.iv.next384, %740 ]
  %741 = load volatile i32* %seed111, align 4
  %742 = trunc i64 %indvars.iv383 to i32
  %743 = mul nsw i32 %741, %742
  %744 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv383
  store i32 %743, i32* %744, align 4, !tbaa !6
  %indvars.iv.next384 = add nuw nsw i64 %indvars.iv383, 1
  %exitcond385 = icmp eq i64 %indvars.iv.next384, 10240
  br i1 %exitcond385, label %745, label %740

; <label>:745                                     ; preds = %740
  %746 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 33
  %747 = bitcast i32* %746 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %747, i64 128, i32 4, i1 false)
  br label %748

; <label>:748                                     ; preds = %748, %745
  %indvars.iv380 = phi i64 [ 0, %745 ], [ %indvars.iv.next381, %748 ]
  %v146.0191 = phi i32 [ 0, %745 ], [ %751, %748 ]
  %749 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv380
  %750 = load i32* %749, align 4, !tbaa !6
  %751 = add i32 %750, %v146.0191
  %indvars.iv.next381 = add nuw nsw i64 %indvars.iv380, 1
  %exitcond382 = icmp eq i64 %indvars.iv.next381, 10240
  br i1 %exitcond382, label %752, label %748

; <label>:752                                     ; preds = %748
  %753 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %751) #2
  br label %754

; <label>:754                                     ; preds = %754, %752
  %indvars.iv376 = phi i64 [ 0, %752 ], [ %indvars.iv.next377, %754 ]
  %755 = load volatile i32* %seed111, align 4
  %756 = trunc i64 %indvars.iv376 to i32
  %757 = mul nsw i32 %755, %756
  %758 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv376
  store i32 %757, i32* %758, align 4, !tbaa !6
  %indvars.iv.next377 = add nuw nsw i64 %indvars.iv376, 1
  %exitcond378 = icmp eq i64 %indvars.iv.next377, 10240
  br i1 %exitcond378, label %759, label %754

; <label>:759                                     ; preds = %754
  %760 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 65
  %761 = bitcast i32* %760 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %761, i64 256, i32 4, i1 false)
  br label %762

; <label>:762                                     ; preds = %762, %759
  %indvars.iv373 = phi i64 [ 0, %759 ], [ %indvars.iv.next374, %762 ]
  %v149.0188 = phi i32 [ 0, %759 ], [ %765, %762 ]
  %763 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv373
  %764 = load i32* %763, align 4, !tbaa !6
  %765 = add i32 %764, %v149.0188
  %indvars.iv.next374 = add nuw nsw i64 %indvars.iv373, 1
  %exitcond375 = icmp eq i64 %indvars.iv.next374, 10240
  br i1 %exitcond375, label %766, label %762

; <label>:766                                     ; preds = %762
  %767 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %765) #2
  br label %768

; <label>:768                                     ; preds = %768, %766
  %indvars.iv369 = phi i64 [ 0, %766 ], [ %indvars.iv.next370, %768 ]
  %769 = load volatile i32* %seed111, align 4
  %770 = trunc i64 %indvars.iv369 to i32
  %771 = mul nsw i32 %769, %770
  %772 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv369
  store i32 %771, i32* %772, align 4, !tbaa !6
  %indvars.iv.next370 = add nuw nsw i64 %indvars.iv369, 1
  %exitcond371 = icmp eq i64 %indvars.iv.next370, 10240
  br i1 %exitcond371, label %773, label %768

; <label>:773                                     ; preds = %768
  %774 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 129
  %775 = bitcast i32* %774 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %775, i64 512, i32 4, i1 false)
  br label %776

; <label>:776                                     ; preds = %776, %773
  %indvars.iv366 = phi i64 [ 0, %773 ], [ %indvars.iv.next367, %776 ]
  %v152.0185 = phi i32 [ 0, %773 ], [ %779, %776 ]
  %777 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv366
  %778 = load i32* %777, align 4, !tbaa !6
  %779 = add i32 %778, %v152.0185
  %indvars.iv.next367 = add nuw nsw i64 %indvars.iv366, 1
  %exitcond368 = icmp eq i64 %indvars.iv.next367, 10240
  br i1 %exitcond368, label %780, label %776

; <label>:780                                     ; preds = %776
  %781 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %779) #2
  br label %782

; <label>:782                                     ; preds = %782, %780
  %indvars.iv362 = phi i64 [ 0, %780 ], [ %indvars.iv.next363, %782 ]
  %783 = load volatile i32* %seed111, align 4
  %784 = trunc i64 %indvars.iv362 to i32
  %785 = mul nsw i32 %783, %784
  %786 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv362
  store i32 %785, i32* %786, align 4, !tbaa !6
  %indvars.iv.next363 = add nuw nsw i64 %indvars.iv362, 1
  %exitcond364 = icmp eq i64 %indvars.iv.next363, 10240
  br i1 %exitcond364, label %787, label %782

; <label>:787                                     ; preds = %782
  %788 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 257
  %789 = bitcast i32* %788 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %789, i64 1024, i32 4, i1 false)
  br label %790

; <label>:790                                     ; preds = %790, %787
  %indvars.iv359 = phi i64 [ 0, %787 ], [ %indvars.iv.next360, %790 ]
  %v155.0182 = phi i32 [ 0, %787 ], [ %793, %790 ]
  %791 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv359
  %792 = load i32* %791, align 4, !tbaa !6
  %793 = add i32 %792, %v155.0182
  %indvars.iv.next360 = add nuw nsw i64 %indvars.iv359, 1
  %exitcond361 = icmp eq i64 %indvars.iv.next360, 10240
  br i1 %exitcond361, label %794, label %790

; <label>:794                                     ; preds = %790
  %795 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %793) #2
  br label %796

; <label>:796                                     ; preds = %796, %794
  %indvars.iv355 = phi i64 [ 0, %794 ], [ %indvars.iv.next356, %796 ]
  %797 = load volatile i32* %seed111, align 4
  %798 = trunc i64 %indvars.iv355 to i32
  %799 = mul nsw i32 %797, %798
  %800 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv355
  store i32 %799, i32* %800, align 4, !tbaa !6
  %indvars.iv.next356 = add nuw nsw i64 %indvars.iv355, 1
  %exitcond357 = icmp eq i64 %indvars.iv.next356, 10240
  br i1 %exitcond357, label %801, label %796

; <label>:801                                     ; preds = %796
  %802 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 513
  %803 = bitcast i32* %802 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %803, i64 2048, i32 4, i1 false)
  br label %804

; <label>:804                                     ; preds = %804, %801
  %indvars.iv352 = phi i64 [ 0, %801 ], [ %indvars.iv.next353, %804 ]
  %v158.0179 = phi i32 [ 0, %801 ], [ %807, %804 ]
  %805 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv352
  %806 = load i32* %805, align 4, !tbaa !6
  %807 = add i32 %806, %v158.0179
  %indvars.iv.next353 = add nuw nsw i64 %indvars.iv352, 1
  %exitcond354 = icmp eq i64 %indvars.iv.next353, 10240
  br i1 %exitcond354, label %808, label %804

; <label>:808                                     ; preds = %804
  %809 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %807) #2
  br label %810

; <label>:810                                     ; preds = %810, %808
  %indvars.iv348 = phi i64 [ 0, %808 ], [ %indvars.iv.next349, %810 ]
  %811 = load volatile i32* %seed111, align 4
  %812 = trunc i64 %indvars.iv348 to i32
  %813 = mul nsw i32 %811, %812
  %814 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv348
  store i32 %813, i32* %814, align 4, !tbaa !6
  %indvars.iv.next349 = add nuw nsw i64 %indvars.iv348, 1
  %exitcond350 = icmp eq i64 %indvars.iv.next349, 10240
  br i1 %exitcond350, label %815, label %810

; <label>:815                                     ; preds = %810
  %816 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 1025
  %817 = bitcast i32* %816 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %817, i64 4096, i32 4, i1 false)
  br label %818

; <label>:818                                     ; preds = %818, %815
  %indvars.iv345 = phi i64 [ 0, %815 ], [ %indvars.iv.next346, %818 ]
  %v161.0176 = phi i32 [ 0, %815 ], [ %821, %818 ]
  %819 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv345
  %820 = load i32* %819, align 4, !tbaa !6
  %821 = add i32 %820, %v161.0176
  %indvars.iv.next346 = add nuw nsw i64 %indvars.iv345, 1
  %exitcond347 = icmp eq i64 %indvars.iv.next346, 10240
  br i1 %exitcond347, label %822, label %818

; <label>:822                                     ; preds = %818
  %823 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %821) #2
  br label %.preheader

.preheader:                                       ; preds = %837, %822
  %indvars.iv342 = phi i64 [ 10, %822 ], [ %indvars.iv.next343, %837 ]
  br label %824

; <label>:824                                     ; preds = %824, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %824 ]
  %825 = load volatile i32* %seed111, align 4
  %826 = trunc i64 %indvars.iv to i32
  %827 = mul nsw i32 %825, %826
  %828 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv
  store i32 %827, i32* %828, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 10240
  br i1 %exitcond, label %829, label %824

; <label>:829                                     ; preds = %824
  %.sum169 = or i64 %indvars.iv342, 1
  %830 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %.sum169
  %831 = bitcast i32* %830 to i8*
  %832 = shl nsw i64 %indvars.iv342, 2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %583, i8* %831, i64 %832, i32 4, i1 false)
  br label %833

; <label>:833                                     ; preds = %833, %829
  %indvars.iv339 = phi i64 [ 0, %829 ], [ %indvars.iv.next340, %833 ]
  %v165.0173 = phi i32 [ 0, %829 ], [ %836, %833 ]
  %834 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv339
  %835 = load i32* %834, align 4, !tbaa !6
  %836 = add i32 %835, %v165.0173
  %indvars.iv.next340 = add nuw nsw i64 %indvars.iv339, 1
  %exitcond341 = icmp eq i64 %indvars.iv.next340, 10240
  br i1 %exitcond341, label %837, label %833

; <label>:837                                     ; preds = %833
  %838 = trunc i64 %indvars.iv342 to i32
  %839 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %838, i32 %836) #2
  %indvars.iv.next343 = add nuw nsw i64 %indvars.iv342, 10
  %840 = trunc i64 %indvars.iv.next343 to i32
  %841 = icmp slt i32 %840, 100
  br i1 %841, label %.preheader, label %842

; <label>:842                                     ; preds = %837
  call void @llvm.lifetime.end(i64 40960, i8* %583) #2
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
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"short", metadata !2, i64 0}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !2, i64 0}
