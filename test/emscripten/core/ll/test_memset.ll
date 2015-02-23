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
  br i1 %exitcond715, label %8, label %2

; <label>:8                                       ; preds = %2
  %9 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 1
  store i8 -91, i8* %9, align 1
  br label %10

; <label>:10                                      ; preds = %10, %8
  %indvars.iv710 = phi i64 [ 0, %8 ], [ %indvars.iv.next711, %10 ]
  %v.0333 = phi i32 [ 0, %8 ], [ %14, %10 ]
  %11 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv710
  %12 = load i8* %11, align 1, !tbaa !1
  %13 = zext i8 %12 to i32
  %14 = add nsw i32 %13, %v.0333
  %indvars.iv.next711 = add nuw nsw i64 %indvars.iv710, 1
  %exitcond712 = icmp eq i64 %indvars.iv.next711, 10240
  br i1 %exitcond712, label %15, label %10

; <label>:15                                      ; preds = %10
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %14) #2
  br label %17

; <label>:17                                      ; preds = %17, %15
  %indvars.iv706 = phi i64 [ 0, %15 ], [ %indvars.iv.next707, %17 ]
  %18 = load volatile i32* %seed, align 4
  %19 = trunc i64 %indvars.iv706 to i32
  %20 = mul nsw i32 %18, %19
  %21 = trunc i32 %20 to i8
  %22 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv706
  store i8 %21, i8* %22, align 1, !tbaa !1
  %indvars.iv.next707 = add nuw nsw i64 %indvars.iv706, 1
  %exitcond708 = icmp eq i64 %indvars.iv.next707, 10240
  br i1 %exitcond708, label %23, label %17

; <label>:23                                      ; preds = %17
  %24 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 2
  %25 = bitcast i8* %24 to i16*
  store i16 -23131, i16* %25, align 2
  br label %26

; <label>:26                                      ; preds = %26, %23
  %indvars.iv703 = phi i64 [ 0, %23 ], [ %indvars.iv.next704, %26 ]
  %v3.0330 = phi i32 [ 0, %23 ], [ %30, %26 ]
  %27 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv703
  %28 = load i8* %27, align 1, !tbaa !1
  %29 = zext i8 %28 to i32
  %30 = add nsw i32 %29, %v3.0330
  %indvars.iv.next704 = add nuw nsw i64 %indvars.iv703, 1
  %exitcond705 = icmp eq i64 %indvars.iv.next704, 10240
  br i1 %exitcond705, label %31, label %26

; <label>:31                                      ; preds = %26
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %30) #2
  br label %33

; <label>:33                                      ; preds = %33, %31
  %indvars.iv699 = phi i64 [ 0, %31 ], [ %indvars.iv.next700, %33 ]
  %34 = load volatile i32* %seed, align 4
  %35 = trunc i64 %indvars.iv699 to i32
  %36 = mul nsw i32 %34, %35
  %37 = trunc i32 %36 to i8
  %38 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv699
  store i8 %37, i8* %38, align 1, !tbaa !1
  %indvars.iv.next700 = add nuw nsw i64 %indvars.iv699, 1
  %exitcond701 = icmp eq i64 %indvars.iv.next700, 10240
  br i1 %exitcond701, label %39, label %33

; <label>:39                                      ; preds = %33
  %40 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 3
  call void @llvm.memset.p0i8.i64(i8* %40, i8 -91, i64 3, i32 1, i1 false)
  br label %41

; <label>:41                                      ; preds = %41, %39
  %indvars.iv696 = phi i64 [ 0, %39 ], [ %indvars.iv.next697, %41 ]
  %v6.0327 = phi i32 [ 0, %39 ], [ %45, %41 ]
  %42 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv696
  %43 = load i8* %42, align 1, !tbaa !1
  %44 = zext i8 %43 to i32
  %45 = add nsw i32 %44, %v6.0327
  %indvars.iv.next697 = add nuw nsw i64 %indvars.iv696, 1
  %exitcond698 = icmp eq i64 %indvars.iv.next697, 10240
  br i1 %exitcond698, label %46, label %41

; <label>:46                                      ; preds = %41
  %47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %45) #2
  br label %48

; <label>:48                                      ; preds = %48, %46
  %indvars.iv692 = phi i64 [ 0, %46 ], [ %indvars.iv.next693, %48 ]
  %49 = load volatile i32* %seed, align 4
  %50 = trunc i64 %indvars.iv692 to i32
  %51 = mul nsw i32 %49, %50
  %52 = trunc i32 %51 to i8
  %53 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv692
  store i8 %52, i8* %53, align 1, !tbaa !1
  %indvars.iv.next693 = add nuw nsw i64 %indvars.iv692, 1
  %exitcond694 = icmp eq i64 %indvars.iv.next693, 10240
  br i1 %exitcond694, label %54, label %48

; <label>:54                                      ; preds = %48
  %55 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 4
  %56 = bitcast i8* %55 to i32*
  store i32 -1515870811, i32* %56, align 4
  br label %57

; <label>:57                                      ; preds = %57, %54
  %indvars.iv689 = phi i64 [ 0, %54 ], [ %indvars.iv.next690, %57 ]
  %v9.0324 = phi i32 [ 0, %54 ], [ %61, %57 ]
  %58 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv689
  %59 = load i8* %58, align 1, !tbaa !1
  %60 = zext i8 %59 to i32
  %61 = add nsw i32 %60, %v9.0324
  %indvars.iv.next690 = add nuw nsw i64 %indvars.iv689, 1
  %exitcond691 = icmp eq i64 %indvars.iv.next690, 10240
  br i1 %exitcond691, label %62, label %57

; <label>:62                                      ; preds = %57
  %63 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %61) #2
  br label %64

; <label>:64                                      ; preds = %64, %62
  %indvars.iv685 = phi i64 [ 0, %62 ], [ %indvars.iv.next686, %64 ]
  %65 = load volatile i32* %seed, align 4
  %66 = trunc i64 %indvars.iv685 to i32
  %67 = mul nsw i32 %65, %66
  %68 = trunc i32 %67 to i8
  %69 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv685
  store i8 %68, i8* %69, align 1, !tbaa !1
  %indvars.iv.next686 = add nuw nsw i64 %indvars.iv685, 1
  %exitcond687 = icmp eq i64 %indvars.iv.next686, 10240
  br i1 %exitcond687, label %70, label %64

; <label>:70                                      ; preds = %64
  %71 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 5
  call void @llvm.memset.p0i8.i64(i8* %71, i8 -91, i64 5, i32 1, i1 false)
  br label %72

; <label>:72                                      ; preds = %72, %70
  %indvars.iv682 = phi i64 [ 0, %70 ], [ %indvars.iv.next683, %72 ]
  %v12.0321 = phi i32 [ 0, %70 ], [ %76, %72 ]
  %73 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv682
  %74 = load i8* %73, align 1, !tbaa !1
  %75 = zext i8 %74 to i32
  %76 = add nsw i32 %75, %v12.0321
  %indvars.iv.next683 = add nuw nsw i64 %indvars.iv682, 1
  %exitcond684 = icmp eq i64 %indvars.iv.next683, 10240
  br i1 %exitcond684, label %77, label %72

; <label>:77                                      ; preds = %72
  %78 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %76) #2
  br label %79

; <label>:79                                      ; preds = %79, %77
  %indvars.iv678 = phi i64 [ 0, %77 ], [ %indvars.iv.next679, %79 ]
  %80 = load volatile i32* %seed, align 4
  %81 = trunc i64 %indvars.iv678 to i32
  %82 = mul nsw i32 %80, %81
  %83 = trunc i32 %82 to i8
  %84 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv678
  store i8 %83, i8* %84, align 1, !tbaa !1
  %indvars.iv.next679 = add nuw nsw i64 %indvars.iv678, 1
  %exitcond680 = icmp eq i64 %indvars.iv.next679, 10240
  br i1 %exitcond680, label %85, label %79

; <label>:85                                      ; preds = %79
  %86 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 6
  call void @llvm.memset.p0i8.i64(i8* %86, i8 -91, i64 6, i32 2, i1 false)
  br label %87

; <label>:87                                      ; preds = %87, %85
  %indvars.iv675 = phi i64 [ 0, %85 ], [ %indvars.iv.next676, %87 ]
  %v15.0318 = phi i32 [ 0, %85 ], [ %91, %87 ]
  %88 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv675
  %89 = load i8* %88, align 1, !tbaa !1
  %90 = zext i8 %89 to i32
  %91 = add nsw i32 %90, %v15.0318
  %indvars.iv.next676 = add nuw nsw i64 %indvars.iv675, 1
  %exitcond677 = icmp eq i64 %indvars.iv.next676, 10240
  br i1 %exitcond677, label %92, label %87

; <label>:92                                      ; preds = %87
  %93 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %91) #2
  br label %94

; <label>:94                                      ; preds = %94, %92
  %indvars.iv671 = phi i64 [ 0, %92 ], [ %indvars.iv.next672, %94 ]
  %95 = load volatile i32* %seed, align 4
  %96 = trunc i64 %indvars.iv671 to i32
  %97 = mul nsw i32 %95, %96
  %98 = trunc i32 %97 to i8
  %99 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv671
  store i8 %98, i8* %99, align 1, !tbaa !1
  %indvars.iv.next672 = add nuw nsw i64 %indvars.iv671, 1
  %exitcond673 = icmp eq i64 %indvars.iv.next672, 10240
  br i1 %exitcond673, label %100, label %94

; <label>:100                                     ; preds = %94
  %101 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 7
  call void @llvm.memset.p0i8.i64(i8* %101, i8 -91, i64 7, i32 1, i1 false)
  br label %102

; <label>:102                                     ; preds = %102, %100
  %indvars.iv668 = phi i64 [ 0, %100 ], [ %indvars.iv.next669, %102 ]
  %v18.0315 = phi i32 [ 0, %100 ], [ %106, %102 ]
  %103 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv668
  %104 = load i8* %103, align 1, !tbaa !1
  %105 = zext i8 %104 to i32
  %106 = add nsw i32 %105, %v18.0315
  %indvars.iv.next669 = add nuw nsw i64 %indvars.iv668, 1
  %exitcond670 = icmp eq i64 %indvars.iv.next669, 10240
  br i1 %exitcond670, label %107, label %102

; <label>:107                                     ; preds = %102
  %108 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %106) #2
  br label %109

; <label>:109                                     ; preds = %109, %107
  %indvars.iv664 = phi i64 [ 0, %107 ], [ %indvars.iv.next665, %109 ]
  %110 = load volatile i32* %seed, align 4
  %111 = trunc i64 %indvars.iv664 to i32
  %112 = mul nsw i32 %110, %111
  %113 = trunc i32 %112 to i8
  %114 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv664
  store i8 %113, i8* %114, align 1, !tbaa !1
  %indvars.iv.next665 = add nuw nsw i64 %indvars.iv664, 1
  %exitcond666 = icmp eq i64 %indvars.iv.next665, 10240
  br i1 %exitcond666, label %115, label %109

