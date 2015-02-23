; ModuleID = 'test_strcasecmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str3 = private unnamed_addr constant [7 x i8] c"hello1\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"iello\00", align 1
@.str5 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str6 = private unnamed_addr constant [2 x i8] c"Z\00", align 1
@.str7 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str8 = private unnamed_addr constant [2 x i8] c"z\00", align 1
@.str9 = private unnamed_addr constant [6 x i8] c"Hello\00", align 1
@.str10 = private unnamed_addr constant [7 x i8] c"Hello1\00", align 1
@.str11 = private unnamed_addr constant [6 x i8] c"Iello\00", align 1
@str12 = private unnamed_addr constant [2 x i8] c"*\00"

; Function Attrs: nounwind readnone uwtable
define i32 @sign(i32 %x) #0 {
  %1 = icmp slt i32 %x, 0
  br i1 %1, label %4, label %2

; <label>:2                                       ; preds = %0
  %3 = icmp sgt i32 %x, 0
  %. = zext i1 %3 to i32
  br label %4

; <label>:4                                       ; preds = %2, %0
  %.0 = phi i32 [ -1, %0 ], [ %., %2 ]
  ret i32 %.0
}

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str12, i64 0, i64 0))
  %1 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %sign.exit, label %3

; <label>:3                                       ; preds = %0
  %4 = icmp sgt i32 %1, 0
  %..i = zext i1 %4 to i32
  br label %sign.exit

sign.exit:                                        ; preds = %3, %0
  %.0.i = phi i32 [ -1, %0 ], [ %..i, %3 ]
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i) #4
  %6 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %7 = icmp slt i32 %6, 0
  br i1 %7, label %sign.exit178, label %8

; <label>:8                                       ; preds = %sign.exit
  %9 = icmp sgt i32 %6, 0
  %..i176 = zext i1 %9 to i32
  br label %sign.exit178

sign.exit178:                                     ; preds = %8, %sign.exit
  %.0.i177 = phi i32 [ -1, %sign.exit ], [ %..i176, %8 ]
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i177) #4
  %11 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %sign.exit175, label %13

; <label>:13                                      ; preds = %sign.exit178
  %14 = icmp sgt i32 %11, 0
  %..i173 = zext i1 %14 to i32
  br label %sign.exit175

sign.exit175:                                     ; preds = %13, %sign.exit178
  %.0.i174 = phi i32 [ -1, %sign.exit178 ], [ %..i173, %13 ]
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i174) #4
  %16 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %17 = icmp slt i32 %16, 0
  br i1 %17, label %sign.exit172, label %18

; <label>:18                                      ; preds = %sign.exit175
  %19 = icmp sgt i32 %16, 0
  %..i170 = zext i1 %19 to i32
  br label %sign.exit172

sign.exit172:                                     ; preds = %18, %sign.exit175
  %.0.i171 = phi i32 [ -1, %sign.exit175 ], [ %..i170, %18 ]
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i171) #4
  %21 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %22 = icmp slt i32 %21, 0
  br i1 %22, label %sign.exit169, label %23

; <label>:23                                      ; preds = %sign.exit172
  %24 = icmp sgt i32 %21, 0
  %..i167 = zext i1 %24 to i32
  br label %sign.exit169

sign.exit169:                                     ; preds = %23, %sign.exit172
  %.0.i168 = phi i32 [ -1, %sign.exit172 ], [ %..i167, %23 ]
  %25 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i168) #4
  %26 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0)) #5
  %27 = icmp slt i32 %26, 0
  br i1 %27, label %sign.exit166, label %28

; <label>:28                                      ; preds = %sign.exit169
  %29 = icmp sgt i32 %26, 0
  %..i164 = zext i1 %29 to i32
  br label %sign.exit166

sign.exit166:                                     ; preds = %28, %sign.exit169
  %.0.i165 = phi i32 [ -1, %sign.exit169 ], [ %..i164, %28 ]
  %30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i165) #4
  %31 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %32 = icmp slt i32 %31, 0
  br i1 %32, label %sign.exit163, label %33

; <label>:33                                      ; preds = %sign.exit166
  %34 = icmp sgt i32 %31, 0
  %..i161 = zext i1 %34 to i32
  br label %sign.exit163

sign.exit163:                                     ; preds = %33, %sign.exit166
  %.0.i162 = phi i32 [ -1, %sign.exit166 ], [ %..i161, %33 ]
  %35 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i162) #4
  %36 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %37 = icmp slt i32 %36, 0
  br i1 %37, label %sign.exit160, label %38

