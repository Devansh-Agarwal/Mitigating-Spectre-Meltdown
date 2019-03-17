; ModuleID = 'example1.c'
source_filename = "example1.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"%d, %d\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @number(i32* %a, i32 %l, i32 %d) #0 {
entry:
  %a.addr = alloca i32*, align 8
  %l.addr = alloca i32, align 4
  %d.addr = alloca i32, align 4
  %k = alloca i32, align 4
  %zzz = alloca i32, align 4
  store i32* %a, i32** %a.addr, align 8
  store i32 %l, i32* %l.addr, align 4
  store i32 %d, i32* %d.addr, align 4
  %0 = load i32*, i32** %a.addr, align 8
  %1 = load i32, i32* %0, align 4
  %add = add nsw i32 %1, 2
  store i32 %add, i32* %k, align 4
  %2 = load i32, i32* %l.addr, align 4
  %3 = load i32, i32* %l.addr, align 4
  %add1 = add nsw i32 %2, %3
  store i32 %add1, i32* %l.addr, align 4
  %4 = load i32, i32* %d.addr, align 4
  %5 = load i32, i32* %k, align 4
  %add2 = add nsw i32 %5, %4
  store i32 %add2, i32* %k, align 4
  %6 = load i32, i32* %l.addr, align 4
  %7 = load i32, i32* %k, align 4
  %add3 = add nsw i32 %7, %6
  store i32 %add3, i32* %k, align 4
  %8 = load i32, i32* %l.addr, align 4
  %add4 = add nsw i32 %8, 2
  store i32 %add4, i32* %l.addr, align 4
  %9 = load i32*, i32** %a.addr, align 8
  %10 = load i32, i32* %9, align 4
  %cmp = icmp sgt i32 %10, 2132
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %11 = load i32, i32* %k, align 4
  %inc = add nsw i32 %11, 1
  store i32 %inc, i32* %k, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %12 = load i32, i32* %k, align 4
  store i32 %12, i32* %zzz, align 4
  %13 = load i32, i32* %zzz, align 4
  %add5 = add nsw i32 %13, 2
  store i32 %add5, i32* %zzz, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %ssss = alloca i32, align 4
  %untaint = alloca i32, align 4
  %untaint2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 22, i32* %e, align 4
  store i32 121, i32* %ssss, align 4
  store i32 222, i32* %untaint, align 4
  store i32 2321, i32* %untaint2, align 4
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0), i32* %a, i32* %b)
  %call1 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i32 0, i32 0), i32* %a)
  %call2 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0), i32* %c, i32* %d)
  %0 = load i32, i32* %a, align 4
  %1 = load i32, i32* %b, align 4
  %cmp = icmp sgt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 7, i32* %c, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32, i32* %d, align 4
  %add = add nsw i32 %2, 22
  store i32 %add, i32* %e, align 4
  store i32 321321, i32* %ssss, align 4
  %3 = load i32, i32* %e, align 4
  %4 = load i32, i32* %d, align 4
  call void @number(i32* %a, i32 %3, i32 %4)
  %5 = load i32, i32* %untaint, align 4
  %cmp3 = icmp slt i32 %5, 2112
  br i1 %cmp3, label %if.then4, label %if.end5

if.then4:                                         ; preds = %if.end
  %6 = load i32, i32* %untaint, align 4
  %mul = mul nsw i32 %6, 21
  store i32 %mul, i32* %untaint, align 4
  br label %if.end5

if.end5:                                          ; preds = %if.then4, %if.end
  %7 = load i32, i32* %untaint, align 4
  %cmp6 = icmp slt i32 %7, 2112
  br i1 %cmp6, label %if.then7, label %if.end10

if.then7:                                         ; preds = %if.end5
  %8 = load i32, i32* %d, align 4
  %mul8 = mul nsw i32 %8, 21
  store i32 %mul8, i32* %d, align 4
  %9 = load i32, i32* %ssss, align 4
  %mul9 = mul nsw i32 %9, 21
  store i32 %mul9, i32* %ssss, align 4
  br label %if.end10

if.end10:                                         ; preds = %if.then7, %if.end5
  %10 = load i32, i32* %ssss, align 4
  %cmp11 = icmp sgt i32 %10, 222
  br i1 %cmp11, label %if.then12, label %if.end13

if.then12:                                        ; preds = %if.end10
  %11 = load i32, i32* %ssss, align 4
  %inc = add nsw i32 %11, 1
  store i32 %inc, i32* %ssss, align 4
  br label %if.end13

if.end13:                                         ; preds = %if.then12, %if.end10
  %12 = load i32, i32* %ssss, align 4
  %13 = load i32, i32* %d, align 4
  %cmp14 = icmp sgt i32 %12, %13
  br i1 %cmp14, label %if.then15, label %if.end17

if.then15:                                        ; preds = %if.end13
  %14 = load i32, i32* %ssss, align 4
  %inc16 = add nsw i32 %14, 1
  store i32 %inc16, i32* %ssss, align 4
  br label %if.end17

if.end17:                                         ; preds = %if.then15, %if.end13
  ret i32 0
}

declare dso_local i32 @__isoc99_scanf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 (trunk 342348)"}
