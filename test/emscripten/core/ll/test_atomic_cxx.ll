; ModuleID = 'test_atomic_cxx.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"struct.std::atomic_flag" = type { %struct.__atomic_flag_base }
%struct.__atomic_flag_base = type { i8 }
%"struct.std::atomic.4" = type { %"struct.std::__atomic_base.5" }
%"struct.std::__atomic_base.5" = type { i8 }
%"struct.std::atomic.2" = type { %"struct.std::__atomic_base.3" }
%"struct.std::__atomic_base.3" = type { i16 }
%"struct.std::atomic.0" = type { %"struct.std::__atomic_base.1" }
%"struct.std::__atomic_base.1" = type { i32 }
%"struct.std::atomic" = type { %"struct.std::__atomic_base" }
%"struct.std::__atomic_base" = type { i64 }

@.str4 = private unnamed_addr constant [17 x i8] c"atomic_flag: %s\0A\00", align 1
@.str5 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str6 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.str8 = private unnamed_addr constant [32 x i8] c"atomic<int>.is_lock_free(): %s\0A\00", align 1
@.str9 = private unnamed_addr constant [25 x i8] c"atomic<int> value: %lld\0A\00", align 1
@.str10 = private unnamed_addr constant [23 x i8] c"store/load %lld: %lld\0A\00", align 1
@.str11 = private unnamed_addr constant [34 x i8] c"exchange %lld: old=%lld new=%lld\0A\00", align 1
@.str12 = private unnamed_addr constant [42 x i8] c"compare_exchange_weak %lld: success = %s\0A\00", align 1
@.str13 = private unnamed_addr constant [44 x i8] c"compare_exchange_strong %lld: success = %s\0A\00", align 1
@.str14 = private unnamed_addr constant [35 x i8] c"fetch_add %lld: old=%lld new=%lld\0A\00", align 1
@.str15 = private unnamed_addr constant [35 x i8] c"fetch_sub %lld: old=%lld new=%lld\0A\00", align 1
@.str16 = private unnamed_addr constant [36 x i8] c"fetch_and %lld: old=%llx, new=%llx\0A\00", align 1
@.str17 = private unnamed_addr constant [35 x i8] c"fetch_or %lld: old=%llx, new=%llx\0A\00", align 1
@.str18 = private unnamed_addr constant [36 x i8] c"fetch_xor %lld: old=%llx, new=%llx\0A\00", align 1
@.str19 = private unnamed_addr constant [18 x i8] c"operator++: %lld\0A\00", align 1
@.str20 = private unnamed_addr constant [18 x i8] c"operator--: %lld\0A\00", align 1
@.str21 = private unnamed_addr constant [18 x i8] c"operator+=: %lld\0A\00", align 1
@.str22 = private unnamed_addr constant [18 x i8] c"operator-=: %lld\0A\00", align 1
@.str23 = private unnamed_addr constant [18 x i8] c"operator|=: %llx\0A\00", align 1
@.str24 = private unnamed_addr constant [18 x i8] c"operator&=: %llx\0A\00", align 1
@.str25 = private unnamed_addr constant [18 x i8] c"operator^=: %llx\0A\00", align 1
@_ZZ4testIchEvT_S0_S0_E11memoryOrder = private unnamed_addr constant [6 x i32] [i32 0, i32 1, i32 2, i32 3, i32 4, i32 5], align 16
@str = private unnamed_addr constant [9 x i8] c"\0A8 bits\0A\00"
@str26 = private unnamed_addr constant [10 x i8] c"\0A16 bits\0A\00"
@str27 = private unnamed_addr constant [10 x i8] c"\0A32 bits\0A\00"
@str28 = private unnamed_addr constant [10 x i8] c"\0A64 bits\0A\00"
@str29 = private unnamed_addr constant [6 x i8] c"done.\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %af = alloca %"struct.std::atomic_flag", align 1
  %puts = call i32 @puts(i8* getelementptr inbounds ([9 x i8]* @str, i64 0, i64 0))
  call void @_Z4testIchEvT_S0_S0_(i8 signext -1, i8 signext -16, i8 signext 15)
  %puts1 = call i32 @puts(i8* getelementptr inbounds ([10 x i8]* @str26, i64 0, i64 0))
  call void @_Z4testIstEvT_S0_S0_(i16 signext -1, i16 signext -3856, i16 signext 3855)
  %puts2 = call i32 @puts(i8* getelementptr inbounds ([10 x i8]* @str27, i64 0, i64 0))
  call void @_Z4testIijEvT_S0_S0_(i32 -1, i32 -252645136, i32 252645135)
  %puts3 = call i32 @puts(i8* getelementptr inbounds ([10 x i8]* @str28, i64 0, i64 0))
  call void @_Z4testIxyEvT_S0_S0_(i64 -1, i64 -1085102592571150096, i64 1085102592571150095)
  %1 = getelementptr inbounds %"struct.std::atomic_flag"* %af, i64 0, i32 0, i32 0
  store atomic i8 0, i8* %1 seq_cst, align 1
  %2 = atomicrmw xchg i8* %1, i8 1 seq_cst
  %3 = icmp ne i8 %2, 0
  %4 = select i1 %3, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str4, i64 0, i64 0), i8* %4)
  %puts4 = call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str29, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define linkonce_odr void @_Z4testIchEvT_S0_S0_(i8 signext %mask0, i8 signext %mask1, i8 signext %mask2) #0 {
_ZNSt13__atomic_baseIcE8exchangeEcSt12memory_order.exit.5:
  %atomicDog = alloca %"struct.std::atomic.4", align 1
  %0 = getelementptr inbounds %"struct.std::atomic.4"* %atomicDog, i64 0, i32 0, i32 0
  store i8 5, i8* %0, align 1
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0))
  %2 = load atomic i8* %0 seq_cst, align 1
  %3 = sext i8 %2 to i64
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str9, i64 0, i64 0), i64 %3)
  store atomic i8 0, i8* %0 monotonic, align 1
  %5 = load atomic i8* %0 monotonic, align 1
  %phitmp = sext i8 %5 to i64
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 0, i64 %phitmp)
  store atomic i8 1, i8* %0 monotonic, align 1
  %7 = load atomic i8* %0 acquire, align 1
  %phitmp51 = sext i8 %7 to i64
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 1, i64 %phitmp51)
  store atomic i8 2, i8* %0 monotonic, align 1
  %9 = load atomic i8* %0 acquire, align 1
  %phitmp52 = sext i8 %9 to i64
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 2, i64 %phitmp52)
  store atomic i8 3, i8* %0 release, align 1
  %11 = load atomic i8* %0 monotonic, align 1
  %phitmp53 = sext i8 %11 to i64
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 3, i64 %phitmp53)
  store atomic i8 4, i8* %0 monotonic, align 1
  %13 = load atomic i8* %0 monotonic, align 1
  %phitmp54 = sext i8 %13 to i64
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 4, i64 %phitmp54)
  store atomic i8 5, i8* %0 seq_cst, align 1
  %15 = load atomic i8* %0 seq_cst, align 1
  %phitmp55 = sext i8 %15 to i64
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 5, i64 %phitmp55)
  %17 = atomicrmw xchg i8* %0, i8 0 monotonic
  %phitmp56 = sext i8 %17 to i64
  %18 = load atomic i8* %0 seq_cst, align 1
  %19 = sext i8 %18 to i64
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 0, i64 %phitmp56, i64 %19)
  %21 = atomicrmw xchg i8* %0, i8 1 acquire
  %phitmp57 = sext i8 %21 to i64
  %22 = load atomic i8* %0 seq_cst, align 1
  %23 = sext i8 %22 to i64
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 1, i64 %phitmp57, i64 %23)
  %25 = atomicrmw xchg i8* %0, i8 2 acquire
  %phitmp58 = sext i8 %25 to i64
  %26 = load atomic i8* %0 seq_cst, align 1
  %27 = sext i8 %26 to i64
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 2, i64 %phitmp58, i64 %27)
  %29 = atomicrmw xchg i8* %0, i8 3 release
  %phitmp59 = sext i8 %29 to i64
  %30 = load atomic i8* %0 seq_cst, align 1
  %31 = sext i8 %30 to i64
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 3, i64 %phitmp59, i64 %31)
  %33 = atomicrmw xchg i8* %0, i8 4 acq_rel
  %phitmp60 = sext i8 %33 to i64
  %34 = load atomic i8* %0 seq_cst, align 1
  %35 = sext i8 %34 to i64
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 4, i64 %phitmp60, i64 %35)
  %37 = atomicrmw xchg i8* %0, i8 5 seq_cst
  %phitmp61 = sext i8 %37 to i64
  %38 = load atomic i8* %0 seq_cst, align 1
  %39 = sext i8 %38 to i64
  %40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 5, i64 %phitmp61, i64 %39)
  br label %41

; <label>:41                                      ; preds = %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIcE8exchangeEcSt12memory_order.exit.5
  %storemerge34 = phi i8 [ 0, %_ZNSt13__atomic_baseIcE8exchangeEcSt12memory_order.exit.5 ], [ %76, %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit ]
  %42 = add i8 %storemerge34, 1
  %43 = sext i8 %storemerge34 to i64
  %44 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %43
  %45 = load i32* %44, align 4, !tbaa !1
  switch i32 %45, label %46 [
    i32 1, label %51
    i32 2, label %51
    i32 3, label %56
    i32 4, label %61
    i32 5, label %66
  ]

; <label>:46                                      ; preds = %41
  %47 = cmpxchg i8* %0, i8 %storemerge34, i8 %42 monotonic monotonic
  %48 = extractvalue { i8, i1 } %47, 0
  %49 = icmp eq i8 %48, %storemerge34
  %50 = zext i1 %49 to i8
  br label %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit

; <label>:51                                      ; preds = %41, %41
  %52 = cmpxchg i8* %0, i8 %storemerge34, i8 %42 acquire acquire
  %53 = extractvalue { i8, i1 } %52, 0
  %54 = icmp eq i8 %53, %storemerge34
  %55 = zext i1 %54 to i8
  br label %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit

; <label>:56                                      ; preds = %41
  %57 = cmpxchg i8* %0, i8 %storemerge34, i8 %42 release monotonic
  %58 = extractvalue { i8, i1 } %57, 0
  %59 = icmp eq i8 %58, %storemerge34
  %60 = zext i1 %59 to i8
  br label %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit

; <label>:61                                      ; preds = %41
  %62 = cmpxchg i8* %0, i8 %storemerge34, i8 %42 acq_rel acquire
  %63 = extractvalue { i8, i1 } %62, 0
  %64 = icmp eq i8 %63, %storemerge34
  %65 = zext i1 %64 to i8
  br label %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit

; <label>:66                                      ; preds = %41
  %67 = cmpxchg i8* %0, i8 %storemerge34, i8 %42 seq_cst seq_cst
  %68 = extractvalue { i8, i1 } %67, 0
  %69 = icmp eq i8 %68, %storemerge34
  %70 = zext i1 %69 to i8
  br label %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit: ; preds = %66, %61, %56, %51, %46
  %71 = phi i8 [ %48, %46 ], [ %68, %66 ], [ %63, %61 ], [ %58, %56 ], [ %53, %51 ]
  %.0.i21 = phi i8 [ %50, %46 ], [ %70, %66 ], [ %65, %61 ], [ %60, %56 ], [ %55, %51 ]
  %72 = icmp ne i8 %.0.i21, 0
  %73 = sext i8 %71 to i64
  %74 = select i1 %72, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %75 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str12, i64 0, i64 0), i64 %73, i8* %74)
  %76 = add i8 %71, 1
  %77 = icmp slt i8 %76, 6
  br i1 %77, label %41, label %.preheader31

.preheader31:                                     ; preds = %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit
  %storemerge1532 = phi i8 [ %112, %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit ], [ 0, %_ZNSt13__atomic_baseIcE21compare_exchange_weakERccSt12memory_orderS2_.exit ]
  %78 = add i8 %storemerge1532, 1
  %79 = sext i8 %storemerge1532 to i64
  %80 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %79
  %81 = load i32* %80, align 4, !tbaa !1
  switch i32 %81, label %82 [
    i32 1, label %87
    i32 2, label %87
    i32 3, label %92
    i32 4, label %97
    i32 5, label %102
  ]

; <label>:82                                      ; preds = %.preheader31
  %83 = cmpxchg i8* %0, i8 %storemerge1532, i8 %78 monotonic monotonic
  %84 = extractvalue { i8, i1 } %83, 0
  %85 = icmp eq i8 %84, %storemerge1532
  %86 = zext i1 %85 to i8
  br label %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit

; <label>:87                                      ; preds = %.preheader31, %.preheader31
  %88 = cmpxchg i8* %0, i8 %storemerge1532, i8 %78 acquire acquire
  %89 = extractvalue { i8, i1 } %88, 0
  %90 = icmp eq i8 %89, %storemerge1532
  %91 = zext i1 %90 to i8
  br label %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit

; <label>:92                                      ; preds = %.preheader31
  %93 = cmpxchg i8* %0, i8 %storemerge1532, i8 %78 release monotonic
  %94 = extractvalue { i8, i1 } %93, 0
  %95 = icmp eq i8 %94, %storemerge1532
  %96 = zext i1 %95 to i8
  br label %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit

; <label>:97                                      ; preds = %.preheader31
  %98 = cmpxchg i8* %0, i8 %storemerge1532, i8 %78 acq_rel acquire
  %99 = extractvalue { i8, i1 } %98, 0
  %100 = icmp eq i8 %99, %storemerge1532
  %101 = zext i1 %100 to i8
  br label %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit

; <label>:102                                     ; preds = %.preheader31
  %103 = cmpxchg i8* %0, i8 %storemerge1532, i8 %78 seq_cst seq_cst
  %104 = extractvalue { i8, i1 } %103, 0
  %105 = icmp eq i8 %104, %storemerge1532
  %106 = zext i1 %105 to i8
  br label %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit: ; preds = %102, %97, %92, %87, %82
  %107 = phi i8 [ %84, %82 ], [ %104, %102 ], [ %99, %97 ], [ %94, %92 ], [ %89, %87 ]
  %.0.i20 = phi i8 [ %86, %82 ], [ %106, %102 ], [ %101, %97 ], [ %96, %92 ], [ %91, %87 ]
  %108 = icmp ne i8 %.0.i20, 0
  %109 = sext i8 %107 to i64
  %110 = select i1 %108, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %111 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str13, i64 0, i64 0), i64 %109, i8* %110)
  %112 = add i8 %107, 1
  %113 = icmp slt i8 %112, 6
  br i1 %113, label %.preheader31, label %_ZNSt13__atomic_baseIcE9fetch_subEcSt12memory_order.exit.5

; <label>:114                                     ; preds = %_ZNSt13__atomic_baseIcE9fetch_subEcSt12memory_order.exit.5, %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit
  %indvars.iv = phi i64 [ 0, %_ZNSt13__atomic_baseIcE9fetch_subEcSt12memory_order.exit.5 ], [ %indvars.iv.next, %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit ]
  %115 = trunc i64 %indvars.iv to i32
  %116 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %indvars.iv
  %117 = load i32* %116, align 4, !tbaa !1
  switch i32 %117, label %118 [
    i32 3, label %119
    i32 5, label %120
  ]

; <label>:118                                     ; preds = %114
  store atomic i8 %mask0, i8* %0 monotonic, align 1
  br label %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit

; <label>:119                                     ; preds = %114
  store atomic i8 %mask0, i8* %0 release, align 1
  br label %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit

; <label>:120                                     ; preds = %114
  store atomic i8 %mask0, i8* %0 seq_cst, align 1
  br label %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit

_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit: ; preds = %120, %119, %118
  %121 = shl i32 1, %115
  %122 = trunc i32 %121 to i8
  %123 = load i32* %116, align 4, !tbaa !1
  switch i32 %123, label %124 [
    i32 1, label %126
    i32 2, label %126
    i32 3, label %128
    i32 4, label %130
    i32 5, label %132
  ]

; <label>:124                                     ; preds = %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit
  %125 = atomicrmw and i8* %0, i8 %122 monotonic
  br label %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit

; <label>:126                                     ; preds = %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit, %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit
  %127 = atomicrmw and i8* %0, i8 %122 acquire
  br label %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit

; <label>:128                                     ; preds = %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit
  %129 = atomicrmw and i8* %0, i8 %122 release
  br label %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit

; <label>:130                                     ; preds = %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit
  %131 = atomicrmw and i8* %0, i8 %122 acq_rel
  br label %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit

; <label>:132                                     ; preds = %_ZNSt13__atomic_baseIcE5storeEcSt12memory_order.exit
  %133 = atomicrmw and i8* %0, i8 %122 seq_cst
  br label %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit

_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit: ; preds = %132, %130, %128, %126, %124
  %.0.i17 = phi i8 [ %125, %124 ], [ %133, %132 ], [ %131, %130 ], [ %129, %128 ], [ %127, %126 ]
  %134 = zext i8 %.0.i17 to i64
  %135 = load atomic i8* %0 seq_cst, align 1
  %136 = zext i8 %135 to i64
  %137 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str16, i64 0, i64 0), i64 %indvars.iv, i64 %134, i64 %136)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 6
  br i1 %exitcond, label %_ZNSt13__atomic_baseIcE9fetch_xorEcSt12memory_order.exit.5, label %114

_ZNSt13__atomic_baseIcE9fetch_xorEcSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIcE9fetch_andEcSt12memory_order.exit
  store atomic i8 0, i8* %0 seq_cst, align 1
  %138 = atomicrmw or i8* %0, i8 1 monotonic
  %phitmp74 = zext i8 %138 to i64
  %139 = load atomic i8* %0 seq_cst, align 1
  %140 = zext i8 %139 to i64
  %141 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 0, i64 %phitmp74, i64 %140)
  %142 = atomicrmw or i8* %0, i8 2 acquire
  %phitmp75 = zext i8 %142 to i64
  %143 = load atomic i8* %0 seq_cst, align 1
  %144 = zext i8 %143 to i64
  %145 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 1, i64 %phitmp75, i64 %144)
  %146 = atomicrmw or i8* %0, i8 4 acquire
  %phitmp76 = zext i8 %146 to i64
  %147 = load atomic i8* %0 seq_cst, align 1
  %148 = zext i8 %147 to i64
  %149 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 2, i64 %phitmp76, i64 %148)
  %150 = atomicrmw or i8* %0, i8 8 release
  %phitmp77 = zext i8 %150 to i64
  %151 = load atomic i8* %0 seq_cst, align 1
  %152 = zext i8 %151 to i64
  %153 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 3, i64 %phitmp77, i64 %152)
  %154 = atomicrmw or i8* %0, i8 16 acq_rel
  %phitmp78 = zext i8 %154 to i64
  %155 = load atomic i8* %0 seq_cst, align 1
  %156 = zext i8 %155 to i64
  %157 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 4, i64 %phitmp78, i64 %156)
  %158 = atomicrmw or i8* %0, i8 32 seq_cst
  %phitmp79 = zext i8 %158 to i64
  %159 = load atomic i8* %0 seq_cst, align 1
  %160 = zext i8 %159 to i64
  %161 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 5, i64 %phitmp79, i64 %160)
  store atomic i8 0, i8* %0 seq_cst, align 1
  %162 = atomicrmw xor i8* %0, i8 1 monotonic
  %phitmp80 = zext i8 %162 to i64
  %163 = load atomic i8* %0 seq_cst, align 1
  %164 = zext i8 %163 to i64
  %165 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 0, i64 %phitmp80, i64 %164)
  %166 = atomicrmw xor i8* %0, i8 2 acquire
  %phitmp81 = zext i8 %166 to i64
  %167 = load atomic i8* %0 seq_cst, align 1
  %168 = zext i8 %167 to i64
  %169 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 1, i64 %phitmp81, i64 %168)
  %170 = atomicrmw xor i8* %0, i8 4 acquire
  %phitmp82 = zext i8 %170 to i64
  %171 = load atomic i8* %0 seq_cst, align 1
  %172 = zext i8 %171 to i64
  %173 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 2, i64 %phitmp82, i64 %172)
  %174 = atomicrmw xor i8* %0, i8 8 release
  %phitmp83 = zext i8 %174 to i64
  %175 = load atomic i8* %0 seq_cst, align 1
  %176 = zext i8 %175 to i64
  %177 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 3, i64 %phitmp83, i64 %176)
  %178 = atomicrmw xor i8* %0, i8 16 acq_rel
  %phitmp84 = zext i8 %178 to i64
  %179 = load atomic i8* %0 seq_cst, align 1
  %180 = zext i8 %179 to i64
  %181 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 4, i64 %phitmp84, i64 %180)
  %182 = atomicrmw xor i8* %0, i8 32 seq_cst
  %phitmp85 = zext i8 %182 to i64
  %183 = load atomic i8* %0 seq_cst, align 1
  %184 = zext i8 %183 to i64
  %185 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 5, i64 %phitmp85, i64 %184)
  store atomic i8 0, i8* %0 seq_cst, align 1
  %186 = atomicrmw add i8* %0, i8 1 seq_cst
  %187 = load atomic i8* %0 seq_cst, align 1
  %188 = sext i8 %187 to i64
  %189 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str19, i64 0, i64 0), i64 %188)
  %190 = atomicrmw sub i8* %0, i8 1 seq_cst
  %191 = load atomic i8* %0 seq_cst, align 1
  %192 = sext i8 %191 to i64
  %193 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str20, i64 0, i64 0), i64 %192)
  %194 = atomicrmw add i8* %0, i8 10 seq_cst
  %195 = load atomic i8* %0 seq_cst, align 1
  %196 = sext i8 %195 to i64
  %197 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str21, i64 0, i64 0), i64 %196)
  %198 = atomicrmw sub i8* %0, i8 5 seq_cst
  %199 = load atomic i8* %0 seq_cst, align 1
  %200 = sext i8 %199 to i64
  %201 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str22, i64 0, i64 0), i64 %200)
  %202 = atomicrmw or i8* %0, i8 %mask0 seq_cst
  %203 = load atomic i8* %0 seq_cst, align 1
  %204 = zext i8 %203 to i64
  %205 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str23, i64 0, i64 0), i64 %204)
  %206 = atomicrmw and i8* %0, i8 %mask1 seq_cst
  %207 = load atomic i8* %0 seq_cst, align 1
  %208 = zext i8 %207 to i64
  %209 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str24, i64 0, i64 0), i64 %208)
  %210 = atomicrmw xor i8* %0, i8 %mask2 seq_cst
  %211 = load atomic i8* %0 seq_cst, align 1
  %212 = zext i8 %211 to i64
  %213 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str25, i64 0, i64 0), i64 %212)
  ret void