; <label>:115                                     ; preds = %109
  %116 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 8
  %117 = bitcast i8* %116 to i64*
  store i64 -6510615555426900571, i64* %117, align 8
  br label %118

; <label>:118                                     ; preds = %118, %115
  %indvars.iv661 = phi i64 [ 0, %115 ], [ %indvars.iv.next662, %118 ]
  %v21.0312 = phi i32 [ 0, %115 ], [ %122, %118 ]
  %119 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv661
  %120 = load i8* %119, align 1, !tbaa !1
  %121 = zext i8 %120 to i32
  %122 = add nsw i32 %121, %v21.0312
  %indvars.iv.next662 = add nuw nsw i64 %indvars.iv661, 1
  %exitcond663 = icmp eq i64 %indvars.iv.next662, 10240
  br i1 %exitcond663, label %123, label %118

; <label>:123                                     ; preds = %118
  %124 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %122) #2
  br label %125

; <label>:125                                     ; preds = %125, %123
  %indvars.iv657 = phi i64 [ 0, %123 ], [ %indvars.iv.next658, %125 ]
  %126 = load volatile i32* %seed, align 4
  %127 = trunc i64 %indvars.iv657 to i32
  %128 = mul nsw i32 %126, %127
  %129 = trunc i32 %128 to i8
  %130 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv657
  store i8 %129, i8* %130, align 1, !tbaa !1
  %indvars.iv.next658 = add nuw nsw i64 %indvars.iv657, 1
  %exitcond659 = icmp eq i64 %indvars.iv.next658, 10240
  br i1 %exitcond659, label %131, label %125

; <label>:131                                     ; preds = %125
  %132 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 9
  call void @llvm.memset.p0i8.i64(i8* %132, i8 -91, i64 9, i32 1, i1 false)
  br label %133

; <label>:133                                     ; preds = %133, %131
  %indvars.iv654 = phi i64 [ 0, %131 ], [ %indvars.iv.next655, %133 ]
  %v24.0309 = phi i32 [ 0, %131 ], [ %137, %133 ]
  %134 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv654
  %135 = load i8* %134, align 1, !tbaa !1
  %136 = zext i8 %135 to i32
  %137 = add nsw i32 %136, %v24.0309
  %indvars.iv.next655 = add nuw nsw i64 %indvars.iv654, 1
  %exitcond656 = icmp eq i64 %indvars.iv.next655, 10240
  br i1 %exitcond656, label %138, label %133

; <label>:138                                     ; preds = %133
  %139 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %137) #2
  br label %140

; <label>:140                                     ; preds = %140, %138
  %indvars.iv650 = phi i64 [ 0, %138 ], [ %indvars.iv.next651, %140 ]
  %141 = load volatile i32* %seed, align 4
  %142 = trunc i64 %indvars.iv650 to i32
  %143 = mul nsw i32 %141, %142
  %144 = trunc i32 %143 to i8
  %145 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv650
  store i8 %144, i8* %145, align 1, !tbaa !1
  %indvars.iv.next651 = add nuw nsw i64 %indvars.iv650, 1
  %exitcond652 = icmp eq i64 %indvars.iv.next651, 10240
  br i1 %exitcond652, label %146, label %140

; <label>:146                                     ; preds = %140
  %147 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 10
  call void @llvm.memset.p0i8.i64(i8* %147, i8 -91, i64 10, i32 2, i1 false)
  br label %148

; <label>:148                                     ; preds = %148, %146
  %indvars.iv647 = phi i64 [ 0, %146 ], [ %indvars.iv.next648, %148 ]
  %v27.0306 = phi i32 [ 0, %146 ], [ %152, %148 ]
  %149 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv647
  %150 = load i8* %149, align 1, !tbaa !1
  %151 = zext i8 %150 to i32
  %152 = add nsw i32 %151, %v27.0306
  %indvars.iv.next648 = add nuw nsw i64 %indvars.iv647, 1
  %exitcond649 = icmp eq i64 %indvars.iv.next648, 10240
  br i1 %exitcond649, label %153, label %148

; <label>:153                                     ; preds = %148
  %154 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %152) #2
  br label %155

; <label>:155                                     ; preds = %155, %153
  %indvars.iv643 = phi i64 [ 0, %153 ], [ %indvars.iv.next644, %155 ]
  %156 = load volatile i32* %seed, align 4
  %157 = trunc i64 %indvars.iv643 to i32
  %158 = mul nsw i32 %156, %157
  %159 = trunc i32 %158 to i8
  %160 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv643
  store i8 %159, i8* %160, align 1, !tbaa !1
  %indvars.iv.next644 = add nuw nsw i64 %indvars.iv643, 1
  %exitcond645 = icmp eq i64 %indvars.iv.next644, 10240
  br i1 %exitcond645, label %161, label %155

; <label>:161                                     ; preds = %155
  %162 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 16
  call void @llvm.memset.p0i8.i64(i8* %162, i8 -91, i64 16, i32 16, i1 false)
  br label %163

; <label>:163                                     ; preds = %163, %161
  %indvars.iv640 = phi i64 [ 0, %161 ], [ %indvars.iv.next641, %163 ]
  %v30.0303 = phi i32 [ 0, %161 ], [ %167, %163 ]
  %164 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv640
  %165 = load i8* %164, align 1, !tbaa !1
  %166 = zext i8 %165 to i32
  %167 = add nsw i32 %166, %v30.0303
  %indvars.iv.next641 = add nuw nsw i64 %indvars.iv640, 1
  %exitcond642 = icmp eq i64 %indvars.iv.next641, 10240
  br i1 %exitcond642, label %168, label %163

; <label>:168                                     ; preds = %163
  %169 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %167) #2
  br label %170

; <label>:170                                     ; preds = %170, %168
  %indvars.iv636 = phi i64 [ 0, %168 ], [ %indvars.iv.next637, %170 ]
  %171 = load volatile i32* %seed, align 4
  %172 = trunc i64 %indvars.iv636 to i32
  %173 = mul nsw i32 %171, %172
  %174 = trunc i32 %173 to i8
  %175 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv636
  store i8 %174, i8* %175, align 1, !tbaa !1
  %indvars.iv.next637 = add nuw nsw i64 %indvars.iv636, 1
  %exitcond638 = icmp eq i64 %indvars.iv.next637, 10240
  br i1 %exitcond638, label %176, label %170

; <label>:176                                     ; preds = %170
  %177 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 15
  call void @llvm.memset.p0i8.i64(i8* %177, i8 -91, i64 32, i32 1, i1 false)
  br label %178

; <label>:178                                     ; preds = %178, %176
  %indvars.iv633 = phi i64 [ 0, %176 ], [ %indvars.iv.next634, %178 ]
  %v33.0300 = phi i32 [ 0, %176 ], [ %182, %178 ]
  %179 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv633
  %180 = load i8* %179, align 1, !tbaa !1
  %181 = zext i8 %180 to i32
  %182 = add nsw i32 %181, %v33.0300
  %indvars.iv.next634 = add nuw nsw i64 %indvars.iv633, 1
  %exitcond635 = icmp eq i64 %indvars.iv.next634, 10240
  br i1 %exitcond635, label %183, label %178

; <label>:183                                     ; preds = %178
  %184 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %182) #2
  br label %185

; <label>:185                                     ; preds = %185, %183
  %indvars.iv629 = phi i64 [ 0, %183 ], [ %indvars.iv.next630, %185 ]
  %186 = load volatile i32* %seed, align 4
  %187 = trunc i64 %indvars.iv629 to i32
  %188 = mul nsw i32 %186, %187
  %189 = trunc i32 %188 to i8
  %190 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv629
  store i8 %189, i8* %190, align 1, !tbaa !1
  %indvars.iv.next630 = add nuw nsw i64 %indvars.iv629, 1
  %exitcond631 = icmp eq i64 %indvars.iv.next630, 10240
  br i1 %exitcond631, label %191, label %185

; <label>:191                                     ; preds = %185
  %192 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 13
  call void @llvm.memset.p0i8.i64(i8* %192, i8 -91, i64 64, i32 1, i1 false)
  br label %193

; <label>:193                                     ; preds = %193, %191
  %indvars.iv626 = phi i64 [ 0, %191 ], [ %indvars.iv.next627, %193 ]
  %v36.0297 = phi i32 [ 0, %191 ], [ %197, %193 ]
  %194 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv626
  %195 = load i8* %194, align 1, !tbaa !1
  %196 = zext i8 %195 to i32
  %197 = add nsw i32 %196, %v36.0297
  %indvars.iv.next627 = add nuw nsw i64 %indvars.iv626, 1
  %exitcond628 = icmp eq i64 %indvars.iv.next627, 10240
  br i1 %exitcond628, label %198, label %193

; <label>:198                                     ; preds = %193
  %199 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %197) #2
  br label %200

; <label>:200                                     ; preds = %200, %198
  %indvars.iv622 = phi i64 [ 0, %198 ], [ %indvars.iv.next623, %200 ]
  %201 = load volatile i32* %seed, align 4
  %202 = trunc i64 %indvars.iv622 to i32
  %203 = mul nsw i32 %201, %202
  %204 = trunc i32 %203 to i8
  %205 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv622
  store i8 %204, i8* %205, align 1, !tbaa !1
  %indvars.iv.next623 = add nuw nsw i64 %indvars.iv622, 1
  %exitcond624 = icmp eq i64 %indvars.iv.next623, 10240
  br i1 %exitcond624, label %206, label %200

; <label>:206                                     ; preds = %200
  call void @llvm.memset.p0i8.i64(i8* %132, i8 -91, i64 128, i32 1, i1 false)
  br label %207

; <label>:207                                     ; preds = %207, %206
  %indvars.iv619 = phi i64 [ 0, %206 ], [ %indvars.iv.next620, %207 ]
  %v39.0294 = phi i32 [ 0, %206 ], [ %211, %207 ]
  %208 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv619
  %209 = load i8* %208, align 1, !tbaa !1
  %210 = zext i8 %209 to i32
  %211 = add nsw i32 %210, %v39.0294
  %indvars.iv.next620 = add nuw nsw i64 %indvars.iv619, 1
  %exitcond621 = icmp eq i64 %indvars.iv.next620, 10240
  br i1 %exitcond621, label %212, label %207

; <label>:212                                     ; preds = %207
  %213 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %211) #2
  br label %214