; <label>:38                                      ; preds = %sign.exit163
  %39 = icmp sgt i32 %36, 0
  %..i158 = zext i1 %39 to i32
  br label %sign.exit160

sign.exit160:                                     ; preds = %38, %sign.exit163
  %.0.i159 = phi i32 [ -1, %sign.exit163 ], [ %..i158, %38 ]
  %40 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i159) #4
  %41 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %42 = icmp slt i32 %41, 0
  br i1 %42, label %sign.exit157, label %43

; <label>:43                                      ; preds = %sign.exit160
  %44 = icmp sgt i32 %41, 0
  %..i155 = zext i1 %44 to i32
  br label %sign.exit157

sign.exit157:                                     ; preds = %43, %sign.exit160
  %.0.i156 = phi i32 [ -1, %sign.exit160 ], [ %..i155, %43 ]
  %45 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i156) #4
  %46 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %47 = icmp slt i32 %46, 0
  br i1 %47, label %sign.exit154, label %48

; <label>:48                                      ; preds = %sign.exit157
  %49 = icmp sgt i32 %46, 0
  %..i152 = zext i1 %49 to i32
  br label %sign.exit154

sign.exit154:                                     ; preds = %48, %sign.exit157
  %.0.i153 = phi i32 [ -1, %sign.exit157 ], [ %..i152, %48 ]
  %50 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i153) #4
  %51 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %52 = icmp slt i32 %51, 0
  br i1 %52, label %sign.exit151, label %53

; <label>:53                                      ; preds = %sign.exit154
  %54 = icmp sgt i32 %51, 0
  %..i149 = zext i1 %54 to i32
  br label %sign.exit151

sign.exit151:                                     ; preds = %53, %sign.exit154
  %.0.i150 = phi i32 [ -1, %sign.exit154 ], [ %..i149, %53 ]
  %55 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i150) #4
  %56 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %57 = icmp slt i32 %56, 0
  br i1 %57, label %sign.exit148, label %58

; <label>:58                                      ; preds = %sign.exit151
  %59 = icmp sgt i32 %56, 0
  %..i146 = zext i1 %59 to i32
  br label %sign.exit148

sign.exit148:                                     ; preds = %58, %sign.exit151
  %.0.i147 = phi i32 [ -1, %sign.exit151 ], [ %..i146, %58 ]
  %60 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i147) #4
  %61 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %62 = icmp slt i32 %61, 0
  br i1 %62, label %sign.exit145, label %63

; <label>:63                                      ; preds = %sign.exit148
  %64 = icmp sgt i32 %61, 0
  %..i143 = zext i1 %64 to i32
  br label %sign.exit145

sign.exit145:                                     ; preds = %63, %sign.exit148
  %.0.i144 = phi i32 [ -1, %sign.exit148 ], [ %..i143, %63 ]
  %65 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i144) #4
  %66 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %67 = icmp slt i32 %66, 0
  br i1 %67, label %sign.exit142, label %68

; <label>:68                                      ; preds = %sign.exit145
  %69 = icmp sgt i32 %66, 0
  %..i140 = zext i1 %69 to i32
  br label %sign.exit142

sign.exit142:                                     ; preds = %68, %sign.exit145
  %.0.i141 = phi i32 [ -1, %sign.exit145 ], [ %..i140, %68 ]
  %70 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i141) #4
  %71 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %72 = icmp slt i32 %71, 0
  br i1 %72, label %sign.exit139, label %73

; <label>:73                                      ; preds = %sign.exit142
  %74 = icmp sgt i32 %71, 0
  %..i137 = zext i1 %74 to i32
  br label %sign.exit139

sign.exit139:                                     ; preds = %73, %sign.exit142
  %.0.i138 = phi i32 [ -1, %sign.exit142 ], [ %..i137, %73 ]
  %75 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i138) #4
  %76 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %77 = icmp slt i32 %76, 0
  br i1 %77, label %sign.exit136, label %78

; <label>:78                                      ; preds = %sign.exit139
  %79 = icmp sgt i32 %76, 0
  %..i134 = zext i1 %79 to i32
  br label %sign.exit136

sign.exit136:                                     ; preds = %78, %sign.exit139
  %.0.i135 = phi i32 [ -1, %sign.exit139 ], [ %..i134, %78 ]
  %80 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i135) #4
  %81 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %82 = icmp slt i32 %81, 0
  br i1 %82, label %sign.exit133, label %83