_ZNSt13__atomic_baseIcE9fetch_subEcSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIcE23compare_exchange_strongERccSt12memory_orderS2_.exit
  store atomic i8 0, i8* %0 seq_cst, align 1
  %214 = atomicrmw add i8* %0, i8 1 monotonic
  %phitmp62 = sext i8 %214 to i64
  %215 = load atomic i8* %0 seq_cst, align 1
  %216 = sext i8 %215 to i64
  %217 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 0, i64 %phitmp62, i64 %216)
  %218 = atomicrmw add i8* %0, i8 1 acquire
  %phitmp63 = sext i8 %218 to i64
  %219 = load atomic i8* %0 seq_cst, align 1
  %220 = sext i8 %219 to i64
  %221 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 1, i64 %phitmp63, i64 %220)
  %222 = atomicrmw add i8* %0, i8 1 acquire
  %phitmp64 = sext i8 %222 to i64
  %223 = load atomic i8* %0 seq_cst, align 1
  %224 = sext i8 %223 to i64
  %225 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 2, i64 %phitmp64, i64 %224)
  %226 = atomicrmw add i8* %0, i8 1 release
  %phitmp65 = sext i8 %226 to i64
  %227 = load atomic i8* %0 seq_cst, align 1
  %228 = sext i8 %227 to i64
  %229 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 3, i64 %phitmp65, i64 %228)
  %230 = atomicrmw add i8* %0, i8 1 acq_rel
  %phitmp66 = sext i8 %230 to i64
  %231 = load atomic i8* %0 seq_cst, align 1
  %232 = sext i8 %231 to i64
  %233 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 4, i64 %phitmp66, i64 %232)
  %234 = atomicrmw add i8* %0, i8 1 seq_cst
  %phitmp67 = sext i8 %234 to i64
  %235 = load atomic i8* %0 seq_cst, align 1
  %236 = sext i8 %235 to i64
  %237 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 5, i64 %phitmp67, i64 %236)
  %238 = atomicrmw sub i8* %0, i8 1 monotonic
  %phitmp68 = sext i8 %238 to i64
  %239 = load atomic i8* %0 seq_cst, align 1
  %240 = sext i8 %239 to i64
  %241 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 0, i64 %phitmp68, i64 %240)
  %242 = atomicrmw sub i8* %0, i8 1 acquire
  %phitmp69 = sext i8 %242 to i64
  %243 = load atomic i8* %0 seq_cst, align 1
  %244 = sext i8 %243 to i64
  %245 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 1, i64 %phitmp69, i64 %244)
  %246 = atomicrmw sub i8* %0, i8 1 acquire
  %phitmp70 = sext i8 %246 to i64
  %247 = load atomic i8* %0 seq_cst, align 1
  %248 = sext i8 %247 to i64
  %249 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 2, i64 %phitmp70, i64 %248)
  %250 = atomicrmw sub i8* %0, i8 1 release
  %phitmp71 = sext i8 %250 to i64
  %251 = load atomic i8* %0 seq_cst, align 1
  %252 = sext i8 %251 to i64
  %253 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 3, i64 %phitmp71, i64 %252)
  %254 = atomicrmw sub i8* %0, i8 1 acq_rel
  %phitmp72 = sext i8 %254 to i64
  %255 = load atomic i8* %0 seq_cst, align 1
  %256 = sext i8 %255 to i64
  %257 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 4, i64 %phitmp72, i64 %256)
  %258 = atomicrmw sub i8* %0, i8 1 seq_cst
  %phitmp73 = sext i8 %258 to i64
  %259 = load atomic i8* %0 seq_cst, align 1
  %260 = sext i8 %259 to i64
  %261 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 5, i64 %phitmp73, i64 %260)
  br label %114
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_Z4testIstEvT_S0_S0_(i16 signext %mask0, i16 signext %mask1, i16 signext %mask2) #0 {
_ZNSt13__atomic_baseIsE8exchangeEsSt12memory_order.exit.5:
  %atomicDog = alloca %"struct.std::atomic.2", align 2
  %0 = getelementptr inbounds %"struct.std::atomic.2"* %atomicDog, i64 0, i32 0, i32 0
  store i16 5, i16* %0, align 2
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0))
  %2 = load atomic i16* %0 seq_cst, align 2
  %3 = sext i16 %2 to i64
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str9, i64 0, i64 0), i64 %3)
  store atomic i16 0, i16* %0 monotonic, align 2
  %5 = load atomic i16* %0 monotonic, align 2
  %phitmp = sext i16 %5 to i64
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 0, i64 %phitmp)
  store atomic i16 1, i16* %0 monotonic, align 2
  %7 = load atomic i16* %0 acquire, align 2
  %phitmp51 = sext i16 %7 to i64
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 1, i64 %phitmp51)
  store atomic i16 2, i16* %0 monotonic, align 2
  %9 = load atomic i16* %0 acquire, align 2
  %phitmp52 = sext i16 %9 to i64
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 2, i64 %phitmp52)
  store atomic i16 3, i16* %0 release, align 2
  %11 = load atomic i16* %0 monotonic, align 2
  %phitmp53 = sext i16 %11 to i64
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 3, i64 %phitmp53)
  store atomic i16 4, i16* %0 monotonic, align 2
  %13 = load atomic i16* %0 monotonic, align 2
  %phitmp54 = sext i16 %13 to i64
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 4, i64 %phitmp54)
  store atomic i16 5, i16* %0 seq_cst, align 2
  %15 = load atomic i16* %0 seq_cst, align 2
  %phitmp55 = sext i16 %15 to i64
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 5, i64 %phitmp55)
  %17 = atomicrmw xchg i16* %0, i16 0 monotonic
  %phitmp56 = sext i16 %17 to i64
  %18 = load atomic i16* %0 seq_cst, align 2
  %19 = sext i16 %18 to i64
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 0, i64 %phitmp56, i64 %19)
  %21 = atomicrmw xchg i16* %0, i16 1 acquire
  %phitmp57 = sext i16 %21 to i64
  %22 = load atomic i16* %0 seq_cst, align 2
  %23 = sext i16 %22 to i64
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 1, i64 %phitmp57, i64 %23)
  %25 = atomicrmw xchg i16* %0, i16 2 acquire
  %phitmp58 = sext i16 %25 to i64
  %26 = load atomic i16* %0 seq_cst, align 2
  %27 = sext i16 %26 to i64
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 2, i64 %phitmp58, i64 %27)
  %29 = atomicrmw xchg i16* %0, i16 3 release
  %phitmp59 = sext i16 %29 to i64
  %30 = load atomic i16* %0 seq_cst, align 2
  %31 = sext i16 %30 to i64
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 3, i64 %phitmp59, i64 %31)
  %33 = atomicrmw xchg i16* %0, i16 4 acq_rel
  %phitmp60 = sext i16 %33 to i64
  %34 = load atomic i16* %0 seq_cst, align 2
  %35 = sext i16 %34 to i64
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 4, i64 %phitmp60, i64 %35)
  %37 = atomicrmw xchg i16* %0, i16 5 seq_cst
  %phitmp61 = sext i16 %37 to i64
  %38 = load atomic i16* %0 seq_cst, align 2
  %39 = sext i16 %38 to i64
  %40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 5, i64 %phitmp61, i64 %39)
  br label %41

; <label>:41                                      ; preds = %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIsE8exchangeEsSt12memory_order.exit.5
  %storemerge34 = phi i16 [ 0, %_ZNSt13__atomic_baseIsE8exchangeEsSt12memory_order.exit.5 ], [ %76, %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit ]
  %42 = add i16 %storemerge34, 1
  %43 = sext i16 %storemerge34 to i64
  %44 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %43
  %45 = load i32* %44, align 4, !tbaa !1
  switch i32 %45, label %46 [
    i32 1, label %51
    i32 2, label %51
    i32 3, label %56
    i32 4, label %61
    i32 5, label %66
  ]

; <label>:46                                      ; preds = %41
  %47 = cmpxchg i16* %0, i16 %storemerge34, i16 %42 monotonic monotonic
  %48 = extractvalue { i16, i1 } %47, 0
  %49 = icmp eq i16 %48, %storemerge34
  %50 = zext i1 %49 to i8
  br label %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit

; <label>:51                                      ; preds = %41, %41
  %52 = cmpxchg i16* %0, i16 %storemerge34, i16 %42 acquire acquire
  %53 = extractvalue { i16, i1 } %52, 0
  %54 = icmp eq i16 %53, %storemerge34
  %55 = zext i1 %54 to i8
  br label %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit

; <label>:56                                      ; preds = %41
  %57 = cmpxchg i16* %0, i16 %storemerge34, i16 %42 release monotonic
  %58 = extractvalue { i16, i1 } %57, 0
  %59 = icmp eq i16 %58, %storemerge34
  %60 = zext i1 %59 to i8
  br label %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit

; <label>:61                                      ; preds = %41
  %62 = cmpxchg i16* %0, i16 %storemerge34, i16 %42 acq_rel acquire
  %63 = extractvalue { i16, i1 } %62, 0
  %64 = icmp eq i16 %63, %storemerge34
  %65 = zext i1 %64 to i8
  br label %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit

; <label>:66                                      ; preds = %41
  %67 = cmpxchg i16* %0, i16 %storemerge34, i16 %42 seq_cst seq_cst
  %68 = extractvalue { i16, i1 } %67, 0
  %69 = icmp eq i16 %68, %storemerge34
  %70 = zext i1 %69 to i8
  br label %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit: ; preds = %66, %61, %56, %51, %46
  %71 = phi i16 [ %48, %46 ], [ %68, %66 ], [ %63, %61 ], [ %58, %56 ], [ %53, %51 ]
  %.0.i21 = phi i8 [ %50, %46 ], [ %70, %66 ], [ %65, %61 ], [ %60, %56 ], [ %55, %51 ]
  %72 = icmp ne i8 %.0.i21, 0
  %73 = sext i16 %71 to i64
  %74 = select i1 %72, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %75 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str12, i64 0, i64 0), i64 %73, i8* %74)
  %76 = add i16 %71, 1
  %77 = icmp slt i16 %76, 6
  br i1 %77, label %41, label %.preheader31