; <label>:214                                     ; preds = %214, %212
  %indvars.iv615 = phi i64 [ 0, %212 ], [ %indvars.iv.next616, %214 ]
  %215 = load volatile i32* %seed, align 4
  %216 = trunc i64 %indvars.iv615 to i32
  %217 = mul nsw i32 %215, %216
  %218 = trunc i32 %217 to i8
  %219 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv615
  store i8 %218, i8* %219, align 1, !tbaa !1
  %indvars.iv.next616 = add nuw nsw i64 %indvars.iv615, 1
  %exitcond617 = icmp eq i64 %indvars.iv.next616, 10240
  br i1 %exitcond617, label %220, label %214

; <label>:220                                     ; preds = %214
  call void @llvm.memset.p0i8.i64(i8* %9, i8 -91, i64 256, i32 1, i1 false)
  br label %221

; <label>:221                                     ; preds = %221, %220
  %indvars.iv612 = phi i64 [ 0, %220 ], [ %indvars.iv.next613, %221 ]
  %v42.0291 = phi i32 [ 0, %220 ], [ %225, %221 ]
  %222 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv612
  %223 = load i8* %222, align 1, !tbaa !1
  %224 = zext i8 %223 to i32
  %225 = add nsw i32 %224, %v42.0291
  %indvars.iv.next613 = add nuw nsw i64 %indvars.iv612, 1
  %exitcond614 = icmp eq i64 %indvars.iv.next613, 10240
  br i1 %exitcond614, label %226, label %221

; <label>:226                                     ; preds = %221
  %227 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %225) #2
  br label %228

; <label>:228                                     ; preds = %228, %226
  %indvars.iv608 = phi i64 [ 0, %226 ], [ %indvars.iv.next609, %228 ]
  %229 = load volatile i32* %seed, align 4
  %230 = trunc i64 %indvars.iv608 to i32
  %231 = mul nsw i32 %229, %230
  %232 = trunc i32 %231 to i8
  %233 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv608
  store i8 %232, i8* %233, align 1, !tbaa !1
  %indvars.iv.next609 = add nuw nsw i64 %indvars.iv608, 1
  %exitcond610 = icmp eq i64 %indvars.iv.next609, 10240
  br i1 %exitcond610, label %234, label %228

; <label>:234                                     ; preds = %228
  call void @llvm.memset.p0i8.i64(i8* %24, i8 -91, i64 512, i32 2, i1 false)
  br label %235

; <label>:235                                     ; preds = %235, %234
  %indvars.iv605 = phi i64 [ 0, %234 ], [ %indvars.iv.next606, %235 ]
  %v45.0288 = phi i32 [ 0, %234 ], [ %239, %235 ]
  %236 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv605
  %237 = load i8* %236, align 1, !tbaa !1
  %238 = zext i8 %237 to i32
  %239 = add nsw i32 %238, %v45.0288
  %indvars.iv.next606 = add nuw nsw i64 %indvars.iv605, 1
  %exitcond607 = icmp eq i64 %indvars.iv.next606, 10240
  br i1 %exitcond607, label %240, label %235

; <label>:240                                     ; preds = %235
  %241 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %239) #2
  br label %242

; <label>:242                                     ; preds = %242, %240
  %indvars.iv601 = phi i64 [ 0, %240 ], [ %indvars.iv.next602, %242 ]
  %243 = load volatile i32* %seed, align 4
  %244 = trunc i64 %indvars.iv601 to i32
  %245 = mul nsw i32 %243, %244
  %246 = trunc i32 %245 to i8
  %247 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv601
  store i8 %246, i8* %247, align 1, !tbaa !1
  %indvars.iv.next602 = add nuw nsw i64 %indvars.iv601, 1
  %exitcond603 = icmp eq i64 %indvars.iv.next602, 10240
  br i1 %exitcond603, label %248, label %242

; <label>:248                                     ; preds = %242
  call void @llvm.memset.p0i8.i64(i8* %55, i8 -91, i64 1024, i32 4, i1 false)
  br label %249

; <label>:249                                     ; preds = %249, %248
  %indvars.iv598 = phi i64 [ 0, %248 ], [ %indvars.iv.next599, %249 ]
  %v48.0285 = phi i32 [ 0, %248 ], [ %253, %249 ]
  %250 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv598
  %251 = load i8* %250, align 1, !tbaa !1
  %252 = zext i8 %251 to i32
  %253 = add nsw i32 %252, %v48.0285
  %indvars.iv.next599 = add nuw nsw i64 %indvars.iv598, 1
  %exitcond600 = icmp eq i64 %indvars.iv.next599, 10240
  br i1 %exitcond600, label %254, label %249

; <label>:254                                     ; preds = %249
  %255 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %253) #2
  br label %.preheader280

.preheader280:                                    ; preds = %272, %254
  %indvars.iv595 = phi i64 [ 10, %254 ], [ %indvars.iv.next596, %272 ]
  br label %256

; <label>:256                                     ; preds = %256, %.preheader280
  %indvars.iv588 = phi i64 [ 0, %.preheader280 ], [ %indvars.iv.next589, %256 ]
  %257 = load volatile i32* %seed, align 4
  %258 = trunc i64 %indvars.iv588 to i32
  %259 = mul nsw i32 %257, %258
  %260 = trunc i32 %259 to i8
  %261 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv588
  store i8 %260, i8* %261, align 1, !tbaa !1
  %indvars.iv.next589 = add nuw nsw i64 %indvars.iv588, 1
  %exitcond590 = icmp eq i64 %indvars.iv.next589, 10240
  br i1 %exitcond590, label %262, label %256

; <label>:262                                     ; preds = %256
  %263 = trunc i64 %indvars.iv595 to i32
  %264 = srem i32 %263, 17
  %265 = sext i32 %264 to i64
  %266 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %265
  call void @llvm.memset.p0i8.i64(i8* %266, i8 -91, i64 %indvars.iv595, i32 1, i1 false)
  br label %267

; <label>:267                                     ; preds = %267, %262
  %indvars.iv592 = phi i64 [ 0, %262 ], [ %indvars.iv.next593, %267 ]
  %v51.0282 = phi i32 [ 0, %262 ], [ %271, %267 ]
  %268 = getelementptr inbounds [10240 x i8]* %buffer, i64 0, i64 %indvars.iv592
  %269 = load i8* %268, align 1, !tbaa !1
  %270 = zext i8 %269 to i32
  %271 = add nsw i32 %270, %v51.0282
  %indvars.iv.next593 = add nuw nsw i64 %indvars.iv592, 1
  %exitcond594 = icmp eq i64 %indvars.iv.next593, 10240
  br i1 %exitcond594, label %272, label %267

; <label>:272                                     ; preds = %267
  %273 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %263, i32 %271) #2
  %indvars.iv.next596 = add nuw nsw i64 %indvars.iv595, 10
  %274 = trunc i64 %indvars.iv.next596 to i32
  %275 = icmp slt i32 %274, 100
  br i1 %275, label %.preheader280, label %276

; <label>:276                                     ; preds = %272
  call void @llvm.lifetime.end(i64 10240, i8* %1) #2
  %puts167 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str4, i64 0, i64 0))
  %277 = bitcast [10240 x i16]* %buffer53 to i8*
  call void @llvm.lifetime.start(i64 20480, i8* %277) #2
  store volatile i32 123, i32* %seed54, align 4
  br label %278

; <label>:278                                     ; preds = %278, %276
  %indvars.iv585 = phi i64 [ 0, %276 ], [ %indvars.iv.next586, %278 ]
  %279 = load volatile i32* %seed54, align 4
  %280 = trunc i64 %indvars.iv585 to i32
  %281 = mul nsw i32 %279, %280
  %282 = trunc i32 %281 to i16
  %283 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv585
  store i16 %282, i16* %283, align 2, !tbaa !4
  %indvars.iv.next586 = add nuw nsw i64 %indvars.iv585, 1
  %exitcond587 = icmp eq i64 %indvars.iv.next586, 10240
  br i1 %exitcond587, label %284, label %278

; <label>:284                                     ; preds = %278
  %285 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 1
  %286 = bitcast i16* %285 to i8*
  store i8 -91, i8* %286, align 2
  br label %287

; <label>:287                                     ; preds = %287, %284
  %indvars.iv582 = phi i64 [ 0, %284 ], [ %indvars.iv.next583, %287 ]
  %v56.0277 = phi i32 [ 0, %284 ], [ %291, %287 ]
  %288 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv582
  %289 = load i16* %288, align 2, !tbaa !4
  %290 = zext i16 %289 to i32
  %291 = add nsw i32 %290, %v56.0277
  %indvars.iv.next583 = add nuw nsw i64 %indvars.iv582, 1
  %exitcond584 = icmp eq i64 %indvars.iv.next583, 10240
  br i1 %exitcond584, label %292, label %287

; <label>:292                                     ; preds = %287
  %293 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %291) #2
  br label %294

; <label>:294                                     ; preds = %294, %292
  %indvars.iv578 = phi i64 [ 0, %292 ], [ %indvars.iv.next579, %294 ]
  %295 = load volatile i32* %seed54, align 4
  %296 = trunc i64 %indvars.iv578 to i32
  %297 = mul nsw i32 %295, %296
  %298 = trunc i32 %297 to i16
  %299 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv578
  store i16 %298, i16* %299, align 2, !tbaa !4
  %indvars.iv.next579 = add nuw nsw i64 %indvars.iv578, 1
  %exitcond580 = icmp eq i64 %indvars.iv.next579, 10240
  br i1 %exitcond580, label %300, label %294

; <label>:300                                     ; preds = %294
  %301 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 2
  store i16 -23131, i16* %301, align 4
  br label %302

; <label>:302                                     ; preds = %302, %300
  %indvars.iv575 = phi i64 [ 0, %300 ], [ %indvars.iv.next576, %302 ]
  %v59.0274 = phi i32 [ 0, %300 ], [ %306, %302 ]
  %303 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv575
  %304 = load i16* %303, align 2, !tbaa !4
  %305 = zext i16 %304 to i32
  %306 = add nsw i32 %305, %v59.0274
  %indvars.iv.next576 = add nuw nsw i64 %indvars.iv575, 1
  %exitcond577 = icmp eq i64 %indvars.iv.next576, 10240
  br i1 %exitcond577, label %307, label %302

; <label>:307                                     ; preds = %302
  %308 = bitcast i16* %301 to i8*
  %309 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %306) #2
  br label %310

; <label>:310                                     ; preds = %310, %307
  %indvars.iv571 = phi i64 [ 0, %307 ], [ %indvars.iv.next572, %310 ]
  %311 = load volatile i32* %seed54, align 4
  %312 = trunc i64 %indvars.iv571 to i32
  %313 = mul nsw i32 %311, %312
  %314 = trunc i32 %313 to i16
  %315 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv571
  store i16 %314, i16* %315, align 2, !tbaa !4
  %indvars.iv.next572 = add nuw nsw i64 %indvars.iv571, 1
  %exitcond573 = icmp eq i64 %indvars.iv.next572, 10240
  br i1 %exitcond573, label %316, label %310