; <label>:83                                      ; preds = %sign.exit136
  %84 = icmp sgt i32 %81, 0
  %..i131 = zext i1 %84 to i32
  br label %sign.exit133

sign.exit133:                                     ; preds = %83, %sign.exit136
  %.0.i132 = phi i32 [ -1, %sign.exit136 ], [ %..i131, %83 ]
  %85 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i132) #4
  %86 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0)) #5
  %87 = icmp slt i32 %86, 0
  br i1 %87, label %sign.exit130, label %88

; <label>:88                                      ; preds = %sign.exit133
  %89 = icmp sgt i32 %86, 0
  %..i128 = zext i1 %89 to i32
  br label %sign.exit130

sign.exit130:                                     ; preds = %88, %sign.exit133
  %.0.i129 = phi i32 [ -1, %sign.exit133 ], [ %..i128, %88 ]
  %90 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i129) #4
  %91 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %92 = icmp slt i32 %91, 0
  br i1 %92, label %sign.exit127, label %93

; <label>:93                                      ; preds = %sign.exit130
  %94 = icmp sgt i32 %91, 0
  %..i125 = zext i1 %94 to i32
  br label %sign.exit127

sign.exit127:                                     ; preds = %93, %sign.exit130
  %.0.i126 = phi i32 [ -1, %sign.exit130 ], [ %..i125, %93 ]
  %95 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i126) #4
  %96 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %97 = icmp slt i32 %96, 0
  br i1 %97, label %sign.exit124, label %98

; <label>:98                                      ; preds = %sign.exit127
  %99 = icmp sgt i32 %96, 0
  %..i122 = zext i1 %99 to i32
  br label %sign.exit124

sign.exit124:                                     ; preds = %98, %sign.exit127
  %.0.i123 = phi i32 [ -1, %sign.exit127 ], [ %..i122, %98 ]
  %100 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i123) #4
  %101 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %102 = icmp slt i32 %101, 0
  br i1 %102, label %sign.exit121, label %103

; <label>:103                                     ; preds = %sign.exit124
  %104 = icmp sgt i32 %101, 0
  %..i119 = zext i1 %104 to i32
  br label %sign.exit121

sign.exit121:                                     ; preds = %103, %sign.exit124
  %.0.i120 = phi i32 [ -1, %sign.exit124 ], [ %..i119, %103 ]
  %105 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i120) #4
  %106 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %107 = icmp slt i32 %106, 0
  br i1 %107, label %sign.exit118, label %108

; <label>:108                                     ; preds = %sign.exit121
  %109 = icmp sgt i32 %106, 0
  %..i116 = zext i1 %109 to i32
  br label %sign.exit118

sign.exit118:                                     ; preds = %108, %sign.exit121
  %.0.i117 = phi i32 [ -1, %sign.exit121 ], [ %..i116, %108 ]
  %110 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i117) #4
  %111 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %112 = icmp slt i32 %111, 0
  br i1 %112, label %sign.exit115, label %113

; <label>:113                                     ; preds = %sign.exit118
  %114 = icmp sgt i32 %111, 0
  %..i113 = zext i1 %114 to i32
  br label %sign.exit115

sign.exit115:                                     ; preds = %113, %sign.exit118
  %.0.i114 = phi i32 [ -1, %sign.exit118 ], [ %..i113, %113 ]
  %115 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i114) #4
  %116 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %117 = icmp slt i32 %116, 0
  br i1 %117, label %sign.exit112, label %118

; <label>:118                                     ; preds = %sign.exit115
  %119 = icmp sgt i32 %116, 0
  %..i110 = zext i1 %119 to i32
  br label %sign.exit112

sign.exit112:                                     ; preds = %118, %sign.exit115
  %.0.i111 = phi i32 [ -1, %sign.exit115 ], [ %..i110, %118 ]
  %120 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i111) #4
  %121 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %122 = icmp slt i32 %121, 0
  br i1 %122, label %sign.exit109, label %123

; <label>:123                                     ; preds = %sign.exit112
  %124 = icmp sgt i32 %121, 0
  %..i107 = zext i1 %124 to i32
  br label %sign.exit109

