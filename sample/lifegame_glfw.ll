; ModuleID = 'lifegame_glfw.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.GLFWwindow = type opaque
%struct.GLFWmonitor = type opaque

@obverse = common global [128 x [128 x i8]] zeroinitializer, align 16
@reverse = common global [128 x [128 x i8]] zeroinitializer, align 16
@noise_xx = common global i32 0, align 4
@noise_yy = common global i32 0, align 4
@noise_x = common global i32 0, align 4
@noise_y = common global i32 0, align 4
@.str = private unnamed_addr constant [10 x i8] c"life game\00", align 1

; Function Attrs: nounwind uwtable
define void @shuffle() #0 {
  br label %.preheader

.preheader:                                       ; preds = %6, %0
  %indvars.iv3 = phi i64 [ 0, %0 ], [ %indvars.iv.next4, %6 ]
  br label %1

; <label>:1                                       ; preds = %1, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %1 ]
  %2 = tail call i32 @rand() #3
  %3 = and i32 %2, 1
  %4 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %indvars.iv3, i64 %indvars.iv
  %5 = xor i32 %3, 1
  %. = trunc i32 %5 to i8
  store i8 %., i8* %4, align 1, !tbaa !1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %6, label %1

; <label>:6                                       ; preds = %1
  %indvars.iv.next4 = add nuw nsw i64 %indvars.iv3, 1
  %exitcond5 = icmp eq i64 %indvars.iv.next4, 128
  br i1 %exitcond5, label %7, label %.preheader

; <label>:7                                       ; preds = %6
  ret void
}

; Function Attrs: nounwind
declare i32 @rand() #1

; Function Attrs: nounwind uwtable
define void @update() #0 {
  br label %.preheader6

.preheader6:                                      ; preds = %61, %0
  %indvars.iv11 = phi i64 [ 0, %0 ], [ %indvars.iv.next12, %61 ]
  %1 = add i64 %indvars.iv11, 128
  br label %.preheader3

.preheader3:                                      ; preds = %60, %.preheader6
  %indvars.iv = phi i64 [ 0, %.preheader6 ], [ %indvars.iv.next, %60 ]
  %2 = add i64 %indvars.iv, 128
  %3 = add i64 %indvars.iv, 127
  %4 = trunc i64 %3 to i32
  %5 = srem i32 %4, 128
  %6 = sext i32 %5 to i64
  %7 = add i64 %indvars.iv11, 127
  %8 = trunc i64 %7 to i32
  %9 = srem i32 %8, 128
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %10, i64 %6
  %12 = load i8* %11, align 1, !tbaa !1
  %13 = trunc i64 %2 to i32
  %14 = srem i32 %13, 128
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %10, i64 %15
  %17 = load i8* %16, align 1, !tbaa !1
  %18 = add i8 %17, %12
  %19 = add i64 %indvars.iv, 129
  %20 = trunc i64 %19 to i32
  %21 = srem i32 %20, 128
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %10, i64 %22
  %24 = load i8* %23, align 1, !tbaa !1
  %25 = add i8 %24, %18
  %26 = trunc i64 %1 to i32
  %27 = srem i32 %26, 128
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %28, i64 %6
  %30 = load i8* %29, align 1, !tbaa !1
  %31 = add i8 %30, %25
  %32 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %28, i64 %15
  %33 = load i8* %32, align 1, !tbaa !1
  %34 = add i8 %33, %31
  %35 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %28, i64 %22
  %36 = load i8* %35, align 1, !tbaa !1
  %37 = add i8 %36, %34
  %38 = add i64 %indvars.iv11, 129
  %39 = trunc i64 %38 to i32
  %40 = srem i32 %39, 128
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %41, i64 %6
  %43 = load i8* %42, align 1, !tbaa !1
  %44 = add i8 %43, %37
  %45 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %41, i64 %15
  %46 = load i8* %45, align 1, !tbaa !1
  %47 = add i8 %46, %44
  %48 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %41, i64 %22
  %49 = load i8* %48, align 1, !tbaa !1
  %50 = add i8 %49, %47
  %51 = getelementptr inbounds [128 x [128 x i8]]* @reverse, i64 0, i64 %indvars.iv11, i64 %indvars.iv
  %52 = load i8* %51, align 1, !tbaa !1
  %53 = sub i8 %50, %52
  switch i8 %53, label %58 [
    i8 3, label %54
    i8 2, label %56
  ]