; <label>:316                                     ; preds = %310
  %317 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 3
  %318 = bitcast i16* %317 to i8*
  call void @llvm.memset.p0i8.i64(i8* %318, i8 -91, i64 3, i32 2, i1 false)
  br label %319

; <label>:319                                     ; preds = %319, %316
  %indvars.iv568 = phi i64 [ 0, %316 ], [ %indvars.iv.next569, %319 ]
  %v62.0271 = phi i32 [ 0, %316 ], [ %323, %319 ]
  %320 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv568
  %321 = load i16* %320, align 2, !tbaa !4
  %322 = zext i16 %321 to i32
  %323 = add nsw i32 %322, %v62.0271
  %indvars.iv.next569 = add nuw nsw i64 %indvars.iv568, 1
  %exitcond570 = icmp eq i64 %indvars.iv.next569, 10240
  br i1 %exitcond570, label %324, label %319

; <label>:324                                     ; preds = %319
  %325 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %323) #2
  br label %326

; <label>:326                                     ; preds = %326, %324
  %indvars.iv564 = phi i64 [ 0, %324 ], [ %indvars.iv.next565, %326 ]
  %327 = load volatile i32* %seed54, align 4
  %328 = trunc i64 %indvars.iv564 to i32
  %329 = mul nsw i32 %327, %328
  %330 = trunc i32 %329 to i16
  %331 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv564
  store i16 %330, i16* %331, align 2, !tbaa !4
  %indvars.iv.next565 = add nuw nsw i64 %indvars.iv564, 1
  %exitcond566 = icmp eq i64 %indvars.iv.next565, 10240
  br i1 %exitcond566, label %332, label %326

; <label>:332                                     ; preds = %326
  %333 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 4
  %334 = bitcast i16* %333 to i32*
  store i32 -1515870811, i32* %334, align 8
  br label %335

; <label>:335                                     ; preds = %335, %332
  %indvars.iv561 = phi i64 [ 0, %332 ], [ %indvars.iv.next562, %335 ]
  %v65.0268 = phi i32 [ 0, %332 ], [ %339, %335 ]
  %336 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv561
  %337 = load i16* %336, align 2, !tbaa !4
  %338 = zext i16 %337 to i32
  %339 = add nsw i32 %338, %v65.0268
  %indvars.iv.next562 = add nuw nsw i64 %indvars.iv561, 1
  %exitcond563 = icmp eq i64 %indvars.iv.next562, 10240
  br i1 %exitcond563, label %340, label %335

; <label>:340                                     ; preds = %335
  %341 = bitcast i16* %333 to i8*
  %342 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %339) #2
  br label %343

; <label>:343                                     ; preds = %343, %340
  %indvars.iv557 = phi i64 [ 0, %340 ], [ %indvars.iv.next558, %343 ]
  %344 = load volatile i32* %seed54, align 4
  %345 = trunc i64 %indvars.iv557 to i32
  %346 = mul nsw i32 %344, %345
  %347 = trunc i32 %346 to i16
  %348 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv557
  store i16 %347, i16* %348, align 2, !tbaa !4
  %indvars.iv.next558 = add nuw nsw i64 %indvars.iv557, 1
  %exitcond559 = icmp eq i64 %indvars.iv.next558, 10240
  br i1 %exitcond559, label %349, label %343

; <label>:349                                     ; preds = %343
  %350 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 5
  %351 = bitcast i16* %350 to i8*
  call void @llvm.memset.p0i8.i64(i8* %351, i8 -91, i64 5, i32 2, i1 false)
  br label %352

; <label>:352                                     ; preds = %352, %349
  %indvars.iv554 = phi i64 [ 0, %349 ], [ %indvars.iv.next555, %352 ]
  %v68.0265 = phi i32 [ 0, %349 ], [ %356, %352 ]
  %353 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv554
  %354 = load i16* %353, align 2, !tbaa !4
  %355 = zext i16 %354 to i32
  %356 = add nsw i32 %355, %v68.0265
  %indvars.iv.next555 = add nuw nsw i64 %indvars.iv554, 1
  %exitcond556 = icmp eq i64 %indvars.iv.next555, 10240
  br i1 %exitcond556, label %357, label %352

; <label>:357                                     ; preds = %352
  %358 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %356) #2
  br label %359

; <label>:359                                     ; preds = %359, %357
  %indvars.iv550 = phi i64 [ 0, %357 ], [ %indvars.iv.next551, %359 ]
  %360 = load volatile i32* %seed54, align 4
  %361 = trunc i64 %indvars.iv550 to i32
  %362 = mul nsw i32 %360, %361
  %363 = trunc i32 %362 to i16
  %364 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv550
  store i16 %363, i16* %364, align 2, !tbaa !4
  %indvars.iv.next551 = add nuw nsw i64 %indvars.iv550, 1
  %exitcond552 = icmp eq i64 %indvars.iv.next551, 10240
  br i1 %exitcond552, label %365, label %359

; <label>:365                                     ; preds = %359
  %366 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 6
  %367 = bitcast i16* %366 to i8*
  call void @llvm.memset.p0i8.i64(i8* %367, i8 -91, i64 6, i32 4, i1 false)
  br label %368

; <label>:368                                     ; preds = %368, %365
  %indvars.iv547 = phi i64 [ 0, %365 ], [ %indvars.iv.next548, %368 ]
  %v71.0262 = phi i32 [ 0, %365 ], [ %372, %368 ]
  %369 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv547
  %370 = load i16* %369, align 2, !tbaa !4
  %371 = zext i16 %370 to i32
  %372 = add nsw i32 %371, %v71.0262
  %indvars.iv.next548 = add nuw nsw i64 %indvars.iv547, 1
  %exitcond549 = icmp eq i64 %indvars.iv.next548, 10240
  br i1 %exitcond549, label %373, label %368

; <label>:373                                     ; preds = %368
  %374 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %372) #2
  br label %375

; <label>:375                                     ; preds = %375, %373
  %indvars.iv543 = phi i64 [ 0, %373 ], [ %indvars.iv.next544, %375 ]
  %376 = load volatile i32* %seed54, align 4
  %377 = trunc i64 %indvars.iv543 to i32
  %378 = mul nsw i32 %376, %377
  %379 = trunc i32 %378 to i16
  %380 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv543
  store i16 %379, i16* %380, align 2, !tbaa !4
  %indvars.iv.next544 = add nuw nsw i64 %indvars.iv543, 1
  %exitcond545 = icmp eq i64 %indvars.iv.next544, 10240
  br i1 %exitcond545, label %381, label %375

; <label>:381                                     ; preds = %375
  %382 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 7
  %383 = bitcast i16* %382 to i8*
  call void @llvm.memset.p0i8.i64(i8* %383, i8 -91, i64 7, i32 2, i1 false)
  br label %384

; <label>:384                                     ; preds = %384, %381
  %indvars.iv540 = phi i64 [ 0, %381 ], [ %indvars.iv.next541, %384 ]
  %v74.0259 = phi i32 [ 0, %381 ], [ %388, %384 ]
  %385 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv540
  %386 = load i16* %385, align 2, !tbaa !4
  %387 = zext i16 %386 to i32
  %388 = add nsw i32 %387, %v74.0259
  %indvars.iv.next541 = add nuw nsw i64 %indvars.iv540, 1
  %exitcond542 = icmp eq i64 %indvars.iv.next541, 10240
  br i1 %exitcond542, label %389, label %384

; <label>:389                                     ; preds = %384
  %390 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %388) #2
  br label %391

; <label>:391                                     ; preds = %391, %389
  %indvars.iv536 = phi i64 [ 0, %389 ], [ %indvars.iv.next537, %391 ]
  %392 = load volatile i32* %seed54, align 4
  %393 = trunc i64 %indvars.iv536 to i32
  %394 = mul nsw i32 %392, %393
  %395 = trunc i32 %394 to i16
  %396 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv536
  store i16 %395, i16* %396, align 2, !tbaa !4
  %indvars.iv.next537 = add nuw nsw i64 %indvars.iv536, 1
  %exitcond538 = icmp eq i64 %indvars.iv.next537, 10240
  br i1 %exitcond538, label %397, label %391

; <label>:397                                     ; preds = %391
  %398 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 8
  %399 = bitcast i16* %398 to i64*
  store i64 -6510615555426900571, i64* %399, align 16
  br label %400

; <label>:400                                     ; preds = %400, %397
  %indvars.iv533 = phi i64 [ 0, %397 ], [ %indvars.iv.next534, %400 ]
  %v77.0256 = phi i32 [ 0, %397 ], [ %404, %400 ]
  %401 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv533
  %402 = load i16* %401, align 2, !tbaa !4
  %403 = zext i16 %402 to i32
  %404 = add nsw i32 %403, %v77.0256
  %indvars.iv.next534 = add nuw nsw i64 %indvars.iv533, 1
  %exitcond535 = icmp eq i64 %indvars.iv.next534, 10240
  br i1 %exitcond535, label %405, label %400

; <label>:405                                     ; preds = %400
  %406 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %404) #2
  br label %407

; <label>:407                                     ; preds = %407, %405
  %indvars.iv529 = phi i64 [ 0, %405 ], [ %indvars.iv.next530, %407 ]
  %408 = load volatile i32* %seed54, align 4
  %409 = trunc i64 %indvars.iv529 to i32
  %410 = mul nsw i32 %408, %409
  %411 = trunc i32 %410 to i16
  %412 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv529
  store i16 %411, i16* %412, align 2, !tbaa !4
  %indvars.iv.next530 = add nuw nsw i64 %indvars.iv529, 1
  %exitcond531 = icmp eq i64 %indvars.iv.next530, 10240
  br i1 %exitcond531, label %413, label %407

; <label>:413                                     ; preds = %407
  %414 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 9
  %415 = bitcast i16* %414 to i8*
  call void @llvm.memset.p0i8.i64(i8* %415, i8 -91, i64 9, i32 2, i1 false)
  br label %416

; <label>:416                                     ; preds = %416, %413
  %indvars.iv526 = phi i64 [ 0, %413 ], [ %indvars.iv.next527, %416 ]
  %v80.0253 = phi i32 [ 0, %413 ], [ %420, %416 ]
  %417 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv526
  %418 = load i16* %417, align 2, !tbaa !4
  %419 = zext i16 %418 to i32
  %420 = add nsw i32 %419, %v80.0253
  %indvars.iv.next527 = add nuw nsw i64 %indvars.iv526, 1
  %exitcond528 = icmp eq i64 %indvars.iv.next527, 10240
  br i1 %exitcond528, label %421, label %416

; <label>:421                                     ; preds = %416
  %422 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %420) #2
  br label %423