sign.exit109:                                     ; preds = %123, %sign.exit112
  %.0.i108 = phi i32 [ -1, %sign.exit112 ], [ %..i107, %123 ]
  %125 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i108) #4
  %126 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %127 = icmp slt i32 %126, 0
  br i1 %127, label %sign.exit106, label %128

; <label>:128                                     ; preds = %sign.exit109
  %129 = icmp sgt i32 %126, 0
  %..i104 = zext i1 %129 to i32
  br label %sign.exit106

sign.exit106:                                     ; preds = %128, %sign.exit109
  %.0.i105 = phi i32 [ -1, %sign.exit109 ], [ %..i104, %128 ]
  %130 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i105) #4
  %131 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %132 = icmp slt i32 %131, 0
  br i1 %132, label %sign.exit103, label %133

; <label>:133                                     ; preds = %sign.exit106
  %134 = icmp sgt i32 %131, 0
  %..i101 = zext i1 %134 to i32
  br label %sign.exit103

sign.exit103:                                     ; preds = %133, %sign.exit106
  %.0.i102 = phi i32 [ -1, %sign.exit106 ], [ %..i101, %133 ]
  %135 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i102) #4
  %136 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %137 = icmp slt i32 %136, 0
  br i1 %137, label %sign.exit100, label %138

; <label>:138                                     ; preds = %sign.exit103
  %139 = icmp sgt i32 %136, 0
  %..i98 = zext i1 %139 to i32
  br label %sign.exit100

sign.exit100:                                     ; preds = %138, %sign.exit103
  %.0.i99 = phi i32 [ -1, %sign.exit103 ], [ %..i98, %138 ]
  %140 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i99) #4
  %141 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %142 = icmp slt i32 %141, 0
  br i1 %142, label %sign.exit97, label %143

; <label>:143                                     ; preds = %sign.exit100
  %144 = icmp sgt i32 %141, 0
  %..i95 = zext i1 %144 to i32
  br label %sign.exit97

sign.exit97:                                      ; preds = %143, %sign.exit100
  %.0.i96 = phi i32 [ -1, %sign.exit100 ], [ %..i95, %143 ]
  %145 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i96) #4
  %146 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0)) #5
  %147 = icmp slt i32 %146, 0
  br i1 %147, label %sign.exit94, label %148

; <label>:148                                     ; preds = %sign.exit97
  %149 = icmp sgt i32 %146, 0
  %..i92 = zext i1 %149 to i32
  br label %sign.exit94

sign.exit94:                                      ; preds = %148, %sign.exit97
  %.0.i93 = phi i32 [ -1, %sign.exit97 ], [ %..i92, %148 ]
  %150 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i93) #4
  %151 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %152 = icmp slt i32 %151, 0
  br i1 %152, label %sign.exit91, label %153

; <label>:153                                     ; preds = %sign.exit94
  %154 = icmp sgt i32 %151, 0
  %..i89 = zext i1 %154 to i32
  br label %sign.exit91

sign.exit91:                                      ; preds = %153, %sign.exit94
  %.0.i90 = phi i32 [ -1, %sign.exit94 ], [ %..i89, %153 ]
  %155 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i90) #4
  %156 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %157 = icmp slt i32 %156, 0
  br i1 %157, label %sign.exit88, label %158

; <label>:158                                     ; preds = %sign.exit91
  %159 = icmp sgt i32 %156, 0
  %..i86 = zext i1 %159 to i32
  br label %sign.exit88

sign.exit88:                                      ; preds = %158, %sign.exit91
  %.0.i87 = phi i32 [ -1, %sign.exit91 ], [ %..i86, %158 ]
  %160 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i87) #4
  %161 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %162 = icmp slt i32 %161, 0
  br i1 %162, label %sign.exit85, label %163

; <label>:163                                     ; preds = %sign.exit88
  %164 = icmp sgt i32 %161, 0
  %..i83 = zext i1 %164 to i32
  br label %sign.exit85

sign.exit85:                                      ; preds = %163, %sign.exit88
  %.0.i84 = phi i32 [ -1, %sign.exit88 ], [ %..i83, %163 ]
  %165 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i84) #4
  %166 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %167 = icmp slt i32 %166, 0
  br i1 %167, label %sign.exit82, label %168

; <label>:168                                     ; preds = %sign.exit85
  %169 = icmp sgt i32 %166, 0
  %..i80 = zext i1 %169 to i32
  br label %sign.exit82