.preheader31:                                     ; preds = %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit
  %storemerge1532 = phi i16 [ %112, %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit ], [ 0, %_ZNSt13__atomic_baseIsE21compare_exchange_weakERssSt12memory_orderS2_.exit ]
  %78 = add i16 %storemerge1532, 1
  %79 = sext i16 %storemerge1532 to i64
  %80 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %79
  %81 = load i32* %80, align 4, !tbaa !1
  switch i32 %81, label %82 [
    i32 1, label %87
    i32 2, label %87
    i32 3, label %92
    i32 4, label %97
    i32 5, label %102
  ]

; <label>:82                                      ; preds = %.preheader31
  %83 = cmpxchg i16* %0, i16 %storemerge1532, i16 %78 monotonic monotonic
  %84 = extractvalue { i16, i1 } %83, 0
  %85 = icmp eq i16 %84, %storemerge1532
  %86 = zext i1 %85 to i8
  br label %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit

; <label>:87                                      ; preds = %.preheader31, %.preheader31
  %88 = cmpxchg i16* %0, i16 %storemerge1532, i16 %78 acquire acquire
  %89 = extractvalue { i16, i1 } %88, 0
  %90 = icmp eq i16 %89, %storemerge1532
  %91 = zext i1 %90 to i8
  br label %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit

; <label>:92                                      ; preds = %.preheader31
  %93 = cmpxchg i16* %0, i16 %storemerge1532, i16 %78 release monotonic
  %94 = extractvalue { i16, i1 } %93, 0
  %95 = icmp eq i16 %94, %storemerge1532
  %96 = zext i1 %95 to i8
  br label %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit

; <label>:97                                      ; preds = %.preheader31
  %98 = cmpxchg i16* %0, i16 %storemerge1532, i16 %78 acq_rel acquire
  %99 = extractvalue { i16, i1 } %98, 0
  %100 = icmp eq i16 %99, %storemerge1532
  %101 = zext i1 %100 to i8
  br label %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit

; <label>:102                                     ; preds = %.preheader31
  %103 = cmpxchg i16* %0, i16 %storemerge1532, i16 %78 seq_cst seq_cst
  %104 = extractvalue { i16, i1 } %103, 0
  %105 = icmp eq i16 %104, %storemerge1532
  %106 = zext i1 %105 to i8
  br label %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit: ; preds = %102, %97, %92, %87, %82
  %107 = phi i16 [ %84, %82 ], [ %104, %102 ], [ %99, %97 ], [ %94, %92 ], [ %89, %87 ]
  %.0.i20 = phi i8 [ %86, %82 ], [ %106, %102 ], [ %101, %97 ], [ %96, %92 ], [ %91, %87 ]
  %108 = icmp ne i8 %.0.i20, 0
  %109 = sext i16 %107 to i64
  %110 = select i1 %108, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %111 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str13, i64 0, i64 0), i64 %109, i8* %110)
  %112 = add i16 %107, 1
  %113 = icmp slt i16 %112, 6
  br i1 %113, label %.preheader31, label %_ZNSt13__atomic_baseIsE9fetch_subEsSt12memory_order.exit.5

; <label>:114                                     ; preds = %_ZNSt13__atomic_baseIsE9fetch_subEsSt12memory_order.exit.5, %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit
  %indvars.iv = phi i64 [ 0, %_ZNSt13__atomic_baseIsE9fetch_subEsSt12memory_order.exit.5 ], [ %indvars.iv.next, %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit ]
  %115 = trunc i64 %indvars.iv to i32
  %116 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %indvars.iv
  %117 = load i32* %116, align 4, !tbaa !1
  switch i32 %117, label %118 [
    i32 3, label %119
    i32 5, label %120
  ]

; <label>:118                                     ; preds = %114
  store atomic i16 %mask0, i16* %0 monotonic, align 2
  br label %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit

; <label>:119                                     ; preds = %114
  store atomic i16 %mask0, i16* %0 release, align 2
  br label %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit

; <label>:120                                     ; preds = %114
  store atomic i16 %mask0, i16* %0 seq_cst, align 2
  br label %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit

_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit: ; preds = %120, %119, %118
  %121 = shl i32 1, %115
  %122 = trunc i32 %121 to i16
  %123 = load i32* %116, align 4, !tbaa !1
  switch i32 %123, label %124 [
    i32 1, label %126
    i32 2, label %126
    i32 3, label %128
    i32 4, label %130
    i32 5, label %132
  ]

; <label>:124                                     ; preds = %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit
  %125 = atomicrmw and i16* %0, i16 %122 monotonic
  br label %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit

; <label>:126                                     ; preds = %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit, %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit
  %127 = atomicrmw and i16* %0, i16 %122 acquire
  br label %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit

; <label>:128                                     ; preds = %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit
  %129 = atomicrmw and i16* %0, i16 %122 release
  br label %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit

; <label>:130                                     ; preds = %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit
  %131 = atomicrmw and i16* %0, i16 %122 acq_rel
  br label %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit

; <label>:132                                     ; preds = %_ZNSt13__atomic_baseIsE5storeEsSt12memory_order.exit
  %133 = atomicrmw and i16* %0, i16 %122 seq_cst
  br label %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit

_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit: ; preds = %132, %130, %128, %126, %124
  %.0.i17 = phi i16 [ %125, %124 ], [ %133, %132 ], [ %131, %130 ], [ %129, %128 ], [ %127, %126 ]
  %134 = zext i16 %.0.i17 to i64
  %135 = load atomic i16* %0 seq_cst, align 2
  %136 = zext i16 %135 to i64
  %137 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str16, i64 0, i64 0), i64 %indvars.iv, i64 %134, i64 %136)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 6
  br i1 %exitcond, label %_ZNSt13__atomic_baseIsE9fetch_xorEsSt12memory_order.exit.5, label %114

_ZNSt13__atomic_baseIsE9fetch_xorEsSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIsE9fetch_andEsSt12memory_order.exit
  store atomic i16 0, i16* %0 seq_cst, align 2
  %138 = atomicrmw or i16* %0, i16 1 monotonic
  %phitmp74 = zext i16 %138 to i64
  %139 = load atomic i16* %0 seq_cst, align 2
  %140 = zext i16 %139 to i64
  %141 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 0, i64 %phitmp74, i64 %140)
  %142 = atomicrmw or i16* %0, i16 2 acquire
  %phitmp75 = zext i16 %142 to i64
  %143 = load atomic i16* %0 seq_cst, align 2
  %144 = zext i16 %143 to i64
  %145 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 1, i64 %phitmp75, i64 %144)
  %146 = atomicrmw or i16* %0, i16 4 acquire
  %phitmp76 = zext i16 %146 to i64
  %147 = load atomic i16* %0 seq_cst, align 2
  %148 = zext i16 %147 to i64
  %149 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 2, i64 %phitmp76, i64 %148)
  %150 = atomicrmw or i16* %0, i16 8 release
  %phitmp77 = zext i16 %150 to i64
  %151 = load atomic i16* %0 seq_cst, align 2
  %152 = zext i16 %151 to i64
  %153 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 3, i64 %phitmp77, i64 %152)
  %154 = atomicrmw or i16* %0, i16 16 acq_rel
  %phitmp78 = zext i16 %154 to i64
  %155 = load atomic i16* %0 seq_cst, align 2
  %156 = zext i16 %155 to i64
  %157 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 4, i64 %phitmp78, i64 %156)
  %158 = atomicrmw or i16* %0, i16 32 seq_cst
  %phitmp79 = zext i16 %158 to i64
  %159 = load atomic i16* %0 seq_cst, align 2
  %160 = zext i16 %159 to i64
  %161 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 5, i64 %phitmp79, i64 %160)
  store atomic i16 0, i16* %0 seq_cst, align 2
  %162 = atomicrmw xor i16* %0, i16 1 monotonic
  %phitmp80 = zext i16 %162 to i64
  %163 = load atomic i16* %0 seq_cst, align 2
  %164 = zext i16 %163 to i64
  %165 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 0, i64 %phitmp80, i64 %164)
  %166 = atomicrmw xor i16* %0, i16 2 acquire
  %phitmp81 = zext i16 %166 to i64
  %167 = load atomic i16* %0 seq_cst, align 2
  %168 = zext i16 %167 to i64
  %169 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 1, i64 %phitmp81, i64 %168)
  %170 = atomicrmw xor i16* %0, i16 4 acquire
  %phitmp82 = zext i16 %170 to i64
  %171 = load atomic i16* %0 seq_cst, align 2
  %172 = zext i16 %171 to i64
  %173 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 2, i64 %phitmp82, i64 %172)
  %174 = atomicrmw xor i16* %0, i16 8 release
  %phitmp83 = zext i16 %174 to i64
  %175 = load atomic i16* %0 seq_cst, align 2
  %176 = zext i16 %175 to i64
  %177 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 3, i64 %phitmp83, i64 %176)
  %178 = atomicrmw xor i16* %0, i16 16 acq_rel
  %phitmp84 = zext i16 %178 to i64
  %179 = load atomic i16* %0 seq_cst, align 2
  %180 = zext i16 %179 to i64
  %181 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 4, i64 %phitmp84, i64 %180)
  %182 = atomicrmw xor i16* %0, i16 32 seq_cst
  %phitmp85 = zext i16 %182 to i64
  %183 = load atomic i16* %0 seq_cst, align 2
  %184 = zext i16 %183 to i64
  %185 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 5, i64 %phitmp85, i64 %184)
  store atomic i16 0, i16* %0 seq_cst, align 2
  %186 = atomicrmw add i16* %0, i16 1 seq_cst
  %187 = load atomic i16* %0 seq_cst, align 2
  %188 = sext i16 %187 to i64
  %189 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str19, i64 0, i64 0), i64 %188)
  %190 = atomicrmw sub i16* %0, i16 1 seq_cst
  %191 = load atomic i16* %0 seq_cst, align 2
  %192 = sext i16 %191 to i64
  %193 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str20, i64 0, i64 0), i64 %192)
  %194 = atomicrmw add i16* %0, i16 10 seq_cst
  %195 = load atomic i16* %0 seq_cst, align 2
  %196 = sext i16 %195 to i64
  %197 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str21, i64 0, i64 0), i64 %196)
  %198 = atomicrmw sub i16* %0, i16 5 seq_cst
  %199 = load atomic i16* %0 seq_cst, align 2
  %200 = sext i16 %199 to i64
  %201 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str22, i64 0, i64 0), i64 %200)
  %202 = atomicrmw or i16* %0, i16 %mask0 seq_cst
  %203 = load atomic i16* %0 seq_cst, align 2
  %204 = zext i16 %203 to i64
  %205 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str23, i64 0, i64 0), i64 %204)
  %206 = atomicrmw and i16* %0, i16 %mask1 seq_cst
  %207 = load atomic i16* %0 seq_cst, align 2
  %208 = zext i16 %207 to i64
  %209 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str24, i64 0, i64 0), i64 %208)
  %210 = atomicrmw xor i16* %0, i16 %mask2 seq_cst
  %211 = load atomic i16* %0 seq_cst, align 2
  %212 = zext i16 %211 to i64
  %213 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str25, i64 0, i64 0), i64 %212)
  ret void