; <label>:423                                     ; preds = %423, %421
  %indvars.iv522 = phi i64 [ 0, %421 ], [ %indvars.iv.next523, %423 ]
  %424 = load volatile i32* %seed54, align 4
  %425 = trunc i64 %indvars.iv522 to i32
  %426 = mul nsw i32 %424, %425
  %427 = trunc i32 %426 to i16
  %428 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv522
  store i16 %427, i16* %428, align 2, !tbaa !4
  %indvars.iv.next523 = add nuw nsw i64 %indvars.iv522, 1
  %exitcond524 = icmp eq i64 %indvars.iv.next523, 10240
  br i1 %exitcond524, label %429, label %423

; <label>:429                                     ; preds = %423
  %430 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 10
  %431 = bitcast i16* %430 to i8*
  call void @llvm.memset.p0i8.i64(i8* %431, i8 -91, i64 10, i32 4, i1 false)
  br label %432

; <label>:432                                     ; preds = %432, %429
  %indvars.iv519 = phi i64 [ 0, %429 ], [ %indvars.iv.next520, %432 ]
  %v83.0250 = phi i32 [ 0, %429 ], [ %436, %432 ]
  %433 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv519
  %434 = load i16* %433, align 2, !tbaa !4
  %435 = zext i16 %434 to i32
  %436 = add nsw i32 %435, %v83.0250
  %indvars.iv.next520 = add nuw nsw i64 %indvars.iv519, 1
  %exitcond521 = icmp eq i64 %indvars.iv.next520, 10240
  br i1 %exitcond521, label %437, label %432

; <label>:437                                     ; preds = %432
  %438 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %436) #2
  br label %439

; <label>:439                                     ; preds = %439, %437
  %indvars.iv515 = phi i64 [ 0, %437 ], [ %indvars.iv.next516, %439 ]
  %440 = load volatile i32* %seed54, align 4
  %441 = trunc i64 %indvars.iv515 to i32
  %442 = mul nsw i32 %440, %441
  %443 = trunc i32 %442 to i16
  %444 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv515
  store i16 %443, i16* %444, align 2, !tbaa !4
  %indvars.iv.next516 = add nuw nsw i64 %indvars.iv515, 1
  %exitcond517 = icmp eq i64 %indvars.iv.next516, 10240
  br i1 %exitcond517, label %445, label %439

; <label>:445                                     ; preds = %439
  %446 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 16
  %447 = bitcast i16* %446 to i8*
  call void @llvm.memset.p0i8.i64(i8* %447, i8 -91, i64 16, i32 16, i1 false)
  br label %448

; <label>:448                                     ; preds = %448, %445
  %indvars.iv512 = phi i64 [ 0, %445 ], [ %indvars.iv.next513, %448 ]
  %v86.0247 = phi i32 [ 0, %445 ], [ %452, %448 ]
  %449 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv512
  %450 = load i16* %449, align 2, !tbaa !4
  %451 = zext i16 %450 to i32
  %452 = add nsw i32 %451, %v86.0247
  %indvars.iv.next513 = add nuw nsw i64 %indvars.iv512, 1
  %exitcond514 = icmp eq i64 %indvars.iv.next513, 10240
  br i1 %exitcond514, label %453, label %448

; <label>:453                                     ; preds = %448
  %454 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %452) #2
  br label %455

; <label>:455                                     ; preds = %455, %453
  %indvars.iv508 = phi i64 [ 0, %453 ], [ %indvars.iv.next509, %455 ]
  %456 = load volatile i32* %seed54, align 4
  %457 = trunc i64 %indvars.iv508 to i32
  %458 = mul nsw i32 %456, %457
  %459 = trunc i32 %458 to i16
  %460 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv508
  store i16 %459, i16* %460, align 2, !tbaa !4
  %indvars.iv.next509 = add nuw nsw i64 %indvars.iv508, 1
  %exitcond510 = icmp eq i64 %indvars.iv.next509, 10240
  br i1 %exitcond510, label %461, label %455

; <label>:461                                     ; preds = %455
  %462 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 15
  %463 = bitcast i16* %462 to i8*
  call void @llvm.memset.p0i8.i64(i8* %463, i8 -91, i64 32, i32 2, i1 false)
  br label %464

; <label>:464                                     ; preds = %464, %461
  %indvars.iv505 = phi i64 [ 0, %461 ], [ %indvars.iv.next506, %464 ]
  %v89.0244 = phi i32 [ 0, %461 ], [ %468, %464 ]
  %465 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv505
  %466 = load i16* %465, align 2, !tbaa !4
  %467 = zext i16 %466 to i32
  %468 = add nsw i32 %467, %v89.0244
  %indvars.iv.next506 = add nuw nsw i64 %indvars.iv505, 1
  %exitcond507 = icmp eq i64 %indvars.iv.next506, 10240
  br i1 %exitcond507, label %469, label %464

; <label>:469                                     ; preds = %464
  %470 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %468) #2
  br label %471

; <label>:471                                     ; preds = %471, %469
  %indvars.iv501 = phi i64 [ 0, %469 ], [ %indvars.iv.next502, %471 ]
  %472 = load volatile i32* %seed54, align 4
  %473 = trunc i64 %indvars.iv501 to i32
  %474 = mul nsw i32 %472, %473
  %475 = trunc i32 %474 to i16
  %476 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv501
  store i16 %475, i16* %476, align 2, !tbaa !4
  %indvars.iv.next502 = add nuw nsw i64 %indvars.iv501, 1
  %exitcond503 = icmp eq i64 %indvars.iv.next502, 10240
  br i1 %exitcond503, label %477, label %471

; <label>:477                                     ; preds = %471
  %478 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 13
  %479 = bitcast i16* %478 to i8*
  call void @llvm.memset.p0i8.i64(i8* %479, i8 -91, i64 64, i32 2, i1 false)
  br label %480

; <label>:480                                     ; preds = %480, %477
  %indvars.iv498 = phi i64 [ 0, %477 ], [ %indvars.iv.next499, %480 ]
  %v92.0241 = phi i32 [ 0, %477 ], [ %484, %480 ]
  %481 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv498
  %482 = load i16* %481, align 2, !tbaa !4
  %483 = zext i16 %482 to i32
  %484 = add nsw i32 %483, %v92.0241
  %indvars.iv.next499 = add nuw nsw i64 %indvars.iv498, 1
  %exitcond500 = icmp eq i64 %indvars.iv.next499, 10240
  br i1 %exitcond500, label %485, label %480

; <label>:485                                     ; preds = %480
  %486 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %484) #2
  br label %487

; <label>:487                                     ; preds = %487, %485
  %indvars.iv494 = phi i64 [ 0, %485 ], [ %indvars.iv.next495, %487 ]
  %488 = load volatile i32* %seed54, align 4
  %489 = trunc i64 %indvars.iv494 to i32
  %490 = mul nsw i32 %488, %489
  %491 = trunc i32 %490 to i16
  %492 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv494
  store i16 %491, i16* %492, align 2, !tbaa !4
  %indvars.iv.next495 = add nuw nsw i64 %indvars.iv494, 1
  %exitcond496 = icmp eq i64 %indvars.iv.next495, 10240
  br i1 %exitcond496, label %493, label %487

; <label>:493                                     ; preds = %487
  call void @llvm.memset.p0i8.i64(i8* %415, i8 -91, i64 128, i32 2, i1 false)
  br label %494

; <label>:494                                     ; preds = %494, %493
  %indvars.iv491 = phi i64 [ 0, %493 ], [ %indvars.iv.next492, %494 ]
  %v95.0238 = phi i32 [ 0, %493 ], [ %498, %494 ]
  %495 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv491
  %496 = load i16* %495, align 2, !tbaa !4
  %497 = zext i16 %496 to i32
  %498 = add nsw i32 %497, %v95.0238
  %indvars.iv.next492 = add nuw nsw i64 %indvars.iv491, 1
  %exitcond493 = icmp eq i64 %indvars.iv.next492, 10240
  br i1 %exitcond493, label %499, label %494

; <label>:499                                     ; preds = %494
  %500 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %498) #2
  br label %501

; <label>:501                                     ; preds = %501, %499
  %indvars.iv487 = phi i64 [ 0, %499 ], [ %indvars.iv.next488, %501 ]
  %502 = load volatile i32* %seed54, align 4
  %503 = trunc i64 %indvars.iv487 to i32
  %504 = mul nsw i32 %502, %503
  %505 = trunc i32 %504 to i16
  %506 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv487
  store i16 %505, i16* %506, align 2, !tbaa !4
  %indvars.iv.next488 = add nuw nsw i64 %indvars.iv487, 1
  %exitcond489 = icmp eq i64 %indvars.iv.next488, 10240
  br i1 %exitcond489, label %507, label %501

; <label>:507                                     ; preds = %501
  call void @llvm.memset.p0i8.i64(i8* %286, i8 -91, i64 256, i32 2, i1 false)
  br label %508

; <label>:508                                     ; preds = %508, %507
  %indvars.iv484 = phi i64 [ 0, %507 ], [ %indvars.iv.next485, %508 ]
  %v98.0235 = phi i32 [ 0, %507 ], [ %512, %508 ]
  %509 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv484
  %510 = load i16* %509, align 2, !tbaa !4
  %511 = zext i16 %510 to i32
  %512 = add nsw i32 %511, %v98.0235
  %indvars.iv.next485 = add nuw nsw i64 %indvars.iv484, 1
  %exitcond486 = icmp eq i64 %indvars.iv.next485, 10240
  br i1 %exitcond486, label %513, label %508

; <label>:513                                     ; preds = %508
  %514 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %512) #2
  br label %515

; <label>:515                                     ; preds = %515, %513
  %indvars.iv480 = phi i64 [ 0, %513 ], [ %indvars.iv.next481, %515 ]
  %516 = load volatile i32* %seed54, align 4
  %517 = trunc i64 %indvars.iv480 to i32
  %518 = mul nsw i32 %516, %517
  %519 = trunc i32 %518 to i16
  %520 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv480
  store i16 %519, i16* %520, align 2, !tbaa !4
  %indvars.iv.next481 = add nuw nsw i64 %indvars.iv480, 1
  %exitcond482 = icmp eq i64 %indvars.iv.next481, 10240
  br i1 %exitcond482, label %521, label %515

; <label>:521                                     ; preds = %515
  call void @llvm.memset.p0i8.i64(i8* %308, i8 -91, i64 512, i32 4, i1 false)
  br label %522

; <label>:522                                     ; preds = %522, %521
  %indvars.iv477 = phi i64 [ 0, %521 ], [ %indvars.iv.next478, %522 ]
  %v101.0232 = phi i32 [ 0, %521 ], [ %526, %522 ]
  %523 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv477
  %524 = load i16* %523, align 2, !tbaa !4
  %525 = zext i16 %524 to i32
  %526 = add nsw i32 %525, %v101.0232
  %indvars.iv.next478 = add nuw nsw i64 %indvars.iv477, 1
  %exitcond479 = icmp eq i64 %indvars.iv.next478, 10240
  br i1 %exitcond479, label %527, label %522