sign.exit82:                                      ; preds = %168, %sign.exit85
  %.0.i81 = phi i32 [ -1, %sign.exit85 ], [ %..i80, %168 ]
  %170 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i81) #4
  %171 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %172 = icmp slt i32 %171, 0
  br i1 %172, label %sign.exit79, label %173

; <label>:173                                     ; preds = %sign.exit82
  %174 = icmp sgt i32 %171, 0
  %..i77 = zext i1 %174 to i32
  br label %sign.exit79

sign.exit79:                                      ; preds = %173, %sign.exit82
  %.0.i78 = phi i32 [ -1, %sign.exit82 ], [ %..i77, %173 ]
  %175 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i78) #4
  %176 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %177 = icmp slt i32 %176, 0
  br i1 %177, label %sign.exit76, label %178

; <label>:178                                     ; preds = %sign.exit79
  %179 = icmp sgt i32 %176, 0
  %..i74 = zext i1 %179 to i32
  br label %sign.exit76

sign.exit76:                                      ; preds = %178, %sign.exit79
  %.0.i75 = phi i32 [ -1, %sign.exit79 ], [ %..i74, %178 ]
  %180 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i75) #4
  %181 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %182 = icmp slt i32 %181, 0
  br i1 %182, label %sign.exit73, label %183

; <label>:183                                     ; preds = %sign.exit76
  %184 = icmp sgt i32 %181, 0
  %..i71 = zext i1 %184 to i32
  br label %sign.exit73

sign.exit73:                                      ; preds = %183, %sign.exit76
  %.0.i72 = phi i32 [ -1, %sign.exit76 ], [ %..i71, %183 ]
  %185 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i72) #4
  %186 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %187 = icmp slt i32 %186, 0
  br i1 %187, label %sign.exit70, label %188

; <label>:188                                     ; preds = %sign.exit73
  %189 = icmp sgt i32 %186, 0
  %..i68 = zext i1 %189 to i32
  br label %sign.exit70

sign.exit70:                                      ; preds = %188, %sign.exit73
  %.0.i69 = phi i32 [ -1, %sign.exit73 ], [ %..i68, %188 ]
  %190 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i69) #4
  %191 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %192 = icmp slt i32 %191, 0
  br i1 %192, label %sign.exit67, label %193

; <label>:193                                     ; preds = %sign.exit70
  %194 = icmp sgt i32 %191, 0
  %..i65 = zext i1 %194 to i32
  br label %sign.exit67

sign.exit67:                                      ; preds = %193, %sign.exit70
  %.0.i66 = phi i32 [ -1, %sign.exit70 ], [ %..i65, %193 ]
  %195 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i66) #4
  %196 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %197 = icmp slt i32 %196, 0
  br i1 %197, label %sign.exit64, label %198

; <label>:198                                     ; preds = %sign.exit67
  %199 = icmp sgt i32 %196, 0
  %..i62 = zext i1 %199 to i32
  br label %sign.exit64

sign.exit64:                                      ; preds = %198, %sign.exit67
  %.0.i63 = phi i32 [ -1, %sign.exit67 ], [ %..i62, %198 ]
  %200 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i63) #4
  %201 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %202 = icmp slt i32 %201, 0
  br i1 %202, label %sign.exit61, label %203

; <label>:203                                     ; preds = %sign.exit64
  %204 = icmp sgt i32 %201, 0
  %..i59 = zext i1 %204 to i32
  br label %sign.exit61

sign.exit61:                                      ; preds = %203, %sign.exit64
  %.0.i60 = phi i32 [ -1, %sign.exit64 ], [ %..i59, %203 ]
  %205 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i60) #4
  %206 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0)) #5
  %207 = icmp slt i32 %206, 0
  br i1 %207, label %sign.exit58, label %208

; <label>:208                                     ; preds = %sign.exit61
  %209 = icmp sgt i32 %206, 0
  %..i56 = zext i1 %209 to i32
  br label %sign.exit58

sign.exit58:                                      ; preds = %208, %sign.exit61
  %.0.i57 = phi i32 [ -1, %sign.exit61 ], [ %..i56, %208 ]
  %210 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i57) #4
  %211 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %212 = icmp slt i32 %211, 0
  br i1 %212, label %sign.exit55, label %213

; <label>:213                                     ; preds = %sign.exit58
  %214 = icmp sgt i32 %211, 0
  %..i53 = zext i1 %214 to i32
  br label %sign.exit55