_ZNSt13__atomic_baseIsE9fetch_subEsSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIsE23compare_exchange_strongERssSt12memory_orderS2_.exit
  store atomic i16 0, i16* %0 seq_cst, align 2
  %214 = atomicrmw add i16* %0, i16 1 monotonic
  %phitmp62 = sext i16 %214 to i64
  %215 = load atomic i16* %0 seq_cst, align 2
  %216 = sext i16 %215 to i64
  %217 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 0, i64 %phitmp62, i64 %216)
  %218 = atomicrmw add i16* %0, i16 1 acquire
  %phitmp63 = sext i16 %218 to i64
  %219 = load atomic i16* %0 seq_cst, align 2
  %220 = sext i16 %219 to i64
  %221 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 1, i64 %phitmp63, i64 %220)
  %222 = atomicrmw add i16* %0, i16 1 acquire
  %phitmp64 = sext i16 %222 to i64
  %223 = load atomic i16* %0 seq_cst, align 2
  %224 = sext i16 %223 to i64
  %225 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 2, i64 %phitmp64, i64 %224)
  %226 = atomicrmw add i16* %0, i16 1 release
  %phitmp65 = sext i16 %226 to i64
  %227 = load atomic i16* %0 seq_cst, align 2
  %228 = sext i16 %227 to i64
  %229 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 3, i64 %phitmp65, i64 %228)
  %230 = atomicrmw add i16* %0, i16 1 acq_rel
  %phitmp66 = sext i16 %230 to i64
  %231 = load atomic i16* %0 seq_cst, align 2
  %232 = sext i16 %231 to i64
  %233 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 4, i64 %phitmp66, i64 %232)
  %234 = atomicrmw add i16* %0, i16 1 seq_cst
  %phitmp67 = sext i16 %234 to i64
  %235 = load atomic i16* %0 seq_cst, align 2
  %236 = sext i16 %235 to i64
  %237 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 5, i64 %phitmp67, i64 %236)
  %238 = atomicrmw sub i16* %0, i16 1 monotonic
  %phitmp68 = sext i16 %238 to i64
  %239 = load atomic i16* %0 seq_cst, align 2
  %240 = sext i16 %239 to i64
  %241 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 0, i64 %phitmp68, i64 %240)
  %242 = atomicrmw sub i16* %0, i16 1 acquire
  %phitmp69 = sext i16 %242 to i64
  %243 = load atomic i16* %0 seq_cst, align 2
  %244 = sext i16 %243 to i64
  %245 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 1, i64 %phitmp69, i64 %244)
  %246 = atomicrmw sub i16* %0, i16 1 acquire
  %phitmp70 = sext i16 %246 to i64
  %247 = load atomic i16* %0 seq_cst, align 2
  %248 = sext i16 %247 to i64
  %249 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 2, i64 %phitmp70, i64 %248)
  %250 = atomicrmw sub i16* %0, i16 1 release
  %phitmp71 = sext i16 %250 to i64
  %251 = load atomic i16* %0 seq_cst, align 2
  %252 = sext i16 %251 to i64
  %253 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 3, i64 %phitmp71, i64 %252)
  %254 = atomicrmw sub i16* %0, i16 1 acq_rel
  %phitmp72 = sext i16 %254 to i64
  %255 = load atomic i16* %0 seq_cst, align 2
  %256 = sext i16 %255 to i64
  %257 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 4, i64 %phitmp72, i64 %256)
  %258 = atomicrmw sub i16* %0, i16 1 seq_cst
  %phitmp73 = sext i16 %258 to i64
  %259 = load atomic i16* %0 seq_cst, align 2
  %260 = sext i16 %259 to i64
  %261 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 5, i64 %phitmp73, i64 %260)
  br label %114
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_Z4testIijEvT_S0_S0_(i32 %mask0, i32 %mask1, i32 %mask2) #0 {
_ZNSt13__atomic_baseIiE8exchangeEiSt12memory_order.exit.5:
  %atomicDog = alloca %"struct.std::atomic.0", align 4
  %0 = getelementptr inbounds %"struct.std::atomic.0"* %atomicDog, i64 0, i32 0, i32 0
  store i32 5, i32* %0, align 4
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0))
  %2 = load atomic i32* %0 seq_cst, align 4
  %3 = sext i32 %2 to i64
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str9, i64 0, i64 0), i64 %3)
  store atomic i32 0, i32* %0 monotonic, align 4
  %5 = load atomic i32* %0 monotonic, align 4
  %phitmp = sext i32 %5 to i64
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 0, i64 %phitmp)
  store atomic i32 1, i32* %0 monotonic, align 4
  %7 = load atomic i32* %0 acquire, align 4
  %phitmp51 = sext i32 %7 to i64
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 1, i64 %phitmp51)
  store atomic i32 2, i32* %0 monotonic, align 4
  %9 = load atomic i32* %0 acquire, align 4
  %phitmp52 = sext i32 %9 to i64
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 2, i64 %phitmp52)
  store atomic i32 3, i32* %0 release, align 4
  %11 = load atomic i32* %0 monotonic, align 4
  %phitmp53 = sext i32 %11 to i64
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 3, i64 %phitmp53)
  store atomic i32 4, i32* %0 monotonic, align 4
  %13 = load atomic i32* %0 monotonic, align 4
  %phitmp54 = sext i32 %13 to i64
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 4, i64 %phitmp54)
  store atomic i32 5, i32* %0 seq_cst, align 4
  %15 = load atomic i32* %0 seq_cst, align 4
  %phitmp55 = sext i32 %15 to i64
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 5, i64 %phitmp55)
  %17 = atomicrmw xchg i32* %0, i32 0 monotonic
  %phitmp56 = sext i32 %17 to i64
  %18 = load atomic i32* %0 seq_cst, align 4
  %19 = sext i32 %18 to i64
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 0, i64 %phitmp56, i64 %19)
  %21 = atomicrmw xchg i32* %0, i32 1 acquire
  %phitmp57 = sext i32 %21 to i64
  %22 = load atomic i32* %0 seq_cst, align 4
  %23 = sext i32 %22 to i64
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 1, i64 %phitmp57, i64 %23)
  %25 = atomicrmw xchg i32* %0, i32 2 acquire
  %phitmp58 = sext i32 %25 to i64
  %26 = load atomic i32* %0 seq_cst, align 4
  %27 = sext i32 %26 to i64
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 2, i64 %phitmp58, i64 %27)
  %29 = atomicrmw xchg i32* %0, i32 3 release
  %phitmp59 = sext i32 %29 to i64
  %30 = load atomic i32* %0 seq_cst, align 4
  %31 = sext i32 %30 to i64
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 3, i64 %phitmp59, i64 %31)
  %33 = atomicrmw xchg i32* %0, i32 4 acq_rel
  %phitmp60 = sext i32 %33 to i64
  %34 = load atomic i32* %0 seq_cst, align 4
  %35 = sext i32 %34 to i64
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 4, i64 %phitmp60, i64 %35)
  %37 = atomicrmw xchg i32* %0, i32 5 seq_cst
  %phitmp61 = sext i32 %37 to i64
  %38 = load atomic i32* %0 seq_cst, align 4
  %39 = sext i32 %38 to i64
  %40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 5, i64 %phitmp61, i64 %39)
  br label %41

; <label>:41                                      ; preds = %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIiE8exchangeEiSt12memory_order.exit.5
  %storemerge34 = phi i32 [ 0, %_ZNSt13__atomic_baseIiE8exchangeEiSt12memory_order.exit.5 ], [ %76, %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit ]
  %42 = add nsw i32 %storemerge34, 1
  %43 = sext i32 %storemerge34 to i64
  %44 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %43
  %45 = load i32* %44, align 4, !tbaa !1
  switch i32 %45, label %46 [
    i32 1, label %51
    i32 2, label %51
    i32 3, label %56
    i32 4, label %61
    i32 5, label %66
  ]

; <label>:46                                      ; preds = %41
  %47 = cmpxchg i32* %0, i32 %storemerge34, i32 %42 monotonic monotonic
  %48 = extractvalue { i32, i1 } %47, 0
  %49 = icmp eq i32 %48, %storemerge34
  %50 = zext i1 %49 to i8
  br label %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit

; <label>:51                                      ; preds = %41, %41
  %52 = cmpxchg i32* %0, i32 %storemerge34, i32 %42 acquire acquire
  %53 = extractvalue { i32, i1 } %52, 0
  %54 = icmp eq i32 %53, %storemerge34
  %55 = zext i1 %54 to i8
  br label %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit

; <label>:56                                      ; preds = %41
  %57 = cmpxchg i32* %0, i32 %storemerge34, i32 %42 release monotonic
  %58 = extractvalue { i32, i1 } %57, 0
  %59 = icmp eq i32 %58, %storemerge34
  %60 = zext i1 %59 to i8
  br label %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit

; <label>:61                                      ; preds = %41
  %62 = cmpxchg i32* %0, i32 %storemerge34, i32 %42 acq_rel acquire
  %63 = extractvalue { i32, i1 } %62, 0
  %64 = icmp eq i32 %63, %storemerge34
  %65 = zext i1 %64 to i8
  br label %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit

; <label>:66                                      ; preds = %41
  %67 = cmpxchg i32* %0, i32 %storemerge34, i32 %42 seq_cst seq_cst
  %68 = extractvalue { i32, i1 } %67, 0
  %69 = icmp eq i32 %68, %storemerge34
  %70 = zext i1 %69 to i8
  br label %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit: ; preds = %66, %61, %56, %51, %46
  %71 = phi i32 [ %48, %46 ], [ %68, %66 ], [ %63, %61 ], [ %58, %56 ], [ %53, %51 ]
  %.0.i21 = phi i8 [ %50, %46 ], [ %70, %66 ], [ %65, %61 ], [ %60, %56 ], [ %55, %51 ]
  %72 = icmp ne i8 %.0.i21, 0
  %73 = sext i32 %71 to i64
  %74 = select i1 %72, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %75 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str12, i64 0, i64 0), i64 %73, i8* %74)
  %76 = add nsw i32 %71, 1
  %77 = icmp slt i32 %76, 6
  br i1 %77, label %41, label %.preheader31

.preheader31:                                     ; preds = %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit
  %storemerge1532 = phi i32 [ %112, %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit ], [ 0, %_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_.exit ]
  %78 = add nsw i32 %storemerge1532, 1
  %79 = sext i32 %storemerge1532 to i64
  %80 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %79
  %81 = load i32* %80, align 4, !tbaa !1
  switch i32 %81, label %82 [
    i32 1, label %87
    i32 2, label %87
    i32 3, label %92
    i32 4, label %97
    i32 5, label %102
  ]