; <label>:54                                      ; preds = %.preheader3
  %55 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %indvars.iv11, i64 %indvars.iv
  store i8 1, i8* %55, align 1, !tbaa !1
  br label %60

; <label>:56                                      ; preds = %.preheader3
  %57 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %indvars.iv11, i64 %indvars.iv
  store i8 %52, i8* %57, align 1, !tbaa !1
  br label %60

; <label>:58                                      ; preds = %.preheader3
  %59 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %indvars.iv11, i64 %indvars.iv
  store i8 0, i8* %59, align 1, !tbaa !1
  br label %60

; <label>:60                                      ; preds = %58, %56, %54
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %61, label %.preheader3

; <label>:61                                      ; preds = %60
  %indvars.iv.next12 = add nuw nsw i64 %indvars.iv11, 1
  %exitcond13 = icmp eq i64 %indvars.iv.next12, 128
  br i1 %exitcond13, label %62, label %.preheader6

; <label>:62                                      ; preds = %61
  ret void
}

; Function Attrs: nounwind uwtable
define void @noise() #0 {
  %1 = tail call i32 @rand() #3
  %2 = srem i32 %1, 7
  %3 = add nsw i32 %2, -3
  store i32 %3, i32* @noise_xx, align 4, !tbaa !4
  %4 = tail call i32 @rand() #3
  %5 = srem i32 %4, 7
  %6 = add nsw i32 %5, -3
  store i32 %6, i32* @noise_yy, align 4, !tbaa !4
  %7 = load i32* @noise_x, align 4, !tbaa !4
  %8 = load i32* @noise_xx, align 4, !tbaa !4
  %9 = add i32 %7, 128
  %10 = add i32 %9, %8
  %11 = srem i32 %10, 128
  store i32 %11, i32* @noise_x, align 4, !tbaa !4
  %12 = load i32* @noise_y, align 4, !tbaa !4
  %13 = add i32 %12, 128
  %14 = add i32 %13, %6
  %15 = srem i32 %14, 128
  store i32 %15, i32* @noise_y, align 4, !tbaa !4
  %16 = sext i32 %15 to i64
  %17 = sext i32 %11 to i64
  %18 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %17, i64 %16
  store i8 1, i8* %18, align 1, !tbaa !1
  ret void
}

; Function Attrs: nounwind uwtable
define void @draw() #0 {
  tail call void @glClear(i32 16384) #3
  br label %.preheader

.preheader:                                       ; preds = %51, %0
  %indvars.iv4 = phi i64 [ 0, %0 ], [ %indvars.iv.next5, %51 ]
  %1 = trunc i64 %indvars.iv4 to i32
  %2 = sitofp i32 %1 to float
  %3 = fmul float %2, 7.812500e-03
  %4 = fpext float %3 to double
  %5 = fadd double %4, -5.000000e-01
  %6 = fmul double %5, 2.000000e+00
  %7 = fptrunc double %6 to float
  %8 = fpext float %2 to double
  %9 = fadd double %8, 1.000000e+00
  %10 = fmul double %9, 7.812500e-03
  %11 = fadd double %10, -5.000000e-01
  %12 = fmul double %11, 2.000000e+00
  %13 = fptrunc double %12 to float
  br label %14

; <label>:14                                      ; preds = %50, %.preheader
  %indvars.iv = phi i64 [ 0, %.preheader ], [ %indvars.iv.next, %50 ]
  %15 = load i32* @noise_x, align 4, !tbaa !4
  %16 = icmp eq i32 %1, %15
  %17 = load i32* @noise_y, align 4, !tbaa !4
  %18 = trunc i64 %indvars.iv to i32
  %19 = icmp eq i32 %18, %17
  %or.cond = and i1 %16, %19
  br i1 %or.cond, label %20, label %33