sign.exit55:                                      ; preds = %213, %sign.exit58
  %.0.i54 = phi i32 [ -1, %sign.exit58 ], [ %..i53, %213 ]
  %215 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i54) #4
  %216 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %217 = icmp slt i32 %216, 0
  br i1 %217, label %sign.exit52, label %218

; <label>:218                                     ; preds = %sign.exit55
  %219 = icmp sgt i32 %216, 0
  %..i50 = zext i1 %219 to i32
  br label %sign.exit52

sign.exit52:                                      ; preds = %218, %sign.exit55
  %.0.i51 = phi i32 [ -1, %sign.exit55 ], [ %..i50, %218 ]
  %220 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i51) #4
  %221 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %222 = icmp slt i32 %221, 0
  br i1 %222, label %sign.exit49, label %223

; <label>:223                                     ; preds = %sign.exit52
  %224 = icmp sgt i32 %221, 0
  %..i47 = zext i1 %224 to i32
  br label %sign.exit49

sign.exit49:                                      ; preds = %223, %sign.exit52
  %.0.i48 = phi i32 [ -1, %sign.exit52 ], [ %..i47, %223 ]
  %225 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i48) #4
  %226 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %227 = icmp slt i32 %226, 0
  br i1 %227, label %sign.exit46, label %228

; <label>:228                                     ; preds = %sign.exit49
  %229 = icmp sgt i32 %226, 0
  %..i44 = zext i1 %229 to i32
  br label %sign.exit46

sign.exit46:                                      ; preds = %228, %sign.exit49
  %.0.i45 = phi i32 [ -1, %sign.exit49 ], [ %..i44, %228 ]
  %230 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i45) #4
  %231 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %232 = icmp slt i32 %231, 0
  br i1 %232, label %sign.exit43, label %233

; <label>:233                                     ; preds = %sign.exit46
  %234 = icmp sgt i32 %231, 0
  %..i41 = zext i1 %234 to i32
  br label %sign.exit43

sign.exit43:                                      ; preds = %233, %sign.exit46
  %.0.i42 = phi i32 [ -1, %sign.exit46 ], [ %..i41, %233 ]
  %235 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i42) #4
  %236 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %237 = icmp slt i32 %236, 0
  br i1 %237, label %sign.exit40, label %238

; <label>:238                                     ; preds = %sign.exit43
  %239 = icmp sgt i32 %236, 0
  %..i38 = zext i1 %239 to i32
  br label %sign.exit40

sign.exit40:                                      ; preds = %238, %sign.exit43
  %.0.i39 = phi i32 [ -1, %sign.exit43 ], [ %..i38, %238 ]
  %240 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i39) #4
  %241 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %242 = icmp slt i32 %241, 0
  br i1 %242, label %sign.exit37, label %243

; <label>:243                                     ; preds = %sign.exit40
  %244 = icmp sgt i32 %241, 0
  %..i35 = zext i1 %244 to i32
  br label %sign.exit37

sign.exit37:                                      ; preds = %243, %sign.exit40
  %.0.i36 = phi i32 [ -1, %sign.exit40 ], [ %..i35, %243 ]
  %245 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i36) #4
  %246 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %247 = icmp slt i32 %246, 0
  br i1 %247, label %sign.exit34, label %248

; <label>:248                                     ; preds = %sign.exit37
  %249 = icmp sgt i32 %246, 0
  %..i32 = zext i1 %249 to i32
  br label %sign.exit34

sign.exit34:                                      ; preds = %248, %sign.exit37
  %.0.i33 = phi i32 [ -1, %sign.exit37 ], [ %..i32, %248 ]
  %250 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i33) #4
  %251 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 3) #5
  %252 = icmp slt i32 %251, 0
  br i1 %252, label %sign.exit31, label %253

; <label>:253                                     ; preds = %sign.exit34
  %254 = icmp sgt i32 %251, 0
  %..i29 = zext i1 %254 to i32
  br label %sign.exit31

sign.exit31:                                      ; preds = %253, %sign.exit34
  %.0.i30 = phi i32 [ -1, %sign.exit34 ], [ %..i29, %253 ]
  %255 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i30) #4
  %256 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 3) #5
  %257 = icmp slt i32 %256, 0
  br i1 %257, label %sign.exit28, label %258

; <label>:258                                     ; preds = %sign.exit31
  %259 = icmp sgt i32 %256, 0
  %..i26 = zext i1 %259 to i32
  br label %sign.exit28