; <label>:527                                     ; preds = %522
  %528 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %526) #2
  br label %529

; <label>:529                                     ; preds = %529, %527
  %indvars.iv473 = phi i64 [ 0, %527 ], [ %indvars.iv.next474, %529 ]
  %530 = load volatile i32* %seed54, align 4
  %531 = trunc i64 %indvars.iv473 to i32
  %532 = mul nsw i32 %530, %531
  %533 = trunc i32 %532 to i16
  %534 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv473
  store i16 %533, i16* %534, align 2, !tbaa !4
  %indvars.iv.next474 = add nuw nsw i64 %indvars.iv473, 1
  %exitcond475 = icmp eq i64 %indvars.iv.next474, 10240
  br i1 %exitcond475, label %535, label %529

; <label>:535                                     ; preds = %529
  call void @llvm.memset.p0i8.i64(i8* %341, i8 -91, i64 1024, i32 8, i1 false)
  br label %536

; <label>:536                                     ; preds = %536, %535
  %indvars.iv470 = phi i64 [ 0, %535 ], [ %indvars.iv.next471, %536 ]
  %v104.0229 = phi i32 [ 0, %535 ], [ %540, %536 ]
  %537 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv470
  %538 = load i16* %537, align 2, !tbaa !4
  %539 = zext i16 %538 to i32
  %540 = add nsw i32 %539, %v104.0229
  %indvars.iv.next471 = add nuw nsw i64 %indvars.iv470, 1
  %exitcond472 = icmp eq i64 %indvars.iv.next471, 10240
  br i1 %exitcond472, label %541, label %536

; <label>:541                                     ; preds = %536
  %542 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %540) #2
  br label %.preheader224

.preheader224:                                    ; preds = %560, %541
  %indvars.iv467 = phi i64 [ 10, %541 ], [ %indvars.iv.next468, %560 ]
  br label %543

; <label>:543                                     ; preds = %543, %.preheader224
  %indvars.iv460 = phi i64 [ 0, %.preheader224 ], [ %indvars.iv.next461, %543 ]
  %544 = load volatile i32* %seed54, align 4
  %545 = trunc i64 %indvars.iv460 to i32
  %546 = mul nsw i32 %544, %545
  %547 = trunc i32 %546 to i16
  %548 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv460
  store i16 %547, i16* %548, align 2, !tbaa !4
  %indvars.iv.next461 = add nuw nsw i64 %indvars.iv460, 1
  %exitcond462 = icmp eq i64 %indvars.iv.next461, 10240
  br i1 %exitcond462, label %549, label %543

; <label>:549                                     ; preds = %543
  %550 = trunc i64 %indvars.iv467 to i32
  %551 = srem i32 %550, 17
  %552 = sext i32 %551 to i64
  %553 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %552
  %554 = bitcast i16* %553 to i8*
  call void @llvm.memset.p0i8.i64(i8* %554, i8 -91, i64 %indvars.iv467, i32 2, i1 false)
  br label %555

; <label>:555                                     ; preds = %555, %549
  %indvars.iv464 = phi i64 [ 0, %549 ], [ %indvars.iv.next465, %555 ]
  %v108.0226 = phi i32 [ 0, %549 ], [ %559, %555 ]
  %556 = getelementptr inbounds [10240 x i16]* %buffer53, i64 0, i64 %indvars.iv464
  %557 = load i16* %556, align 2, !tbaa !4
  %558 = zext i16 %557 to i32
  %559 = add nsw i32 %558, %v108.0226
  %indvars.iv.next465 = add nuw nsw i64 %indvars.iv464, 1
  %exitcond466 = icmp eq i64 %indvars.iv.next465, 10240
  br i1 %exitcond466, label %560, label %555

; <label>:560                                     ; preds = %555
  %561 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %550, i32 %559) #2
  %indvars.iv.next468 = add nuw nsw i64 %indvars.iv467, 10
  %562 = trunc i64 %indvars.iv.next468 to i32
  %563 = icmp slt i32 %562, 100
  br i1 %563, label %.preheader224, label %564

; <label>:564                                     ; preds = %560
  call void @llvm.lifetime.end(i64 20480, i8* %277) #2
  %puts168 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @str5, i64 0, i64 0))
  %565 = bitcast [10240 x i32]* %buffer110 to i8*
  call void @llvm.lifetime.start(i64 40960, i8* %565) #2
  store volatile i32 123, i32* %seed111, align 4
  br label %566

; <label>:566                                     ; preds = %566, %564
  %indvars.iv457 = phi i64 [ 0, %564 ], [ %indvars.iv.next458, %566 ]
  %567 = load volatile i32* %seed111, align 4
  %568 = trunc i64 %indvars.iv457 to i32
  %569 = mul nsw i32 %567, %568
  %570 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv457
  store i32 %569, i32* %570, align 4, !tbaa !6
  %indvars.iv.next458 = add nuw nsw i64 %indvars.iv457, 1
  %exitcond459 = icmp eq i64 %indvars.iv.next458, 10240
  br i1 %exitcond459, label %571, label %566

; <label>:571                                     ; preds = %566
  %572 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 1
  %573 = bitcast i32* %572 to i8*
  store i8 -91, i8* %573, align 4
  br label %574

; <label>:574                                     ; preds = %574, %571
  %indvars.iv454 = phi i64 [ 0, %571 ], [ %indvars.iv.next455, %574 ]
  %v113.0221 = phi i32 [ 0, %571 ], [ %577, %574 ]
  %575 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv454
  %576 = load i32* %575, align 4, !tbaa !6
  %577 = add i32 %576, %v113.0221
  %indvars.iv.next455 = add nuw nsw i64 %indvars.iv454, 1
  %exitcond456 = icmp eq i64 %indvars.iv.next455, 10240
  br i1 %exitcond456, label %578, label %574

; <label>:578                                     ; preds = %574
  %579 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1, i32 %577) #2
  br label %580

; <label>:580                                     ; preds = %580, %578
  %indvars.iv450 = phi i64 [ 0, %578 ], [ %indvars.iv.next451, %580 ]
  %581 = load volatile i32* %seed111, align 4
  %582 = trunc i64 %indvars.iv450 to i32
  %583 = mul nsw i32 %581, %582
  %584 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv450
  store i32 %583, i32* %584, align 4, !tbaa !6
  %indvars.iv.next451 = add nuw nsw i64 %indvars.iv450, 1
  %exitcond452 = icmp eq i64 %indvars.iv.next451, 10240
  br i1 %exitcond452, label %585, label %580

; <label>:585                                     ; preds = %580
  %586 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 2
  %587 = bitcast i32* %586 to i16*
  store i16 -23131, i16* %587, align 8
  br label %588

; <label>:588                                     ; preds = %588, %585
  %indvars.iv447 = phi i64 [ 0, %585 ], [ %indvars.iv.next448, %588 ]
  %v116.0218 = phi i32 [ 0, %585 ], [ %591, %588 ]
  %589 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv447
  %590 = load i32* %589, align 4, !tbaa !6
  %591 = add i32 %590, %v116.0218
  %indvars.iv.next448 = add nuw nsw i64 %indvars.iv447, 1
  %exitcond449 = icmp eq i64 %indvars.iv.next448, 10240
  br i1 %exitcond449, label %592, label %588

; <label>:592                                     ; preds = %588
  %593 = bitcast i32* %586 to i8*
  %594 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 2, i32 %591) #2
  br label %595

; <label>:595                                     ; preds = %595, %592
  %indvars.iv443 = phi i64 [ 0, %592 ], [ %indvars.iv.next444, %595 ]
  %596 = load volatile i32* %seed111, align 4
  %597 = trunc i64 %indvars.iv443 to i32
  %598 = mul nsw i32 %596, %597
  %599 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv443
  store i32 %598, i32* %599, align 4, !tbaa !6
  %indvars.iv.next444 = add nuw nsw i64 %indvars.iv443, 1
  %exitcond445 = icmp eq i64 %indvars.iv.next444, 10240
  br i1 %exitcond445, label %600, label %595

; <label>:600                                     ; preds = %595
  %601 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 3
  %602 = bitcast i32* %601 to i8*
  call void @llvm.memset.p0i8.i64(i8* %602, i8 -91, i64 3, i32 4, i1 false)
  br label %603

; <label>:603                                     ; preds = %603, %600
  %indvars.iv440 = phi i64 [ 0, %600 ], [ %indvars.iv.next441, %603 ]
  %v119.0215 = phi i32 [ 0, %600 ], [ %606, %603 ]
  %604 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv440
  %605 = load i32* %604, align 4, !tbaa !6
  %606 = add i32 %605, %v119.0215
  %indvars.iv.next441 = add nuw nsw i64 %indvars.iv440, 1
  %exitcond442 = icmp eq i64 %indvars.iv.next441, 10240
  br i1 %exitcond442, label %607, label %603

; <label>:607                                     ; preds = %603
  %608 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 3, i32 %606) #2
  br label %609

; <label>:609                                     ; preds = %609, %607
  %indvars.iv436 = phi i64 [ 0, %607 ], [ %indvars.iv.next437, %609 ]
  %610 = load volatile i32* %seed111, align 4
  %611 = trunc i64 %indvars.iv436 to i32
  %612 = mul nsw i32 %610, %611
  %613 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv436
  store i32 %612, i32* %613, align 4, !tbaa !6
  %indvars.iv.next437 = add nuw nsw i64 %indvars.iv436, 1
  %exitcond438 = icmp eq i64 %indvars.iv.next437, 10240
  br i1 %exitcond438, label %614, label %609

; <label>:614                                     ; preds = %609
  %615 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 4
  store i32 -1515870811, i32* %615, align 16
  br label %616

; <label>:616                                     ; preds = %616, %614
  %indvars.iv433 = phi i64 [ 0, %614 ], [ %indvars.iv.next434, %616 ]
  %v122.0212 = phi i32 [ 0, %614 ], [ %619, %616 ]
  %617 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv433
  %618 = load i32* %617, align 4, !tbaa !6
  %619 = add i32 %618, %v122.0212
  %indvars.iv.next434 = add nuw nsw i64 %indvars.iv433, 1
  %exitcond435 = icmp eq i64 %indvars.iv.next434, 10240
  br i1 %exitcond435, label %620, label %616

; <label>:620                                     ; preds = %616
  %621 = bitcast i32* %615 to i8*
  %622 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 4, i32 %619) #2
  br label %623