; <label>:82                                      ; preds = %.preheader31
  %83 = cmpxchg i32* %0, i32 %storemerge1532, i32 %78 monotonic monotonic
  %84 = extractvalue { i32, i1 } %83, 0
  %85 = icmp eq i32 %84, %storemerge1532
  %86 = zext i1 %85 to i8
  br label %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit

; <label>:87                                      ; preds = %.preheader31, %.preheader31
  %88 = cmpxchg i32* %0, i32 %storemerge1532, i32 %78 acquire acquire
  %89 = extractvalue { i32, i1 } %88, 0
  %90 = icmp eq i32 %89, %storemerge1532
  %91 = zext i1 %90 to i8
  br label %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit

; <label>:92                                      ; preds = %.preheader31
  %93 = cmpxchg i32* %0, i32 %storemerge1532, i32 %78 release monotonic
  %94 = extractvalue { i32, i1 } %93, 0
  %95 = icmp eq i32 %94, %storemerge1532
  %96 = zext i1 %95 to i8
  br label %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit

; <label>:97                                      ; preds = %.preheader31
  %98 = cmpxchg i32* %0, i32 %storemerge1532, i32 %78 acq_rel acquire
  %99 = extractvalue { i32, i1 } %98, 0
  %100 = icmp eq i32 %99, %storemerge1532
  %101 = zext i1 %100 to i8
  br label %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit

; <label>:102                                     ; preds = %.preheader31
  %103 = cmpxchg i32* %0, i32 %storemerge1532, i32 %78 seq_cst seq_cst
  %104 = extractvalue { i32, i1 } %103, 0
  %105 = icmp eq i32 %104, %storemerge1532
  %106 = zext i1 %105 to i8
  br label %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit: ; preds = %102, %97, %92, %87, %82
  %107 = phi i32 [ %84, %82 ], [ %104, %102 ], [ %99, %97 ], [ %94, %92 ], [ %89, %87 ]
  %.0.i20 = phi i8 [ %86, %82 ], [ %106, %102 ], [ %101, %97 ], [ %96, %92 ], [ %91, %87 ]
  %108 = icmp ne i8 %.0.i20, 0
  %109 = sext i32 %107 to i64
  %110 = select i1 %108, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %111 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str13, i64 0, i64 0), i64 %109, i8* %110)
  %112 = add nsw i32 %107, 1
  %113 = icmp slt i32 %112, 6
  br i1 %113, label %.preheader31, label %_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order.exit.5

; <label>:114                                     ; preds = %_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order.exit.5, %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit
  %indvars.iv = phi i64 [ 0, %_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order.exit.5 ], [ %indvars.iv.next, %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit ]
  %115 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %indvars.iv
  %116 = load i32* %115, align 4, !tbaa !1
  switch i32 %116, label %117 [
    i32 3, label %118
    i32 5, label %119
  ]

; <label>:117                                     ; preds = %114
  store atomic i32 %mask0, i32* %0 monotonic, align 4
  br label %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit

; <label>:118                                     ; preds = %114
  store atomic i32 %mask0, i32* %0 release, align 4
  br label %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit

; <label>:119                                     ; preds = %114
  store atomic i32 %mask0, i32* %0 seq_cst, align 4
  br label %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit

_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit: ; preds = %119, %118, %117
  %120 = trunc i64 %indvars.iv to i32
  %121 = shl i32 1, %120
  %122 = load i32* %115, align 4, !tbaa !1
  switch i32 %122, label %123 [
    i32 1, label %125
    i32 2, label %125
    i32 3, label %127
    i32 4, label %129
    i32 5, label %131
  ]

; <label>:123                                     ; preds = %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit
  %124 = atomicrmw and i32* %0, i32 %121 monotonic
  br label %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit

; <label>:125                                     ; preds = %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit, %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit
  %126 = atomicrmw and i32* %0, i32 %121 acquire
  br label %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit

; <label>:127                                     ; preds = %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit
  %128 = atomicrmw and i32* %0, i32 %121 release
  br label %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit

; <label>:129                                     ; preds = %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit
  %130 = atomicrmw and i32* %0, i32 %121 acq_rel
  br label %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit

; <label>:131                                     ; preds = %_ZNSt13__atomic_baseIiE5storeEiSt12memory_order.exit
  %132 = atomicrmw and i32* %0, i32 %121 seq_cst
  br label %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit

_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit: ; preds = %131, %129, %127, %125, %123
  %.0.i17 = phi i32 [ %124, %123 ], [ %132, %131 ], [ %130, %129 ], [ %128, %127 ], [ %126, %125 ]
  %133 = zext i32 %.0.i17 to i64
  %134 = load atomic i32* %0 seq_cst, align 4
  %135 = zext i32 %134 to i64
  %136 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str16, i64 0, i64 0), i64 %indvars.iv, i64 %133, i64 %135)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 6
  br i1 %exitcond, label %_ZNSt13__atomic_baseIiE9fetch_xorEiSt12memory_order.exit.5, label %114

_ZNSt13__atomic_baseIiE9fetch_xorEiSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order.exit
  store atomic i32 0, i32* %0 seq_cst, align 4
  %137 = atomicrmw or i32* %0, i32 1 monotonic
  %phitmp74 = zext i32 %137 to i64
  %138 = load atomic i32* %0 seq_cst, align 4
  %139 = zext i32 %138 to i64
  %140 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 0, i64 %phitmp74, i64 %139)
  %141 = atomicrmw or i32* %0, i32 2 acquire
  %phitmp75 = zext i32 %141 to i64
  %142 = load atomic i32* %0 seq_cst, align 4
  %143 = zext i32 %142 to i64
  %144 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 1, i64 %phitmp75, i64 %143)
  %145 = atomicrmw or i32* %0, i32 4 acquire
  %phitmp76 = zext i32 %145 to i64
  %146 = load atomic i32* %0 seq_cst, align 4
  %147 = zext i32 %146 to i64
  %148 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 2, i64 %phitmp76, i64 %147)
  %149 = atomicrmw or i32* %0, i32 8 release
  %phitmp77 = zext i32 %149 to i64
  %150 = load atomic i32* %0 seq_cst, align 4
  %151 = zext i32 %150 to i64
  %152 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 3, i64 %phitmp77, i64 %151)
  %153 = atomicrmw or i32* %0, i32 16 acq_rel
  %phitmp78 = zext i32 %153 to i64
  %154 = load atomic i32* %0 seq_cst, align 4
  %155 = zext i32 %154 to i64
  %156 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 4, i64 %phitmp78, i64 %155)
  %157 = atomicrmw or i32* %0, i32 32 seq_cst
  %phitmp79 = zext i32 %157 to i64
  %158 = load atomic i32* %0 seq_cst, align 4
  %159 = zext i32 %158 to i64
  %160 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 5, i64 %phitmp79, i64 %159)
  store atomic i32 0, i32* %0 seq_cst, align 4
  %161 = atomicrmw xor i32* %0, i32 1 monotonic
  %phitmp80 = zext i32 %161 to i64
  %162 = load atomic i32* %0 seq_cst, align 4
  %163 = zext i32 %162 to i64
  %164 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 0, i64 %phitmp80, i64 %163)
  %165 = atomicrmw xor i32* %0, i32 2 acquire
  %phitmp81 = zext i32 %165 to i64
  %166 = load atomic i32* %0 seq_cst, align 4
  %167 = zext i32 %166 to i64
  %168 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 1, i64 %phitmp81, i64 %167)
  %169 = atomicrmw xor i32* %0, i32 4 acquire
  %phitmp82 = zext i32 %169 to i64
  %170 = load atomic i32* %0 seq_cst, align 4
  %171 = zext i32 %170 to i64
  %172 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 2, i64 %phitmp82, i64 %171)
  %173 = atomicrmw xor i32* %0, i32 8 release
  %phitmp83 = zext i32 %173 to i64
  %174 = load atomic i32* %0 seq_cst, align 4
  %175 = zext i32 %174 to i64
  %176 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 3, i64 %phitmp83, i64 %175)
  %177 = atomicrmw xor i32* %0, i32 16 acq_rel
  %phitmp84 = zext i32 %177 to i64
  %178 = load atomic i32* %0 seq_cst, align 4
  %179 = zext i32 %178 to i64
  %180 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 4, i64 %phitmp84, i64 %179)
  %181 = atomicrmw xor i32* %0, i32 32 seq_cst
  %phitmp85 = zext i32 %181 to i64
  %182 = load atomic i32* %0 seq_cst, align 4
  %183 = zext i32 %182 to i64
  %184 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 5, i64 %phitmp85, i64 %183)
  store atomic i32 0, i32* %0 seq_cst, align 4
  %185 = atomicrmw add i32* %0, i32 1 seq_cst
  %186 = load atomic i32* %0 seq_cst, align 4
  %187 = sext i32 %186 to i64
  %188 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str19, i64 0, i64 0), i64 %187)
  %189 = atomicrmw sub i32* %0, i32 1 seq_cst
  %190 = load atomic i32* %0 seq_cst, align 4
  %191 = sext i32 %190 to i64
  %192 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str20, i64 0, i64 0), i64 %191)
  %193 = atomicrmw add i32* %0, i32 10 seq_cst
  %194 = load atomic i32* %0 seq_cst, align 4
  %195 = sext i32 %194 to i64
  %196 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str21, i64 0, i64 0), i64 %195)
  %197 = atomicrmw sub i32* %0, i32 5 seq_cst
  %198 = load atomic i32* %0 seq_cst, align 4
  %199 = sext i32 %198 to i64
  %200 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str22, i64 0, i64 0), i64 %199)
  %201 = atomicrmw or i32* %0, i32 %mask0 seq_cst
  %202 = load atomic i32* %0 seq_cst, align 4
  %203 = zext i32 %202 to i64
  %204 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str23, i64 0, i64 0), i64 %203)
  %205 = atomicrmw and i32* %0, i32 %mask1 seq_cst
  %206 = load atomic i32* %0 seq_cst, align 4
  %207 = zext i32 %206 to i64
  %208 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str24, i64 0, i64 0), i64 %207)
  %209 = atomicrmw xor i32* %0, i32 %mask2 seq_cst
  %210 = load atomic i32* %0 seq_cst, align 4
  %211 = zext i32 %210 to i64
  %212 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str25, i64 0, i64 0), i64 %211)
  ret void