; <label>:20                                      ; preds = %14
  tail call void @glColor3f(float 0x3FE8F8F900000000, float 0x3FCF1F1F20000000, float 0x3FCD1D1D20000000) #3
  tail call void @glBegin(i32 7) #3
  %21 = sitofp i32 %17 to float
  %22 = fmul float %21, 7.812500e-03
  %23 = fpext float %22 to double
  %24 = fadd double %23, -5.000000e-01
  %25 = fmul double %24, 2.000000e+00
  %26 = fptrunc double %25 to float
  tail call void @glVertex2f(float %7, float %26) #3
  tail call void @glVertex2f(float %13, float %26) #3
  %27 = fpext float %21 to double
  %28 = fadd double %27, 1.000000e+00
  %29 = fmul double %28, 7.812500e-03
  %30 = fadd double %29, -5.000000e-01
  %31 = fmul double %30, 2.000000e+00
  %32 = fptrunc double %31 to float
  tail call void @glVertex2f(float %13, float %32) #3
  tail call void @glVertex2f(float %7, float %32) #3
  tail call void @glEnd() #3
  br label %50

; <label>:33                                      ; preds = %14
  %34 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %indvars.iv4, i64 %indvars.iv
  %35 = load i8* %34, align 1, !tbaa !1
  %36 = icmp eq i8 %35, 0
  br i1 %36, label %50, label %37

; <label>:37                                      ; preds = %33
  tail call void @glColor3f(float 0.000000e+00, float 0x3FE1313140000000, float 0x3FDB1B1B20000000) #3
  tail call void @glBegin(i32 7) #3
  %38 = sitofp i32 %18 to float
  %39 = fmul float %38, 7.812500e-03
  %40 = fpext float %39 to double
  %41 = fadd double %40, -5.000000e-01
  %42 = fmul double %41, 2.000000e+00
  %43 = fptrunc double %42 to float
  tail call void @glVertex2f(float %7, float %43) #3
  tail call void @glVertex2f(float %13, float %43) #3
  %44 = fpext float %38 to double
  %45 = fadd double %44, 1.000000e+00
  %46 = fmul double %45, 7.812500e-03
  %47 = fadd double %46, -5.000000e-01
  %48 = fmul double %47, 2.000000e+00
  %49 = fptrunc double %48 to float
  tail call void @glVertex2f(float %13, float %49) #3
  tail call void @glVertex2f(float %7, float %49) #3
  tail call void @glEnd() #3
  br label %50

; <label>:50                                      ; preds = %37, %33, %20
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %51, label %14

; <label>:51                                      ; preds = %50
  %indvars.iv.next5 = add nuw nsw i64 %indvars.iv4, 1
  %exitcond6 = icmp eq i64 %indvars.iv.next5, 128
  br i1 %exitcond6, label %52, label %.preheader

; <label>:52                                      ; preds = %51
  ret void
}

declare void @glClear(i32) #2

declare void @glColor3f(float, float, float) #2

declare void @glBegin(i32) #2

declare void @glVertex2f(float, float) #2

declare void @glEnd() #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call i64 @time(i64* null) #3
  %2 = trunc i64 %1 to i32
  tail call void @srand(i32 %2) #3
  %3 = tail call i32 @glfwInit() #3
  %4 = tail call %struct.GLFWwindow* @glfwCreateWindow(i32 512, i32 512, i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0), %struct.GLFWmonitor* null, %struct.GLFWwindow* null) #3
  tail call void @glfwMakeContextCurrent(%struct.GLFWwindow* %4) #3
  tail call void @glfwSwapInterval(i32 1) #3
  br label %.preheader.i

.preheader.i:                                     ; preds = %10, %0
  %indvars.iv3.i = phi i64 [ 0, %0 ], [ %indvars.iv.next4.i, %10 ]
  br label %5