; <label>:623                                     ; preds = %623, %620
  %indvars.iv429 = phi i64 [ 0, %620 ], [ %indvars.iv.next430, %623 ]
  %624 = load volatile i32* %seed111, align 4
  %625 = trunc i64 %indvars.iv429 to i32
  %626 = mul nsw i32 %624, %625
  %627 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv429
  store i32 %626, i32* %627, align 4, !tbaa !6
  %indvars.iv.next430 = add nuw nsw i64 %indvars.iv429, 1
  %exitcond431 = icmp eq i64 %indvars.iv.next430, 10240
  br i1 %exitcond431, label %628, label %623

; <label>:628                                     ; preds = %623
  %629 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 5
  %630 = bitcast i32* %629 to i8*
  call void @llvm.memset.p0i8.i64(i8* %630, i8 -91, i64 5, i32 4, i1 false)
  br label %631

; <label>:631                                     ; preds = %631, %628
  %indvars.iv426 = phi i64 [ 0, %628 ], [ %indvars.iv.next427, %631 ]
  %v125.0209 = phi i32 [ 0, %628 ], [ %634, %631 ]
  %632 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv426
  %633 = load i32* %632, align 4, !tbaa !6
  %634 = add i32 %633, %v125.0209
  %indvars.iv.next427 = add nuw nsw i64 %indvars.iv426, 1
  %exitcond428 = icmp eq i64 %indvars.iv.next427, 10240
  br i1 %exitcond428, label %635, label %631

; <label>:635                                     ; preds = %631
  %636 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 5, i32 %634) #2
  br label %637

; <label>:637                                     ; preds = %637, %635
  %indvars.iv422 = phi i64 [ 0, %635 ], [ %indvars.iv.next423, %637 ]
  %638 = load volatile i32* %seed111, align 4
  %639 = trunc i64 %indvars.iv422 to i32
  %640 = mul nsw i32 %638, %639
  %641 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv422
  store i32 %640, i32* %641, align 4, !tbaa !6
  %indvars.iv.next423 = add nuw nsw i64 %indvars.iv422, 1
  %exitcond424 = icmp eq i64 %indvars.iv.next423, 10240
  br i1 %exitcond424, label %642, label %637

; <label>:642                                     ; preds = %637
  %643 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 6
  %644 = bitcast i32* %643 to i8*
  call void @llvm.memset.p0i8.i64(i8* %644, i8 -91, i64 6, i32 8, i1 false)
  br label %645

; <label>:645                                     ; preds = %645, %642
  %indvars.iv419 = phi i64 [ 0, %642 ], [ %indvars.iv.next420, %645 ]
  %v128.0206 = phi i32 [ 0, %642 ], [ %648, %645 ]
  %646 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv419
  %647 = load i32* %646, align 4, !tbaa !6
  %648 = add i32 %647, %v128.0206
  %indvars.iv.next420 = add nuw nsw i64 %indvars.iv419, 1
  %exitcond421 = icmp eq i64 %indvars.iv.next420, 10240
  br i1 %exitcond421, label %649, label %645

; <label>:649                                     ; preds = %645
  %650 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 6, i32 %648) #2
  br label %651

; <label>:651                                     ; preds = %651, %649
  %indvars.iv415 = phi i64 [ 0, %649 ], [ %indvars.iv.next416, %651 ]
  %652 = load volatile i32* %seed111, align 4
  %653 = trunc i64 %indvars.iv415 to i32
  %654 = mul nsw i32 %652, %653
  %655 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv415
  store i32 %654, i32* %655, align 4, !tbaa !6
  %indvars.iv.next416 = add nuw nsw i64 %indvars.iv415, 1
  %exitcond417 = icmp eq i64 %indvars.iv.next416, 10240
  br i1 %exitcond417, label %656, label %651

; <label>:656                                     ; preds = %651
  %657 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 7
  %658 = bitcast i32* %657 to i8*
  call void @llvm.memset.p0i8.i64(i8* %658, i8 -91, i64 7, i32 4, i1 false)
  br label %659

; <label>:659                                     ; preds = %659, %656
  %indvars.iv412 = phi i64 [ 0, %656 ], [ %indvars.iv.next413, %659 ]
  %v131.0203 = phi i32 [ 0, %656 ], [ %662, %659 ]
  %660 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv412
  %661 = load i32* %660, align 4, !tbaa !6
  %662 = add i32 %661, %v131.0203
  %indvars.iv.next413 = add nuw nsw i64 %indvars.iv412, 1
  %exitcond414 = icmp eq i64 %indvars.iv.next413, 10240
  br i1 %exitcond414, label %663, label %659

; <label>:663                                     ; preds = %659
  %664 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 7, i32 %662) #2
  br label %665

; <label>:665                                     ; preds = %665, %663
  %indvars.iv408 = phi i64 [ 0, %663 ], [ %indvars.iv.next409, %665 ]
  %666 = load volatile i32* %seed111, align 4
  %667 = trunc i64 %indvars.iv408 to i32
  %668 = mul nsw i32 %666, %667
  %669 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv408
  store i32 %668, i32* %669, align 4, !tbaa !6
  %indvars.iv.next409 = add nuw nsw i64 %indvars.iv408, 1
  %exitcond410 = icmp eq i64 %indvars.iv.next409, 10240
  br i1 %exitcond410, label %670, label %665

; <label>:670                                     ; preds = %665
  %671 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 8
  %672 = bitcast i32* %671 to i64*
  store i64 -6510615555426900571, i64* %672, align 16
  br label %673

; <label>:673                                     ; preds = %673, %670
  %indvars.iv405 = phi i64 [ 0, %670 ], [ %indvars.iv.next406, %673 ]
  %v134.0200 = phi i32 [ 0, %670 ], [ %676, %673 ]
  %674 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv405
  %675 = load i32* %674, align 4, !tbaa !6
  %676 = add i32 %675, %v134.0200
  %indvars.iv.next406 = add nuw nsw i64 %indvars.iv405, 1
  %exitcond407 = icmp eq i64 %indvars.iv.next406, 10240
  br i1 %exitcond407, label %677, label %673

; <label>:677                                     ; preds = %673
  %678 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 8, i32 %676) #2
  br label %679

; <label>:679                                     ; preds = %679, %677
  %indvars.iv401 = phi i64 [ 0, %677 ], [ %indvars.iv.next402, %679 ]
  %680 = load volatile i32* %seed111, align 4
  %681 = trunc i64 %indvars.iv401 to i32
  %682 = mul nsw i32 %680, %681
  %683 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv401
  store i32 %682, i32* %683, align 4, !tbaa !6
  %indvars.iv.next402 = add nuw nsw i64 %indvars.iv401, 1
  %exitcond403 = icmp eq i64 %indvars.iv.next402, 10240
  br i1 %exitcond403, label %684, label %679

; <label>:684                                     ; preds = %679
  %685 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 9
  %686 = bitcast i32* %685 to i8*
  call void @llvm.memset.p0i8.i64(i8* %686, i8 -91, i64 9, i32 4, i1 false)
  br label %687

; <label>:687                                     ; preds = %687, %684
  %indvars.iv398 = phi i64 [ 0, %684 ], [ %indvars.iv.next399, %687 ]
  %v137.0197 = phi i32 [ 0, %684 ], [ %690, %687 ]
  %688 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv398
  %689 = load i32* %688, align 4, !tbaa !6
  %690 = add i32 %689, %v137.0197
  %indvars.iv.next399 = add nuw nsw i64 %indvars.iv398, 1
  %exitcond400 = icmp eq i64 %indvars.iv.next399, 10240
  br i1 %exitcond400, label %691, label %687

; <label>:691                                     ; preds = %687
  %692 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 9, i32 %690) #2
  br label %693

; <label>:693                                     ; preds = %693, %691
  %indvars.iv394 = phi i64 [ 0, %691 ], [ %indvars.iv.next395, %693 ]
  %694 = load volatile i32* %seed111, align 4
  %695 = trunc i64 %indvars.iv394 to i32
  %696 = mul nsw i32 %694, %695
  %697 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv394
  store i32 %696, i32* %697, align 4, !tbaa !6
  %indvars.iv.next395 = add nuw nsw i64 %indvars.iv394, 1
  %exitcond396 = icmp eq i64 %indvars.iv.next395, 10240
  br i1 %exitcond396, label %698, label %693

; <label>:698                                     ; preds = %693
  %699 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 10
  %700 = bitcast i32* %699 to i8*
  call void @llvm.memset.p0i8.i64(i8* %700, i8 -91, i64 10, i32 8, i1 false)
  br label %701

; <label>:701                                     ; preds = %701, %698
  %indvars.iv391 = phi i64 [ 0, %698 ], [ %indvars.iv.next392, %701 ]
  %v140.0194 = phi i32 [ 0, %698 ], [ %704, %701 ]
  %702 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv391
  %703 = load i32* %702, align 4, !tbaa !6
  %704 = add i32 %703, %v140.0194
  %indvars.iv.next392 = add nuw nsw i64 %indvars.iv391, 1
  %exitcond393 = icmp eq i64 %indvars.iv.next392, 10240
  br i1 %exitcond393, label %705, label %701

; <label>:705                                     ; preds = %701
  %706 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 10, i32 %704) #2
  br label %707

; <label>:707                                     ; preds = %707, %705
  %indvars.iv387 = phi i64 [ 0, %705 ], [ %indvars.iv.next388, %707 ]
  %708 = load volatile i32* %seed111, align 4
  %709 = trunc i64 %indvars.iv387 to i32
  %710 = mul nsw i32 %708, %709
  %711 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv387
  store i32 %710, i32* %711, align 4, !tbaa !6
  %indvars.iv.next388 = add nuw nsw i64 %indvars.iv387, 1
  %exitcond389 = icmp eq i64 %indvars.iv.next388, 10240
  br i1 %exitcond389, label %712, label %707

; <label>:712                                     ; preds = %707
  %713 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 16
  %714 = bitcast i32* %713 to i8*
  call void @llvm.memset.p0i8.i64(i8* %714, i8 -91, i64 16, i32 16, i1 false)
  br label %715

; <label>:715                                     ; preds = %715, %712
  %indvars.iv384 = phi i64 [ 0, %712 ], [ %indvars.iv.next385, %715 ]
  %v143.0191 = phi i32 [ 0, %712 ], [ %718, %715 ]
  %716 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv384
  %717 = load i32* %716, align 4, !tbaa !6
  %718 = add i32 %717, %v143.0191
  %indvars.iv.next385 = add nuw nsw i64 %indvars.iv384, 1
  %exitcond386 = icmp eq i64 %indvars.iv.next385, 10240
  br i1 %exitcond386, label %719, label %715

; <label>:719                                     ; preds = %715
  %720 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 16, i32 %718) #2
  br label %721