sign.exit28:                                      ; preds = %258, %sign.exit31
  %.0.i27 = phi i32 [ -1, %sign.exit31 ], [ %..i26, %258 ]
  %260 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i27) #4
  %261 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %262 = icmp slt i32 %261, 0
  br i1 %262, label %sign.exit25, label %263

; <label>:263                                     ; preds = %sign.exit28
  %264 = icmp sgt i32 %261, 0
  %..i23 = zext i1 %264 to i32
  br label %sign.exit25

sign.exit25:                                      ; preds = %263, %sign.exit28
  %.0.i24 = phi i32 [ -1, %sign.exit28 ], [ %..i23, %263 ]
  %265 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i24) #4
  %266 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i64 3) #5
  %267 = icmp slt i32 %266, 0
  br i1 %267, label %sign.exit22, label %268

; <label>:268                                     ; preds = %sign.exit25
  %269 = icmp sgt i32 %266, 0
  %..i20 = zext i1 %269 to i32
  br label %sign.exit22

sign.exit22:                                      ; preds = %268, %sign.exit25
  %.0.i21 = phi i32 [ -1, %sign.exit25 ], [ %..i20, %268 ]
  %270 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i21) #4
  %271 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %272 = icmp slt i32 %271, 0
  br i1 %272, label %sign.exit19, label %273

; <label>:273                                     ; preds = %sign.exit22
  %274 = icmp sgt i32 %271, 0
  %..i17 = zext i1 %274 to i32
  br label %sign.exit19

sign.exit19:                                      ; preds = %273, %sign.exit22
  %.0.i18 = phi i32 [ -1, %sign.exit22 ], [ %..i17, %273 ]
  %275 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i18) #4
  %276 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %277 = icmp slt i32 %276, 0
  br i1 %277, label %sign.exit16, label %278

; <label>:278                                     ; preds = %sign.exit19
  %279 = icmp sgt i32 %276, 0
  %..i14 = zext i1 %279 to i32
  br label %sign.exit16

sign.exit16:                                      ; preds = %278, %sign.exit19
  %.0.i15 = phi i32 [ -1, %sign.exit19 ], [ %..i14, %278 ]
  %280 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i15) #4
  %281 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %282 = icmp slt i32 %281, 0
  br i1 %282, label %sign.exit13, label %283

; <label>:283                                     ; preds = %sign.exit16
  %284 = icmp sgt i32 %281, 0
  %..i11 = zext i1 %284 to i32
  br label %sign.exit13

sign.exit13:                                      ; preds = %283, %sign.exit16
  %.0.i12 = phi i32 [ -1, %sign.exit16 ], [ %..i11, %283 ]
  %285 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i12) #4
  %286 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %287 = icmp slt i32 %286, 0
  br i1 %287, label %sign.exit10, label %288

; <label>:288                                     ; preds = %sign.exit13
  %289 = icmp sgt i32 %286, 0
  %..i8 = zext i1 %289 to i32
  br label %sign.exit10

sign.exit10:                                      ; preds = %288, %sign.exit13
  %.0.i9 = phi i32 [ -1, %sign.exit13 ], [ %..i8, %288 ]
  %290 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i9) #4
  %291 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i64 3) #5
  %292 = icmp slt i32 %291, 0
  br i1 %292, label %sign.exit7, label %293

; <label>:293                                     ; preds = %sign.exit10
  %294 = icmp sgt i32 %291, 0
  %..i5 = zext i1 %294 to i32
  br label %sign.exit7

sign.exit7:                                       ; preds = %293, %sign.exit10
  %.0.i6 = phi i32 [ -1, %sign.exit10 ], [ %..i5, %293 ]
  %295 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i6) #4
  %296 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i64 3) #5
  %297 = icmp slt i32 %296, 0
  br i1 %297, label %sign.exit4, label %298

; <label>:298                                     ; preds = %sign.exit7
  %299 = icmp sgt i32 %296, 0
  %..i2 = zext i1 %299 to i32
  br label %sign.exit4

sign.exit4:                                       ; preds = %298, %sign.exit7
  %.0.i3 = phi i32 [ -1, %sign.exit7 ], [ %..i2, %298 ]
  %300 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i3) #4
  %puts1 = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str12, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind readonly
declare i32 @strcasecmp(i8* nocapture, i8* nocapture) #3

; Function Attrs: nounwind readonly
declare i32 @strncasecmp(i8* nocapture, i8* nocapture, i64) #3

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
