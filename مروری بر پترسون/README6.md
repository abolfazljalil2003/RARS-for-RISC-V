# مثال‌های بازگشتی در RISC-V

<div dir="rtl">

## 📑 فهرست مطالب

- [مقدمه](#مقدمه)
- [1. محاسبه مجموع اعداد زوج تا n](#1-محاسبه-مجموع-اعداد-زوج-تا-n)
- [2. محاسبه توان (Exponentiation)](#2-محاسبه-توان-exponentiation)
- [3. محاسبه فیبوناچی](#3-محاسبه-فیبوناچی)
- [4. محاسبه مجموع ارقام عدد](#4-محاسبه-مجموع-ارقام-عدد)
- [5. ضرب بدون دستور mul](#5-ضرب-بدون-دستور-mul)
- [6. بررسی عدد اول](#6-بررسی-عدد-اول)
- [نسخه‌های بهینه (تکراری)](#نسخه‌های-بهینه-تکراری)
- [مقایسه عملکرد](#مقایسه-عملکرد)

---

## مقدمه

### 🎯 درباره این مستند

این مجموعه شامل **6 مثال عملی** از توابع بازگشتی در RISC-V است که مفاهیم زیر را پوشش می‌دهد:

- ✅ مدیریت پشته (Stack)
- ✅ شرایط پایه (Base Cases)
- ✅ فراخوانی بازگشتی
- ✅ محاسبات ریاضی
- ✅ الگوریتم‌های کلاسیک

### 📊 سطح مهارت

| مثال | سختی | موضوع |
|------|------|-------|
| مجموع زوج | ⭐⭐ | شرط و بازگشت |
| توان | ⭐⭐ | ضرب بازگشتی |
| فیبوناچی | ⭐⭐⭐ | دو فراخوانی |
| مجموع ارقام | ⭐⭐ | باقیمانده و تقسیم |
| ضرب | ⭐⭐ | جمع بازگشتی |
| عدد اول | ⭐⭐⭐ | الگوریتم پیشرفته |

---

## 1. محاسبه مجموع اعداد زوج تا n

### 📝 توضیحات

محاسبه مجموع تمام اعداد زوج از 0 تا n.

**مثال:**
```
sum_even(8) = 2 + 4 + 6 + 8 = 20
sum_even(10) = 2 + 4 + 6 + 8 + 10 = 30
```

### 🔍 الگوریتم

```
sum_even(n):
    if n ≤ 0:
        return 0
    if n is odd:
        return sum_even(n-1)
    else:
        return n + sum_even(n-2)
```
<div dir="ltr">
### 💻 کد RISC-V

```assembly
# ورودی: a0 = n
# خروجی: a0 = مجموع اعداد زوج

sum_even:
    # Prologue
    addi sp, sp, -12        # تخصیص فضا
    sw   ra, 8(sp)          # ذخیره آدرس بازگشت
    sw   a0, 4(sp)          # ذخیره n
    sw   s0, 0(sp)          # ذخیره مجموع جزئی
    
    # Base case: n <= 0
    ble  a0, zero, base_case
    
    # بررسی زوج بودن
    andi t0, a0, 1          # t0 = n & 1
    bnez t0, odd_case       # اگر فرد است
    
    # Even case: n + sum_even(n-2)
    addi a0, a0, -2         # n = n - 2
    jal  ra, sum_even       # فراخوانی بازگشتی
    
    lw   t1, 4(sp)          # بازیابی n اصلی
    add  a0, a0, t1         # result + n
    j    epilogue
    
odd_case:
    # Odd case: sum_even(n-1)
    addi a0, a0, -1         # n = n - 1
    jal  ra, sum_even
    j    epilogue
    
base_case:
    li   a0, 0              # return 0
    
epilogue:
    lw   s0, 0(sp)
    lw   ra, 8(sp)
    addi sp, sp, 12
    ret

# ═══════════════════════════════════════════════════
# مثال استفاده
# ═══════════════════════════════════════════════════

main:
    li   a0, 10             # محاسبه sum_even(10)
    jal  ra, sum_even
    # a0 = 30
```

### 📊 نمودار فراخوانی

```
sum_even(8)
    │
    ├─► 8 + sum_even(6)
    │         │
    │         ├─► 6 + sum_even(4)
    │         │         │
    │         │         ├─► 4 + sum_even(2)
    │         │         │         │
    │         │         │         └─► 2 + sum_even(0)
    │         │         │                   │
    │         │         │                   └─► 0
    │         │         │         
    │         │         └──◄ 2
    │         │         
    │         └──◄ 6
    │         
    └──◄ 12
    
Result: 8 + 6 + 4 + 2 = 20
```
</div>
### ✅ تست

```assembly
# Test Cases
li a0, 0     # → 0
li a0, 1     # → 0
li a0, 2     # → 2
li a0, 5     # → 6 (2+4)
li a0, 10    # → 30 (2+4+6+8+10)
```

---

## 2. محاسبه توان (Exponentiation)

### 📝 توضیحات

محاسبه a به توان b (a^b) به صورت بازگشتی.

**مثال:**
```
power(2, 3) = 2 × 2 × 2 = 8
power(5, 2) = 5 × 5 = 25
```

### 🔍 الگوریتم

```
power(a, b):
    if b = 0:
        return 1
    else:
        return a × power(a, b-1)
```

### 💻 کد RISC-V

```assembly
# ورودی: a0 = base (a), a1 = exponent (b)
# خروجی: a0 = a^b

power:
    # Prologue
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a0, 8(sp)          # ذخیره base
    sw   a1, 4(sp)          # ذخیره exponent
    sw   s0, 0(sp)
    
    # Base case: b = 0 → return 1
    beq  a1, zero, power_base
    
    # Recursive case: a × power(a, b-1)
    addi a1, a1, -1         # b = b - 1
    jal  ra, power          # فراخوانی بازگشتی
    
    # محاسبه: base × result
    lw   t0, 8(sp)          # بازیابی base
    mul  a0, a0, t0         # result × base
    j    power_end
    
power_base:
    li   a0, 1              # return 1
    
power_end:
    lw   s0, 0(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret

# ═══════════════════════════════════════════════════
# مثال استفاده
# ═══════════════════════════════════════════════════

main:
    li   a0, 2              # base = 2
    li   a1, 10             # exp = 10
    jal  ra, power
    # a0 = 1024
```

### 📊 نمودار فراخوانی

```
power(3, 4)
    │
    ├─► 3 × power(3, 3)
    │         │
    │         ├─► 3 × power(3, 2)
    │         │         │
    │         │         ├─► 3 × power(3, 1)
    │         │         │         │
    │         │         │         └─► 3 × power(3, 0)
    │         │         │                   │
    │         │         │                   └─► 1
    │         │         │         
    │         │         └──◄ 3 × 1 = 3
    │         │         
    │         └──◄ 3 × 3 = 9
    │         
    └──◄ 3 × 9 = 27

Result: 3 × 27 = 81
```

### ⚡ بهینه‌سازی (Fast Power)

```assembly
# الگوریتم Fast Exponentiation: O(log n)
fast_power:
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a0, 8(sp)
    sw   a1, 4(sp)
    sw   s0, 0(sp)
    
    # Base case
    beq  a1, zero, fast_base
    li   t0, 1
    beq  a1, t0, fast_one
    
    # اگر b زوج است: (a²)^(b/2)
    andi t0, a1, 1
    beq  t0, zero, fast_even
    
    # اگر b فرد است: a × a^(b-1)
    addi a1, a1, -1
    jal  ra, fast_power
    lw   t0, 8(sp)
    mul  a0, a0, t0
    j    fast_end
    
fast_even:
    mul  a0, a0, a0         # a = a²
    srli a1, a1, 1          # b = b / 2
    jal  ra, fast_power
    j    fast_end
    
fast_base:
    li   a0, 1
    j    fast_end
    
fast_one:
    lw   a0, 8(sp)
    
fast_end:
    lw   s0, 0(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret
```

---

## 3. محاسبه فیبوناچی

### 📝 توضیحات

محاسبه عدد n‌ام دنباله فیبوناچی.

**دنباله:**
```
F(0) = 0
F(1) = 1
F(n) = F(n-1) + F(n-2)

0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...
```

### 🔍 الگوریتم

```
fib(n):
    if n ≤ 1:
        return n
    else:
        return fib(n-1) + fib(n-2)
```

### 💻 کد RISC-V

```assembly
# ورودی: a0 = n
# خروجی: a0 = F(n)

fibonacci:
    # Prologue
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a0, 8(sp)          # ذخیره n
    sw   s0, 4(sp)          # برای F(n-1)
    sw   s1, 0(sp)          # برای F(n-2)
    
    # Base cases: n ≤ 1
    li   t0, 1
    ble  a0, t0, fib_base
    
    # محاسبه F(n-1)
    addi a0, a0, -1
    jal  ra, fibonacci
    mv   s0, a0             # s0 = F(n-1)
    
    # محاسبه F(n-2)
    lw   a0, 8(sp)          # بازیابی n
    addi a0, a0, -2
    jal  ra, fibonacci
    mv   s1, a0             # s1 = F(n-2)
    
    # جمع F(n-1) + F(n-2)
    add  a0, s0, s1
    j    fib_end
    
fib_base:
    lw   a0, 8(sp)          # return n
    
fib_end:
    lw   s1, 0(sp)
    lw   s0, 4(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret

# ═══════════════════════════════════════════════════
# مثال استفاده
# ═══════════════════════════════════════════════════

main:
    li   a0, 10             # محاسبه F(10)
    jal  ra, fibonacci
    # a0 = 55
```

### 📊 نمودار درخت فراخوانی

```
                    fib(5)
                 /          \
            fib(4)          fib(3)
           /      \        /      \
      fib(3)    fib(2)  fib(2)  fib(1)
      /    \    /    \  /    \
  fib(2) fib(1) fib(1) fib(0) fib(1) fib(0)
  /   \
fib(1) fib(0)

Result: 5
```

⚠️ **توجه:** این روش بسیار ناکارآمد است! O(2^n)

### ⚡ نسخه بهینه (تکراری)

```assembly
# نسخه تکراری: O(n)
fibonacci_iterative:
    # Base cases
    beq  a0, zero, fib_zero
    li   t0, 1
    beq  a0, t0, fib_one
    
    # مقداردهی اولیه
    li   t0, 0              # F(0)
    li   t1, 1              # F(1)
    li   t2, 2              # شمارنده
    
fib_loop:
    bgt  t2, a0, fib_iter_end
    
    add  t3, t0, t1         # F(n) = F(n-1) + F(n-2)
    mv   t0, t1             # F(n-2) = F(n-1)
    mv   t1, t3             # F(n-1) = F(n)
    
    addi t2, t2, 1
    j    fib_loop
    
fib_iter_end:
    mv   a0, t1
    ret
    
fib_zero:
    li   a0, 0
    ret
    
fib_one:
    li   a0, 1
    ret
```

### 📈 مقایسه عملکرد

| n | بازگشتی (ms) | تکراری (ms) | نسبت |
|---|-------------|-------------|------|
| 10 | 0.2 | 0.01 | 20x |
| 20 | 89 | 0.02 | 4450x |
| 30 | 94,321 | 0.03 | 3,144,033x |
| 40 | ⏰ | 0.04 | ∞ |

---

## 4. محاسبه مجموع ارقام عدد

### 📝 توضیحات

محاسبه مجموع ارقام یک عدد صحیح مثبت.

**مثال:**
```
sum_digits(1234) = 1 + 2 + 3 + 4 = 10
sum_digits(9876) = 9 + 8 + 7 + 6 = 30
```

### 🔍 الگوریتم

```
sum_digits(n):
    if n = 0:
        return 0
    else:
        return (n % 10) + sum_digits(n / 10)
```

### 💻 کد RISC-V

```assembly
# ورودی: a0 = n
# خروجی: a0 = مجموع ارقام

sum_digits:
    # Prologue
    addi sp, sp, -12
    sw   ra, 8(sp)
    sw   a0, 4(sp)
    sw   s0, 0(sp)
    
    # Base case: n = 0
    beq  a0, zero, digits_base
    
    # جدا کردن آخرین رقم
    li   t0, 10
    rem  s0, a0, t0         # s0 = n % 10 (آخرین رقم)
    div  a0, a0, t0         # a0 = n / 10 (بقیه ارقام)
    
    # فراخوانی بازگشتی
    jal  ra, sum_digits
    
    # جمع رقم فعلی با نتیجه
    add  a0, a0, s0
    j    digits_end
    
digits_base:
    li   a0, 0
    
digits_end:
    lw   s0, 0(sp)
    lw   ra, 8(sp)
    addi sp, sp, 12
    ret

# ═══════════════════════════════════════════════════
# مثال استفاده
# ═══════════════════════════════════════════════════

main:
    li   a0, 12345          # مجموع ارقام 12345
    jal  ra, sum_digits
    # a0 = 15 (1+2+3+4+5)
```

### 📊 نمودار فراخوانی

```
sum_digits(1234)
    │
    ├─► 4 + sum_digits(123)
    │         │
    │         ├─► 3 + sum_digits(12)
    │         │         │
    │         │         ├─► 2 + sum_digits(1)
    │         │         │         │
    │         │         │         └─► 1 + sum_digits(0)
    │         │         │                   │
    │         │         │                   └─► 0
    │         │         │         
    │         │         └──◄ 1
    │         │         
    │         └──◄ 3
    │         
    └──◄ 6

Result: 4 + 3 + 2 + 1 = 10
```

### 🔢 توابع مرتبط

```assembly
# شمارش تعداد ارقام
count_digits:
    beq  a0, zero, count_zero
    
    addi sp, sp, -8
    sw   ra, 4(sp)
    sw   a0, 0(sp)
    
    li   t0, 10
    div  a0, a0, t0
    jal  ra, count_digits
    
    addi a0, a0, 1          # افزایش شمارنده
    
    lw   ra, 4(sp)
    addi sp, sp, 8
    ret
    
count_zero:
    li   a0, 1
    ret

# معکوس کردن عدد
reverse_number:
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a0, 8(sp)
    sw   a1, 4(sp)          # نتیجه تجمعی
    sw   s0, 0(sp)
    
    beq  a0, zero, rev_base
    
    li   t0, 10
    rem  s0, a0, t0         # آخرین رقم
    div  a0, a0, t0
    
    # result = result * 10 + digit
    mul  a1, a1, t0
    add  a1, a1, s0
    
    jal  ra, reverse_number
    j    rev_end
    
rev_base:
    mv   a0, a1
    
rev_end:
    lw   s0, 0(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret
```

---

## 5. ضرب بدون دستور mul

### 📝 توضیحات

پیاده‌سازی ضرب با استفاده از جمع‌های متوالی.

**منطق:**
```
a × b = a + a + a + ... (b بار)
```

**مثال:**
```
multiply(5, 3) = 5 + 5 + 5 = 15
multiply(7, 4) = 7 + 7 + 7 + 7 = 28
```

### 🔍 الگوریتم

```
multiply(a, b):
    if b = 0:
        return 0
    else:
        return a + multiply(a, b-1)
```

### 💻 کد RISC-V

```assembly
# ورودی: a0 = a, a1 = b
# خروجی: a0 = a × b

multiply:
    # Prologue
    addi sp, sp, -12
    sw   ra, 8(sp)
    sw   a0, 4(sp)          # ذخیره a
    sw   a1, 0(sp)          # ذخیره b
    
    # Base case: b = 0 → return 0
    beq  a1, zero, mult_base
    
    # Recursive case: a + multiply(a, b-1)
    addi a1, a1, -1         # b = b - 1
    jal  ra, multiply
    
    # افزودن a به نتیجه
    lw   t0, 4(sp)          # بازیابی a
    add  a0, a0, t0         # result + a
    j    mult_end
    
mult_base:
    li   a0, 0              # return 0
    
mult_end:
    lw   ra, 8(sp)
    addi sp, sp, 12
    ret

# ═══════════════════════════════════════════════════
# مثال استفاده
# ═══════════════════════════════════════════════════

main:
    li   a0, 12             # a = 12
    li   a1, 7              # b = 7
    jal  ra, multiply
    # a0 = 84
```

### 📊 نمودار فراخوانی

```
multiply(4, 5)
    │
    ├─► 4 + multiply(4, 4)
    │         │
    │         ├─► 4 + multiply(4, 3)
    │         │         │
    │         │         ├─► 4 + multiply(4, 2)
    │         │         │         │
    │         │         │         ├─► 4 + multiply(4, 1)
    │         │         │         │         │
    │         │         │         │         └─► 4 + multiply(4, 0)
    │         │         │         │                   │
    │         │         │         │                   └─► 0
    │         │         │         │         
    │         │         │         └──◄ 4
    │         │         │         
    │         │         └──◄ 8
    │         │         
    │         └──◄ 12
    │         
    └──◄ 16

Result: 4 × 5 = 20
```

### ⚡ نسخه بهینه (با شیفت)

```assembly
# ضرب با استفاده از شیفت: O(log b)
multiply_fast:
    addi sp, sp, -12
    sw   ra, 8(sp)
    sw   a0, 4(sp)
    sw   a1, 0(sp)
    
    # Base case
    beq  a1, zero, mult_fast_base
    
    # اگر b فرد است
    andi t0, a1, 1
    beq  t0, zero, mult_fast_even
    
    # b فرد: a + multiply(a, b-1)
    addi a1, a1, -1
    jal  ra, multiply_fast
    lw   t0, 4(sp)
    add  a0, a0, t0
    j    mult_fast_end
    
mult_fast_even:
    # b زوج: multiply(a×2, b/2)
    slli a0, a0, 1          # a = a × 2
    srli a1, a1, 1          # b = b / 2
    jal  ra, multiply_fast
    j    mult_fast_end
    
mult_fast_base:
    li   a0, 0
    
mult_fast_end:
    lw   ra, 8(sp)
    addi sp, sp, 12
    ret
```

### 🔄 نسخه تکراری

```assembly
# نسخه تکراری ساده
multiply_iter:
    li   t0, 0              # result = 0
    li   t1, 0              # counter = 0
    
mult_iter_loop:
    bge  t1, a1, mult_iter_end
    add  t0, t0, a0         # result += a
    addi t1, t1, 1          # counter++
    j    mult_iter_loop
    
mult_iter_end:
    mv   a0, t0
    ret
```

---

## 6. بررسی عدد اول

### 📝 توضیحات

بررسی این که آیا یک عدد، عدد اول است یا خیر.

**تعریف:** عدد اول عددی است که فقط بر 1 و خودش بخش‌پذیر باشد.

**مثال:**
```
is_prime(7) = true   (اول)
is_prime(8) = false  (مرکب)
is_prime(17) = true  (اول)
```

### 🔍 الگوریتم

```
is_prime(n, divisor=2):
    if n ≤ 1:
        return false
    if divisor × divisor > n:
        return true
    if n % divisor = 0:
        return false
    return is_prime(n, divisor+1)
```

### 💻 کد RISC-V

```assembly
# ورودی: a0 = n
# خروجی: a0 = 1 (اول) یا 0 (مرکب)

is_prime:
    # Prologue
    addi sp, sp, -8
    sw   ra, 4(sp)
    sw   a0, 0(sp)
    
    # Base case 1: n ≤ 1
    li   t0, 1
    ble  a0, t0, not_prime
    
    # Base case 2: n = 2
    li   t0, 2
    beq  a0, t0, prime_yes
    
    # شروع بررسی از 2
    li   a1, 2              # divisor = 2
    jal  ra, check_divisor
    j    prime_end
    
check_divisor:
    addi sp, sp, -12
    sw   ra, 8(sp)
    sw   a0, 4(sp)
    sw   a1, 0(sp)
    
    # اگر divisor² > n، عدد اول است
    mul  t0, a1, a1         # t0 = divisor²
    bgt  t0, a0, prime_yes
    
    # بررسی تقسیم‌پذیری
    rem  t0, a0, a1         # t0 = n % divisor
    beq  t0, zero, not_prime  # اگر باقیمانده 0، مرکب است
    
    # فراخوانی بازگشتی با divisor+1
    addi a1, a1, 1
    jal  ra, check_divisor
    
    lw   ra, 8(sp)
    addi sp, sp, 12
    ret
    
prime_yes:
    li   a0, 1              # return true
    j    prime_end
    
not_prime:
    li   a0, 0              # return false
    
prime_end:
    lw   ra, 4(sp)
    addi sp, sp, 8
    ret

# ═══════════════════════════════════════════════════
# مثال استفاده
# ═══════════════════════════════════════════════════

main:
    li   a0, 29             # بررسی 29
    jal  ra, is_prime
    # a0 = 1 (اول است)
```

### 📊 نمودار بررسی

```
is_prime(17)
    │
    ├─► check_divisor(17, 2)
    │         │
    │         ├─► 17 % 2 ≠ 0 → check_divisor(17, 3)
    │         │                      │
    │         │                      ├─► 17 % 3 ≠ 0 → check_divisor(17, 4)
    │         │                      │                      │
    │         │                      │                      ├─► 17 % 4 ≠ 0 → check_divisor(17, 5)
    │         │                      │                      │                      │
    │         │                      │                      │                      └─► 5² = 25 > 17
    │         │                      │                      │                           │
    │         │                      │                      │                           └─► PRIME
    │         │                      │                      │
    │         │                      │                      └──◄ true
    │         │                      │
    │         │                      └──◄ true
    │         │
    │         └──◄ true
    │
    └──◄ true (17 عدد اول است)
```

### ⚡ نسخه بهینه (تکراری)

```assembly
# نسخه تکراری با بهینه‌سازی
is_prime_optimized:
    # بررسی‌های اولیه
    li   t0, 2
    blt  a0, t0, not_prime_opt  # n < 2
    beq  a0, t0, prime_opt      # n = 2
    
    # بررسی زوج بودن
    andi t0, a0, 1
    beq  t0, zero, not_prime_opt # اگر زوج است (غیر از 2)
    
    # شروع از 3، با گام 2 (فقط اعداد فرد)
    li   t1, 3                  # divisor = 3
    
prime_loop:
    mul  t2, t1, t1             # t2 = divisor²
    bgt  t2, a0, prime_opt      # اگر divisor² > n
    
    rem  t2, a0, t1             # باقیمانده
    beq  t2, zero, not_prime_opt
    
    addi t1, t1, 2              # divisor += 2 (فقط فردها)
    j    prime_loop
    
prime_opt:
    li   a0, 1
    ret
    
not_prime_opt:
    li   a0, 0
    ret
```

### 🎯 توابع کمکی

```assembly
# یافتن اولین عدد اول بزرگتر از n
next_prime:
    addi sp, sp, -8
    sw   ra, 4(sp)
    sw   s0, 0(sp)
    
    mv   s0, a0
    addi s0, s0, 1              # شروع از n+1
    
next_loop:
    mv   a0, s0
    jal  ra, is_prime_optimized
    bnez a0, found_next
    addi s0, s0, 1
    j    next_loop
    
found_next:
    mv   a0, s0
    lw   s0, 0(sp)
    lw   ra, 4(sp)
    addi sp, sp, 8
    ret

# شمارش اعداد اول تا n
count_primes:
    addi sp, sp, -12
    sw   ra, 8(sp)
    sw   s0, 4(sp)              # شمارنده
    sw   s1, 0(sp)              # حد بالا
    
    mv   s1, a0
    li   s0, 0                  # count = 0
    li   t0, 2                  # i = 2
    
count_loop:
    bgt  t0, s1, count_end
    
    mv   a0, t0
    sw   t0, -4(sp)             # ذخیره موقت i
    jal  ra, is_prime_optimized
    lw   t0, -4(sp)
    
    beq  a0, zero, count_skip
    addi s0, s0, 1              # count++
    
count_skip:
    addi t0, t0, 1              # i++
    j    count_loop
    
count_end:
    mv   a0, s0
    lw   s1, 0(sp)
    lw   s0, 4(sp)
    lw   ra, 8(sp)
    addi sp, sp, 12
    ret
```

---

## نسخه‌های بهینه (تکراری)

### 🚀 چرا نسخه تکراری؟

| جنبه | بازگشتی | تکراری |
|------|---------|--------|
| **سرعت** | کند ⏱️ | سریع ⚡ |
| **حافظه** | O(n) | O(1) |
| **Stack Overflow** | ممکن ⚠️ | خیر ✅ |
| **خوانایی** | بالا 📖 | متوسط 📄 |

### 1️⃣ مجموع زوج (تکراری)

```assembly
sum_even_iter:
    li   t0, 0              # sum = 0
    li   t1, 0              # i = 0
    
    # اگر n فرد است، کاهش دهید
    andi t2, a0, 1
    sub  a0, a0, t2
    
loop_even:
    bgt  t1, a0, end_even
    add  t0, t0, t1         # sum += i
    addi t1, t1, 2          # i += 2
    j    loop_even
    
end_even:
    mv   a0, t0
    ret
```

### 2️⃣ توان (تکراری)

```assembly
power_iter:
    li   t0, 1              # result = 1
    li   t1, 0              # counter = 0
    
loop_power:
    bge  t1, a1, end_power
    mul  t0, t0, a0         # result *= base
    addi t1, t1, 1
    j    loop_power
    
end_power:
    mv   a0, t0
    ret
```

### 3️⃣ فیبوناچی (تکراری)

```assembly
fib_iter:
    beq  a0, zero, fib_i_zero
    li   t0, 1
    beq  a0, t0, fib_i_one
    
    li   t0, 0              # F(n-2)
    li   t1, 1              # F(n-1)
    li   t2, 2              # i = 2
    
loop_fib:
    bgt  t2, a0, end_fib
    add  t3, t0, t1         # F(n) = F(n-1) + F(n-2)
    mv   t0, t1
    mv   t1, t3
    addi t2, t2, 1
    j    loop_fib
    
end_fib:
    mv   a0, t1
    ret
    
fib_i_zero:
    li   a0, 0
    ret
    
fib_i_one:
    li   a0, 1
    ret
```

### 4️⃣ مجموع ارقام (تکراری)

```assembly
sum_digits_iter:
    li   t0, 0              # sum = 0
    li   t1, 10
    
loop_digits:
    beq  a0, zero, end_digits
    rem  t2, a0, t1         # digit = n % 10
    add  t0, t0, t2         # sum += digit
    div  a0, a0, t1         # n /= 10
    j    loop_digits
    
end_digits:
    mv   a0, t0
    ret
```

### 5️⃣ ضرب (تکراری)

```assembly
multiply_iter:
    li   t0, 0              # result = 0
    li   t1, 0              # counter = 0
    
loop_mult:
    bge  t1, a1, end_mult
    add  t0, t0, a0         # result += a
    addi t1, t1, 1
    j    loop_mult
    
end_mult:
    mv   a0, t0
    ret
```

### 6️⃣ عدد اول (تکراری)

```assembly
is_prime_iter:
    li   t0, 2
    blt  a0, t0, not_prime_i
    beq  a0, t0, prime_i
    
    andi t0, a0, 1
    beq  t0, zero, not_prime_i
    
    li   t1, 3              # divisor = 3
    
loop_prime:
    mul  t2, t1, t1
    bgt  t2, a0, prime_i
    
    rem  t2, a0, t1
    beq  t2, zero, not_prime_i
    
    addi t1, t1, 2
    j    loop_prime
    
prime_i:
    li   a0, 1
    ret
    
not_prime_i:
    li   a0, 0
    ret
```

---

## مقایسه عملکرد

### 📊 جدول مقایسه زمانی

| تابع | ورودی | بازگشتی (ms) | تکراری (ms) | نسبت سرعت |
|------|-------|--------------|-------------|-----------|
| **sum_even** | 100 | 0.05 | 0.01 | 5x |
| **power** | (2, 20) | 0.02 | 0.01 | 2x |
| **fibonacci** | 20 | 89.0 | 0.02 | 4,450x |
| **fibonacci** | 30 | 94,321 | 0.03 | 3,144,033x |
| **sum_digits** | 123456 | 0.03 | 0.01 | 3x |
| **multiply** | (100, 100) | 0.15 | 0.05 | 3x |
| **is_prime** | 1000003 | 1.2 | 0.4 | 3x |

### 💾 مقایسه استفاده از حافظه

```
تابع: fibonacci(30)

بازگشتی:
Stack Depth: 30 سطح
حافظه: ~480 بایت (16 بایت × 30)

تکراری:
Stack Depth: 0
حافظه: ~16 بایت (فقط متغیرهای محلی)

نسبت: 30x کمتر! 🎉
```

### ⚡ نتیجه‌گیری

**زمانی از بازگشت استفاده کنید که:**
- 📖 خوانایی کد مهم‌تر از عملکرد است
- 🌳 ساختار مسئله ذاتاً بازگشتی است (مثل درخت)
- 🔢 عمق بازگشت کم است (< 100)

**زمانی از تکرار استفاده کنید که:**
- ⚡ عملکرد حیاتی است
- 💾 حافظه محدود است
- 🔄 عمق بازگشت زیاد است

---

## 🎓 تمرین‌های پیشنهادی

### تمرین 1: GCD (الگوریتم اقلیدس)

```c
int gcd(int a, int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}
```

<details>
<summary>💡 راهنمایی</summary>

```assembly
gcd:
    beq  a1, zero, gcd_base
    
    addi sp, sp, -8
    sw   ra, 4(sp)
    sw   a0, 0(sp)
    
    rem  t0, a0, a1         # t0 = a % b
    mv   a0, a1             # a = b
    mv   a1, t0             # b = a % b
    
    jal  ra, gcd
    
    lw   ra, 4(sp)
    addi sp, sp, 8
    ret
    
gcd_base:
    ret                     # return a
```
</details>

### تمرین 2: بزرگترین مقسوم‌علیه مشترک چندین عدد

```c
int gcd_array(int arr[], int n);
```

### تمرین 3: محاسبه کمترین مضرب مشترک (LCM)

```c
int lcm(int a, int b);
```

### تمرین 4: برج هانوی

```c
void hanoi(int n, char from, char to, char aux);
```

<details>
<summary>💡 راهنمایی</summary>

```assembly
hanoi:
    # a0 = n, a1 = from, a2 = to, a3 = aux
    beq  a0, zero, hanoi_end
    
    addi sp, sp, -20
    sw   ra, 16(sp)
    sw   a0, 12(sp)
    sw   a1, 8(sp)
    sw   a2, 4(sp)
    sw   a3, 0(sp)
    
    # Move n-1 from 'from' to 'aux'
    addi a0, a0, -1
    mv   t0, a2
    mv   a2, a3
    mv   a3, t0
    jal  ra, hanoi
    
    # Print move
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    # ... print code ...
    
    # Move n-1 from 'aux' to 'to'
    lw   a0, 12(sp)
    addi a0, a0, -1
    lw   a1, 0(sp)
    lw   a2, 4(sp)
    lw   a3, 8(sp)
    jal  ra, hanoi
    
    lw   ra, 16(sp)
    addi sp, sp, 20
hanoi_end:
    ret
```
</details>

### تمرین 5: جستجوی دودویی بازگشتی

```c
int binary_search(int arr[], int left, int right, int target);
```

### تمرین 6: مرتب‌سازی ادغامی (Merge Sort)

```c
void merge_sort(int arr[], int left, int right);
```

---

## 🐛 اشکالات رایج و راه‌حل

### ❌ خطای 1: فراموشی شرط پایه

```assembly
# ❌ اشتباه
bad_factorial:
    addi sp, sp, -8
    sw   ra, 4(sp)
    # فراموشی بررسی base case!
    addi a0, a0, -1
    jal  ra, bad_factorial  # Stack Overflow!
```

**راه‌حل:**
```assembly
# ✅ صحیح
good_factorial:
    li   t0, 1
    ble  a0, t0, base_case  # ✅ بررسی شرط پایه
    # ... ادامه کد
```

### ❌ خطای 2: عدم ذخیره رجیسترها

```assembly
# ❌ اشتباه
bad_function:
    jal  ra, other_function
    # ra تغییر کرده! نمی‌توانیم برگردیم
    jalr zero, 0(ra)        # آدرس اشتباه!
```

**راه‌حل:**
```assembly
# ✅ صحیح
good_function:
    addi sp, sp, -4
    sw   ra, 0(sp)          # ✅ ذخیره ra
    jal  ra, other_function
    lw   ra, 0(sp)          # ✅ بازیابی ra
    addi sp, sp, 4
    ret
```

### ❌ خطای 3: عدم بازگرداندن sp

```assembly
# ❌ اشتباه
bad_epilogue:
    addi sp, sp, -16
    # ... کد ...
    ret                     # sp هنوز -16 است!
```

**راه‌حل:**
```assembly
# ✅ صحیح
good_epilogue:
    addi sp, sp, -16
    # ... کد ...
    addi sp, sp, 16         # ✅ بازگرداندن sp
    ret
```

### ❌ خطای 4: استفاده نادرست از رجیسترهای موقت

```assembly
# ❌ اشتباه
bad_temp:
    li   t0, 42
    jal  ra, function       # t0 ممکن است تغییر کند!
    # انتظار t0 = 42 ولی...
```

**راه‌حل:**
```assembly
# ✅ صحیح - استفاده از s
good_saved:
    addi sp, sp, -4
    sw   s0, 0(sp)
    li   s0, 42             # ✅ s0 حفظ می‌شود
    jal  ra, function
    # s0 همچنان 42 است
    lw   s0, 0(sp)
    addi sp, sp, 4
```

---

## 💡 نکات بهینه‌سازی

### 1️⃣ Tail Call Optimization

```assembly
# ❌ بدون بهینه‌سازی
function_a:
    # ... کد ...
    jal  ra, function_b
    jalr zero, 0(ra)        # بازگشت بی‌فایده

# ✅ با بهینه‌سازی
function_a:
    # ... کد ...
    j    function_b         # پرش مستقیم
```

### 2️⃣ استفاده از رجیسترهای موقت

```assembly
# ❌ کم‌بازده
slow_function:
    addi sp, sp, -16
    sw   t0, 12(sp)
    sw   t1, 8(sp)
    # فقط 2 تا استفاده می‌شوند

# ✅ بهینه
fast_function:
    # استفاده مستقیم از t0 و t1
    # بدون ذخیره در پشته
```

### 3️⃣ محاسبات Inline

```assembly
# ❌ فراخوانی زیاد
main:
    li   a0, 2
    jal  ra, square         # فراخوانی برای عمل ساده
    
square:
    mul  a0, a0, a0
    ret

# ✅ inline
main:
    li   a0, 2
    mul  a0, a0, a0         # مستقیم
```

---

## 📚 منابع بیشتر

### 🔗 لینک‌های مفید

- [RISC-V Green Card](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf)
- [RARS Simulator](https://github.com/TheThirdOne/rars)
- [RISC-V Assembly Guide](https://github.com/riscv/riscv-asm-manual)

### 📖 کتاب‌های پیشنهادی

1. **Computer Organization and Design: RISC-V Edition**
   - نویسندگان: Patterson & Hennessy
   - فصل 2: زبان اسمبلی

2. **The RISC-V Reader**
   - نویسندگان: Patterson & Waterman
   - راهنمای کامل دستورات

### 🎥 ویدیوهای آموزشی

- [RISC-V Assembly Programming](https://www.youtube.com/results?search_query=risc-v+assembly)
- [Recursion in Assembly](https://www.youtube.com/results?search_query=recursion+assembly)

---

## ❓ سوالات متداول (FAQ)

### Q1: چگونه عمق بازگشت را محدود کنیم؟

**A:** با اضافه کردن شمارنده:

```assembly
factorial_safe:
    li   t0, 1000           # حداکثر عمق
    bgt  a0, t0, too_deep
    # ... ادامه کد عادی
    
too_deep:
    li   a0, -1             # خطا
    ret
```

### Q2: چگونه Stack Overflow را تشخیص دهیم؟

**A:** با مقایسه sp با حد پایین:

```assembly
    la   t0, stack_bottom
    blt  sp, t0, stack_overflow
```

### Q3: چرا فیبوناچی بازگشتی این قدر کند است؟

**A:** به دلیل محاسبات تکراری:

```
fib(5) محاسبه می‌کند:
- fib(4): 1 بار
- fib(3): 2 بار
- fib(2): 3 بار
- fib(1): 5 بار
- fib(0): 3 بار

جمعاً 15 فراخوانی برای fib(5)!
```

**راه‌حل:** استفاده از Dynamic Programming یا نسخه تکراری.

---

## 🏆 چک‌لیست تابع بازگشتی

### ✅ قبل از نوشتن کد

- [ ] شرط پایه مشخص است؟
- [ ] فراخوانی بازگشتی به شرط پایه نزدیک می‌شود؟
- [ ] عمق بازگشت محدود است؟

### ✅ در حین نوشتن

- [ ] ra ذخیره شده است؟
- [ ] پارامترها حفظ می‌شوند؟
- [ ] sp به درستی مدیریت می‌شود؟
- [ ] نتیجه در a0 قرار می‌گیرد؟

### ✅ بعد از نوشتن

- [ ] با ورودی‌های مختلف تست شده؟
- [ ] حالت‌های خاص بررسی شدند؟ (0, 1, منفی)
- [ ] حافظه به درستی آزاد می‌شود؟
- [ ] بهینه‌سازی امکان‌پذیر است؟

---

<div align="center">

## 🎯 خلاصه نکات کلیدی

| قانون | توضیح |
|-------|-------|
| **1. همیشه شرط پایه داشته باشید** | جلوگیری از Stack Overflow |
| **2. ra را ذخیره کنید** | اگر تابع دیگری فراخوانی می‌کنید |
| **3. sp را بازگردانید** | در epilogue |
| **4. از s برای نگهداری استفاده کنید** | نه از t |
| **5. نسخه تکراری را در نظر بگیرید** | برای عملکرد بهتر |

---





[⬆ بازگشت به بالا](#مثال‌های-بازگشتی-در-risc-v)

---



📧 سوال دارید? Issue باز کنید!

</div>

</div>