_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_.exit
  store atomic i32 0, i32* %0 seq_cst, align 4
  %213 = atomicrmw add i32* %0, i32 1 monotonic
  %phitmp62 = sext i32 %213 to i64
  %214 = load atomic i32* %0 seq_cst, align 4
  %215 = sext i32 %214 to i64
  %216 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 0, i64 %phitmp62, i64 %215)
  %217 = atomicrmw add i32* %0, i32 1 acquire
  %phitmp63 = sext i32 %217 to i64
  %218 = load atomic i32* %0 seq_cst, align 4
  %219 = sext i32 %218 to i64
  %220 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 1, i64 %phitmp63, i64 %219)
  %221 = atomicrmw add i32* %0, i32 1 acquire
  %phitmp64 = sext i32 %221 to i64
  %222 = load atomic i32* %0 seq_cst, align 4
  %223 = sext i32 %222 to i64
  %224 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 2, i64 %phitmp64, i64 %223)
  %225 = atomicrmw add i32* %0, i32 1 release
  %phitmp65 = sext i32 %225 to i64
  %226 = load atomic i32* %0 seq_cst, align 4
  %227 = sext i32 %226 to i64
  %228 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 3, i64 %phitmp65, i64 %227)
  %229 = atomicrmw add i32* %0, i32 1 acq_rel
  %phitmp66 = sext i32 %229 to i64
  %230 = load atomic i32* %0 seq_cst, align 4
  %231 = sext i32 %230 to i64
  %232 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 4, i64 %phitmp66, i64 %231)
  %233 = atomicrmw add i32* %0, i32 1 seq_cst
  %phitmp67 = sext i32 %233 to i64
  %234 = load atomic i32* %0 seq_cst, align 4
  %235 = sext i32 %234 to i64
  %236 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 5, i64 %phitmp67, i64 %235)
  %237 = atomicrmw sub i32* %0, i32 1 monotonic
  %phitmp68 = sext i32 %237 to i64
  %238 = load atomic i32* %0 seq_cst, align 4
  %239 = sext i32 %238 to i64
  %240 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 0, i64 %phitmp68, i64 %239)
  %241 = atomicrmw sub i32* %0, i32 1 acquire
  %phitmp69 = sext i32 %241 to i64
  %242 = load atomic i32* %0 seq_cst, align 4
  %243 = sext i32 %242 to i64
  %244 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 1, i64 %phitmp69, i64 %243)
  %245 = atomicrmw sub i32* %0, i32 1 acquire
  %phitmp70 = sext i32 %245 to i64
  %246 = load atomic i32* %0 seq_cst, align 4
  %247 = sext i32 %246 to i64
  %248 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 2, i64 %phitmp70, i64 %247)
  %249 = atomicrmw sub i32* %0, i32 1 release
  %phitmp71 = sext i32 %249 to i64
  %250 = load atomic i32* %0 seq_cst, align 4
  %251 = sext i32 %250 to i64
  %252 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 3, i64 %phitmp71, i64 %251)
  %253 = atomicrmw sub i32* %0, i32 1 acq_rel
  %phitmp72 = sext i32 %253 to i64
  %254 = load atomic i32* %0 seq_cst, align 4
  %255 = sext i32 %254 to i64
  %256 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 4, i64 %phitmp72, i64 %255)
  %257 = atomicrmw sub i32* %0, i32 1 seq_cst
  %phitmp73 = sext i32 %257 to i64
  %258 = load atomic i32* %0 seq_cst, align 4
  %259 = sext i32 %258 to i64
  %260 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 5, i64 %phitmp73, i64 %259)
  br label %114
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_Z4testIxyEvT_S0_S0_(i64 %mask0, i64 %mask1, i64 %mask2) #0 {
_ZNSt13__atomic_baseIxE8exchangeExSt12memory_order.exit.5:
  %atomicDog = alloca %"struct.std::atomic", align 8
  %0 = getelementptr inbounds %"struct.std::atomic"* %atomicDog, i64 0, i32 0, i32 0
  store i64 5, i64* %0, align 8
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0))
  %2 = load atomic i64* %0 seq_cst, align 8
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str9, i64 0, i64 0), i64 %2)
  store atomic i64 0, i64* %0 monotonic, align 8
  %4 = load atomic i64* %0 monotonic, align 8
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 0, i64 %4)
  store atomic i64 1, i64* %0 monotonic, align 8
  %6 = load atomic i64* %0 acquire, align 8
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 1, i64 %6)
  store atomic i64 2, i64* %0 monotonic, align 8
  %8 = load atomic i64* %0 acquire, align 8
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 2, i64 %8)
  store atomic i64 3, i64* %0 release, align 8
  %10 = load atomic i64* %0 monotonic, align 8
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 3, i64 %10)
  store atomic i64 4, i64* %0 monotonic, align 8
  %12 = load atomic i64* %0 monotonic, align 8
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 4, i64 %12)
  store atomic i64 5, i64* %0 seq_cst, align 8
  %14 = load atomic i64* %0 seq_cst, align 8
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str10, i64 0, i64 0), i64 5, i64 %14)
  %16 = atomicrmw xchg i64* %0, i64 0 monotonic
  %17 = load atomic i64* %0 seq_cst, align 8
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 0, i64 %16, i64 %17)
  %19 = atomicrmw xchg i64* %0, i64 1 acquire
  %20 = load atomic i64* %0 seq_cst, align 8
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 1, i64 %19, i64 %20)
  %22 = atomicrmw xchg i64* %0, i64 2 acquire
  %23 = load atomic i64* %0 seq_cst, align 8
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 2, i64 %22, i64 %23)
  %25 = atomicrmw xchg i64* %0, i64 3 release
  %26 = load atomic i64* %0 seq_cst, align 8
  %27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 3, i64 %25, i64 %26)
  %28 = atomicrmw xchg i64* %0, i64 4 acq_rel
  %29 = load atomic i64* %0 seq_cst, align 8
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 4, i64 %28, i64 %29)
  %31 = atomicrmw xchg i64* %0, i64 5 seq_cst
  %32 = load atomic i64* %0 seq_cst, align 8
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str11, i64 0, i64 0), i64 5, i64 %31, i64 %32)
  br label %34

; <label>:34                                      ; preds = %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIxE8exchangeExSt12memory_order.exit.5
  %storemerge34 = phi i64 [ 0, %_ZNSt13__atomic_baseIxE8exchangeExSt12memory_order.exit.5 ], [ %67, %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit ]
  %35 = add nsw i64 %storemerge34, 1
  %36 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %storemerge34
  %37 = load i32* %36, align 4, !tbaa !1
  switch i32 %37, label %38 [
    i32 1, label %43
    i32 2, label %43
    i32 3, label %48
    i32 4, label %53
    i32 5, label %58
  ]

; <label>:38                                      ; preds = %34
  %39 = cmpxchg i64* %0, i64 %storemerge34, i64 %35 monotonic monotonic
  %40 = extractvalue { i64, i1 } %39, 0
  %41 = icmp eq i64 %40, %storemerge34
  %42 = zext i1 %41 to i8
  br label %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit

; <label>:43                                      ; preds = %34, %34
  %44 = cmpxchg i64* %0, i64 %storemerge34, i64 %35 acquire acquire
  %45 = extractvalue { i64, i1 } %44, 0
  %46 = icmp eq i64 %45, %storemerge34
  %47 = zext i1 %46 to i8
  br label %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit

; <label>:48                                      ; preds = %34
  %49 = cmpxchg i64* %0, i64 %storemerge34, i64 %35 release monotonic
  %50 = extractvalue { i64, i1 } %49, 0
  %51 = icmp eq i64 %50, %storemerge34
  %52 = zext i1 %51 to i8
  br label %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit

; <label>:53                                      ; preds = %34
  %54 = cmpxchg i64* %0, i64 %storemerge34, i64 %35 acq_rel acquire
  %55 = extractvalue { i64, i1 } %54, 0
  %56 = icmp eq i64 %55, %storemerge34
  %57 = zext i1 %56 to i8
  br label %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit

; <label>:58                                      ; preds = %34
  %59 = cmpxchg i64* %0, i64 %storemerge34, i64 %35 seq_cst seq_cst
  %60 = extractvalue { i64, i1 } %59, 0
  %61 = icmp eq i64 %60, %storemerge34
  %62 = zext i1 %61 to i8
  br label %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit: ; preds = %58, %53, %48, %43, %38
  %63 = phi i64 [ %40, %38 ], [ %60, %58 ], [ %55, %53 ], [ %50, %48 ], [ %45, %43 ]
  %.0.i21 = phi i8 [ %42, %38 ], [ %62, %58 ], [ %57, %53 ], [ %52, %48 ], [ %47, %43 ]
  %64 = icmp ne i8 %.0.i21, 0
  %65 = select i1 %64, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %66 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str12, i64 0, i64 0), i64 %63, i8* %65)
  %67 = add nsw i64 %63, 1
  %68 = icmp slt i64 %67, 6
  br i1 %68, label %34, label %.preheader31

.preheader31:                                     ; preds = %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit, %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit
  %storemerge1532 = phi i64 [ %101, %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit ], [ 0, %_ZNSt13__atomic_baseIxE21compare_exchange_weakERxxSt12memory_orderS2_.exit ]
  %69 = add nsw i64 %storemerge1532, 1
  %70 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %storemerge1532
  %71 = load i32* %70, align 4, !tbaa !1
  switch i32 %71, label %72 [
    i32 1, label %77
    i32 2, label %77
    i32 3, label %82
    i32 4, label %87
    i32 5, label %92
  ]

; <label>:72                                      ; preds = %.preheader31
  %73 = cmpxchg i64* %0, i64 %storemerge1532, i64 %69 monotonic monotonic
  %74 = extractvalue { i64, i1 } %73, 0
  %75 = icmp eq i64 %74, %storemerge1532
  %76 = zext i1 %75 to i8
  br label %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit

; <label>:77                                      ; preds = %.preheader31, %.preheader31
  %78 = cmpxchg i64* %0, i64 %storemerge1532, i64 %69 acquire acquire
  %79 = extractvalue { i64, i1 } %78, 0
  %80 = icmp eq i64 %79, %storemerge1532
  %81 = zext i1 %80 to i8
  br label %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit

; <label>:82                                      ; preds = %.preheader31
  %83 = cmpxchg i64* %0, i64 %storemerge1532, i64 %69 release monotonic
  %84 = extractvalue { i64, i1 } %83, 0
  %85 = icmp eq i64 %84, %storemerge1532
  %86 = zext i1 %85 to i8
  br label %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit

; <label>:87                                      ; preds = %.preheader31
  %88 = cmpxchg i64* %0, i64 %storemerge1532, i64 %69 acq_rel acquire
  %89 = extractvalue { i64, i1 } %88, 0
  %90 = icmp eq i64 %89, %storemerge1532
  %91 = zext i1 %90 to i8
  br label %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit

; <label>:92                                      ; preds = %.preheader31
  %93 = cmpxchg i64* %0, i64 %storemerge1532, i64 %69 seq_cst seq_cst
  %94 = extractvalue { i64, i1 } %93, 0
  %95 = icmp eq i64 %94, %storemerge1532
  %96 = zext i1 %95 to i8
  br label %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit

_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit: ; preds = %92, %87, %82, %77, %72
  %97 = phi i64 [ %74, %72 ], [ %94, %92 ], [ %89, %87 ], [ %84, %82 ], [ %79, %77 ]
  %.0.i20 = phi i8 [ %76, %72 ], [ %96, %92 ], [ %91, %87 ], [ %86, %82 ], [ %81, %77 ]
  %98 = icmp ne i8 %.0.i20, 0
  %99 = select i1 %98, i8* getelementptr inbounds ([5 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0)
  %100 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str13, i64 0, i64 0), i64 %97, i8* %99)
  %101 = add nsw i64 %97, 1
  %102 = icmp slt i64 %101, 6
  br i1 %102, label %.preheader31, label %_ZNSt13__atomic_baseIxE9fetch_subExSt12memory_order.exit.5

; <label>:103                                     ; preds = %_ZNSt13__atomic_baseIxE9fetch_subExSt12memory_order.exit.5, %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit
  %i9.027 = phi i64 [ 0, %_ZNSt13__atomic_baseIxE9fetch_subExSt12memory_order.exit.5 ], [ %125, %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit ]
  %104 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %i9.027
  %105 = load i32* %104, align 4, !tbaa !1
  switch i32 %105, label %106 [
    i32 3, label %107
    i32 5, label %108
  ]

; <label>:106                                     ; preds = %103
  store atomic i64 %mask0, i64* %0 monotonic, align 8
  br label %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit

; <label>:107                                     ; preds = %103
  store atomic i64 %mask0, i64* %0 release, align 8
  br label %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit

; <label>:108                                     ; preds = %103
  store atomic i64 %mask0, i64* %0 seq_cst, align 8
  br label %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit

_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit: ; preds = %108, %107, %106
  %109 = trunc i64 %i9.027 to i32
  %110 = shl i32 1, %109
  %111 = sext i32 %110 to i64
  %112 = load i32* %104, align 4, !tbaa !1
  switch i32 %112, label %113 [
    i32 1, label %115
    i32 2, label %115
    i32 3, label %117
    i32 4, label %119
    i32 5, label %121
  ]

; <label>:113                                     ; preds = %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit
  %114 = atomicrmw and i64* %0, i64 %111 monotonic
  br label %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit

; <label>:115                                     ; preds = %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit, %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit
  %116 = atomicrmw and i64* %0, i64 %111 acquire
  br label %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit

; <label>:117                                     ; preds = %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit
  %118 = atomicrmw and i64* %0, i64 %111 release
  br label %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit

; <label>:119                                     ; preds = %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit
  %120 = atomicrmw and i64* %0, i64 %111 acq_rel
  br label %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit

; <label>:121                                     ; preds = %_ZNSt13__atomic_baseIxE5storeExSt12memory_order.exit
  %122 = atomicrmw and i64* %0, i64 %111 seq_cst
  br label %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit

_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit: ; preds = %121, %119, %117, %115, %113
  %.0.i17 = phi i64 [ %114, %113 ], [ %122, %121 ], [ %120, %119 ], [ %118, %117 ], [ %116, %115 ]
  %123 = load atomic i64* %0 seq_cst, align 8
  %124 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str16, i64 0, i64 0), i64 %i9.027, i64 %.0.i17, i64 %123)
  %125 = add nsw i64 %i9.027, 1
  %exitcond40 = icmp eq i64 %125, 6
  br i1 %exitcond40, label %_ZNSt13__atomic_baseIxE8fetch_orExSt12memory_order.exit.5, label %103

; <label>:126                                     ; preds = %_ZNSt13__atomic_baseIxE8fetch_orExSt12memory_order.exit.5, %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit
  %indvars.iv = phi i64 [ 0, %_ZNSt13__atomic_baseIxE8fetch_orExSt12memory_order.exit.5 ], [ %indvars.iv.next, %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit ]
  %127 = trunc i64 %indvars.iv to i32
  %128 = shl i32 1, %127
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [6 x i32]* @_ZZ4testIchEvT_S0_S0_E11memoryOrder, i64 0, i64 %indvars.iv
  %131 = load i32* %130, align 4, !tbaa !1
  switch i32 %131, label %132 [
    i32 1, label %134
    i32 2, label %134
    i32 3, label %136
    i32 4, label %138
    i32 5, label %140
  ]

; <label>:132                                     ; preds = %126
  %133 = atomicrmw xor i64* %0, i64 %129 monotonic
  br label %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit

; <label>:134                                     ; preds = %126, %126
  %135 = atomicrmw xor i64* %0, i64 %129 acquire
  br label %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit

; <label>:136                                     ; preds = %126
  %137 = atomicrmw xor i64* %0, i64 %129 release
  br label %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit

; <label>:138                                     ; preds = %126
  %139 = atomicrmw xor i64* %0, i64 %129 acq_rel
  br label %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit

; <label>:140                                     ; preds = %126
  %141 = atomicrmw xor i64* %0, i64 %129 seq_cst
  br label %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit

_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit: ; preds = %140, %138, %136, %134, %132
  %.0.i = phi i64 [ %133, %132 ], [ %141, %140 ], [ %139, %138 ], [ %137, %136 ], [ %135, %134 ]
  %sext = shl i64 %.0.i, 32
  %142 = ashr exact i64 %sext, 32
  %143 = load atomic i64* %0 seq_cst, align 8
  %144 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i64 0, i64 0), i64 %indvars.iv, i64 %142, i64 %143)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 6
  br i1 %exitcond, label %145, label %126

; <label>:145                                     ; preds = %_ZNSt13__atomic_baseIxE9fetch_xorExSt12memory_order.exit
  store atomic i64 0, i64* %0 seq_cst, align 8
  %146 = atomicrmw add i64* %0, i64 1 seq_cst
  %147 = load atomic i64* %0 seq_cst, align 8
  %148 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str19, i64 0, i64 0), i64 %147)
  %149 = atomicrmw sub i64* %0, i64 1 seq_cst
  %150 = load atomic i64* %0 seq_cst, align 8
  %151 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str20, i64 0, i64 0), i64 %150)
  %152 = atomicrmw add i64* %0, i64 10 seq_cst
  %153 = load atomic i64* %0 seq_cst, align 8
  %154 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str21, i64 0, i64 0), i64 %153)
  %155 = atomicrmw sub i64* %0, i64 5 seq_cst
  %156 = load atomic i64* %0 seq_cst, align 8
  %157 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str22, i64 0, i64 0), i64 %156)
  %158 = atomicrmw or i64* %0, i64 %mask0 seq_cst
  %159 = load atomic i64* %0 seq_cst, align 8
  %160 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str23, i64 0, i64 0), i64 %159)
  %161 = atomicrmw and i64* %0, i64 %mask1 seq_cst
  %162 = load atomic i64* %0 seq_cst, align 8
  %163 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str24, i64 0, i64 0), i64 %162)
  %164 = atomicrmw xor i64* %0, i64 %mask2 seq_cst
  %165 = load atomic i64* %0 seq_cst, align 8
  %166 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str25, i64 0, i64 0), i64 %165)
  ret void

_ZNSt13__atomic_baseIxE8fetch_orExSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIxE9fetch_andExSt12memory_order.exit
  store atomic i64 0, i64* %0 seq_cst, align 8
  %167 = atomicrmw or i64* %0, i64 1 monotonic
  %168 = load atomic i64* %0 seq_cst, align 8
  %169 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 0, i64 %167, i64 %168)
  %170 = atomicrmw or i64* %0, i64 2 acquire
  %171 = load atomic i64* %0 seq_cst, align 8
  %172 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 1, i64 %170, i64 %171)
  %173 = atomicrmw or i64* %0, i64 4 acquire
  %174 = load atomic i64* %0 seq_cst, align 8
  %175 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 2, i64 %173, i64 %174)
  %176 = atomicrmw or i64* %0, i64 8 release
  %177 = load atomic i64* %0 seq_cst, align 8
  %178 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 3, i64 %176, i64 %177)
  %179 = atomicrmw or i64* %0, i64 16 acq_rel
  %180 = load atomic i64* %0 seq_cst, align 8
  %181 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 4, i64 %179, i64 %180)
  %182 = atomicrmw or i64* %0, i64 32 seq_cst
  %183 = load atomic i64* %0 seq_cst, align 8
  %184 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str17, i64 0, i64 0), i64 5, i64 %182, i64 %183)
  store atomic i64 0, i64* %0 seq_cst, align 8
  br label %126

_ZNSt13__atomic_baseIxE9fetch_subExSt12memory_order.exit.5: ; preds = %_ZNSt13__atomic_baseIxE23compare_exchange_strongERxxSt12memory_orderS2_.exit
  store atomic i64 0, i64* %0 seq_cst, align 8
  %185 = atomicrmw add i64* %0, i64 1 monotonic
  %186 = load atomic i64* %0 seq_cst, align 8
  %187 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 0, i64 %185, i64 %186)
  %188 = atomicrmw add i64* %0, i64 1 acquire
  %189 = load atomic i64* %0 seq_cst, align 8
  %190 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 1, i64 %188, i64 %189)
  %191 = atomicrmw add i64* %0, i64 1 acquire
  %192 = load atomic i64* %0 seq_cst, align 8
  %193 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 2, i64 %191, i64 %192)
  %194 = atomicrmw add i64* %0, i64 1 release
  %195 = load atomic i64* %0 seq_cst, align 8
  %196 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 3, i64 %194, i64 %195)
  %197 = atomicrmw add i64* %0, i64 1 acq_rel
  %198 = load atomic i64* %0 seq_cst, align 8
  %199 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 4, i64 %197, i64 %198)
  %200 = atomicrmw add i64* %0, i64 1 seq_cst
  %201 = load atomic i64* %0 seq_cst, align 8
  %202 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str14, i64 0, i64 0), i64 5, i64 %200, i64 %201)
  %203 = atomicrmw sub i64* %0, i64 1 monotonic
  %204 = load atomic i64* %0 seq_cst, align 8
  %205 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 0, i64 %203, i64 %204)
  %206 = atomicrmw sub i64* %0, i64 1 acquire
  %207 = load atomic i64* %0 seq_cst, align 8
  %208 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 1, i64 %206, i64 %207)
  %209 = atomicrmw sub i64* %0, i64 1 acquire
  %210 = load atomic i64* %0 seq_cst, align 8
  %211 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 2, i64 %209, i64 %210)
  %212 = atomicrmw sub i64* %0, i64 1 release
  %213 = load atomic i64* %0 seq_cst, align 8
  %214 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 3, i64 %212, i64 %213)
  %215 = atomicrmw sub i64* %0, i64 1 acq_rel
  %216 = load atomic i64* %0 seq_cst, align 8
  %217 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 4, i64 %215, i64 %216)
  %218 = atomicrmw sub i64* %0, i64 1 seq_cst
  %219 = load atomic i64* %0 seq_cst, align 8
  %220 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str15, i64 0, i64 0), i64 5, i64 %218, i64 %219)
  br label %103
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"_ZTSSt12memory_order", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