; <label>:721                                     ; preds = %721, %719
  %indvars.iv380 = phi i64 [ 0, %719 ], [ %indvars.iv.next381, %721 ]
  %722 = load volatile i32* %seed111, align 4
  %723 = trunc i64 %indvars.iv380 to i32
  %724 = mul nsw i32 %722, %723
  %725 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv380
  store i32 %724, i32* %725, align 4, !tbaa !6
  %indvars.iv.next381 = add nuw nsw i64 %indvars.iv380, 1
  %exitcond382 = icmp eq i64 %indvars.iv.next381, 10240
  br i1 %exitcond382, label %726, label %721

; <label>:726                                     ; preds = %721
  %727 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 15
  %728 = bitcast i32* %727 to i8*
  call void @llvm.memset.p0i8.i64(i8* %728, i8 -91, i64 32, i32 4, i1 false)
  br label %729

; <label>:729                                     ; preds = %729, %726
  %indvars.iv377 = phi i64 [ 0, %726 ], [ %indvars.iv.next378, %729 ]
  %v146.0188 = phi i32 [ 0, %726 ], [ %732, %729 ]
  %730 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv377
  %731 = load i32* %730, align 4, !tbaa !6
  %732 = add i32 %731, %v146.0188
  %indvars.iv.next378 = add nuw nsw i64 %indvars.iv377, 1
  %exitcond379 = icmp eq i64 %indvars.iv.next378, 10240
  br i1 %exitcond379, label %733, label %729

; <label>:733                                     ; preds = %729
  %734 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 32, i32 %732) #2
  br label %735

; <label>:735                                     ; preds = %735, %733
  %indvars.iv373 = phi i64 [ 0, %733 ], [ %indvars.iv.next374, %735 ]
  %736 = load volatile i32* %seed111, align 4
  %737 = trunc i64 %indvars.iv373 to i32
  %738 = mul nsw i32 %736, %737
  %739 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv373
  store i32 %738, i32* %739, align 4, !tbaa !6
  %indvars.iv.next374 = add nuw nsw i64 %indvars.iv373, 1
  %exitcond375 = icmp eq i64 %indvars.iv.next374, 10240
  br i1 %exitcond375, label %740, label %735

; <label>:740                                     ; preds = %735
  %741 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 13
  %742 = bitcast i32* %741 to i8*
  call void @llvm.memset.p0i8.i64(i8* %742, i8 -91, i64 64, i32 4, i1 false)
  br label %743

; <label>:743                                     ; preds = %743, %740
  %indvars.iv370 = phi i64 [ 0, %740 ], [ %indvars.iv.next371, %743 ]
  %v149.0185 = phi i32 [ 0, %740 ], [ %746, %743 ]
  %744 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv370
  %745 = load i32* %744, align 4, !tbaa !6
  %746 = add i32 %745, %v149.0185
  %indvars.iv.next371 = add nuw nsw i64 %indvars.iv370, 1
  %exitcond372 = icmp eq i64 %indvars.iv.next371, 10240
  br i1 %exitcond372, label %747, label %743

; <label>:747                                     ; preds = %743
  %748 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 64, i32 %746) #2
  br label %749

; <label>:749                                     ; preds = %749, %747
  %indvars.iv366 = phi i64 [ 0, %747 ], [ %indvars.iv.next367, %749 ]
  %750 = load volatile i32* %seed111, align 4
  %751 = trunc i64 %indvars.iv366 to i32
  %752 = mul nsw i32 %750, %751
  %753 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv366
  store i32 %752, i32* %753, align 4, !tbaa !6
  %indvars.iv.next367 = add nuw nsw i64 %indvars.iv366, 1
  %exitcond368 = icmp eq i64 %indvars.iv.next367, 10240
  br i1 %exitcond368, label %754, label %749

; <label>:754                                     ; preds = %749
  call void @llvm.memset.p0i8.i64(i8* %686, i8 -91, i64 128, i32 4, i1 false)
  br label %755

; <label>:755                                     ; preds = %755, %754
  %indvars.iv363 = phi i64 [ 0, %754 ], [ %indvars.iv.next364, %755 ]
  %v152.0182 = phi i32 [ 0, %754 ], [ %758, %755 ]
  %756 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv363
  %757 = load i32* %756, align 4, !tbaa !6
  %758 = add i32 %757, %v152.0182
  %indvars.iv.next364 = add nuw nsw i64 %indvars.iv363, 1
  %exitcond365 = icmp eq i64 %indvars.iv.next364, 10240
  br i1 %exitcond365, label %759, label %755

; <label>:759                                     ; preds = %755
  %760 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 128, i32 %758) #2
  br label %761

; <label>:761                                     ; preds = %761, %759
  %indvars.iv359 = phi i64 [ 0, %759 ], [ %indvars.iv.next360, %761 ]
  %762 = load volatile i32* %seed111, align 4
  %763 = trunc i64 %indvars.iv359 to i32
  %764 = mul nsw i32 %762, %763
  %765 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv359
  store i32 %764, i32* %765, align 4, !tbaa !6
  %indvars.iv.next360 = add nuw nsw i64 %indvars.iv359, 1
  %exitcond361 = icmp eq i64 %indvars.iv.next360, 10240
  br i1 %exitcond361, label %766, label %761

; <label>:766                                     ; preds = %761
  call void @llvm.memset.p0i8.i64(i8* %573, i8 -91, i64 256, i32 4, i1 false)
  br label %767

; <label>:767                                     ; preds = %767, %766
  %indvars.iv356 = phi i64 [ 0, %766 ], [ %indvars.iv.next357, %767 ]
  %v155.0179 = phi i32 [ 0, %766 ], [ %770, %767 ]
  %768 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv356
  %769 = load i32* %768, align 4, !tbaa !6
  %770 = add i32 %769, %v155.0179
  %indvars.iv.next357 = add nuw nsw i64 %indvars.iv356, 1
  %exitcond358 = icmp eq i64 %indvars.iv.next357, 10240
  br i1 %exitcond358, label %771, label %767

; <label>:771                                     ; preds = %767
  %772 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 256, i32 %770) #2
  br label %773

; <label>:773                                     ; preds = %773, %771
  %indvars.iv352 = phi i64 [ 0, %771 ], [ %indvars.iv.next353, %773 ]
  %774 = load volatile i32* %seed111, align 4
  %775 = trunc i64 %indvars.iv352 to i32
  %776 = mul nsw i32 %774, %775
  %777 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv352
  store i32 %776, i32* %777, align 4, !tbaa !6
  %indvars.iv.next353 = add nuw nsw i64 %indvars.iv352, 1
  %exitcond354 = icmp eq i64 %indvars.iv.next353, 10240
  br i1 %exitcond354, label %778, label %773

; <label>:778                                     ; preds = %773
  call void @llvm.memset.p0i8.i64(i8* %593, i8 -91, i64 512, i32 8, i1 false)
  br label %779

; <label>:779                                     ; preds = %779, %778
  %indvars.iv349 = phi i64 [ 0, %778 ], [ %indvars.iv.next350, %779 ]
  %v158.0176 = phi i32 [ 0, %778 ], [ %782, %779 ]
  %780 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv349
  %781 = load i32* %780, align 4, !tbaa !6
  %782 = add i32 %781, %v158.0176
  %indvars.iv.next350 = add nuw nsw i64 %indvars.iv349, 1
  %exitcond351 = icmp eq i64 %indvars.iv.next350, 10240
  br i1 %exitcond351, label %783, label %779

; <label>:783                                     ; preds = %779
  %784 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 512, i32 %782) #2
  br label %785

; <label>:785                                     ; preds = %785, %783
  %indvars.iv345 = phi i64 [ 0, %783 ], [ %indvars.iv.next346, %785 ]
  %786 = load volatile i32* %seed111, align 4
  %787 = trunc i64 %indvars.iv345 to i32
  %788 = mul nsw i32 %786, %787
  %789 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv345
  store i32 %788, i32* %789, align 4, !tbaa !6
  %indvars.iv.next346 = add nuw nsw i64 %indvars.iv345, 1
  %exitcond347 = icmp eq i64 %indvars.iv.next346, 10240
  br i1 %exitcond347, label %790, label %785

; <label>:790                                     ; preds = %785
  call void @llvm.memset.p0i8.i64(i8* %621, i8 -91, i64 1024, i32 16, i1 false)
  br label %791

; <label>:791                                     ; preds = %791, %790
  %indvars.iv342 = phi i64 [ 0, %790 ], [ %indvars.iv.next343, %791 ]
  %v161.0173 = phi i32 [ 0, %790 ], [ %794, %791 ]
  %792 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv342
  %793 = load i32* %792, align 4, !tbaa !6
  %794 = add i32 %793, %v161.0173
  %indvars.iv.next343 = add nuw nsw i64 %indvars.iv342, 1
  %exitcond344 = icmp eq i64 %indvars.iv.next343, 10240
  br i1 %exitcond344, label %795, label %791

; <label>:795                                     ; preds = %791
  %796 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 1024, i32 %794) #2
  br label %.preheader

.preheader:                                       ; preds = %812, %795
  %indvars.iv339 = phi i64 [ 10, %795 ], [ %indvars.iv.next340, %812 ]
  br label %797

; <label>:797                                     ; preds = %797, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %797 ]
  %798 = load volatile i32* %seed111, align 4
  %799 = trunc i64 %indvars.iv to i32
  %800 = mul nsw i32 %798, %799
  %801 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv
  store i32 %800, i32* %801, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 10240
  br i1 %exitcond, label %802, label %797

; <label>:802                                     ; preds = %797
  %803 = trunc i64 %indvars.iv339 to i32
  %804 = srem i32 %803, 17
  %805 = sext i32 %804 to i64
  %806 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %805
  %807 = bitcast i32* %806 to i8*
  call void @llvm.memset.p0i8.i64(i8* %807, i8 -91, i64 %indvars.iv339, i32 4, i1 false)
  br label %808

; <label>:808                                     ; preds = %808, %802
  %indvars.iv336 = phi i64 [ 0, %802 ], [ %indvars.iv.next337, %808 ]
  %v165.0170 = phi i32 [ 0, %802 ], [ %811, %808 ]
  %809 = getelementptr inbounds [10240 x i32]* %buffer110, i64 0, i64 %indvars.iv336
  %810 = load i32* %809, align 4, !tbaa !6
  %811 = add i32 %810, %v165.0170
  %indvars.iv.next337 = add nuw nsw i64 %indvars.iv336, 1
  %exitcond338 = icmp eq i64 %indvars.iv.next337, 10240
  br i1 %exitcond338, label %812, label %808

; <label>:812                                     ; preds = %808
  %813 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i32 %803, i32 %811) #2
  %indvars.iv.next340 = add nuw nsw i64 %indvars.iv339, 10
  %814 = trunc i64 %indvars.iv.next340 to i32
  %815 = icmp slt i32 %814, 100
  br i1 %815, label %.preheader, label %816

; <label>:816                                     ; preds = %812
  call void @llvm.lifetime.end(i64 40960, i8* %565) #2
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
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"short", metadata !2, i64 0}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !2, i64 0}