; <label>:5                                       ; preds = %5, %.preheader.i
  %indvars.iv.i = phi i64 [ 0, %.preheader.i ], [ %indvars.iv.next.i, %5 ]
  %6 = tail call i32 @rand() #3
  %7 = and i32 %6, 1
  %8 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %indvars.iv3.i, i64 %indvars.iv.i
  %9 = xor i32 %7, 1
  %..i = trunc i32 %9 to i8
  store i8 %..i, i8* %8, align 1, !tbaa !1
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.i = icmp eq i64 %indvars.iv.next.i, 128
  br i1 %exitcond.i, label %10, label %5

; <label>:10                                      ; preds = %5
  %indvars.iv.next4.i = add nuw nsw i64 %indvars.iv3.i, 1
  %exitcond5.i = icmp eq i64 %indvars.iv.next4.i, 128
  br i1 %exitcond5.i, label %shuffle.exit.preheader, label %.preheader.i

shuffle.exit.preheader:                           ; preds = %10
  %11 = tail call i32 @glfwWindowShouldClose(%struct.GLFWwindow* %4) #3
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %shuffle.exit, label %shuffle.exit._crit_edge

shuffle.exit:                                     ; preds = %shuffle.exit, %shuffle.exit.preheader
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([128 x [128 x i8]]* @reverse, i64 0, i64 0, i64 0), i8* getelementptr inbounds ([128 x [128 x i8]]* @obverse, i64 0, i64 0, i64 0), i64 16384, i32 16, i1 false)
  tail call void @update()
  %13 = tail call i32 @rand() #3
  %14 = srem i32 %13, 7
  %15 = add nsw i32 %14, -3
  store i32 %15, i32* @noise_xx, align 4, !tbaa !4
  %16 = tail call i32 @rand() #3
  %17 = srem i32 %16, 7
  %18 = add nsw i32 %17, -3
  store i32 %18, i32* @noise_yy, align 4, !tbaa !4
  %19 = load i32* @noise_x, align 4, !tbaa !4
  %20 = load i32* @noise_xx, align 4, !tbaa !4
  %21 = add i32 %19, 128
  %22 = add i32 %21, %20
  %23 = srem i32 %22, 128
  store i32 %23, i32* @noise_x, align 4, !tbaa !4
  %24 = load i32* @noise_y, align 4, !tbaa !4
  %25 = add i32 %17, 125
  %26 = add i32 %25, %24
  %27 = srem i32 %26, 128
  store i32 %27, i32* @noise_y, align 4, !tbaa !4
  %28 = sext i32 %27 to i64
  %29 = sext i32 %23 to i64
  %30 = getelementptr inbounds [128 x [128 x i8]]* @obverse, i64 0, i64 %29, i64 %28
  store i8 1, i8* %30, align 1, !tbaa !1
  tail call void @draw()
  tail call void @glfwSwapBuffers(%struct.GLFWwindow* %4) #3
  tail call void @glfwPollEvents() #3
  %31 = tail call i32 @glfwWindowShouldClose(%struct.GLFWwindow* %4) #3
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %shuffle.exit, label %shuffle.exit._crit_edge

shuffle.exit._crit_edge:                          ; preds = %shuffle.exit, %shuffle.exit.preheader
  tail call void @glfwDestroyWindow(%struct.GLFWwindow* %4) #3
  tail call void @glfwTerminate() #3
  ret i32 0
}

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind
declare i64 @time(i64*) #1

declare i32 @glfwInit() #2

declare %struct.GLFWwindow* @glfwCreateWindow(i32, i32, i8*, %struct.GLFWmonitor*, %struct.GLFWwindow*) #2

declare void @glfwMakeContextCurrent(%struct.GLFWwindow*) #2

declare void @glfwSwapInterval(i32) #2

declare i32 @glfwWindowShouldClose(%struct.GLFWwindow*) #2

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

declare void @glfwSwapBuffers(%struct.GLFWwindow*) #2

declare void @glfwPollEvents() #2

declare void @glfwDestroyWindow(%struct.GLFWwindow*) #2

declare void @glfwTerminate() #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"int", metadata !2, i64 0}
